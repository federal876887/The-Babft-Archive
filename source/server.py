from flask import Flask, request, jsonify
import requests
from PIL import Image, UnidentifiedImageError
from io import BytesIO
import traceback
import urllib.parse
import os
# librosa imported lazily inside /process-music to avoid crashing the app if not installed
import re
import qrcode
import math  # This is correctly imported
import base64
import numpy as np
from functools import wraps
from collections import defaultdict, deque
from time import time

app = Flask(__name__)

# ==================== SECURITY CONFIGURATION ====================
MAX_PIXELS = 5000000  # Maximum allowed pixels in an image (5MP)
MAX_REQUEST_SIZE = 50 * 1024 * 1024  # 50MB max request size
REQUESTS_PER_MINUTE = 12
CRASH_PROTECTION_ENABLED = False

# IP Blacklist - Add IPs here to block them
IP_BLACKLIST = set([
    # "192.168.1.1",  # Example: Uncomment and add malicious IPs
])

# Rate limiting - tracks requests per IP
request_history = defaultdict(list)

def get_client_ip():
    """Get client IP address, accounting for proxies"""
    if request.environ.get('HTTP_X_FORWARDED_FOR'):
        return request.environ.get('HTTP_X_FORWARDED_FOR').split(',')[0].strip()
    return request.remote_addr

def is_ip_blocked(ip):
    """Check if IP is blacklisted"""
    return ip in IP_BLACKLIST

def check_rate_limit(ip):
    """Check if IP has exceeded rate limit"""
    current_time = time()
    minute_ago = current_time - 60

    # Clean old requests
    request_history[ip] = [req_time for req_time in request_history[ip] if req_time > minute_ago]

    if len(request_history[ip]) >= REQUESTS_PER_MINUTE:
        return False

    request_history[ip].append(current_time)
    return True


def rgba_to_int(r, g, b, a):
    return (r << 24) | (g << 16) | (b << 8) | a

API_KEY = 'i-know-the-key-is-visible-please-be-kind'

# ==================== MIDDLEWARE ====================
@app.before_request
def check_security():
    """Check IP blacklist and rate limiting before processing request"""
    try:
        client_ip = get_client_ip()

        # Check if IP is blocked
        if is_ip_blocked(client_ip):
            return jsonify({"error": "Access denied - IP blocked"}), 403

        # Check rate limit
        if not check_rate_limit(client_ip):
            return jsonify({
                "error": "Rate limit exceeded - Maximum 10 requests per minute",
                "retry_after": 60
            }), 429

        # Check request size
        if request.content_length and request.content_length > MAX_REQUEST_SIZE:
            return jsonify({
                "error": f"Request too large - Maximum {MAX_REQUEST_SIZE / (1024*1024):.0f}MB allowed"
            }), 413

    except Exception as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"Security check error: {e}")
            return jsonify({"error": "Security check failed"}), 500
        raise

def rgba_to_int(r, g, b, a):
    return (r << 24) | (g << 16) | (b << 8) | a

def require_api_key(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        try:
            # Check header first
            key = request.headers.get('X-API-Key')
            # Fallback to query param
            if not key:
                key = request.args.get('api_key')
            # Fallback to JSON body
            if not key:
                try:
                    body = request.get_json(silent=True)
                    if isinstance(body, dict):
                        key = body.get('api_key')
                except Exception:
                    key = None

            if not key or key != API_KEY:
                return jsonify({"error": "Unauthorized - invalid API key"}), 401
            return f(*args, **kwargs)
        except Exception as e:
            if CRASH_PROTECTION_ENABLED:
                print(f"API key check error: {e}")
                return jsonify({"error": "Authentication check failed"}), 500
            raise
    return decorated


@app.route('/image', methods=['POST'])
@require_api_key
def process_image():
    if not request.is_json:
        return "invalid", 400, {'Content-Type': 'text/plain; charset=utf-8'}

    try:
        data = request.get_json()
        image_url = data.get('url')

        if not image_url:
            return "invalid", 400, {'Content-Type': 'text/plain; charset=utf-8'}

        response = requests.get(image_url, timeout=10, stream=True)
        response.raise_for_status()

        img_bytes = BytesIO(response.content)
        img = Image.open(img_bytes)
        img = img.convert("RGBA")

        width, height = img.size
        total_pixels = width * height

        # Validate pixel count
        if total_pixels > MAX_PIXELS:
            return jsonify({
                "error": f"Image too large - Maximum {MAX_PIXELS:,} pixels allowed",
                "provided_pixels": total_pixels,
                "max_pixels": MAX_PIXELS
            }), 413

        pixels_data = list(img.getdata())

        processed_pixels = []
        for r, g, b, a in pixels_data:
            processed_pixels.append(rgba_to_int(r, g, b, a))

        return jsonify({
            "dimensions": [width, height],
            "pixels": processed_pixels,
            "total_pixels": total_pixels
        })

    except requests.exceptions.Timeout:
        return jsonify({"error": "Image request timeout"}), 408
    except (requests.exceptions.RequestException, UnidentifiedImageError, IOError) as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"Image processing error: {e}")
            return "invalid", 400, {'Content-Type': 'text/plain; charset=utf-8'}
        raise
    except Exception as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"Image processing unexpected error: {e}")
            traceback.print_exc()
            return jsonify({"error": "Image processing failed"}), 500
        raise




# ==================== OBJ VOXELIZATION HELPERS ====================

def parse_obj(content, scale=1.0):
    vertices = []
    faces = []
    for line in content.split('\n'):
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        parts = line.split()
        if not parts:
            continue
        if parts[0] == 'v' and len(parts) >= 4:
            try:
                vertices.append((
                    float(parts[1]) * scale,
                    float(parts[2]) * scale,
                    float(parts[3]) * scale
                ))
            except ValueError:
                continue
        elif parts[0] == 'f':
            face_indices = []
            for p in parts[1:]:
                try:
                    vid = int(p.split('/')[0])
                    if vid < 0:
                        vid = len(vertices) + vid
                    else:
                        vid -= 1
                    if 0 <= vid < len(vertices):
                        face_indices.append(vid)
                except (ValueError, IndexError):
                    continue
            for i in range(1, len(face_indices) - 1):
                faces.append((face_indices[0], face_indices[i], face_indices[i + 1]))
    return vertices, faces


def _vec_sub(a, b):
    return (a[0]-b[0], a[1]-b[1], a[2]-b[2])

def _vec_cross(a, b):
    return (a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0])

def _vec_dot(a, b):
    return a[0]*b[0] + a[1]*b[1] + a[2]*b[2]

def _vec_len(v):
    return math.sqrt(v[0]**2 + v[1]**2 + v[2]**2)

def _vec_normalize(v):
    ln = _vec_len(v)
    if ln < 1e-10:
        return (0.0, 0.0, 1.0)
    return (v[0]/ln, v[1]/ln, v[2]/ln)


def voxelize_mesh(vertices, faces, voxel_size, fill_interior=False):
    """Grid-based voxelization with smooth surface blocks.
    Surface voxels stay as individual small blocks (client rotates them for smoothness).
    Interior voxels get greedy-meshed into large merged blocks for efficiency.

    Args:
        vertices: list of (x,y,z) tuples
        faces: list of (i0, i1, i2) index tuples
        voxel_size: size of each grid cell
        fill_interior: if True, also fills interior volume

    Returns:
        list of block dicts with position, size, rotation=[0,0,0], is_surface flag
    """
    inv_vs = 1.0 / voxel_size
    filled = set()  # surface shell voxels

    def add_voxel(px, py, pz):
        """Add a voxel and its immediate neighbors to ensure watertight surface."""
        gx = int(math.floor(px * inv_vs))
        gy = int(math.floor(py * inv_vs))
        gz = int(math.floor(pz * inv_vs))
        filled.add((gx, gy, gz))
        # Also fill the cell on the other side of cell boundaries to prevent gaps
        fx = px * inv_vs - gx
        fy = py * inv_vs - gy
        fz = pz * inv_vs - gz
        # If point is near a cell boundary, also fill the neighbor
        threshold = 0.15
        if fx < threshold:
            filled.add((gx - 1, gy, gz))
        elif fx > 1.0 - threshold:
            filled.add((gx + 1, gy, gz))
        if fy < threshold:
            filled.add((gx, gy - 1, gz))
        elif fy > 1.0 - threshold:
            filled.add((gx, gy + 1, gz))
        if fz < threshold:
            filled.add((gx, gy, gz - 1))
        elif fz > 1.0 - threshold:
            filled.add((gx, gy, gz + 1))

    # Phase 1a: Sample triangle edges explicitly for crisp silhouettes
    for face in faces:
        v0, v1, v2 = vertices[face[0]], vertices[face[1]], vertices[face[2]]
        edges = [(v0, v1), (v1, v2), (v2, v0)]
        for ea, eb in edges:
            edge = _vec_sub(eb, ea)
            edge_len = _vec_len(edge)
            step = 0.15 * voxel_size  # very dense edge sampling
            n_steps = max(1, int(math.ceil(edge_len / step)))
            for i in range(n_steps + 1):
                t = i / n_steps
                px = ea[0] + t * edge[0]
                py = ea[1] + t * edge[1]
                pz = ea[2] + t * edge[2]
                add_voxel(px, py, pz)

    # Phase 1b: Sample triangle interiors
    for face in faces:
        v0, v1, v2 = vertices[face[0]], vertices[face[1]], vertices[face[2]]
        e1 = _vec_sub(v1, v0)
        e2 = _vec_sub(v2, v0)
        len_e1 = _vec_len(e1)
        len_e2 = _vec_len(e2)
        step = 0.2 * voxel_size  # denser than before for better coverage
        n1 = max(1, int(math.ceil(len_e1 / step)))
        n2 = max(1, int(math.ceil(len_e2 / step)))
        for i in range(n1 + 1):
            u = i / n1
            bx = v0[0] + u * e1[0]
            by = v0[1] + u * e1[1]
            bz = v0[2] + u * e1[2]
            for j in range(int((1.0 - u) * n2) + 2):
                v = j / n2
                if u + v > 1.0001:
                    break
                add_voxel(bx + v * e2[0], by + v * e2[1], bz + v * e2[2])

    if not filled:
        return []

    # Phase 2: Identify surface vs interior
    # Surface = filled cells that have at least one empty 6-neighbor
    # We always need to classify surface cells even without fill_interior
    interior = set()

    if fill_interior:
        # Flood-fill exterior to find interior
        coords = list(filled)
        gmin = (min(c[0] for c in coords), min(c[1] for c in coords), min(c[2] for c in coords))
        gmax = (max(c[0] for c in coords), max(c[1] for c in coords), max(c[2] for c in coords))

        mn_x, mn_y, mn_z = gmin[0] - 1, gmin[1] - 1, gmin[2] - 1
        mx_x, mx_y, mx_z = gmax[0] + 1, gmax[1] + 1, gmax[2] + 1
        total = (mx_x - mn_x + 1) * (mx_y - mn_y + 1) * (mx_z - mn_z + 1)

        if total <= 4_000_000:
            exterior = set()
            queue = deque([(mn_x, mn_y, mn_z)])
            exterior.add((mn_x, mn_y, mn_z))
            while queue:
                x, y, z = queue.popleft()
                for dx, dy, dz in ((1,0,0),(-1,0,0),(0,1,0),(0,-1,0),(0,0,1),(0,0,-1)):
                    nx, ny, nz = x + dx, y + dy, z + dz
                    if mn_x <= nx <= mx_x and mn_y <= ny <= mx_y and mn_z <= nz <= mx_z:
                        key = (nx, ny, nz)
                        if key not in exterior and key not in filled:
                            exterior.add(key)
                            queue.append(key)

            # Interior cells = inside bounds, not exterior, not surface
            for x in range(gmin[0], gmax[0] + 1):
                for y in range(gmin[1], gmax[1] + 1):
                    for z in range(gmin[2], gmax[2] + 1):
                        key = (x, y, z)
                        if key not in exterior and key not in filled:
                            interior.add(key)
        else:
            print(f"Grid too large for interior fill ({total} cells), surface only")

    print(f"Surface voxels: {len(filled)}, Interior voxels: {len(interior)}")

    blocks = []

    # Phase 3: Emit surface voxels as individual blocks (NOT greedy meshed)
    # These stay small so the client can rotate them for a smooth appearance
    for voxel in filled:
        x, y, z = voxel
        cx = (x + 0.5) * voxel_size
        cy = (y + 0.5) * voxel_size
        cz = (z + 0.5) * voxel_size
        blocks.append({
            "position": [round(cx, 4), round(cy, 4), round(cz, 4)],
            "size": [round(voxel_size, 4), round(voxel_size, 4), round(voxel_size, 4)],
            "rotation": [0, 0, 0],
            "surface": True
        })

    # Phase 4: Greedy mesh ONLY interior voxels (they don't need rotation)
    if interior:
        remaining = set(interior)
        for voxel in sorted(remaining):
            if voxel not in remaining:
                continue
            x, y, z = voxel
            # Extend in X
            x_len = 0
            while (x + x_len, y, z) in remaining:
                x_len += 1
            # Extend in Z
            z_len = 0
            ok = True
            while ok:
                for xi in range(x, x + x_len):
                    if (xi, y, z + z_len) not in remaining:
                        ok = False
                        break
                if ok:
                    z_len += 1
            # Extend in Y
            y_len = 0
            ok = True
            while ok:
                for xi in range(x, x + x_len):
                    for zi in range(z, z + z_len):
                        if (xi, y + y_len, zi) not in remaining:
                            ok = False
                            break
                    if not ok:
                        break
                if ok:
                    y_len += 1
            # Remove consumed voxels
            for xi in range(x, x + x_len):
                for yi in range(y, y + y_len):
                    for zi in range(z, z + z_len):
                        remaining.discard((xi, yi, zi))
            # Emit merged block
            cx = (x + x_len / 2.0) * voxel_size
            cy = (y + y_len / 2.0) * voxel_size
            cz = (z + z_len / 2.0) * voxel_size
            blocks.append({
                "position": [round(cx, 4), round(cy, 4), round(cz, 4)],
                "size": [round(x_len * voxel_size, 4), round(y_len * voxel_size, 4), round(z_len * voxel_size, 4)],
                "rotation": [0, 0, 0],
                "surface": False
            })

    return blocks


@app.route('/obj-to-voxels-optimized', methods=['POST'])
@require_api_key
def obj_to_voxels_optimized():
    try:
        data = request.get_json()
        obj_content = data.get('obj_content')
        scale = float(data.get('scale', 1.0))
        voxel_size = float(data.get('voxel_size', 1.0))
        fill_interior = data.get('fill_interior', False)

        if not obj_content:
            return jsonify({"error": "No OBJ content"}), 400

        voxel_size = max(0.1, min(4.0, voxel_size))

        vertices, faces = parse_obj(obj_content, scale)
        if not vertices:
            return jsonify({"error": "No vertices found in OBJ"}), 400
        if not faces:
            return jsonify({"error": "No faces found in OBJ"}), 400

        print(f"Parsed {len(vertices)} vertices, {len(faces)} triangles")

        # Compute model bounds and center
        xs = [v[0] for v in vertices]
        ys = [v[1] for v in vertices]
        zs = [v[2] for v in vertices]
        min_x, max_x = min(xs), max(xs)
        min_y, max_y = min(ys), max(ys)
        min_z, max_z = min(zs), max(zs)
        center_x = (min_x + max_x) / 2
        center_y = (min_y + max_y) / 2
        center_z = (min_z + max_z) / 2

        print(f"Bounds: ({min_x:.2f},{min_y:.2f},{min_z:.2f}) to ({max_x:.2f},{max_y:.2f},{max_z:.2f})")
        print(f"Block size: {voxel_size}, Fill interior: {fill_interior}")

        # Unified grid-based voxelization (surface + optional interior)
        blocks = voxelize_mesh(vertices, faces, voxel_size, fill_interior)

        if not blocks:
            return jsonify({"error": "No voxels generated"}), 400

        # Center all block positions around model origin
        for b in blocks:
            b["position"][0] = round(b["position"][0] - center_x, 4)
            b["position"][1] = round(b["position"][1] - center_y, 4)
            b["position"][2] = round(b["position"][2] - center_z, 4)

        # Enforce block limit
        MAX_BLOCKS = 200000
        if len(blocks) > MAX_BLOCKS:
            print(f"Block limit reached, truncating {len(blocks)} to {MAX_BLOCKS}")
            blocks = blocks[:MAX_BLOCKS]

        print(f"Total blocks: {len(blocks)}")

        return jsonify({
            "success": True,
            "voxel_count": len(blocks),
            "raw_voxel_count": len(faces),
            "surface_count": len(blocks),
            "interior_count": 0,
            "voxels": blocks,
            "bounds": {
                "min": [min_x - center_x, min_y - center_y, min_z - center_z],
                "max": [max_x - center_x, max_y - center_y, max_z - center_z],
                "size": [max_x - min_x, max_y - min_y, max_z - min_z]
            },
            "center": [center_x, center_y, center_z],
            "voxel_size": voxel_size
        })

    except Exception as e:
        print(f"OBJ conversion error: {e}")
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500



@app.route('/qr-code', methods=['POST'])
@require_api_key
def generate_qr_code():
    try:
        data = request.get_json()
        text_content = data.get('text')  # Changed from 'url' to 'text'
        block_size = float(data.get('block_size', 1.0))
        scale = float(data.get('scale', 1.0))
        error_correction = data.get('error_correction', 'M').upper()

        if not text_content:
            return jsonify({"error": "No text content provided"}), 400

        # Map error correction levels
        error_correction_map = {
            'L': qrcode.constants.ERROR_CORRECT_L,
            'M': qrcode.constants.ERROR_CORRECT_M,
            'Q': qrcode.constants.ERROR_CORRECT_Q,
            'H': qrcode.constants.ERROR_CORRECT_H
        }

        ec_level = error_correction_map.get(error_correction, qrcode.constants.ERROR_CORRECT_M)

        # Generate QR code
        qr = qrcode.QRCode(
            version=1,
            error_correction=ec_level,
            box_size=1,
            border=4,
        )

        qr.add_data(text_content)
        qr.make(fit=True)

        # Create QR code matrix
        qr_matrix = qr.get_matrix()

        # Convert to list format
        matrix_list = []
        for row in qr_matrix:
            matrix_list.append([1 if cell else 0 for cell in row])

        size = len(qr_matrix)

        return jsonify({
            "success": True,
            "data": text_content,
            "size": size,
            "matrix": matrix_list,
            "block_count": sum(sum(row) for row in matrix_list),
            "dimensions": [size, size]
        })

    except ValueError as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"QR code value error: {e}")
            return jsonify({"error": "Invalid parameter values"}), 400
        raise
    except Exception as e:
        if CRASH_PROTECTION_ENABLED:
            print(f"QR code generation error: {e}")
            traceback.print_exc()
            return jsonify({"error": "QR code generation failed"}), 500
        raise

# ==================== ERROR HANDLERS ====================
@app.errorhandler(429)
def handle_rate_limit(e):
    """Handle rate limit errors"""
    return jsonify({
        "error": "Rate limit exceeded - Maximum 10 requests per minute",
        "retry_after": 60
    }), 429

@app.errorhandler(413)
def handle_large_request(e):
    """Handle request too large errors"""
    return jsonify({
        "error": f"Request too large - Maximum {MAX_REQUEST_SIZE / (1024*1024):.0f}MB allowed"
    }), 413

@app.errorhandler(500)
def handle_server_error(e):
    """Handle server errors gracefully"""
    if CRASH_PROTECTION_ENABLED:
        print(f"Server error: {e}")
        return jsonify({"error": "Internal server error"}), 500
    raise

if __name__ == '__main__':
    print("=" * 60)
    print("Server Security Configuration:")
    print("=" * 60)
    print(f"Max pixels per image: {MAX_PIXELS:,}")
    print(f"Max request size: {MAX_REQUEST_SIZE / (1024*1024):.0f}MB")
    print(f"Rate limit: {REQUESTS_PER_MINUTE} requests/minute per IP")
    print(f"Crash protection: {'ENABLED' if CRASH_PROTECTION_ENABLED else 'DISABLED'}")
    print(f"Blacklisted IPs: {len(IP_BLACKLIST)}")
    print("=" * 60)
    app.run(debug=True, host='0.0.0.0', port=5000)