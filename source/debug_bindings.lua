--[[
    Debug Bindings Visualizer
    Run this script AFTER placing blocks to see:
    - All controllers (purple highlight)
    - All blocks with active bindings (blue highlight)
    - Pistons and their states (green=extended, red=retracted)
    - Connection beams between controllers and bound blocks
    - Detailed console output of every connection/binding

    Run again to clear debug visuals.
]]

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer

-- Toggle: if debug folder exists, clear it and exit
local existingDebug = workspace:FindFirstChild("_DebugBindings")
if existingDebug then
    existingDebug:Destroy()
    print("\n[DEBUG] Cleared debug visuals")
    return
end

local debugFolder = Instance.new("Folder")
debugFolder.Name = "_DebugBindings"
debugFolder.Parent = workspace

-- ============================================================================
-- Logging
-- ============================================================================
local logLines = {}
local function log(category, msg)
    local line = string.format("[%s] %s", category, msg)
    table.insert(logLines, line)
    print(line)
end

local function logSpacer()
    log("----", string.rep("-", 50))
end

-- ============================================================================
-- Helpers
-- ============================================================================
local function isController(model)
    if not model or not model:IsA("Model") then return false end
    if model:FindFirstChild("ControllerId") or model:FindFirstChild("ControllerRefTemplate") then
        return true
    end
    if model:FindFirstChild("VehicleSeat") then return true end
    local n = model.Name
    if n == "Lever" or n == "Switch" or n == "SwitchBig" or n == "Button"
       or n == "Delay" or n == "Gate" or n == "RemoteController" then
        return true
    end
    if CollectionService:HasTag(model, "SeatInput") or CollectionService:HasTag(model, "SwitchInput") then
        return true
    end
    return false
end

local function getMyBlocks()
    local blocksFolder = workspace:FindFirstChild("Blocks")
    if not blocksFolder then return {} end
    local blocks = {}
    -- Check all player folders (not just ours, so we can debug team builds)
    for _, folder in ipairs(blocksFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, block in ipairs(folder:GetChildren()) do
                if block:IsA("Model") then
                    table.insert(blocks, block)
                end
            end
        end
    end
    return blocks
end

local function posStr(part)
    if not part then return "nil" end
    local p = part.Position
    return string.format("(%.1f, %.1f, %.1f)", p.X, p.Y, p.Z)
end

local function createHighlight(parent, adornee, fillColor, outlineColor, fillTransp, name)
    local h = Instance.new("Highlight")
    h.Name = name or "DebugHighlight"
    h.FillColor = fillColor
    h.OutlineColor = outlineColor or fillColor
    h.FillTransparency = fillTransp or 0.5
    h.OutlineTransparency = 0.2
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = adornee
    h.Parent = parent
    return h
end

local function createDebugBeam(parent, from, to, color, name)
    -- Create attachments and beam to visualize connection
    local att0 = Instance.new("Attachment")
    att0.Name = "DebugAtt0"
    att0.Parent = from

    local att1 = Instance.new("Attachment")
    att1.Name = "DebugAtt1"
    att1.Parent = to

    local beam = Instance.new("Beam")
    beam.Name = name or "DebugBeam"
    beam.Attachment0 = att0
    beam.Attachment1 = att1
    beam.Color = ColorSequence.new(color)
    beam.Width0 = 0.3
    beam.Width1 = 0.3
    beam.FaceCamera = true
    beam.LightEmission = 0.5
    beam.Transparency = NumberSequence.new(0.3)
    beam.Parent = parent

    -- Store attachments for cleanup
    local cleanup = Instance.new("Folder")
    cleanup.Name = "DebugBeamCleanup"
    cleanup.Parent = parent
    att0.Parent = cleanup
    att1.Parent = cleanup
    -- Re-parent attachments to actual parts for beam to work
    att0.Parent = from
    att1.Parent = to

    return beam
end

local function createBillboard(parent, adornee, text, color)
    local bb = Instance.new("BillboardGui")
    bb.Name = "DebugLabel"
    bb.Adornee = adornee
    bb.Size = UDim2.new(0, 200, 0, 50)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    label.BackgroundTransparency = 0.3
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextScaled = true
    label.Text = text
    label.Parent = bb

    Instance.new("UICorner", label).CornerRadius = UDim.new(0, 4)
    return bb
end

-- ============================================================================
-- Main Scan
-- ============================================================================
print("\n" .. string.rep("=", 60))
log("SCAN", "Starting debug binding scan...")
logSpacer()

local allBlocks = getMyBlocks()
log("SCAN", string.format("Found %d total block models", #allBlocks))

local controllers = {}
local pistons = {}
local boundBlocks = {}     -- blocks with active binds (value ~= -1)
local allBindValues = {}   -- every bind IntValue found
local beamConnections = {} -- controller -> target via beam

-- ============================================================================
-- Pass 1: Identify controllers, pistons, and bind values
-- ============================================================================
logSpacer()
log("PASS1", "Scanning for controllers, pistons, and bindings...")

for _, block in ipairs(allBlocks) do
    local part = block:FindFirstChild("PPart") or block.PrimaryPart

    -- Check if controller
    if isController(block) then
        table.insert(controllers, block)
        log("CTRL", string.format("  %s at %s (owner: %s)",
            block.Name, posStr(part), block.Parent and block.Parent.Name or "?"))

        -- Check for beams (visual connections to other blocks)
        for _, child in ipairs(block:GetChildren()) do
            if child:IsA("Beam") then
                local att1 = child.Attachment1
                local target = att1 and att1.Parent and att1.Parent.Parent
                if target and target:IsA("Model") then
                    table.insert(beamConnections, {
                        controller = block,
                        target = target,
                        beam = child,
                    })
                    log("BEAM", string.format("    -> %s at %s",
                        target.Name,
                        posStr(target:FindFirstChild("PPart") or target.PrimaryPart)))
                end
            end
        end
    end

    -- Check for bind values
    for _, child in ipairs(block:GetChildren()) do
        if child:IsA("IntValue") and child.Name:sub(1, 4) == "Bind" and child.Name ~= "BindingSB" then
            local actionName = child:FindFirstChild("ActionName")
            local info = {
                block = block,
                bindValue = child,
                name = child.Name,
                value = child.Value,
                actionName = actionName and actionName.Value or "?",
            }
            table.insert(allBindValues, info)

            if child.Value ~= -1 then
                table.insert(boundBlocks, info)
                log("BIND", string.format("  %s.%s = %d (action: %s) at %s",
                    block.Name, child.Name, child.Value, info.actionName,
                    posStr(part)))
            end
        end
    end

    -- Check ControllerRef / ControllerId ObjectValues
    local controllerRef = block:FindFirstChild("ControllerRef")
    if controllerRef and controllerRef:IsA("ObjectValue") and controllerRef.Value then
        log("REF", string.format("  %s -> ControllerRef = %s",
            block.Name, controllerRef.Value.Name))
    end

    local controllerId = block:FindFirstChild("ControllerId")
    if controllerId and controllerId:IsA("ObjectValue") and controllerId.Value then
        log("REF", string.format("  %s -> ControllerId = %s",
            block.Name, controllerId.Value.Name))
    end

    -- Check pistons
    if block.Name == "Piston" then
        local lastDir = block:FindFirstChild("LastDirrection")
        local extendLen = block:FindFirstChild("ExtendLength")
        local speed = block:FindFirstChild("Speed")
        local isExtended = lastDir and lastDir.Value == 1

        table.insert(pistons, {
            block = block,
            extended = isExtended,
            extendLength = extendLen and extendLen.Value or "?",
            speed = speed and speed.Value or "?",
            lastDirection = lastDir and lastDir.Value or "?",
        })

        local state = isExtended and "EXTENDED" or "RETRACTED"
        log("PISTON", string.format("  Piston at %s - %s (len=%s, speed=%s, dir=%s)",
            posStr(part), state,
            tostring(extendLen and extendLen.Value),
            tostring(speed and speed.Value),
            tostring(lastDir and lastDir.Value)))
    end

    -- Check special block states
    if block.Name == "Servo" then
        local hinge = part and part:FindFirstChild("HingeConstraint")
        if hinge then
            log("SERVO", string.format("  Servo at %s - angle=%s, speed=%s, torque=%s",
                posStr(part),
                tostring(hinge.TargetAngle),
                tostring(hinge.AngularSpeed),
                tostring(hinge.ServoMaxTorque)))
        end
    end
end

-- ============================================================================
-- Pass 2: Create visual debug overlays
-- ============================================================================
logSpacer()
log("VISUALS", "Creating debug highlights...")

-- Highlight controllers in purple
for _, ctrl in ipairs(controllers) do
    createHighlight(debugFolder, ctrl,
        Color3.fromRGB(155, 60, 172),
        Color3.fromRGB(200, 100, 220),
        0.4, "CtrlHighlight")

    local part = ctrl:FindFirstChild("PPart") or ctrl.PrimaryPart
    if part then
        createBillboard(debugFolder, part,
            "CTRL: " .. ctrl.Name,
            Color3.fromRGB(200, 100, 220))
    end
end

-- Highlight bound blocks in blue
local highlightedBlocks = {}
for _, info in ipairs(boundBlocks) do
    if not highlightedBlocks[info.block] then
        highlightedBlocks[info.block] = true
        createHighlight(debugFolder, info.block,
            Color3.fromRGB(49, 155, 176),
            Color3.fromRGB(80, 200, 220),
            0.6, "BoundHighlight")

        local part = info.block:FindFirstChild("PPart") or info.block.PrimaryPart
        if part then
            -- Collect all binds for this block
            local bindTexts = {}
            for _, b in ipairs(boundBlocks) do
                if b.block == info.block then
                    table.insert(bindTexts, string.format("%s=%d", b.name:sub(5), b.value))
                end
            end
            createBillboard(debugFolder, part,
                info.block.Name .. "\n" .. table.concat(bindTexts, " "),
                Color3.fromRGB(80, 200, 220))
        end
    end
end

-- Highlight pistons in green (extended) or red (retracted)
for _, piston in ipairs(pistons) do
    local color = piston.extended
        and Color3.fromRGB(50, 200, 50)
        or Color3.fromRGB(200, 50, 50)
    createHighlight(debugFolder, piston.block, color, color, 0.4, "PistonHighlight")

    local part = piston.block:FindFirstChild("PPart") or piston.block.PrimaryPart
    if part then
        local state = piston.extended and "EXTENDED" or "RETRACTED"
        createBillboard(debugFolder, part,
            string.format("PISTON %s\nlen=%s spd=%s",
                state, tostring(piston.extendLength), tostring(piston.speed)),
            color)
    end
end

-- Draw debug beams for existing beam connections
for _, conn in ipairs(beamConnections) do
    local ctrlPart = conn.controller:FindFirstChild("PPart") or conn.controller.PrimaryPart
    local targetPart = conn.target:FindFirstChild("PPart") or conn.target.PrimaryPart
    if ctrlPart and targetPart then
        createDebugBeam(debugFolder, ctrlPart, targetPart,
            Color3.fromRGB(255, 100, 100), "ConnBeam")
    end
end

-- ============================================================================
-- Summary
-- ============================================================================
logSpacer()
log("SUMMARY", string.format("Controllers: %d", #controllers))
log("SUMMARY", string.format("Pistons: %d (extended: %d, retracted: %d)",
    #pistons,
    #(function() local t = {} for _, p in ipairs(pistons) do if p.extended then table.insert(t, p) end end return t end)(),
    #(function() local t = {} for _, p in ipairs(pistons) do if not p.extended then table.insert(t, p) end end return t end)()))
log("SUMMARY", string.format("Total bind IntValues: %d", #allBindValues))
log("SUMMARY", string.format("Active bindings (value ~= -1): %d", #boundBlocks))
log("SUMMARY", string.format("Beam connections: %d", #beamConnections))

-- Count unbound blocks that HAVE bind slots
local unboundWithSlots = 0
for _, info in ipairs(allBindValues) do
    if info.value == -1 then
        unboundWithSlots = unboundWithSlots + 1
    end
end
log("SUMMARY", string.format("Unbound slots (value == -1): %d", unboundWithSlots))

logSpacer()
log("INFO", "Run this script again to clear debug visuals")
log("INFO", "Purple = Controller, Blue = Bound block, Green/Red = Piston")
print(string.rep("=", 60) .. "\n")

-- ============================================================================
-- BindTool RF Parameter Inspector
-- Shows what parameters the BindTool RF expects
-- ============================================================================
logSpacer()
log("RF-CHECK", "Inspecting BindTool structure...")

local function inspectBindTool()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    local tool = (backpack and backpack:FindFirstChild("BindTool"))
        or (char and char:FindFirstChild("BindTool"))

    if not tool then
        log("RF-CHECK", "  BindTool not found in Backpack or Character")
        return
    end

    log("RF-CHECK", "  BindTool found in: " .. tool.Parent.Name)

    for _, child in ipairs(tool:GetChildren()) do
        log("RF-CHECK", string.format("  Child: %s (%s)", child.Name, child.ClassName))
        if child:IsA("RemoteFunction") or child:IsA("RemoteEvent") then
            log("RF-CHECK", string.format("    ^ This is the %s for %s",
                child.ClassName, child.Name))
        end
    end

    -- Check for RF, RF2, UnbindRF
    local rf = tool:FindFirstChild("RF")
    local rf2 = tool:FindFirstChild("RF2")
    local unbindRF = tool:FindFirstChild("UnbindRF")

    log("RF-CHECK", string.format("  RF: %s", rf and rf.ClassName or "NOT FOUND"))
    log("RF-CHECK", string.format("  RF2: %s", rf2 and rf2.ClassName or "NOT FOUND"))
    log("RF-CHECK", string.format("  UnbindRF: %s", unbindRF and unbindRF.ClassName or "NOT FOUND"))
end

inspectBindTool()

-- ============================================================================
-- Bind IntValue Structure Inspector
-- Shows what children each BindXxx IntValue has (ActionName, etc.)
-- ============================================================================
logSpacer()
log("BIND-STRUCT", "Inspecting bind IntValue structure...")

local inspected = false
for _, info in ipairs(allBindValues) do
    if not inspected then
        inspected = true
        local bv = info.bindValue
        log("BIND-STRUCT", string.format("  Sample: %s.%s (Value=%d)",
            info.block.Name, bv.Name, bv.Value))
        for _, child in ipairs(bv:GetChildren()) do
            log("BIND-STRUCT", string.format("    Child: %s (%s) = %s",
                child.Name, child.ClassName,
                pcall(function() return tostring(child.Value) end) and tostring(child.Value) or "?"))
        end
        -- Check a few more for consistency
        local count = 0
        for _, info2 in ipairs(allBindValues) do
            if info2.block ~= info.block then
                count = count + 1
                if count <= 2 then
                    local bv2 = info2.bindValue
                    log("BIND-STRUCT", string.format("  Sample: %s.%s (Value=%d)",
                        info2.block.Name, bv2.Name, bv2.Value))
                    for _, child in ipairs(bv2:GetChildren()) do
                        log("BIND-STRUCT", string.format("    Child: %s (%s) = %s",
                            child.Name, child.ClassName,
                            pcall(function() return tostring(child.Value) end) and tostring(child.Value) or "?"))
                    end
                end
            end
        end
    end
end

if not inspected then
    log("BIND-STRUCT", "  No bind IntValues found to inspect")
end

print("\n[DEBUG] Done! Visuals are in workspace._DebugBindings")
