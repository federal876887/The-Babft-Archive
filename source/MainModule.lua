_G.X = _G.X or {}
local X = _G.X

X.library = loadstring(game:HttpGet("https://raw.githubusercontent.com/federal876887/The-Babft-Archive/refs/heads/main/server/libtest.lua"))()
X.listing = loadstring(game:HttpGet("https://raw.githubusercontent.com/federal876887/The-Babft-Archive/refs/heads/main/server/listing.lua"))()
local NormalColorBlock = loadstring(game:HttpGet("https://raw.githubusercontent.com/federal876887/The-Babft-Archive/refs/heads/main/special/extras/blockcolors.lua"))()
local LZ4 = loadstring(game:HttpGet("https://raw.githubusercontent.com/federal876887/The-Babft-Archive/refs/heads/main/others/LZ4.lua"))()
print(X.library)

local apikey = "i-know-the-key-is-visible-please-be-kind"
X.ReplicatedStorage = game:GetService("ReplicatedStorage")
X.HttpService = game:GetService("HttpService")
X.Players = game:GetService("Players")
X.Workspace = game:GetService("Workspace") 

if not isfolder("VoltaraBuildStorage") then
    makefolder("VoltaraBuildStorage")
    workspace.CheckCodeFunction:InvokeServer("=D")
    workspace.CheckCodeFunction:InvokeServer("=p")
    workspace.CheckCodeFunction:InvokeServer("hi")
    workspace.CheckCodeFunction:InvokeServer("squid army")
    workspace.CheckCodeFunction:InvokeServer("chillthrill709 was here")
end

local MainHighlight = X.Workspace:FindFirstChild("Global_Preview_Highlight")
if not MainHighlight then
    MainHighlight = Instance.new("Highlight")
    MainHighlight.Name = "Global_Preview_Highlight"
    MainHighlight.FillColor = Color3.fromRGB(83, 101, 153)
    MainHighlight.OutlineColor = Color3.fromRGB(14, 17, 26)
    MainHighlight.FillTransparency = 0.85
    MainHighlight.OutlineTransparency = 0.3
    MainHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    MainHighlight.Parent = X.Workspace
end

X.CurrentZone = nil
local BuildingParts = X.ReplicatedStorage.BuildingParts

-- Base64 encoder/decoder for compact binary storage
local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local b64lookup = {}
for i = 1, 64 do b64lookup[string.sub(b64chars, i, i)] = i - 1 end

function X.Base64Encode(data)
    local out = {}
    local len = #data
    for i = 1, len, 3 do
        local a = string.byte(data, i)
        local b = i + 1 <= len and string.byte(data, i + 1) or 0
        local c = i + 2 <= len and string.byte(data, i + 2) or 0
        local n = a * 65536 + b * 256 + c
        out[#out + 1] = string.sub(b64chars, math.floor(n / 262144) + 1, math.floor(n / 262144) + 1)
        out[#out + 1] = string.sub(b64chars, math.floor(n / 4096) % 64 + 1, math.floor(n / 4096) % 64 + 1)
        out[#out + 1] = i + 1 <= len and string.sub(b64chars, math.floor(n / 64) % 64 + 1, math.floor(n / 64) % 64 + 1) or "="
        out[#out + 1] = i + 2 <= len and string.sub(b64chars, n % 64 + 1, n % 64 + 1) or "="
    end
    return table.concat(out)
end

function X.Base64Decode(data)
    data = data:gsub("[^A-Za-z0-9+/=]", "")
    local out = {}
    for i = 1, #data, 4 do
        local a = b64lookup[string.sub(data, i, i)] or 0
        local b = b64lookup[string.sub(data, i + 1, i + 1)] or 0
        local c = b64lookup[string.sub(data, i + 2, i + 2)] or 0
        local d = b64lookup[string.sub(data, i + 3, i + 3)] or 0
        local n = a * 262144 + b * 4096 + c * 64 + d
        out[#out + 1] = string.char(math.floor(n / 65536) % 256)
        if string.sub(data, i + 2, i + 2) ~= "=" then out[#out + 1] = string.char(math.floor(n / 256) % 256) end
        if string.sub(data, i + 3, i + 3) ~= "=" then out[#out + 1] = string.char(n % 256) end
    end
    return table.concat(out)
end

-- Key minification maps for smaller JSON before compression
local KEY_MINIFY = {
    Position = "P", Rotation = "R", Color = "C", Size = "S",
    Transparency = "T", Anchored = "A", CanCollide = "CC", ShowShadow = "SS",
    SecondaryPartPosition = "SP", SecondaryPartRotation = "SR",
    Length = "L", MatchRotation = "MR", AngleLimit = "AL",
    Damping = "D", Stiffness = "ST", MinLength = "ML", MaxLength = "XL",
    TargetLength = "TL", MaxLengthLimit = "XLL",
    ExtendLength = "EL", Speed = "SPD", LastDirrection = "LD",
    MaxSpeed = "MS", ReverseSpin = "RS", WheelTorque = "WT",
    MaxForce = "MF", MaxThrust = "MT", ThrustSpeed = "TS",
    ServoTorque = "SVT", ServoSpeed = "SVS", ReverseRotation = "RR",
    TargetAngle = "TA", AngularSpeed = "AS",
    WaitDuration = "WD", SemitoneOffset = "SO", Text = "TX",
    ShieldEnabled = "SE", MagnetEnabled = "ME", LightEnabled = "LE",
    LightColor = "LC", LightEnabled = "LE",
    DepthScale = "DS", HeadScale = "HS", HeightScale = "HTS", WidthScale = "WS",
    Keybinds = "KB", BlockConnections = "BC",
    BlockName = "BN", BlockPos = "BP", ControllerData = "CD",
    ControllerType = "CT", ControllerPos = "CP",
    TargetType = "TT", TargetPos = "TP", ConnectionType = "CNT",
    ControllerRef = "CR", ControllerId = "CI", ControllerRelativePos = "CRP",
    BindUp = "BU", BindDown = "BD", BindLeft = "BL", BindRight = "BR",
    BindFire = "BF", BindAim = "BA", BindInteract = "BI",
}

local KEY_EXPAND = {}
for full, short in pairs(KEY_MINIFY) do KEY_EXPAND[short] = full end

local function minifyKeys(tbl)
    if type(tbl) ~= "table" then return tbl end
    local out = {}
    for k, v in pairs(tbl) do
        local newKey = KEY_MINIFY[k] or k
        if type(v) == "table" then
            out[newKey] = minifyKeys(v)
        else
            out[newKey] = v
        end
    end
    return out
end

local function expandKeys(tbl)
    if type(tbl) ~= "table" then return tbl end
    local out = {}
    for k, v in pairs(tbl) do
        local newKey = KEY_EXPAND[k] or k
        if type(v) == "table" then
            out[newKey] = expandKeys(v)
        else
            out[newKey] = v
        end
    end
    return out
end

function X.SafeCompress(jsonString)
    -- Minify JSON keys before compression for smaller output
    local success, parsed = pcall(function()
        return X.HttpService:JSONDecode(jsonString)
    end)
    local toCompress = jsonString
    if success and parsed then
        local minified = minifyKeys(parsed)
        local ok, result = pcall(function()
            return X.HttpService:JSONEncode(minified)
        end)
        if ok and result then
            toCompress = result
        end
    end

    -- Skip compression for large data to avoid lag and LZ4 offset overflow
    if #toCompress > 50000 then
        return jsonString
    end

    local ok, compressed = pcall(LZ4.compress, toCompress)
    if not ok or not compressed then
        return jsonString
    end

    return "LZ4B:" .. X.Base64Encode(compressed)
end

function X.SafeDecompress(data)
    if type(data) ~= "string" or data == "" then
        return data
    end

    -- New format: LZ4 + Base64 + minified keys
    if string.sub(data, 1, 5) == "LZ4B:" then
        local encoded = string.sub(data, 6)
        local decodeSuccess, decompressed = pcall(function()
            local binary = X.Base64Decode(encoded)
            return LZ4.decompress(binary)
        end)

        if decodeSuccess and decompressed and decompressed ~= "" then
            -- Expand minified keys back to full names
            local ok, parsed = pcall(function()
                return X.HttpService:JSONDecode(decompressed)
            end)
            if ok and parsed then
                local expanded = expandKeys(parsed)
                local encOk, result = pcall(function()
                    return X.HttpService:JSONEncode(expanded)
                end)
                if encOk and result then
                    return result
                end
            end
            return decompressed
        end
    end

    -- Legacy format: LZ4 + byte table JSON (backward compat)
    if string.sub(data, 1, 4) == "LZ4:" then
        local encoded = string.sub(data, 5)
        local decodeSuccess, byteTable = pcall(function()
            return X.HttpService:JSONDecode(encoded)
        end)

        if decodeSuccess and byteTable and type(byteTable) == "table" then
            local decompressSuccess, decompressed = pcall(function()
                local parts = {}
                for _, byte in ipairs(byteTable) do
                    parts[#parts + 1] = string.char(byte)
                end
                return LZ4.decompress(table.concat(parts))
            end)

            if decompressSuccess and decompressed and decompressed ~= "" then
                return decompressed
            end
        end
    end

    -- Legacy format: old lualzw STRUCTURE: prefix
    if string.sub(data, 1, 10) == "STRUCTURE:" then
        return data
    end

    return data
end

X.Config = {
    zones = {
        blue = workspace["Really blueZone"],
        yellow = workspace["New YellerZone"],
        red = workspace["Really redZone"],
        magenta = workspace.MagentaZone,
        black = workspace.BlackZone,
        white = workspace.WhiteZone,
        green = workspace.CamoZone,
    },
    speedMode = 4,
    safeMode = false,
}

local BuildPreview = nil

if workspace:FindFirstChild("BuildPreview") then
    BuildPreview = workspace.BuildPreview
else
    BuildPreview = Instance.new("Model")
    BuildPreview.Name = "BuildPreview"
    BuildPreview.Parent = workspace
end

local player = X.Players.LocalPlayer
local playerData = player.Data
local deg = 57.29577951308232
local precision = 0.01
local defaultSize = Vector3.new(2, 2, 2)

local Color3_new = Color3.new
local Color3_fromRGB = Color3.fromRGB
local Vector3_new = Vector3.new
X.CFrame_new = CFrame.new
local CFrame_Angles = CFrame.Angles

X.math_floor = math.floor
local math_ceil = math.ceil

X.math_rad = math.rad
local math_pow = math.pow
local math_abs = math.abs

local string_split = string.split
local string_gsub = string.gsub
local string_find = string.find

X.table_insert = table.insert
local table_remove = table.remove

local loadstring = loadstring
local unpack = unpack
local task_spawn = task.spawn

local remoteInvoke = Instance.new("RemoteFunction").InvokeServer
local remoteFire = Instance.new("RemoteEvent").FireServer

local modelSetPrimary = Instance.new("Model").SetPrimaryPartCFrame

local workspaceFind = workspace.FindFirstChild
local workspaceDescendants = workspace.GetDescendants
local workspaceChildren = workspace.GetChildren
local workspaceDestroy = workspace.Destroy
local workspaceClone = workspace.Clone

local CFrameToAngles = CFrame.new().ToEulerAnglesXYZ
local CFrameToObjectSpace = CFrame.new().ToObjectSpace

local request = syn and syn.request or request or http_request

local rotX = 0
local rotY = 0 
local rotZ = 0
local moveMultiplier = 1

function X.ColorsAreEqual(color1, color2, tolerance)
    tolerance = tolerance or 0.01 -- tolerance 0.01%
    return math_abs(color1.R - color2.R) <= tolerance and
           math_abs(color1.G - color2.G) <= tolerance and
           math_abs(color1.B - color2.B) <= tolerance
end

function X.ShouldPaintBlock(blockName, targetColor)
    local defaultColorData = NormalColorBlock[blockName]
    
    if not defaultColorData then
        return true
    end
    
    local defaultColor = Color3.new(
        defaultColorData[1] or 1,
        defaultColorData[2] or 1,
        defaultColorData[3] or 1
    )
    
    return not X.ColorsAreEqual(targetColor, defaultColor)
end

-- Adaptive auto-speed state
X._auto = {
    timer = nil,
    interval = 0.3,        -- current yield interval (seconds)
    batchSize = 20,         -- how many ops before checking
    opCount = 0,            -- ops since last check
    lastResponseTime = 0,   -- last measured server response time
    responseTimes = {},     -- rolling window of recent response times
    maxSamples = 8,         -- how many samples to keep
    consecutiveSlow = 0,    -- streak of slow responses
    consecutiveFast = 0,    -- streak of fast responses
}

function X.AutoTrackResponse(duration)
    local auto = X._auto
    auto.lastResponseTime = duration
    auto.responseTimes[#auto.responseTimes + 1] = duration
    if #auto.responseTimes > auto.maxSamples then
        table.remove(auto.responseTimes, 1)
    end

    -- Calculate average response time from rolling window
    local sum = 0
    for _, t in ipairs(auto.responseTimes) do
        sum = sum + t
    end
    local avg = sum / #auto.responseTimes

    -- Adaptive logic: adjust interval and batch size based on server health
    if avg > 0.8 or duration > 1.2 then
        -- Server is struggling, back off
        auto.consecutiveFast = 0
        auto.consecutiveSlow = auto.consecutiveSlow + 1
        if auto.consecutiveSlow >= 2 then
            auto.interval = math.min(auto.interval + 0.15, 1.5)
            auto.batchSize = math.max(auto.batchSize - 2, 3)
            auto.consecutiveSlow = 0
        end
    elseif avg < 0.2 and duration < 0.3 then
        -- Server is fast, speed up
        auto.consecutiveSlow = 0
        auto.consecutiveFast = auto.consecutiveFast + 1
        if auto.consecutiveFast >= 3 then
            auto.interval = math.max(auto.interval - 0.05, 0.05)
            auto.batchSize = math.min(auto.batchSize + 2, 25)
            auto.consecutiveFast = 0
        end
    else
        -- Stable, gently converge toward a balanced interval
        auto.consecutiveSlow = 0
        auto.consecutiveFast = 0
        if auto.interval > 0.3 then
            auto.interval = auto.interval - 0.02
        end
    end
end

function X.ShouldWait(index)
    if X.Config.speedMode == -1 then
        -- Ultra: no yielding at all, remoteInvoke already yields to server
        return true
    end
    if X.Config.speedMode == 4 then
        -- Auto: adaptive yield based on server response health
        local auto = X._auto
        auto.opCount = auto.opCount + 1

        if not auto.timer then
            auto.timer = os.clock()
        end

        -- Only check every batchSize ops to reduce overhead
        if auto.opCount >= auto.batchSize then
            auto.opCount = 0
            local elapsed = os.clock() - auto.timer
            if elapsed >= auto.interval then
                task.wait()
                auto.timer = os.clock()
            end
        end
        return true
    end
    if X.Config.speedMode == 3 then
        if index % 5 == 0 then task.wait() end
        return true
    end
    if X.Config.speedMode == 2 then
        if index % 3 == 0 then task.wait() end
        return true
    end
    if X.Config.speedMode == 1 then
        if index % 2 == 0 then task.wait() end
        return true
    end
    return true
end

function X.Memoize(func)
    local cache = setmetatable({}, { __mode = "v" })
    return function(key)
        local value = cache[key]
        if not value then
            value = func(key)
            cache[key] = value
        end
        return value
    end
end

function X.ListBuilds()
    local files = listfiles("VoltaraBuildStorage")
    local builds = {}
    for _, file in next, files, nil do
        if string.sub(file, #file - 5, #file) == ".Build" or string.sub(file, #file - 6, #file) == ".vBuild" then
            
            local fileName = file:match("([^/\\]+)$") or file
            local extensionLength = (string.sub(file, #file - 5, #file) == ".Build" and 6 or 7)
            local buildName = string.sub(fileName, 1, #fileName - extensionLength)
            
            print("File path:", file)
            print("Extracted name:", buildName)
            
            X.table_insert(builds, {name = buildName, path = file}) 
        end
    end
    return builds
end

function X.DecodeColor(encoded)
    -- Handle different color formats
    if type(encoded) == "number" then
        -- In Lua 5.1 (Roblox), we need to use math.floor and division
        local r = math.floor(encoded / 16777216)  -- 256^3
        local remaining = encoded - (r * 16777216)
        local g = math.floor(remaining / 65536)    -- 256^2
        remaining = remaining - (g * 65536)
        local b = math.floor(remaining / 256)      -- 256^1
        local a = remaining - (b * 256)             -- 256^0
        
        return {
            Color = Color3.fromRGB(r, g, b),
            Alpha = a
        }
    elseif type(encoded) == "string" then
        local r, g, b, a = string.match(encoded, "(%d+),(%d+),(%d+),(%d+)")
        if r and g and b and a then
            return {
                Color = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)),
                Alpha = tonumber(a)
            }
        end
        
        local r, g, b = string.match(encoded, "(%d+),(%d+),(%d+)")
        if r and g and b then
            return {
                Color = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)),
                Alpha = 255
            }
        end
    end
    
    return {
        Color = Color3.new(1, 1, 1),
        Alpha = 255
    }
end

X.GetColor = X.Memoize(X.DecodeColor)

function X.CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in next, properties, nil do
        instance[property] = value
    end
    return instance
end

function X.AnglesString(angles)
    local split = string_split(angles, ",")
    return CFrame_Angles(X.math_rad(split[1]), X.math_rad(split[2]), X.math_rad(split[3]))
end

function X.String(value)
    return string_gsub(tostring(value), " ", "")
end

function X.Raw(value)
    return unpack(string_split(value, ","))
end

function X.Floor(value, decimals)
    return X.math_floor((value * 10 ^ decimals + 0.5)) / 10 ^ decimals
end

function X.GetStringAngles(cframe)
    local x, y, z = CFrameToAngles(cframe)
    return X.Floor(x * deg, 5) .. "," .. X.Floor(y * deg, 5) .. "," .. X.Floor(z * deg, 5)
end

function X.GetAngles(cframe)
    local x, y, z = CFrameToAngles(cframe)
    return CFrame_Angles(x, y, z)
end

function X.GetTeam()
    print(player.Team)
end

function X.GetPlot()
    return X.Config.zones[tostring(player.Team)]
end

local teamPlayersCache = {}

function X.GetTeamPlayers(team)
	local players = {}
	for _, player in ipairs(X.Players:GetPlayers()) do
		if tostring(player.Team) == team then
			X.table_insert(players, player.Name)
		end
	end
	return players
end

function X.GetBlocks(team)
    local teamPlayers = X.GetTeamPlayers(team)
    local blocks = {}
    
    for _, playerName in ipairs(teamPlayers) do
        local playerBlocks = workspace.Blocks:FindFirstChild(playerName)
        
        if playerBlocks then
            for _, block in ipairs(playerBlocks:GetChildren()) do
                if block:FindFirstChild("Health") then
                    X.table_insert(blocks, block)
                end
            end
        end
    end
    
    return blocks
end

function X.GetTeamBlocks(team)
	return X.GetBlocks(team)
end

function X.GetPreviewBlocks()
    local blocks = {}
    for _, block in next, workspaceChildren(BuildPreview), nil do
        X.table_insert(blocks, block)
    end
    return blocks
end

function X.GetTool(toolName)
    local tool = workspaceFind(player.Backpack, toolName)
    if tool then
        tool = player.Backpack[toolName].RF
        if tool then
            return tool
        end
    else
        tool = workspaceFind(player.Character, toolName)
        if tool then
            tool = player.Character[toolName].RF
            return tool
        end
    end
    return nil
end

local existingGui = game:GetService("CoreGui"):FindFirstChild("progressBar")
if existingGui then
    existingGui:Destroy()
end

local screenGui = X.CreateInstance("ScreenGui", {
    Parent = game:GetService("CoreGui"),
    Name = "progressBar",
})

local progressBar = X.CreateInstance("Frame", {
    Parent = screenGui,
    Name = "ProgressContainer",
    BackgroundColor3 = Color3_fromRGB(20, 20, 20),
    BackgroundTransparency = 0.025,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 1, -97),
    Size = UDim2.new(0, 300, 0, 90),
})

-- Add corner radius
X.CreateInstance("UICorner", {
    Parent = progressBar,
    CornerRadius = UDim.new(0, 8),
})

-- Add border stroke
X.CreateInstance("UIStroke", {
    Parent = progressBar,
    Color = Color3_fromRGB(50, 50, 50),
    Thickness = 1,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
})

-- Title
X.CreateInstance("TextLabel", {
    Parent = progressBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 15),
    Size = UDim2.new(1, -30, 0, 18),
    Font = Enum.Font.GothamBold,
    Text = "Building Progress",
    TextColor3 = Color3_fromRGB(255, 255, 255),
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ZIndex = 2,
})

-- Progress bar background
X.CreateInstance("Frame", {
    Parent = progressBar,
    BackgroundColor3 = Color3_fromRGB(64, 64, 64),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 15, 0, 43),
    Size = UDim2.new(1, -30, 0, 14),
    ZIndex = 1,
})

X.CreateInstance("UICorner", {
    Parent = progressBar:FindFirstChild("Frame"),
    CornerRadius = UDim.new(0, 3),
})

-- Progress bar fill
local progressFill = X.CreateInstance("Frame", {
    Parent = progressBar:FindFirstChild("Frame"),
    Name = "ProgressFill",
    BackgroundColor3 = Color3_fromRGB(59, 130, 246),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0, 0, 1, 0),
    ZIndex = 2,
})

X.CreateInstance("UICorner", {
    Parent = progressFill,
    CornerRadius = UDim.new(0, 3),
})

-- Progress text (percentage) - overlay on bar
local progressText = X.CreateInstance("TextLabel", {
    Parent = progressBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 43),
    Size = UDim2.new(1, -30, 0, 14),
    Font = Enum.Font.GothamBold,
    Text = "0%",
    TextColor3 = Color3_fromRGB(255, 255, 255),
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,
    ZIndex = 3,
})

-- Action text
local actionText = X.CreateInstance("TextLabel", {
    Parent = progressBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 67),
    Size = UDim2.new(1, -30, 0, 14),
    Font = Enum.Font.GothamBold,
    Text = "Ready",
    TextColor3 = Color3_fromRGB(200, 200, 200),
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ZIndex = 2,
})

local totalBlocks = 0
local processedBlocks = 0
local currentStatus = "Ready"
local currentAction = "Building"
local scaledBlocksCount = 0
local propertiesBlocksCount = 0
local paintedBlocksCount = 0

function X.UpdateProgression(text)
    local progress = progressText
    local typeofText = typeof(text)
    local progressValue = 0
    
    if typeofText == "number" then
        progressValue = math.min(math_ceil(text), 100)
        typeofText = progressValue .. "%"
    else
        typeofText = text
        progressValue = 0
    end
    
    progress.Text = typeofText
    
    -- Animate the progress bar fill
    local bgFrame = progressBar:FindFirstChild("Frame")
    if bgFrame then
        local fillElement = bgFrame:FindFirstChild("ProgressFill")
        if fillElement then
            local barWidth = bgFrame.AbsoluteSize.X
            local fillWidth = (progressValue / 100) * barWidth
            local tweenInfo = TweenInfo.new(
                0.2,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            )
            local tween = game:GetService("TweenService"):Create(
                fillElement,
                tweenInfo,
                { Size = UDim2.new(0, fillWidth, 1, 0) }
            )
            tween:Play()
        end
    end
end

-- Enhanced progression update with status and block count
function X.UpdateProgressionWithStatus(progress, status, blocksProcessed, blocksTotal)
    -- Update progress bar percentage
    if progress then
        X.UpdateProgression(progress)
    end
    
    -- Update action text
    if status then
        currentAction = status
        actionText.Text = status
    end
end

-- Quick status update function
function X.SetStatus(statusMessage)
    currentAction = statusMessage
    actionText.Text = statusMessage
end

-- Set total blocks count
function X.SetTotalBlocks(count)
    totalBlocks = count
    processedBlocks = 0
end

-- Increment processed block count
function X.IncrementBlocksProcessed()
    processedBlocks = processedBlocks + 1
    return processedBlocks
end

local function getBindToolRF()
    local character = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local tool = (character and character:FindFirstChild("BindTool")) or (backpack and backpack:FindFirstChild("BindTool"))
    return tool and (tool:FindFirstChild("RF") or tool:FindFirstChild("RF2"))
end

local CollectionService = game:GetService("CollectionService")

local function isControllerModel(model)
    if not model or not model:IsA("Model") then return false end
    if model:FindFirstChild("ControllerId") or model:FindFirstChild("ControllerRefTemplate") then
        return true
    end
    if model:FindFirstChild("VehicleSeat") then
        return true
    end
    local n = model.Name
    if n == "Lever" or n == "Switch" or n == "SwitchBig" or n == "Button" or n == "Delay" or n == "Gate" then
        return true
    end
    if CollectionService:HasTag(model, "SeatInput") or CollectionService:HasTag(model, "SwitchInput") then
        return true
    end
    return false
end

local function getAllControllers()
    local blocksFolder = workspace:FindFirstChild("Blocks")
    if not blocksFolder then return {} end
    local controllers = {}
    for _, folder in ipairs(blocksFolder:GetChildren()) do
        for _, model in ipairs(folder:GetChildren()) do
            if isControllerModel(model) then
                table.insert(controllers, model)
            end
        end
    end
    return controllers
end

local function findControllerForBlock(block)
    local blocksFolder = workspace:FindFirstChild("Blocks")
    if not blocksFolder then return nil end
    for _, folder in ipairs(blocksFolder:GetChildren()) do
        for _, model in ipairs(folder:GetChildren()) do
            if model:IsA("Model") then
                for _, child in ipairs(model:GetChildren()) do
                    if child:IsA("Beam") and child.Attachment1 and child.Attachment1.Parent and child.Attachment1.Parent.Parent == block then
                        return model
                    end
                end
            end
        end
    end
    return nil
end

local function findBlockByNameAndPos(blockName, posString)
    local blocksFolder = workspace:FindFirstChild("Blocks")
    if not blocksFolder then return nil end
    if not posString then
        for _, folder in ipairs(blocksFolder:GetChildren()) do
            local block = folder:FindFirstChild(blockName)
            if block and block:IsA("Model") then
                return block
            end
        end
        return nil
    end

    local ok, targetPos = pcall(function()
        return Vector3_new(X.Raw(posString))
    end)
    if not ok then
        return nil
    end

    local best = nil
    local bestDist = math.huge
    for _, folder in ipairs(blocksFolder:GetChildren()) do
        for _, block in ipairs(folder:GetChildren()) do
            if block:IsA("Model") and block.Name == blockName then
                local part = block:FindFirstChild("PPart") or block.PrimaryPart
                if part then
                    local dist = (part.Position - targetPos).Magnitude
                    if dist < bestDist then
                        best = block
                        bestDist = dist
                    end
                end
            end
        end
    end
    return best
end

local function findControllerByHint(name, posString)
    local blocksFolder = workspace:FindFirstChild("Blocks")
    if not blocksFolder then return nil end
    local best = nil
    local bestDist = math.huge

    local targetPos = nil
    if posString then
        local ok, vec = pcall(function()
            return Vector3_new(X.Raw(posString))
        end)
        if ok then
            targetPos = vec
        end
    end

    for _, folder in ipairs(blocksFolder:GetChildren()) do
        for _, model in ipairs(folder:GetChildren()) do
            if model:IsA("Model") and model.Name == name then
                if not targetPos or not model.PrimaryPart then
                    return model
                end
                local dist = (model.PrimaryPart.Position - targetPos).Magnitude
                if dist < bestDist then
                    best = model
                    bestDist = dist
                end
            end
        end
    end
    return best
end

function X.ExtractConnections(teamName)
    local connections = {}
    
    local teamPlayers = X.GetTeamPlayers(teamName)
    if not teamPlayers or #teamPlayers == 0 then
        return connections
    end
    
    local zone = X.Config.zones[teamName] or X.GetPlot()
    if not zone then
        return connections
    end
    
    -- First pass: collect all controllers (including Pistons for weld tracking)
    local controllers = {}
    for _, playerName in ipairs(teamPlayers) do
        local playerFolder = workspace.Blocks:FindFirstChild(playerName)
        if playerFolder then
            for _, block in ipairs(playerFolder:GetChildren()) do
                if block:IsA("Model") then
                    local isController = block.Name:match("Switch")
                        or block.Name:match("Button")
                        or block.Name:match("Lever")
                        or block.Name:match("Gate")
                        or block.Name:match("Delay")
                        or block.Name:match("VehicleSeat")
                        or block.Name:match("CarSeat")
                        or block.Name:match("PilotSeat")
                        or block.Name == "Piston"

                    if isController then
                        local part = block:FindFirstChild("PPart") or block.PrimaryPart
                        if part then
                            -- Convert to RELATIVE position (same as how blocks are saved)
                            local relativeCF = zone.CFrame:ToObjectSpace(part.CFrame)
                            controllers[block] = {
                                type = block.Name,
                                position = relativeCF.p,
                                model = block
                            }
                        end
                    end
                end
            end
        end
    end
    
    -- Find connections
    for controller, controllerInfo in pairs(controllers) do
        for _, playerName in ipairs(teamPlayers) do
            local playerFolder = workspace.Blocks:FindFirstChild(playerName)
            if playerFolder then
                for _, block in ipairs(playerFolder:GetChildren()) do
                    if block:IsA("Model") and block ~= controller then
                        local connected = false
                        local connectionType = nil
                        
                        -- Check for ControllerId
                        local controllerId = block:FindFirstChild("ControllerId")
                        if controllerId and controllerId.Value == controller then
                            connected = true
                            connectionType = "ControllerId"
                        end
                        
                        -- Check for ControllerRef
                        local controllerRef = block:FindFirstChild("ControllerRef")
                        if controllerRef and controllerRef.Value == controller then
                            connected = true
                            connectionType = "ControllerRef"
                        end
                        
                        -- Check for weld constraints
                        if not connected then
                            for _, constraint in ipairs(controller:GetDescendants()) do
                                if constraint:IsA("WeldConstraint") or constraint:IsA("Weld") then
                                    local part0 = constraint.Part0
                                    local part1 = constraint.Part1
                                    
                                    if (part0 and part0:IsDescendantOf(block)) or 
                                       (part1 and part1:IsDescendantOf(block)) then
                                        connected = true
                                        connectionType = "WeldConstraint"
                                        break
                                    end
                                end
                            end
                        end
                        
                        if connected then
                            local targetPart = block:FindFirstChild("PPart") or block.PrimaryPart
                            if targetPart then
                                -- Convert target position to RELATIVE
                                local targetRelativeCF = zone.CFrame:ToObjectSpace(targetPart.CFrame)
                                
                                table.insert(connections, {
                                    ControllerType = controller.Name,
                                    ControllerPos = X.String(controllerInfo.position), -- Already relative
                                    TargetType = block.Name,
                                    TargetPos = X.String(targetRelativeCF.p),
                                    ConnectionType = connectionType
                                })
                            end
                        end
                    end
                end
            end
        end
    end
    
    return connections
end

function X.ExtractKeybinds(teamName)
    local keybinds = {}
    
    local teamPlayers = X.GetTeamPlayers(teamName)
    if not teamPlayers or #teamPlayers == 0 then
        return keybinds
    end
    
    local zone = X.Config.zones[teamName] or X.GetPlot()
    if not zone then
        return keybinds
    end
    
    -- First, collect all controllers and their relative positions
    local controllersByModel = {}
    for _, playerName in ipairs(teamPlayers) do
        local playerFolder = workspace.Blocks:FindFirstChild(playerName)
        if playerFolder then
            for _, block in ipairs(playerFolder:GetChildren()) do
                if typeof(block) == "Instance" and block:IsA("Model") then
                    local isController = block.Name:match("Switch") 
                        or block.Name:match("Button") 
                        or block.Name:match("Lever")
                        or block.Name:match("Gate")
                        or block.Name:match("Delay")
                        or block.Name:match("VehicleSeat")
                        or block.Name:match("CarSeat")
                        or block.Name:match("PilotSeat")
                    
                    if isController then
                        local part = block:FindFirstChild("PPart") or block.PrimaryPart
                        if part then
                            local relativeCF = zone.CFrame:ToObjectSpace(part.CFrame)
                            controllersByModel[block] = {
                                name = block.Name,
                                relativePos = relativeCF.p
                            }
                        end
                    end
                end
            end
        end
    end
    
    -- Now find blocks with keybinds to these controllers
    for _, playerName in ipairs(teamPlayers) do
        local playerFolder = workspace.Blocks:FindFirstChild(playerName)
        if playerFolder then
            for _, block in ipairs(playerFolder:GetChildren()) do
                if typeof(block) == "Instance" and block:IsA("Model") then
                    local hasControllerConnection = false
                    local controllerData = {}
                    
                    -- Check for ControllerRef
                    local controllerRef = block:FindFirstChild("ControllerRef")
                    if controllerRef and controllerRef:IsA("ObjectValue") and controllerRef.Value then
                        local controller = controllerRef.Value
                        if controllersByModel[controller] then
                            controllerData.ControllerRef = controller.Name
                            controllerData.ControllerRelativePos = X.String(controllersByModel[controller].relativePos)
                            hasControllerConnection = true
                        end
                    end
                    
                    -- Check for ControllerId
                    local controllerId = block:FindFirstChild("ControllerId")
                    if controllerId and controllerId:IsA("ObjectValue") and controllerId.Value then
                        local controller = controllerId.Value
                        if controllersByModel[controller] then
                            controllerData.ControllerId = controller.Name
                            controllerData.ControllerRelativePos = X.String(controllersByModel[controller].relativePos)
                            hasControllerConnection = true
                        end
                    end
                    
                    -- Only save keybinds for non-controller blocks
                    local isController = block.Name:match("Switch") 
                        or block.Name:match("Button") 
                        or block.Name:match("CarSeat")
                        or block.Name:match("PilotSeat")
                        or block.Name:match("Lever")
                        or block.Name:match("Gate")
                        or block.Name:match("Delay")
                        or block.Name:match("VehicleSeat")
                    
                    if not isController then
                        -- Save actual bind values
                        local bindAttributes = {"BindUp", "BindDown", "BindLeft", "BindRight", "BindFire", "BindAim", "BindInteract"}
                        local blockKeybinds = {}
                        
                        for _, bindName in ipairs(bindAttributes) do
                            local bindValue = block:FindFirstChild(bindName)
                            if bindValue and bindValue:IsA("IntValue") and bindValue.Value ~= -1 then
                                blockKeybinds[bindName] = bindValue.Value
                                hasControllerConnection = true
                            end
                        end
                        
                        if next(blockKeybinds) then
                            controllerData.Keybinds = blockKeybinds
                        end
                    end
                    
                    -- Save if there's any connection
                    if hasControllerConnection then
                        local part = block:FindFirstChild("PPart") or block.PrimaryPart
                        if part then
                            local relativeCF = zone.CFrame:ToObjectSpace(part.CFrame)
                            
                            table.insert(keybinds, {
                                BlockName = block.Name,
                                BlockPos = X.String(relativeCF.p),
                                ControllerData = controllerData
                            })
                        end
                    end
                end
            end
        end
    end
    
    return keybinds
end

function X.Encode(blocks, teamName)
    if not blocks or #blocks == 0 then
        warn("No blocks provided")
        return nil
    end
    
    local encoded = {}
    local zone = nil
    if teamName then
        zone = X.Config.zones[teamName]
        if not zone then
            zone = X.GetPlot()
        end
    else
        zone = X.GetPlot()
    end
    
    if not zone then
        warn("No valid zone found")
        return nil
    end
    
    X.CurrentZone = zone
    local blocksEncoded = 0
    
    for _, block in next, blocks, nil do
        if not block or not block.Name or not block.PPart then
            warn("Invalid block structure", block)
            continue
        end
        
        local blockName = block.Name
        local part = block.PPart
        if not encoded[blockName] then
            encoded[blockName] = {}
        end
        
        local relativeCFrame = CFrameToObjectSpace(zone.CFrame, part.CFrame)
        local blockData = {
            Rotation = X.GetStringAngles(relativeCFrame),
            Position = X.String(relativeCFrame.p),
        }
        
        if part.CastShadow ~= true then
            blockData.ShowShadow = false
        end
        
        if part.CanCollide ~= true then
            blockData.CanCollide = false
        end
        
        if part.Anchored ~= true then
            blockData.Anchored = false
        end
        
        if part.Transparency > 0 then
            blockData.Transparency = part.Transparency
        end
        
        if not string_find(blockName, "Block") or part.Size ~= Vector3_new(2, 2, 2) then
            blockData.Size = X.String(part.Size)
        end
        
        if part.Color ~= BuildingParts[blockName].PPart.Color then
            blockData.Color = X.String(part.Color)
        end

        if blockName == "Spring" or blockName == "Bar" or blockName == "Rope" then
            local secondaryPart = nil
            local secondaryFolder = block:FindFirstChild("SecondaryPart")
            if secondaryFolder then
                secondaryPart = secondaryFolder:FindFirstChild("Part") or secondaryFolder:FindFirstChildWhichIsA("BasePart")
            end
            if not secondaryPart then
                for _, child in ipairs(block:GetDescendants()) do
                    if child:IsA("BasePart") and child ~= part then
                        secondaryPart = child
                        break
                    end
                end
            end
            if secondaryPart then
                local secCF = zone.CFrame:ToObjectSpace(secondaryPart.CFrame)
                local srx, sry, srz = secCF:ToEulerAnglesXYZ()
                blockData.SecondaryPartRotation = string.format("%.3f, %.3f, %.3f", math.deg(srx), math.deg(sry), math.deg(srz))
                blockData.SecondaryPartPosition = string.format("%.6f, %.6f, %.6f", secCF.X, secCF.Y, secCF.Z)
            end
        end

        X.table_insert(encoded[blockName], blockData)
        blocksEncoded = blocksEncoded + 1
    end
    
    if blocksEncoded == 0 then
        warn("No blocks were successfully encoded")
        return nil
    end
    
    local success, result = pcall(function()
        return X.HttpService:JSONEncode(encoded)
    end)
    
    if success then
        print("Successfully encoded " .. blocksEncoded .. " blocks")
        return result
    else
        warn("Failed to JSON encode -", result)
        return nil
    end
end

function X.Decode(json, scale)
    if not json or json == "" then
        warn("Empty Build File")
        return {}
    end
    
    local decoded = {}
    if not scale then
        scale = 1
    end

    local success, result = xpcall(function()
        decoded = X.HttpService:JSONDecode(json)
    end, function(err)
        warn("Nigga Json: ", err)
    end)
    
    if not success then
        return {}
    end

    local blockTypesProcessed = 0
    local totalBlocksDecoded = 0
    
    for blockName, blockData in next, decoded, nil do
        if blockName == "Keybinds" or blockName == "BlockConnections" then
            continue
        end
        if workspaceFind(BuildingParts, blockName) then
            local blocksInType = 0
            for _, data in next, blockData, nil do
                local entry = decoded[blockName][_]
                if entry then
                    local posSuccess, pos = pcall(function()
                        return X.CFrame_new(Vector3_new(X.Raw(data.Position)) * scale)
                    end)
                    local rotSuccess, rot = pcall(function()
                        return X.AnglesString(data.Rotation)
                    end)
                    
                    if posSuccess and rotSuccess then
                        entry.Position = pos
                        entry.Rotation = rot
                        entry.Color = data.Color and pcall(function() return Color3_new(X.Raw(data.Color)) end) and Color3_new(X.Raw(data.Color)) or nil
                        entry.Size = data.Size and (data.Size ~= "2,2,2" and Vector3_new(X.Raw(data.Size)) * scale or nil)
                        decoded[blockName][_] = entry
                        blocksInType = blocksInType + 1
                    else
                        warn("Failed to parse block: ", blockName)
                    end
                end
            end
            blockTypesProcessed = blockTypesProcessed + 1
            totalBlocksDecoded = totalBlocksDecoded + blocksInType
        else
            decoded[blockName] = nil
        end
    end
    return decoded
end

function X.Convert(filename)
    if not filename or filename == "" then
        warn("No filename provided")
        return nil
    end
    
    local success, content = pcall(function()
        return readfile(filename)
    end)
    
    if not success then
        warn("Failed to read file ", filename)
        return nil
    end
    
    if not content or content == "" then
        warn("File is empty ", filename)
        return nil
    end
    
    local converted = {}
    if not string_find(content, "/") then
        return nil
    end
    
    local blocksConverted = 0
    for _, entry in next, string_split(content, "/"), nil do
        if entry and entry ~= "" then
            local parts = string_split(entry, ":")
            if #parts == 5 and workspaceFind(BuildingParts, parts[5]) then
                if not converted[parts[5]] then
                    converted[parts[5]] = {}
                end
                
                local posSuccess, rotSuccess = pcall(function()
                    local relativeCFrame = CFrameToObjectSpace(X.CFrame_new(0, -17.9999924, 0), 
                        X.CFrame_new(X.Raw(parts[1])) * X.AnglesString(parts[2]))
                    
                    local blockInfo = {
                        Color = parts[3] ~= "-" and parts[3] or nil,
                        Size = parts[4] ~= "-" and parts[4] or nil,
                        Position = X.String(relativeCFrame.p),
                        Rotation = X.GetStringAngles(relativeCFrame)
                    }
                    
                    X.table_insert(converted[parts[5]], blockInfo)
                end)
                
                if posSuccess and rotSuccess then
                    blocksConverted = blocksConverted + 1
                else
                    warn("Failed to parse block entry. ", entry)
                end
            end
        end
    end
    
    if blocksConverted == 0 then
        return nil
    end
    
    local encodeSuccess, result = pcall(function()
        return X.HttpService:JSONEncode(converted)
    end)
    
    if encodeSuccess then
        return result
    else
        return nil
    end
end

local function unbindAllWithAllControllers()
	local Players = game:GetService("Players")
	local CollectionService = game:GetService("CollectionService")

	local lp = Players.LocalPlayer

	local function getBindToolRF()
		local backpack = lp:FindFirstChild("Backpack") or lp:WaitForChild("Backpack", 5)
		local char = lp.Character
		local tool = (backpack and backpack:FindFirstChild("BindTool")) or (char and char:FindFirstChild("BindTool"))
		return tool and tool:FindFirstChild("RF")
	end

	local function isController(model)
		if not model then return false end
		if model:FindFirstChild("VehicleSeat") then return true end
		local n = model.Name
		if n == "Lever" or n == "Switch" or n == "SwitchBig" or n == "Button" or n == "Delay" or n == "Gate" then
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
		local myFolder = blocksFolder:FindFirstChild(lp.Name)
		if not myFolder then return {} end
		return myFolder:GetChildren()
	end

	local rf = getBindToolRF()
	if not rf then
		return
	end

	local blocks = getMyBlocks()

	local controllers = {}
	local binds = {}

	for _, model in ipairs(blocks) do
		if model:IsA("Model") then
			if isController(model) then
				table.insert(controllers, model)
			end
			-- FIX: Check if child exists and is an IntValue before accessing
			for _, child in ipairs(model:GetChildren()) do
				-- Only process IntValues with names starting with "Bind"
				if child:IsA("IntValue") and child.Name:sub(1, 4) == "Bind" then
					table.insert(binds, child)
				end
			end
		end
	end

	if #controllers == 0 then
		return
	end

	local count = 0
	local threads = 0
	for _, controller in ipairs(controllers) do
		for _, bindVal in ipairs(binds) do
			threads = threads + 1
			task_spawn(function()
				local success = pcall(function()
					rf:InvokeServer({ bindVal }, controller, -1, true)
				end)
				if success then
					bindVal.Value = -1
					count += 1
				end
				threads = threads - 1
			end)
			-- Batch 10 at a time
			if threads >= 10 then
				while threads >= 10 do task.wait() end
			end
		end
	end
	-- Wait for all unbind calls to finish
	while threads > 0 do task.wait() end
end

local PropertiesToSave = {
    Default = {
        "ShowShadow",  -- PPart.CastShadow (inverted)
        "CanCollide",  -- PPart.CanCollide
        "Anchored",    -- PPart.Anchored
        "Color",       -- PPart.Color (only if different from default)
        "Rotation",    -- Calculated from CFrame
        "Position",    -- Calculated from CFrame
        "Transparency",-- TransparencyModifier.Value or default for GlassBlock
        "Size"         -- Only if not default (2,2,2)
    },
    
    Fireworks = {
        "FlightDistance",
        "FuseTime"
    },

    Jets = {
        JetTurbine = { "MaxForce", "MaxSpeed" },
        SonicJetTurbine = { "MaxForce", "MaxSpeed" },
        SmallJet = { "MaxForce", "MaxSpeed" }
    },
 
    Wheels = {
        WheelBlock = { "MaxSpeed", "ReverseSpin", "WheelTorque" },
        LargeWheel = { "MaxSpeed", "ReverseSpin", "WheelTorque" },
        FrontWheel = { "MaxSpeed", "ReverseSpin", "WheelTorque" },
        BackWheel = { "MaxSpeed", "ReverseSpin", "WheelTorque" },
        RearWheel = { "MaxSpeed", "ReverseSpin", "WheelTorque" },
        LeftWheel = { "MaxSpeed", "ReverseSpin", "WheelTorque" },
        RightWheel = { "MaxSpeed", "ReverseSpin", "WheelTorque" }
    },

    Aim = {
        "Aim"
    },
    
    Cameras = {
        "ShowCrosshairs"
    },
    
    Activators = {
        "On"
    },
    
    Specials = {
        Servo = {
            "ServoTorque",
            "ServoSpeed",
            "ReverseRotation",
            "TargetAngle"
        },
        
        Piston = {
            "ExtendLength",
            "Speed",
            "LastDirrection"
        },
        
        Delay = {
            "WaitDuration"
        },

        Magnet = { --
            "MagnetEnabled"
        },

        ShieldGenerator = {
            "ShieldEnabled"
        },
        
        Note = {
            "SemitoneOffset"
        },
        
        Rope = {
            "Length",
            "MatchRotation",
            "SecondaryPartRotation",
            "SecondaryPartPosition"
        },
        
        Sign = {
            "Text"
        },
        
        CandyRed = {
            "DepthScale",
            "HeadScale",
            "HeightScale",
            "WidthScale"
        },
        CandyBlue = {
            "DepthScale",
            "HeadScale",
            "HeightScale",
            "WidthScale"
        },
        
        Bar = {
            "Length",
            "AngleLimit",
            "MatchRotation",
            "SecondaryPartRotation",
            "SecondaryPartPosition"
        },

        Spring = {
            "Damping",
            "MaxLength",        -- This is actually FreeLength
            "MaxLengthLimit",   -- Actual MaxLength
            "TargetLength",
            "MinLength",
            "Stiffness",
            "SecondaryPartRotation",
            "SecondaryPartPosition"
        }
    },
    
    SpecialCollision = {
        BoxingGlove = {"CanCollide"},         -- From Glove part
        BoatMotor = {"CanCollide"},           -- From Motor.Bottom
        BoatMotorUltra = {"CanCollide"},      -- From Motor.Bottom
        BoatMotorWinter = {"CanCollide"},     -- From Motor.Bottom
        LockedDoor = {"CanCollide"},          -- From Part
        Portal = {"CanCollide"},              -- From Light
        SpikeTrap = {"CanCollide"},           -- From Box
        PineTree = {"CanCollide"},            -- From Leaves4
        WoodDoor = {"CanCollide"},            -- From Door.DoorFrame
        WoodTrapDoor = {"CanCollide"}         -- From Door.DoorFrame
    },
    
    Lamp = {
        "LightColor",  -- From Light.Color
        "LightEnabled" -- From Light.Enabled
    },
    
    VehicleController = {
        "MaxSpeed",
        "ThrustSpeed",
        "TurnSpeed",
        "HoverForce",
        "HoverHeight"
    },
    
    Thrusters = {
        "MaxThrust",
        "ThrustSpeed"
    },
    
    Buttons = {
        "ButtonColor",
        "ButtonState"
    },
    
    Switches = {
        "SwitchState"
    },
    
    Timers = {
        "Interval",
        "Enabled"
    },
    
    TextDisplays = {
        "Text",
        "TextColor",
        "TextSize",
        "BackgroundColor"
    },
    
    NumberDisplays = {
        "Value",
        "TextColor",
        "BackgroundColor"
    },
    
}

local BlockNameAlias = {
    FrontWheel = "WheelBlock",
    RearWheel = "WheelBlock",
    LeftWheel = "WheelBlock",
    RightWheel = "WheelBlock",
    BackWheel = "WheelBlock",  -- ADDED
    BigWheel = "LargeWheel"
}

function X.SavePlot(filename, teamName)
    if not filename or not teamName then
        return
    end

    local cleanFilename = filename:gsub("%.Build$", ""):gsub("%.vBuild$", "")
    local filePath = "VoltaraBuildStorage/" .. cleanFilename .. ".vBuild"
    
    local function GetTeamPlayers(team)
        local players = {}
        for _, player in ipairs(X.Players:GetPlayers()) do
            if tostring(player.Team) == team then
                X.table_insert(players, player.Name)
            end
        end
        return players
    end
    
    local teamPlayers = GetTeamPlayers(teamName)
    if not teamPlayers or #teamPlayers == 0 then
        X.SetStatus("No players on team")
        return
    end

    local zone = X.Config.zones[teamName]
    if not zone then
        X.SetStatus("No zone found")
        return
    end

    X.SetStatus("Scanning blocks...")
    local blockData = {}
    local scanCount = 0

    for _, playerName in ipairs(teamPlayers) do
        local playerFolder = workspace.Blocks:FindFirstChild(playerName)
        if playerFolder then
            for _, block in ipairs(playerFolder:GetChildren()) do
                if block:IsA("Model") and block:FindFirstChild("PPart") then
                    scanCount = scanCount + 1
                    if scanCount % 200 == 0 then
                        --X.SetStatus(string.format("Scanning: %d blocks...", scanCount))
                        task.wait()
                    end
                    local PPart = block.PPart
                    local blockInfo = {}
                    
                    blockInfo.ShowShadow = PPart.CastShadow ~= false
                    blockInfo.CanCollide = PPart.CanCollide
                    blockInfo.Anchored = PPart.Anchored
                    
                    local relativeCF = zone.CFrame:ToObjectSpace(PPart.CFrame)
                    local rx, ry, rz = relativeCF:ToEulerAnglesXYZ()
                    blockInfo.Rotation = string.format("%.3f, %.3f, %.3f", math.deg(rx), math.deg(ry), math.deg(rz))
                    blockInfo.Position = string.format("%.6f, %.6f, %.6f", relativeCF.X, relativeCF.Y, relativeCF.Z)
                    
                    if NormalColorBlock[block.Name] then
                        local defaultColor = Color3.new(unpack(NormalColorBlock[block.Name]))
                        if PPart.Color ~= defaultColor then
                            blockInfo.Color = string.format("%.6f, %.6f, %.6f", PPart.Color.R, PPart.Color.G, PPart.Color.B)
                        end
                    else
                        blockInfo.Color = string.format("%.6f, %.6f, %.6f", PPart.Color.R, PPart.Color.G, PPart.Color.B)
                    end
                    
                    if block:FindFirstChild("TransparencyModifier") then
                        blockInfo.Transparency = block.TransparencyModifier.Value
                    elseif block.Name == "GlassBlock" then
                        blockInfo.Transparency = 0.5
                    end
                    
                    if PPart.Size ~= Vector3.new(2, 2, 2) then
                        blockInfo.Size = string.format("%.6f, %.6f, %.6f", PPart.Size.X, PPart.Size.Y, PPart.Size.Z)
                    end

                    if block.Name == "Sign" then
                        local stringInput = block:FindFirstChild("StringInput")
                        if stringInput and stringInput:IsA("StringValue") then
                            blockInfo.Text = stringInput.Value
                        end
                    end
        
                    -- Save ShieldGenerator state
                    if block.Name == "ShieldGenerator" then
                        local onValue = block:FindFirstChild("On")
                        if onValue and onValue:IsA("BoolValue") then
                            -- Save as 1 if true, 0 if false
                            blockInfo.ShieldEnabled = onValue.Value and 1 or 0
                        end
                    end

                    -- Save Magnet state based on TouchInterest existence
                    if block.Name == "Magnet" then
                        local magnetField = block:FindFirstChild("MagnetField")
                        if magnetField then
                            local touchInterest = magnetField:FindFirstChild("TouchInterest")
                            -- Save as 1 if TouchInterest exists, 0 if not
                            blockInfo.MagnetEnabled = touchInterest and 1 or 0
                        end
                    end

                    -- Save LightBulb PointLight enabled state
                    if block.Name == "LightBulb" then
                        local bulbEnd = block:FindFirstChild("BulbEnd")
                        if bulbEnd then
                            local pointLight = bulbEnd:FindFirstChild("PointLight")
                            if pointLight and pointLight:IsA("PointLight") then
                                -- Save as 1 if enabled, 0 if disabled
                                blockInfo.LightEnabled = pointLight.Enabled and 1 or 0
                            end
                        end
                    end

                    -- Save Servo properties from HingeConstraint
                    if block.Name == "Servo" then
                        if PPart:FindFirstChild("HingeConstraint") then
                            local hinge = PPart.HingeConstraint
                            blockInfo.AngularSpeed = hinge.AngularSpeed
                            blockInfo.ServoTorque = hinge.ServoMaxTorque
                        end
                    end

                    if block.Name == "Spring" then
                        local springConstraint = PPart:FindFirstChild("SpringConstraint")
                        if springConstraint and springConstraint:IsA("SpringConstraint") then
                            blockInfo.Damping = springConstraint.Damping
                            blockInfo.Stiffness = springConstraint.Stiffness
                            blockInfo.MinLength = springConstraint.MinLength
                            blockInfo.MaxLength = springConstraint.MaxLength
                            blockInfo.TargetLength = springConstraint.FreeLength
                        end
                    end

                    if block.Name == "Rope" then
                        local RopeConstraint = PPart:FindFirstChild("RopeConstraint")
                        local alignOrientation = PPart:FindFirstChild("AlignOrientation")
                        
                        if RopeConstraint and RopeConstraint:IsA("RopeConstraint") then
                            blockInfo.Length = RopeConstraint.Length
                        end
                        
                        if alignOrientation and alignOrientation:IsA("AlignOrientation") then
                            if alignOrientation:GetAttribute("Enabled") ~= nil then
                                blockInfo.MatchRotation = alignOrientation:GetAttribute("Enabled") and 1 or 0
                            elseif alignOrientation.enabled ~= nil then
                                blockInfo.MatchRotation = alignOrientation.enabled and 1 or 0
                            else
                                blockInfo.MatchRotation = 1
                            end
                        else
                            blockInfo.MatchRotation = 1
                        end
                    end

                    if block.Name == "Bar" then
                        local RodConstraint = PPart:FindFirstChild("RodConstraint")
                        local AlignOrientation = PPart:FindFirstChild("AlignOrientation")
                        
                        if RodConstraint and RodConstraint:IsA("RodConstraint") then
                            blockInfo.Length = RodConstraint.Length
                            blockInfo.AngleLimit = RodConstraint.LimitAngle0
                        end

                        if RodConstraint and RodConstraint:IsA("RodConstraint") then
                            blockInfo.Length = RodConstraint.Length
                        end
                        
                        if AlignOrientation and AlignOrientation:IsA("AlignOrientation") then
                            if AlignOrientation:GetAttribute("Enabled") ~= nil then
                                blockInfo.MatchRotation = AlignOrientation:GetAttribute("Enabled") and 1 or 0
                            elseif AlignOrientation.enabled ~= nil then
                                blockInfo.MatchRotation = AlignOrientation.enabled and 1 or 0
                            else
                                blockInfo.MatchRotation = 1
                            end
                        else
                            blockInfo.MatchRotation = 1
                        end
                    end

                    -- Save properties for ALL block types
                    for category, props in pairs(PropertiesToSave) do
                        if type(props) == "table" then
                            -- Handle ALL wheel types (FrontWheel, BackWheel, etc.)
                            if string.find(block.Name:lower(), "wheel") then
                                -- Save MaxSpeed
                                if block:FindFirstChild("MaxSpeed") then
                                    blockInfo.MaxSpeed = block.MaxSpeed.Value
                                end
                                
                                -- Save ReverseSpin
                                if block:FindFirstChild("ReverseSpin") then
                                    blockInfo.ReverseSpin = block.ReverseSpin.Value
                                end
                                
                                -- Save WheelTorque from HingeConstraint
                                if block.PPart and block.PPart:FindFirstChild("HingeConstraint") then
                                    local hinge = block.PPart.HingeConstraint
                                    if hinge:IsA("HingeConstraint") then
                                        blockInfo.WheelTorque = hinge.MotorMaxTorque
                                    end
                                end
                                
                            else
                                -- Handle other block types using the alias system
                                local realName = BlockNameAlias[block.Name] or block.Name
                                for blockType, propList in pairs(props) do
                                    if blockType == realName then
                                        for _, prop in ipairs(propList) do
                                            if block:FindFirstChild(prop) then
                                                blockInfo[prop] = block[prop].Value
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    if block.Name == "Rope" or block.Name == "Bar" or block.Name == "Spring" then
                        if block:FindFirstChild("SecondaryPart") then
                            local secCF = zone.CFrame:ToObjectSpace(block.SecondaryPart.Part.CFrame)
                            local srx, sry, srz = secCF:ToEulerAnglesXYZ()
                            blockInfo.SecondaryPartRotation = string.format("%.3f, %.3f, %.3f", math.deg(srx), math.deg(sry), math.deg(srz))
                            blockInfo.SecondaryPartPosition = string.format("%.6f, %.6f, %.6f", secCF.X, secCF.Y, secCF.Z)
                        end
                    end
                    
                    if not blockData[block.Name] then
                        blockData[block.Name] = {}
                    end
                    
                    X.table_insert(blockData[block.Name], blockInfo)
                end
            end
        end
    end
    
    if not next(blockData) then
        X.SetStatus("No blocks found to save")
        return
    end

    --X.SetStatus(string.format("Encoding %d block types...", scanCount))

    local jsonData = {}
    for blockName, blocks in pairs(blockData) do
        jsonData[blockName] = blocks
    end

    -- Extract and save keybinds
    --X.SetStatus("Extracting keybinds...")
    local keybinds = X.ExtractKeybinds(teamName)
    if #keybinds > 0 then
        jsonData.Keybinds = keybinds
        print("Saved", #keybinds, "keybind(s)")
    end

    -- Extract and save block connections (which switch is connected to which wheel)
    --X.SetStatus("Extracting connections...")
    local connections = X.ExtractConnections(teamName)
    if #connections > 0 then
        jsonData.BlockConnections = connections
        print("Saved", #connections, "block connection(s)")
    end

    --X.SetStatus("Writing file...")

    local success, err = pcall(function()
        local jsonString = X.HttpService:JSONEncode(jsonData)
        local compressed = X.SafeCompress(jsonString)
        writefile(filePath, compressed)
    end)

    if success then
        --print("Build saved successfully to " .. filePath)
        X.SetStatus("Saved: " .. cleanFilename)
    else
        --warn("Error saving build:", err)
        X.SetStatus("Save failed: " .. tostring(err))
    end
end

function X.ClearPreview(chunked)
    local children = workspaceChildren(BuildPreview)
    if chunked then
        local batchSize = 500
        for i = 1, #children do
            workspaceDestroy(children[i])
            if i % batchSize == 0 then
                task.wait()
            end
        end
    else
        for _, child in next, children, nil do
            workspaceDestroy(child)
        end
    end
end

function X.ChunkedPreviewLoad(descriptors, options)
    options = options or {}
    local batchSize = options.batchSize or 500
    local total = #descriptors
    local placed = 0

    X.ClearPreview()

    for i, desc in ipairs(descriptors) do
        local template = BuildingParts:FindFirstChild(desc.blockType)
        if template then
            local clone = workspaceClone(template)
            local cframe = X.CFrame_new(desc.position)
            if desc.rotation then
                cframe = cframe * desc.rotation
            end

            local primaryPart = clone:FindFirstChild("PPart")

            -- Handle Spring/Bar/Rope with secondary parts
            if (desc.blockType == "Spring" or desc.blockType == "Bar" or desc.blockType == "Rope") and desc.secondaryPartPosition and desc.secondaryPartRotation then
                if primaryPart then
                    primaryPart.CFrame = cframe
                end

                local secondaryCFrame = cframe
                if desc.secondaryPartPosition then
                    secondaryCFrame = X.CFrame_new(desc.secondaryPartPosition)
                    if desc.secondaryPartRotation then
                        secondaryCFrame = secondaryCFrame * desc.secondaryPartRotation
                    end
                end

                local secondaryPart = nil
                local secondaryFolder = clone:FindFirstChild("SecondaryPart")
                if secondaryFolder then
                    secondaryPart = secondaryFolder:FindFirstChild("Part") or secondaryFolder:FindFirstChildWhichIsA("BasePart")
                end
                if not secondaryPart then
                    for _, child in ipairs(clone:GetDescendants()) do
                        if child:IsA("BasePart") and child ~= primaryPart then
                            secondaryPart = child
                            break
                        end
                    end
                end
                if secondaryPart then
                    secondaryPart.CFrame = secondaryCFrame
                end
            elseif clone:IsA("Model") and clone.PrimaryPart then
                modelSetPrimary(clone, cframe)
            else
                for _, child in ipairs(clone:GetDescendants()) do
                    if child:IsA("BasePart") then
                        child.CFrame = cframe
                        break
                    end
                end
            end

            clone.Health.Value = ""
            clone.Parent = BuildPreview

            if primaryPart then
                if desc.size then primaryPart.Size = desc.size end
                if desc.color then primaryPart.Color = desc.color end
                primaryPart.Transparency = desc.transparency or 0
                primaryPart.CanCollide = desc.canCollide ~= false
                primaryPart.CastShadow = desc.castShadow ~= false
                primaryPart.Anchored = true

                for _, child in ipairs(clone:GetDescendants()) do
                    if child:IsA("BasePart") and child ~= primaryPart then
                        if desc.size then child.Size = desc.size end
                        child.Transparency = primaryPart.Transparency
                    end
                end
            end

            placed = placed + 1
            if placed % batchSize == 0 then
                if options.onProgress then
                    options.onProgress(placed, total)
                end
                task.wait()
            end
        end
    end

    return placed
end

X.ClearPreview()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
-- ============================================================================

function X.LoadBlocks(blocksData, teamName, keybindsData, connectionsData)
    if not blocksData or not next(blocksData) then
        warn("No block data provided")
        return false
    end

    local zone = teamName and X.Config.zones[teamName] or X.GetPlot()
    if not zone then
        warn("No valid zone")
        return false
    end

    local zoneCFrame = zone.CFrame
    local buildingTool = X.GetTool("BuildingTool")
    local scalingTool = X.GetTool("ScalingTool")
    local paintingTool = X.GetTool("PaintingTool")

    local propertiesTool = nil
    local setPropertieRF = nil
    pcall(function()
        propertiesTool = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("PropertiesTool"))
            or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("PropertiesTool"))
        if propertiesTool then
            setPropertieRF = propertiesTool:FindFirstChild("SetPropertieRF")
        end
    end)

    totalBlocks = 0
    processedBlocks = 0

    for blockType, blockList in pairs(blocksData) do
        if blockType == "Keybinds" or blockType == "BlockConnections" then continue end
        if not playerData[blockType] then continue end
        totalBlocks += #blockList
    end

    if totalBlocks == 0 then
        warn("No blocks to load")
        return false
    end

    X.SetStatus("Placing blocks")
    X.UpdateProgression(0)

    -- Spatial hash for expected block positions -> data
    local expectedGrid = {}
    local processedBlocksList = {}
    local math_floor = math.floor

    local GRID_CELL = 4
    local function gridKey(x, y, z)
        return math_floor(x / GRID_CELL) .. "," .. math_floor(y / GRID_CELL) .. "," .. math_floor(z / GRID_CELL)
    end

    local function addExpected(pos, data, blockType) 
        local entry = { Position = pos, Data = data, BlockType = blockType, Matched = false }
        local key = gridKey(pos.X, pos.Y, pos.Z)
        local bucket = expectedGrid[key]
        if not bucket then
            bucket = {}
            expectedGrid[key] = bucket
        end
        bucket[#bucket + 1] = entry
    end

    -- Search radius of 3 studs to handle placement drift
    local MATCH_RADIUS_SQ = 9.0
    local function findExpected(bx, by, bz, blockName)
        local bestEntry = nil
        local bestDistSq = MATCH_RADIUS_SQ
        -- 4-stud grid cells: ±1 cell covers 3-stud radius
        for dx = -1, 1 do
            for dy = -1, 1 do
                for dz = -1, 1 do
                    local cx = math_floor(bx / GRID_CELL) + dx
                    local cy = math_floor(by / GRID_CELL) + dy
                    local cz = math_floor(bz / GRID_CELL) + dz
                    local bucket = expectedGrid[cx .. "," .. cy .. "," .. cz]
                    if bucket then
                        for _, entry in ipairs(bucket) do
                            if not entry.Matched then
                                if not blockName or not entry.BlockType or entry.BlockType == blockName then
                                    local ep = entry.Position
                                    local ex, ey, ez = ep.X - bx, ep.Y - by, ep.Z - bz
                                    local distSq = ex*ex + ey*ey + ez*ez
                                    if distSq < bestDistSq then
                                        bestDistSq = distSq
                                        bestEntry = entry
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return bestEntry
    end

    -- Phase 1: Place all blocks in parallel (fire-and-forget)
    local placedIndex = 0
    local activeThreads = 0
    for blockType, blockList in pairs(blocksData) do
        if blockType == "Keybinds" or blockType == "BlockConnections" then continue end
        local blockData_entry = playerData[blockType]
        if not blockData_entry then continue end
        local blockCount = blockData_entry.Value or 0
        local usedBlocks = (blockData_entry.Used and blockData_entry.Used.Value) or 0

        for index, blockData in ipairs(blockList) do
            if blockCount - usedBlocks < index then
                break
            end

            local position = blockData.Position
            local rotation = blockData.Rotation
            if type(position) == "string" then
                position = X.CFrame_new(Vector3_new(X.Raw(position)))
            end
            if type(rotation) == "string" then
                rotation = X.AnglesString(rotation)
            end

            local cframe = zoneCFrame * position * rotation
            placedIndex = placedIndex + 1

            -- Track expected position for post-placement matching
            addExpected(cframe.p, blockData, blockType)

            if blockType == "Spring" or blockType == "Bar" or blockType == "Rope" then
                if blockData.SecondaryPartPosition and blockData.SecondaryPartRotation then
                    local secPosition = X.CFrame_new(Vector3_new(X.Raw(blockData.SecondaryPartPosition)))
                    local secRotation = X.AnglesString(blockData.SecondaryPartRotation)
                    local secondaryCFrame = zoneCFrame * secPosition * secRotation

                    activeThreads = activeThreads + 1
                    task_spawn(function()
                        local t0 = os.clock()
                        pcall(remoteInvoke, buildingTool,
                            blockType, blockCount, nil, nil,
                            blockData.Anchored ~= false, cframe, secondaryCFrame)
                        X.AutoTrackResponse(os.clock() - t0)
                        activeThreads = activeThreads - 1
                    end)

                    usedBlocks = usedBlocks + 1

                    -- Yield occasionally to not flood
                    if placedIndex % 10 == 0 then task.wait() end
                    continue
                end
            end

            activeThreads = activeThreads + 1
            task_spawn(function()
                local t0 = os.clock()
                pcall(remoteInvoke, buildingTool, blockType, blockCount, nil, nil,
                    blockData.Anchored ~= false, cframe)
                X.AutoTrackResponse(os.clock() - t0)
                activeThreads = activeThreads - 1
            end)

            usedBlocks = usedBlocks + 1

            -- Yield occasionally to not flood the network
            if placedIndex % 10 == 0 then
                task.wait()
                X.UpdateProgression(placedIndex / totalBlocks * 30)
                X.SetStatus(string.format("Placing: %d/%d", placedIndex, totalBlocks))
            end
        end
    end

    -- Wait for placement calls to finish
    X.UpdateProgression(30)
    X.SetStatus("Waiting for server...")
    local waitStart = os.clock()
    while activeThreads > 0 and (os.clock() - waitStart) < 15 do
        task.wait(0.1)
    end

    -- Match blocks as they replicate (merged poll + scan in one loop)
    local matchedCount = 0
    local matchedSet = {} -- track already-matched workspace blocks by reference

    local function tryMatchBlock(block)
        if matchedSet[block] then return end
        if not block:IsA("Model") then return end
        local ppart = block:FindFirstChild("PPart")
        if not ppart then return end
        local bp = ppart.Position
        local entry = findExpected(bp.X, bp.Y, bp.Z, block.Name)
        if entry then
            entry.Matched = true
            matchedSet[block] = true
            processedBlocksList[#processedBlocksList + 1] = {
                Block = block,
                Data = entry.Data
            }
            matchedCount = matchedCount + 1
        end
    end

    local function scanFolder(folder)
        for _, child in ipairs(folder:GetChildren()) do
            if child:IsA("Model") then
                tryMatchBlock(child)
            elseif child:IsA("Folder") then
                scanFolder(child)
            end
        end
    end

    local blocksFolder = workspace.Blocks
    local matchTimeout = 15
    local matchStart = os.clock()
    local stableTicks = 0
    local prevMatched = 0

    while (os.clock() - matchStart) < matchTimeout do
        for _, child in ipairs(blocksFolder:GetChildren()) do
            if child:IsA("Folder") then
                scanFolder(child)
            end
        end

        if matchedCount >= totalBlocks then break end

        X.SetStatus(string.format("Matching blocks... %d/%d", matchedCount, totalBlocks))
        X.UpdateProgression(30 + (matchedCount / totalBlocks * 5))

        -- Stop early if no new matches for 1s
        if matchedCount == prevMatched then
            stableTicks = stableTicks + 1
            if stableTicks >= 4 then break end
        else
            stableTicks = 0
            prevMatched = matchedCount
        end

        task.wait(0.25)
    end

    if matchedCount < totalBlocks then
        warn(totalBlocks - matchedCount, "blocks could not be matched")
    end

    -- Build spatial index for all placed blocks (used by connections + keybinds)
    local nameToPlaced = {}
    local allPlacedGrid = {}
    local totalProcessed = #processedBlocksList
    for i = 1, totalProcessed do
        local block = processedBlocksList[i].Block
        if block then
            local name = block.Name
            if not nameToPlaced[name] then nameToPlaced[name] = {} end
            local list = nameToPlaced[name]
            list[#list + 1] = block

            local ppart = block:FindFirstChild("PPart") or block.PrimaryPart
            if ppart then
                local p = ppart.Position
                local key = gridKey(p.X, p.Y, p.Z)
                if not allPlacedGrid[key] then allPlacedGrid[key] = {} end
                allPlacedGrid[key][#allPlacedGrid[key] + 1] = { block = block, pos = p }
            end
        end
    end

    -- Helper: find nearest block by name near a position
    -- 5 stud radius to handle piston arm drift and placement variance
    local DIST_LIMIT = 5.0
    local DIST_LIMIT_SQ = DIST_LIMIT * DIST_LIMIT
    local function findNearestByName(targetName, targetPos)
        local candidates = nameToPlaced[targetName]
        if not candidates then return nil end
        local best, bestDist = nil, DIST_LIMIT_SQ
        for i = 1, #candidates do
            local c = candidates[i]
            local mp = c:FindFirstChild("PPart") or c.PrimaryPart
            if mp then
                local dx, dy, dz = mp.Position.X - targetPos.X, mp.Position.Y - targetPos.Y, mp.Position.Z - targetPos.Z
                local distSq = dx*dx + dy*dy + dz*dz
                if distSq < bestDist then
                    bestDist = distSq
                    best = c
                end
            end
        end
        return best
    end

    -- BindToolRF setup (connections + keybinds deferred to AFTER piston extension)
    local bindToolRF = nil
    pcall(function()
        bindToolRF = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("BindTool") and LocalPlayer.Character.BindTool:FindFirstChild("RF"))
            or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("BindTool") and LocalPlayer.Backpack.BindTool:FindFirstChild("RF"))
    end)

    -- Also grab UnbindRF for proper unbinding
    local unbindToolRF = nil
    pcall(function()
        local tool = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("BindTool"))
            or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("BindTool"))
        if tool then
            unbindToolRF = tool:FindFirstChild("UnbindRF")
        end
    end)

    if false then -- DEFERRED: connections run after piston extension (see Phase 6 below)
        for _, connEntry in ipairs(connectionsData) do
            local okc, crel = pcall(function() return Vector3_new(X.Raw(connEntry.ControllerPos)) end)
            local okt, trel = pcall(function() return Vector3_new(X.Raw(connEntry.TargetPos)) end)
            if not okc or not okt then continue end

            local absCtrlPos = (zoneCFrame * X.CFrame_new(crel)).p
            local absTargetPos = (zoneCFrame * X.CFrame_new(trel)).p

            local foundController = findNearestByName(connEntry.ControllerType, absCtrlPos)
            local foundTarget = findNearestByName(connEntry.TargetType, absTargetPos)

            if foundController and foundTarget then
                local val = foundTarget:FindFirstChild(connEntry.ConnectionType)
                if val and val:IsA("ObjectValue") then
                    val.Value = foundController
                elseif bindToolRF then
                    local bound = false
                    for _, child in ipairs(foundTarget:GetChildren()) do
                        if child:IsA("IntValue") and child.Name:sub(1,4) == "Bind" then
                            pcall(function()
                                bindToolRF:InvokeServer({ child }, foundController, child.Value or -1, false)
                            end)
                            bound = true
                            break
                        end
                    end
                    if not bound then
                        local descendant = foundTarget:FindFirstChild("BindUp", true) or foundTarget:FindFirstChild("BindDown", true) or foundTarget:FindFirstChild("BindLeft", true) or foundTarget:FindFirstChild("BindRight", true)
                        if descendant and descendant:IsA("IntValue") then
                            pcall(function()
                                bindToolRF:InvokeServer({ descendant }, foundController, descendant.Value or -1, false)
                            end)
                        end
                    end
                end
            end
        end
    end

    -- Phase 3: Keybinds (DEFERRED to after piston extension)
    if false then -- DEFERRED: keybinds run after piston extension (see Phase 7 below)
        for _, entry in ipairs(keybindsData) do
            local blockName = entry.BlockName
            local controllerData = entry.ControllerData or {}

            local ok, relPos = pcall(function() return Vector3_new(X.Raw(entry.BlockPos)) end)
            if not ok or not relPos then continue end
            local targetPos = (zoneCFrame * X.CFrame_new(relPos)).p

            local targetBlock = findNearestByName(blockName, targetPos)
            if not targetBlock then continue end

            local controllerInstance = nil
            if controllerData.ControllerRelativePos then
                local ok2, crel = pcall(function() return Vector3_new(X.Raw(controllerData.ControllerRelativePos)) end)
                if ok2 and crel then
                    local absCPos = (zoneCFrame * X.CFrame_new(crel)).p
                    local desiredName = controllerData.ControllerRef or controllerData.ControllerId
                    if desiredName then
                        controllerInstance = findNearestByName(desiredName, absCPos)
                    end
                    if not controllerInstance then
                        -- Search all placed blocks for nearest
                        local bestDist = DIST_LIMIT_SQ
                        for _, list in pairs(nameToPlaced) do
                            for _, m in ipairs(list) do
                                local mp = m:FindFirstChild("PPart") or m.PrimaryPart
                                if mp then
                                    local dx, dy, dz = mp.Position.X - absCPos.X, mp.Position.Y - absCPos.Y, mp.Position.Z - absCPos.Z
                                    local distSq = dx*dx + dy*dy + dz*dz
                                    if distSq < bestDist then
                                        bestDist = distSq
                                        controllerInstance = m
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if not controllerInstance and (controllerData.ControllerRef or controllerData.ControllerId) then
                local searchName = controllerData.ControllerRef or controllerData.ControllerId
                local part = targetBlock:FindFirstChild("PPart") or targetBlock.PrimaryPart
                local refPos = part and part.Position
                if refPos then
                    controllerInstance = findNearestByName(searchName, refPos)
                end
            end

            if not controllerInstance then
                local part = targetBlock:FindFirstChild("PPart") or targetBlock.PrimaryPart
                if part then
                    local bestDist = math.huge
                    for _, folder in ipairs(workspace.Blocks:GetChildren()) do
                        for _, m in ipairs(folder:GetChildren()) do
                            if m:IsA("Model") and isControllerModel(m) then
                                local mp = m:FindFirstChild("PPart") or m.PrimaryPart
                                if mp then
                                    local dx, dy, dz = mp.Position.X - part.Position.X, mp.Position.Y - part.Position.Y, mp.Position.Z - part.Position.Z
                                    local distSq = dx*dx + dy*dy + dz*dz
                                    if distSq < bestDist then
                                        bestDist = distSq
                                        controllerInstance = m
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if controllerInstance and controllerData.Keybinds then
                for bindName, keyCode in pairs(controllerData.Keybinds) do
                    local bindVal = targetBlock:FindFirstChild(bindName)
                    if bindVal and bindVal:IsA("IntValue") then
                        local success = pcall(function()
                            bindToolRF:InvokeServer({ bindVal }, controllerInstance, tonumber(keyCode) or keyCode, false)
                        end)
                        if success then
                            bindVal.Value = tonumber(keyCode) or keyCode
                        end
                    end
                end
            end
        end
    end

    -- Phase 2: Scaling (parallel)
    X.SetStatus("Scaling blocks")
    X.UpdateProgression(36)
    local scaleThreads = 0
    local scaledCount = 0
    for i = 1, totalProcessed do
        local bi = processedBlocksList[i]
        if bi.Data.Size then
            local ppart = bi.Block:FindFirstChild("PPart")
            if ppart then
                scaleThreads = scaleThreads + 1
                task_spawn(function()
                    pcall(remoteInvoke, scalingTool, bi.Block, bi.Data.Size, ppart.CFrame)
                    scaleThreads = scaleThreads - 1
                end)
                scaledCount = scaledCount + 1
                if scaledCount % 10 == 0 then
                    task.wait()
                    X.UpdateProgression(40 + (scaledCount / totalProcessed * 20))
                    X.SetStatus(string.format("Scaling: %d/%d", scaledCount, totalProcessed))
                end
            end
        end
    end
    -- Wait for scaling to finish before properties
    local scaleWait = os.clock()
    while scaleThreads > 0 and (os.clock() - scaleWait) < 10 do
        task.wait(0.1)
    end
    task.wait(0.5)
    X.UpdateProgression(60)

    -- Phase 3: Properties (all in one pass)
    X.SetStatus("Applying properties")
    X.UpdateProgression(50)

    -- Lookup tables for special blocks
    local WHEEL_NAMES = {
        FrontWheel = true, BackWheel = true,
        BackWheelCookie = true, FrontWheelCookie = true,
        BackWheelMint = true, FrontWheelMint = true,
        HugeFrontWheel = true, HugeBackWheel = true,
    }
    local SPEED_CYCLE = {40, 30, 20, 10, 5, 4, 3, 2, 1, 0.5, 50}
    local IS_HUGE_WHEEL = { HugeFrontWheel = true, HugeBackWheel = true }
    local NORMAL_TORQUE_MAP = { [10000000] = 1, [100000000] = 2, [1000000000] = 3, [10000000000] = 4 }
    local HUGE_TORQUE_MAP = { [100000000] = 1, [1000000000] = 2, [10000000000] = 3, [1000000] = 4 }
    local JET_SPEED_MAP = { [50] = 1, [25] = 2, [10] = 3, [5] = 4 }
    local JET_FORCE_MAP = { [1000000] = 1, [10000000] = 2, [100000000] = 3, [1000000000] = 4 }
    local SERVO_ANGLE_MAP = { [20] = 1, [5] = 2, [90] = 3, [75] = 4, [60] = 5 }
    local SERVO_SPEED_MAP = { [4] = 1, [3] = 2, [2] = 3, [1] = 4, [0.5] = 5, [50] = 6, [40] = 7, [30] = 8, [20] = 9, [10] = 10 }
    local SERVO_TORQUE_MAP = { [10000000] = 1, [100000000] = 2, [1000000000] = 3, [10000000000] = 4 }

    local toPaint = {}

    for idx = 1, totalProcessed do
        local bi = processedBlocksList[idx]
        local block = bi.Block
        local data = bi.Data
        local blockName = block.Name

        -- Base properties (shadow, collision, anchored, transparency)
        if setPropertieRF then
            if data.ShowShadow == false then
                task_spawn(pcall, setPropertieRF.InvokeServer, setPropertieRF, "Cast shadow", {block}, false)
            end
            if data.CanCollide == false then
                task_spawn(pcall, setPropertieRF.InvokeServer, setPropertieRF, "Collision", {block}, false)
            end
            if data.Anchored == false then
                task_spawn(pcall, setPropertieRF.InvokeServer, setPropertieRF, "Anchored", {block}, false)
            elseif data.Anchored ~= false then
                task_spawn(pcall, setPropertieRF.InvokeServer, setPropertieRF, "Anchored", {block}, true)
            end
            if data.Transparency and data.Transparency > 0 then
                local steps = math_floor(data.Transparency / 0.25 + 0.5)
                for i = 1, steps do
                    task_spawn(pcall, setPropertieRF.InvokeServer, setPropertieRF, "Transparency", {block}, 0.25)
                end
            end
        end

        -- Wheels
        if WHEEL_NAMES[blockName] and setPropertieRF then
            task_spawn(function()
                if data.MaxSpeed then
                    local clicks = 0
                    for i, speed in ipairs(SPEED_CYCLE) do
                        if speed == data.MaxSpeed then clicks = i - 1; break end
                    end
                    for i = 1, clicks do
                        pcall(setPropertieRF.InvokeServer, setPropertieRF, "Wheel speed", {block})
                    end
                end
                if data.ReverseSpin == true then
                    pcall(setPropertieRF.InvokeServer, setPropertieRF, "Reverse spin", {block}, true)
                end
                if data.WheelTorque then
                    local tq = tonumber(data.WheelTorque)
                    local tMap = IS_HUGE_WHEEL[blockName] and HUGE_TORQUE_MAP or NORMAL_TORQUE_MAP
                    local defTq = IS_HUGE_WHEEL[blockName] and 10000000 or 1000000
                    if tq ~= defTq then
                        for i = 1, (tMap[tq] or 0) do
                            pcall(setPropertieRF.InvokeServer, setPropertieRF, "Wheel torque", {block})
                        end
                    end
                end
            end)

        elseif blockName == "Piston" and setPropertieRF then
            task_spawn(function()
                if data.ExtendLength then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Piston length", {block}, data.ExtendLength) end
                if data.Speed then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Piston speed", {block}, data.Speed) end
                if data.LastDirrection == 1 then
                    local ar = block:FindFirstChild("PPart") and block.PPart:FindFirstChild("ActivateRemote")
                    if ar then ar:FireServer("Push") end
                end
            end)

        elseif blockName == "Delay" and setPropertieRF then
            if data.WaitDuration then task_spawn(pcall, setPropertieRF.InvokeServer, setPropertieRF, "Delay time", {block}, data.WaitDuration) end

        elseif blockName == "Spring" and setPropertieRF then
            task_spawn(function()
                if data.Damping then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Damping", {block}, data.Damping) end
                if data.MaxLength then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Max lenght", {block}, data.MaxLength) end
                if data.MaxLengthLimit then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Target lenght", {block}, data.MaxLengthLimit) end
                if data.TargetLength then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Target lenght", {block}, data.TargetLength) end
                if data.MinLength then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Min lenght", {block}, data.MinLength) end
                if data.Stiffness then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Stiffness", {block}, data.Stiffness) end
            end)

        elseif blockName == "Rope" and setPropertieRF then
            task_spawn(function()
                if data.Length then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Length", {block}, data.Length) end
                if data.MatchRotation == 0 then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Match rotation", {block}) end
            end)

        elseif blockName == "Bar" and setPropertieRF then
            task_spawn(function()
                if data.Length then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Length", {block}, data.Length) end
                if data.AngleLimit then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Angle limit", {block}, data.AngleLimit) end
                if data.MatchRotation == 0 then pcall(setPropertieRF.InvokeServer, setPropertieRF, "Match rotation", {block}) end
            end)

        elseif blockName == "Sign" and data.Text then
            local updateSignRE = block:FindFirstChild("ClickDetector")
                and block.ClickDetector:FindFirstChild("Script")
                and block.ClickDetector.Script:FindFirstChild("UpdateSignRE")
            if updateSignRE and updateSignRE:IsA("RemoteEvent") then
                updateSignRE:FireServer(data.Text)
            end

        elseif (blockName == "JetTurbine" or blockName == "SonicJetTurbine") and setPropertieRF then
            task_spawn(function()
                if data.MaxSpeed then
                    for i = 1, (JET_SPEED_MAP[data.MaxSpeed] or 0) do
                        pcall(setPropertieRF.InvokeServer, setPropertieRF, "Jet speed", {block}, data.MaxSpeed)
                    end
                end
                if data.MaxForce then
                    for i = 1, (JET_FORCE_MAP[data.MaxForce] or 0) do
                        pcall(setPropertieRF.InvokeServer, setPropertieRF, "Jet force", {block}, data.MaxForce)
                    end
                end
            end)

        elseif blockName == "Servo" and setPropertieRF then
            task_spawn(function()
                if data.TargetAngle then
                    for i = 1, (SERVO_ANGLE_MAP[data.TargetAngle] or 0) do
                        pcall(setPropertieRF.InvokeServer, setPropertieRF, "Servo angle", {block}, data.TargetAngle)
                    end
                end
                if data.ServoTorque then
                    for i = 1, (SERVO_TORQUE_MAP[data.ServoTorque] or 0) do
                        pcall(setPropertieRF.InvokeServer, setPropertieRF, "Servo torque", {block}, data.ServoTorque)
                    end
                end
                if data.AngularSpeed then
                    for i = 1, (SERVO_SPEED_MAP[data.AngularSpeed] or 0) do
                        pcall(setPropertieRF.InvokeServer, setPropertieRF, "Servo speed", {block}, data.AngularSpeed)
                    end
                end
                if data.ReverseRotation then
                    pcall(setPropertieRF.InvokeServer, setPropertieRF, "Reverse rotation", {block}, data.ReverseRotation)
                end
            end)

        elseif blockName == "LightBulb" then
            if data.LightEnabled == 1 then
                local ar = block:FindFirstChild("PPart") and block.PPart:FindFirstChild("ActivateRemote")
                if ar and ar:IsA("RemoteEvent") then ar:FireServer() end
            end

        elseif blockName == "ShieldGenerator" then
            if data.ShieldEnabled == 1 then
                local ar = block:FindFirstChild("PPart") and block.PPart:FindFirstChild("ActivateRemote")
                if ar and ar:IsA("RemoteEvent") then ar:FireServer() end
            end

        elseif blockName == "Note" and setPropertieRF then
            task_spawn(function()
                local offset = data.SemitoneOffset or 0
                local ft = (offset >= 1 and offset <= 10) and offset or (offset == 11 and 10 or 0)
                for i = 1, ft do
                    pcall(setPropertieRF.InvokeServer, setPropertieRF, "Key", {block}, offset)
                end
            end)
        end

        -- Collect paint data
        if data.Color then
            if X.ShouldPaintBlock(blockName, data.Color) then
                toPaint[#toPaint + 1] = {block, data.Color}
            end
        end

        if idx % 100 == 0 then
            X.UpdateProgression(65 + (idx / totalProcessed * 20))
            task.wait()
        end
    end
    X.UpdateProgression(85)

    -- Phase 5b: Wait for pistons to finish extending before binding
    local maxPistonWait = 0
    local pistonCount = 0
    for i = 1, totalProcessed do
        local bi = processedBlocksList[i]
        if bi.Block and bi.Block.Parent and bi.Block.Name == "Piston" and bi.Data.LastDirrection == 1 then
            local extLen = tonumber(bi.Data.ExtendLength) or 5
            local speed = tonumber(bi.Data.Speed) or 5
            local pistonTime = extLen / math.max(speed, 0.1) + 0.5 -- +0.5s buffer
            if pistonTime > maxPistonWait then
                maxPistonWait = pistonTime
            end
            pistonCount = pistonCount + 1
        end
    end

    if maxPistonWait > 0 then
        X.SetStatus(string.format("Waiting for %d piston(s) to extend...", pistonCount))
        -- Cap at 15 seconds to avoid infinite waits
        local pistonWaitTime = math.min(maxPistonWait, 15)
        local pistonWaitStart = os.clock()
        while (os.clock() - pistonWaitStart) < pistonWaitTime do
            local elapsed = os.clock() - pistonWaitStart
            X.UpdateProgression(85 + (elapsed / pistonWaitTime * 3))
            task.wait(0.25)
        end
    else
        task.wait(0.5) -- Brief settle time even with no pistons
    end

    X.UpdateProgression(88)

    -- Phase 6: Connections (NOW after pistons have extended)
    X.SetStatus("Restoring connections")
    unbindAllWithAllControllers()

    if connectionsData and type(connectionsData) == "table" and #connectionsData > 0 and bindToolRF then
        local connCount = 0
        local connTotal = #connectionsData
        for _, connEntry in ipairs(connectionsData) do
            local okc, crel = pcall(function() return Vector3_new(X.Raw(connEntry.ControllerPos)) end)
            local okt, trel = pcall(function() return Vector3_new(X.Raw(connEntry.TargetPos)) end)
            if not okc or not okt then continue end

            local absCtrlPos = (zoneCFrame * X.CFrame_new(crel)).p
            local absTargetPos = (zoneCFrame * X.CFrame_new(trel)).p

            local foundController = findNearestByName(connEntry.ControllerType, absCtrlPos)
            local foundTarget = findNearestByName(connEntry.TargetType, absTargetPos)

            if foundController and foundTarget then
                local val = foundTarget:FindFirstChild(connEntry.ConnectionType)
                if val and val:IsA("ObjectValue") then
                    val.Value = foundController
                elseif bindToolRF then
                    -- Collect all bind IntValues grouped by ActionName for correct RF format
                    local bindsByAction = {}
                    for _, child in ipairs(foundTarget:GetChildren()) do
                        if child:IsA("IntValue") and child.Name:sub(1,4) == "Bind" and child.Name ~= "BindingSB" then
                            local actionName = child:FindFirstChild("ActionName")
                            local action = actionName and actionName.Value or child.Name
                            if not bindsByAction[action] then
                                bindsByAction[action] = {}
                            end
                            table.insert(bindsByAction[action], child)
                        end
                    end
                    -- Send bind request
                    if next(bindsByAction) then
                        pcall(function()
                            bindToolRF:InvokeServer(bindsByAction, foundController, {}, false, false)
                        end)
                    end
                end
            end
            connCount = connCount + 1
            if connCount % 5 == 0 then
                X.SetStatus(string.format("Connections: %d/%d", connCount, connTotal))
                task.wait()
            end
        end
    end

    X.UpdateProgression(91)

    -- Phase 7: Keybinds (after pistons extended + connections restored)
    X.SetStatus("Restoring keybinds")
    if keybindsData and type(keybindsData) == "table" and #keybindsData > 0 and bindToolRF then
        local kbCount = 0
        for _, entry in ipairs(keybindsData) do
            local blockName = entry.BlockName
            local controllerData = entry.ControllerData or {}

            local ok, relPos = pcall(function() return Vector3_new(X.Raw(entry.BlockPos)) end)
            if not ok or not relPos then continue end
            local targetPos = (zoneCFrame * X.CFrame_new(relPos)).p

            local targetBlock = findNearestByName(blockName, targetPos)
            if not targetBlock then continue end

            local controllerInstance = nil
            if controllerData.ControllerRelativePos then
                local ok2, crel = pcall(function() return Vector3_new(X.Raw(controllerData.ControllerRelativePos)) end)
                if ok2 and crel then
                    local absCPos = (zoneCFrame * X.CFrame_new(crel)).p
                    local desiredName = controllerData.ControllerRef or controllerData.ControllerId
                    if desiredName then
                        controllerInstance = findNearestByName(desiredName, absCPos)
                    end
                    if not controllerInstance then
                        -- Search all placed blocks for nearest controller
                        local bestDist = DIST_LIMIT_SQ
                        for _, list in pairs(nameToPlaced) do
                            for _, m in ipairs(list) do
                                local mp = m:FindFirstChild("PPart") or m.PrimaryPart
                                if mp then
                                    local dx, dy, dz = mp.Position.X - absCPos.X, mp.Position.Y - absCPos.Y, mp.Position.Z - absCPos.Z
                                    local distSq = dx*dx + dy*dy + dz*dz
                                    if distSq < bestDist then
                                        bestDist = distSq
                                        controllerInstance = m
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if not controllerInstance and (controllerData.ControllerRef or controllerData.ControllerId) then
                local searchName = controllerData.ControllerRef or controllerData.ControllerId
                local part = targetBlock:FindFirstChild("PPart") or targetBlock.PrimaryPart
                local refPos = part and part.Position
                if refPos then
                    controllerInstance = findNearestByName(searchName, refPos)
                end
            end

            if not controllerInstance then
                local part = targetBlock:FindFirstChild("PPart") or targetBlock.PrimaryPart
                if part then
                    local bestDist = math.huge
                    for _, folder in ipairs(workspace.Blocks:GetChildren()) do
                        for _, m in ipairs(folder:GetChildren()) do
                            if m:IsA("Model") and isControllerModel(m) then
                                local mp = m:FindFirstChild("PPart") or m.PrimaryPart
                                if mp then
                                    local dx, dy, dz = mp.Position.X - part.Position.X, mp.Position.Y - part.Position.Y, mp.Position.Z - part.Position.Z
                                    local distSq = dx*dx + dy*dy + dz*dz
                                    if distSq < bestDist then
                                        bestDist = distSq
                                        controllerInstance = m
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if controllerInstance and controllerData.Keybinds then
                -- Group bind values by ActionName for correct RF call format
                local bindsByAction = {}
                local keyCodesMap = {}
                for bindName, keyCode in pairs(controllerData.Keybinds) do
                    local bindVal = targetBlock:FindFirstChild(bindName)
                    if bindVal and bindVal:IsA("IntValue") then
                        local actionName = bindVal:FindFirstChild("ActionName")
                        local action = actionName and actionName.Value or bindName
                        if not bindsByAction[action] then
                            bindsByAction[action] = {}
                        end
                        table.insert(bindsByAction[action], bindVal)
                        keyCodesMap[action] = tonumber(keyCode) or keyCode
                    end
                end
                if next(bindsByAction) then
                    local success = pcall(function()
                        bindToolRF:InvokeServer(bindsByAction, controllerInstance, keyCodesMap, false, false)
                    end)
                    -- Update local values on success
                    if success then
                        for bindName, keyCode in pairs(controllerData.Keybinds) do
                            local bindVal = targetBlock:FindFirstChild(bindName)
                            if bindVal and bindVal:IsA("IntValue") then
                                bindVal.Value = tonumber(keyCode) or keyCode
                            end
                        end
                    end
                end
            end
            kbCount = kbCount + 1
            if kbCount % 5 == 0 then task.wait() end
        end
    end

    X.UpdateProgression(94)

    -- Phase 8: Paint
    if #toPaint > 0 then
        X.SetStatus("Painting blocks")
        if paintingTool then
            task_spawn(pcall, remoteInvoke, paintingTool, toPaint)
        end
    end

    X.UpdateProgression(98)

    X.ClearPreview()
    X.SetStatus("Done!")
    X.UpdateProgression(100)

    task.wait(1)
    X.SetStatus("Ready")
    X.UpdateProgression(0)

    return true
end

function X.ResolveFileContent(filename)
    if type(filename) == "table" then
        return X.HttpService:JSONEncode(filename)
    end
    if type(filename) == "string" and not string.find(filename, "%.") then
        local vPath = "VoltaraBuildStorage/" .. filename .. ".vBuild"
        local buildPath = "VoltaraBuildStorage/" .. filename .. ".Build"
        if isfile(vPath) then filename = vPath
        elseif isfile(buildPath) then filename = buildPath end
    end
    local converted = X.Convert(filename)
    if converted then return converted end
    local fileContent = readfile(filename)
    if not fileContent or fileContent == "" then
        warn("File is empty or not found")
        return nil
    end
    return X.SafeDecompress(fileContent)
end

function X.LoadFile(filename, scale, teamName)
    local content
    if #workspaceChildren(BuildPreview) > 0 then
        content = X.Encode(X.GetPreviewBlocks(), X.GetTeam())
    else
        content = X.ResolveFileContent(filename)
        if not content then return end
    end

    local decodedRaw = nil
    local ok, result = pcall(function()
        decodedRaw = X.HttpService:JSONDecode(content)
    end)

    local blocks = X.Decode(content, scale)
    local keybinds = (decodedRaw and decodedRaw.Keybinds) or nil
    local connections = (decodedRaw and decodedRaw.BlockConnections) or nil
    X.LoadBlocks(blocks, teamName, keybinds, connections)
end

function X.PreviewFile(filename, scale, teamName)
    local content = X.ResolveFileContent(filename)
    if not content then return end
    
    local function DecodeBuildData(json, scale)
        local decodeSuccess, decoded = pcall(function()
            return X.HttpService:JSONDecode(json)
        end)
        
        if not decodeSuccess or not decoded then
            warn("Failed to parse JSON. File may be corrupted.")
            return {}
        end
        
        for blockType, blocks in pairs(decoded) do
            if type(blocks) ~= "table" then continue end
            for _, block in ipairs(blocks) do
                if block.Position and type(block.Position) == "string" then
                    block.Position = Vector3.new(block.Position:match("([^,]+),([^,]+),([^,]+)"))
                end
                
                if block.Rotation and type(block.Rotation) == "string" then
                    local x, y, z = block.Rotation:match("([^,]+),([^,]+),([^,]+)")
                    block.Rotation = CFrame.Angles(X.math_rad(x), X.math_rad(y), X.math_rad(z))
                end
                
                if block.Size and type(block.Size) == "string" then
                    block.Size = Vector3.new(block.Size:match("([^,]+),([^,]+),([^,]+)"))
                end
                
                if block.Color and type(block.Color) == "string" then
                    block.Color = Color3.new(block.Color:match("([^,]+),([^,]+),([^,]+)"))
                end
                
                if block.SecondaryPartPosition and type(block.SecondaryPartPosition) == "string" then
                    local sx, sy, sz = block.SecondaryPartPosition:match("([^,]+),([^,]+),([^,]+)")
                    block.SecondaryPartPosition = Vector3.new(tonumber(sx), tonumber(sy), tonumber(sz))
                end

                if block.SecondaryPartRotation and type(block.SecondaryPartRotation) == "string" then
                    local x, y, z = block.SecondaryPartRotation:match("([^,]+),([^,]+),([^,]+)")
                    block.SecondaryPartRotation = CFrame.Angles(X.math_rad(x), X.math_rad(y), X.math_rad(z))
                end
                
                if scale then
                    if block.Position then block.Position = block.Position * scale end
                    if block.Size then block.Size = block.Size * scale end
                    if block.SecondaryPartPosition then block.SecondaryPartPosition = block.SecondaryPartPosition * scale end
                end
            end
        end
        return decoded
    end
    
    local decoded = DecodeBuildData(content, scale or 1)
    local zone = teamName and X.Config.zones[teamName] or X.GetPlot()
    
    for blockType, blockList in pairs(decoded) do
        if BuildingParts:FindFirstChild(blockType) then
            for _, blockData in ipairs(blockList) do
                local clone = workspaceClone(BuildingParts[blockType])
                local cframe = zone.CFrame * CFrame.new(blockData.Position) * blockData.Rotation
                
                local primaryPart = clone:FindFirstChild("PPart")
                
                -- For Spring, Rope, and Bar blocks - don't use modelSetPrimary, position parts individually
                if (blockType == "Spring" or blockType == "Bar" or blockType == "Rope") and blockData.SecondaryPartPosition and blockData.SecondaryPartRotation then
                    local secondaryCFrame = zone.CFrame * CFrame.new(blockData.SecondaryPartPosition) * blockData.SecondaryPartRotation

                    -- Position primary part
                    if primaryPart then
                        primaryPart.CFrame = cframe
                    end

                    -- Find and position secondary part (check multiple possible structures)
                    local secondaryPart = nil
                    local secondaryFolder = clone:FindFirstChild("SecondaryPart")
                    if secondaryFolder then
                        secondaryPart = secondaryFolder:FindFirstChild("Part") or secondaryFolder:FindFirstChildWhichIsA("BasePart")
                    end
                    if not secondaryPart then
                        for _, child in ipairs(clone:GetDescendants()) do
                            if child:IsA("BasePart") and child ~= primaryPart then
                                secondaryPart = child
                                break
                            end
                        end
                    end
                    if secondaryPart then
                        secondaryPart.CFrame = secondaryCFrame
                    end

                    -- Apply properties to all parts
                    for _, part in ipairs(clone:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = blockData.Transparency or 0
                            part.CanCollide = blockData.CanCollide or true
                            part.CastShadow = blockData.ShowShadow ~= false
                            part.Anchored = blockData.Anchored ~= false
                            if blockData.Size and part == primaryPart then
                                part.Size = blockData.Size
                            end
                            if blockData.Color then
                                part.Color = blockData.Color
                            end
                        end
                    end

                    clone.Health.Value = ""
                    clone.Parent = BuildPreview
                else
                    -- Standard block handling - use modelSetPrimary
                    modelSetPrimary(clone, cframe)
                    clone.Health.Value = ""
                    clone.Parent = BuildPreview
                    
                    local part = clone.PPart
                    part.Transparency = blockData.Transparency or 0
                    part.CanCollide = blockData.CanCollide or true
                    part.CastShadow = blockData.ShowShadow ~= false
                    part.Anchored = blockData.Anchored ~= false
                    
                    if blockData.Size then
                        part.Size = blockData.Size
                    end
                    
                    if blockData.Color then
                        part.Color = blockData.Color
                    end
                end
            end
        end
    end
end

function X.UpdatePreview(offset, rotation)
    local previewBlocks = BuildPreview:GetChildren()
    if #previewBlocks == 0 then
        return
    end
    
    if offset then
        for _, block in ipairs(previewBlocks) do
            if block:IsA("Model") then
                if block.PrimaryPart then
                    local currentCF = block:GetPrimaryPartCFrame()
                    block:SetPrimaryPartCFrame(currentCF + offset)
                else
                    for _, part in ipairs(block:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CFrame = part.CFrame + offset
                        end
                    end
                end
            elseif block:IsA("BasePart") then
                block.CFrame = block.CFrame + offset
            end
        end
    end
    
    if rotX ~= 0 or rotY ~= 0 or rotZ ~= 0 then
        local totalPosition = Vector3.new(0, 0, 0)
        local blockCount = 0
        
        for _, block in ipairs(previewBlocks) do
            if block:IsA("Model") and block.PrimaryPart then
                totalPosition = totalPosition + block.PrimaryPart.Position
                blockCount = blockCount + 1
            elseif block:IsA("BasePart") then
                totalPosition = totalPosition + block.Position
                blockCount = blockCount + 1
            end
        end
        
        if blockCount > 0 then
            local center = totalPosition / blockCount
            
            local rotationCFrame = CFrame.Angles(
                X.math_rad(rotX),
                X.math_rad(rotY), 
                X.math_rad(rotZ)
            )
            
            for _, block in ipairs(previewBlocks) do
                if block:IsA("Model") and block.PrimaryPart then
                    local primaryPart = block.PrimaryPart
                    local relativePos = primaryPart.Position - center
                    local rotatedPos = rotationCFrame * relativePos
                    local newPosition = center + rotatedPos
                    
                    local currentRotation = primaryPart.CFrame - primaryPart.CFrame.Position
                    local newRotation = rotationCFrame * currentRotation
                    
                    block:SetPrimaryPartCFrame(X.CFrame_new(newPosition) * newRotation)
                    
                elseif block:IsA("BasePart") then
                    local relativePos = block.Position - center
                    local rotatedPos = rotationCFrame * relativePos
                    local newPosition = center + rotatedPos
                    
                    local currentRotation = block.CFrame - block.CFrame.Position
                    local newRotation = rotationCFrame * currentRotation
                    
                    block.CFrame = X.CFrame_new(newPosition) * newRotation
                end
            end
        end
    end
end

function X.MirrorBuild()
    local previewBlocks = BuildPreview:GetChildren()
    if #previewBlocks == 0 then
        return
    end
    
    local totalPosition = Vector3.new(0, 0, 0)
    local blockCount = 0
    
    for _, block in ipairs(previewBlocks) do
        if block:IsA("Model") and block.PrimaryPart then
            totalPosition = totalPosition + block.PrimaryPart.Position
            blockCount = blockCount + 1
        elseif block:IsA("BasePart") then
            totalPosition = totalPosition + block.Position
            blockCount = blockCount + 1
        end
    end
    
    if blockCount == 0 then return end
    
    local center = totalPosition / blockCount
    
    for _, block in ipairs(previewBlocks) do
        if block:IsA("Model") and block.PrimaryPart then
            local primaryPart = block.PrimaryPart
            local relativePos = primaryPart.Position - center
            local mirroredPos = Vector3.new(-relativePos.X, relativePos.Y, relativePos.Z) + center
            
            local currentRotation = primaryPart.CFrame - primaryPart.CFrame.Position
            local x, y, z = currentRotation:ToEulerAnglesXYZ()
            local mirroredRotation = CFrame.Angles(x, -y, z)
            
            block:SetPrimaryPartCFrame(CFrame.new(mirroredPos) * mirroredRotation)
            
        elseif block:IsA("BasePart") then
            local relativePos = block.Position - center
            local mirroredPos = Vector3.new(-relativePos.X, relativePos.Y, relativePos.Z) + center
            
            local currentRotation = block.CFrame - block.CFrame.Position
            local x, y, z = currentRotation:ToEulerAnglesXYZ()
            local mirroredRotation = CFrame.Angles(x, -y, z)
            
            block.CFrame = X.CFrame_new(mirroredPos) * mirroredRotation
        end
    end
end

function X.CreateBlockData(name, cframe, size, color)
    return {
        Name = name,
        PPart = {
            CFrame = cframe,
            CastShadow = false,
            CanCollide = true,
            Anchored = true,
            Transparency = 0,
            Color = color.Color,
            Size = size,
        },
    }
end

function X.CountPreviewBlockRequirements()
    local previewBlocks = X.GetPreviewBlocks()
    local required = {}
    local standardBlockVolume = 8 -- 2x2x2
    for _, block in ipairs(previewBlocks) do
        local ppart = block:FindFirstChild("PPart")
        local blocksNeeded = 1
        if ppart then
            local size = ppart.Size
            local baseTemplate = BuildingParts:FindFirstChild(block.Name)
            local baseSize = baseTemplate and baseTemplate:FindFirstChild("PPart") and baseTemplate.PPart.Size or Vector3.new(2, 2, 2)
            local baseVolume = baseSize.X * baseSize.Y * baseSize.Z
            local volume = size.X * size.Y * size.Z
            blocksNeeded = math.max(1, math.ceil(volume / baseVolume))
        end
        required[block.Name] = (required[block.Name] or 0) + blocksNeeded
    end
    return required
end

function X.ListPreviewBlocks()
    X.ListBlockRequirements(X.CountPreviewBlockRequirements())
end

function X.ListBlockRequirements(required)
    if not required or not next(required) then
        X.listing:Clear()
        return
    end
    X.listing:Clear()
    for blockType, count in pairs(required) do
        local blockData = playerData[blockType]
        local available = blockData and blockData.Value or 0
        local used = blockData and blockData.Used and blockData.Used.Value or 0
        local remaining = math.max(0, available - used)
        local deficit = math.max(0, count - remaining)
        X.listing:Add(blockType, count, deficit > 0 and deficit or nil)
    end
end

function X.BuildFromPreview(options)
    options = options or {}
    if #workspaceChildren(BuildPreview) == 0 then
        X.SetStatus("No preview to build")
        return
    end
    local previewBlocks = X.GetPreviewBlocks()
    if #previewBlocks == 0 then
        X.SetStatus("No preview blocks")
        return
    end
    X.SetStatus(string.format("Building %d blocks...", #previewBlocks))
    local blocks = {}
    for _, block in ipairs(previewBlocks) do
        if block:FindFirstChild("PPart") then
            X.table_insert(blocks, X.CreateBlockData(
                block.Name,
                block.PPart.CFrame,
                block.PPart.Size,
                { Color = block.PPart.Color }
            ))
        end
    end
    local jsonTable = X.Encode(blocks)
    if jsonTable then
        local decoded = X.Decode(jsonTable, 1)
        if decoded and next(decoded) then
            X.LoadBlocks(decoded)
        end
    end
    if options.postBuildFn then
        options.postBuildFn(previewBlocks)
    end
    if options.clearAfter then
        X.ClearPreview()
    end
end

local imageCache = nil
local lastUrl = nil
local Image_Server_Url = "https://babftserver-production.up.railway.app/image"
local imageUrl = nil
local imageBlockType = "MetalBlock"
local imageBlockSize = 0.5
local resolution = 5

X.GetColor = X.Memoize(X.DecodeColor)

function X.GetImage(url)
    if lastUrl == url and imageCache then
        return imageCache
    end
    
    if not url or url == "" then
        warn("No URL provided")
        return nil
    end
    
    if not string.find(url, "://") then
        url = "http://" .. url
    end
    
    local success, result = pcall(function()
        local bodyData = {
            url = url
        }
        
        local response = request({
            Url = Image_Server_Url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["X-API-Key"] = apikey,
            },
            Body = X.HttpService:JSONEncode(bodyData),
            Timeout = 30
        })
        
        if response then            
            if response.StatusCode == 200 then
                local success, decoded = pcall(function()
                    return X.HttpService:JSONDecode(response.Body)
                end)
                
                if success and decoded then
                    return { 
                        success = true, 
                        data = response.Body,
                        decoded = decoded
                    }
                else
                    return { 
                        success = false, 
                        error = "Invalid JSON response",
                        data = response.Body
                    }
                end
            else
                return { 
                    success = false, 
                    error = "HTTP " .. response.StatusCode,
                    data = response.Body
                }
            end
        end
    end)

    if success and result and result.success then
        -- Cache the successful result
        imageCache = result.data
        lastUrl = url
        return result.data
    else
        if result then
            warn("Server error")
            if result.data then
                print("succeful respond")
            end
        else
            warn("Failed to connect to server")
        end
        X.SetStatus("Server error")
        return nil
    end
end

function X.ProcessImage(url, blockType, baseBlockSize, resolution, preview)
    if not url or url == "" then
        warn("None or empty URL provided")
        X.SetStatus("Error: No URL")
        return
    end

    -- Add http:// if missing
    if not string.find(url, "://") then
        url = "http://" .. url
    end

    -- Validate block type
    local blockTemplate = BuildingParts:FindFirstChild(blockType)
    if not blockTemplate then
        return
    end

    -- Parse and validate numeric inputs
    resolution = tonumber(resolution) or 5
    resolution = math.max(1, math.min(20, math.floor(resolution))) -- Limit to reasonable values
    
    baseBlockSize = tonumber(baseBlockSize) or 0.5
    baseBlockSize = math.max(0.1, math.min(5, baseBlockSize))
    
    -- Get image data from server
    local imageData = X.GetImage(url)
    if not imageData then
        X.SetStatus("Failed to load image")
        return
    end

    -- Parse the JSON response
    local decodedImage
    local success, err = pcall(function()
        decodedImage = X.HttpService:JSONDecode(imageData)
    end)

    if not success or not decodedImage then
        return
    end
    
    -- Check for server error
    if decodedImage.error then
        return
    end
    
    -- Validate response structure
    if not decodedImage.dimensions or not decodedImage.pixels then
        return
    end
    
    -- Get dimensions
    local originalWidth = decodedImage.dimensions[1]
    local originalHeight = decodedImage.dimensions[2]
    
    if not originalWidth or not originalHeight then
        warn("Invalid image dimensions")
        return
    end
        
    -- Calculate output size
    local generatedWidth = math.ceil(originalWidth / resolution)
    local generatedHeight = math.ceil(originalHeight / resolution)
    
    -- Limit size to prevent lag
    if generatedWidth > 150 or generatedHeight > 150 then
        return
    end
    
    -- Get plot
    local currentPlot = X.GetPlot()
    if not currentPlot then
        warn("Could not get plot")
        return
    end
    
    -- Calculate positioning
    local yPlotOffset = 5.1 + (generatedHeight * baseBlockSize)
    local xPlotOffset = (generatedWidth * baseBlockSize) / 2
    local plotCFrame = currentPlot.CFrame

    local blocksForJsonEncoding = {}
    local descriptors = {}
    local totalBlocks = generatedWidth * generatedHeight
    local processed = 0

    X.SetStatus("Processing Image Data")
    X.UpdateProgression(0)

    -- Process each block position
    for y = 0, generatedHeight - 1 do
        for x = 0, generatedWidth - 1 do
            local pixelX = math.floor(x * resolution + resolution/2)
            local pixelY = math.floor(y * resolution + resolution/2)
            pixelX = math.max(0, math.min(originalWidth - 1, pixelX))
            pixelY = math.max(0, math.min(originalHeight - 1, pixelY))

            local pixelIndex = (pixelY * originalWidth) + pixelX + 1

            if pixelIndex > 0 and pixelIndex <= #decodedImage.pixels then
                local colorData = X.GetColor(decodedImage.pixels[pixelIndex])

                if colorData and colorData.Color then
                    local localBlockPosition = Vector3.new(
                        -x * baseBlockSize + xPlotOffset,
                        -y * baseBlockSize + yPlotOffset,
                        0
                    )

                    if preview then
                        local absoluteCFrame = plotCFrame * X.CFrame_new(localBlockPosition)
                        X.table_insert(descriptors, {
                            blockType = blockType,
                            position = absoluteCFrame.Position,
                            size = Vector3.new(baseBlockSize, baseBlockSize, baseBlockSize),
                            color = colorData.Color,
                            transparency = 1 - (colorData.Alpha / 255),
                            canCollide = false,
                            castShadow = false,
                        })
                    else
                        local absoluteCFrame = plotCFrame * X.CFrame_new(localBlockPosition)
                        local relativeCFrame = plotCFrame:ToObjectSpace(absoluteCFrame)

                        local blockJsonData = {
                            Position = X.String(relativeCFrame.Position),
                            Rotation = X.GetStringAngles(relativeCFrame),
                            Color = X.String(colorData.Color),
                            Size = X.String(Vector3.new(baseBlockSize, baseBlockSize, baseBlockSize)),
                            Transparency = 1 - (colorData.Alpha / 255),
                            Anchored = true,
                            CanCollide = false,
                            ShowShadow = false
                        }

                        if not blocksForJsonEncoding[blockType] then
                            blocksForJsonEncoding[blockType] = {}
                        end
                        table.insert(blocksForJsonEncoding[blockType], blockJsonData)
                    end
                end
            end

            processed = processed + 1
            if processed % 100 == 0 then
                local percent = math.floor((processed / totalBlocks) * 100)
                X.UpdateProgression(percent)
                X.SetStatus("Processing Image")
                task.wait()
            end
        end
    end

    X.UpdateProgression(100)

    if preview then
        X.ChunkedPreviewLoad(descriptors, { batchSize = 20 })
        print("Preview Generated")
    else
        if next(blocksForJsonEncoding) then
            local jsonString = X.HttpService:JSONEncode(blocksForJsonEncoding)
            local decoded = X.Decode(jsonString, 1)
            if decoded and next(decoded) then
                X.LoadBlocks(decoded)
            end
        end
    end
end

function X.ListBuild(filename, scale)
    local content = X.ResolveFileContent(filename)
    if not content then return end

    -- Now decode the JSON
    local success, decoded = pcall(function()
        return X.HttpService:JSONDecode(content)
    end)
    
    if not success or not decoded then
        warn("Failed to parse JSON. File may be corrupted.")
        return
    end
    
    local required = {}
    local defaultSize = Vector3.new(2, 2, 2)  -- Standard block size
    local scale = scale or 1  -- Use provided scale or default to 1
    
    for blockType, blockList in pairs(decoded) do
        if blockType == "Keybinds" or blockType == "BlockConnections" then continue end
        if not workspaceFind(BuildingParts, blockType) then continue end
        if type(blockList) ~= "table" then continue end
        local totalBlocksNeeded = 0

        for _, blockData in ipairs(blockList) do
            -- Check if this block has a custom size
            if blockData.Size then
                -- Parse the size string (format: "X,Y,Z")
                local sizeStr = blockData.Size
                if type(sizeStr) == "string" then
                    local x, y, z = string.match(sizeStr, "([^,]+),([^,]+),([^,]+)")
                    if x and y and z then
                        local blockSize = Vector3.new(
                            tonumber(x) or 2,
                            tonumber(y) or 2,
                            tonumber(z) or 2
                        )
                        
                        -- Calculate volume in standard blocks (2x2x2 = 8 cubic units)
                        -- Each standard block is 2x2x2 = 8 cubic units
                        local volume = blockSize.X * blockSize.Y * blockSize.Z
                        local standardBlockVolume = 8  -- 2×2×2
                        
                        -- Account for scaling factor
                        local scaledVolume = volume / standardBlockVolume
                        
                        -- Apply user's scale multiplier
                        if scale and scale ~= 1 then
                            -- If scaling the entire build, adjust volume accordingly
                            scaledVolume = scaledVolume * (scale * scale * scale)
                        end
                        
                        -- Round up to nearest whole block
                        local blocksForThisPart = math.max(1, math.ceil(scaledVolume))
                        totalBlocksNeeded = totalBlocksNeeded + blocksForThisPart
                    else
                        -- If we can't parse size, assume 1 block
                        totalBlocksNeeded = totalBlocksNeeded + 1
                    end
                else
                    totalBlocksNeeded = totalBlocksNeeded + 1
                end
            else
                -- Default size (2,2,2) = 1 block
                totalBlocksNeeded = totalBlocksNeeded + 1
            end
        end
        
        -- Store the total blocks needed for this type
        required[blockType] = totalBlocksNeeded
    end

    X.ListBlockRequirements(required)
end

function X.ListImageBlocks()
    if not imageUrl or not imageBlockType or not imageBlockSize or not resolution then
        return
    end

    local imageData = X.GetImage(imageUrl)
    if imageData == "invalid" or not imageData then
        return
    end

    local decodedImageJson
    local successJsonDecode = pcall(function()
        decodedImageJson = X.HttpService:JSONDecode(imageData)
    end)

    if not successJsonDecode or not decodedImageJson or not decodedImageJson.dimensions or not decodedImageJson.pixels then
        return
    end

    local originalWidth = decodedImageJson.dimensions[1]
    local originalHeight = decodedImageJson.dimensions[2]

    local generatedWidth = math.ceil(originalWidth / resolution)
    local generatedHeight = math.ceil(originalHeight / resolution)

    local required = {}

    for y = 0, generatedHeight - 1 do
        for x = 0, generatedWidth - 1 do
            local startPixelX = x * resolution
            local startPixelY = y * resolution
            local pixelIndex = (startPixelY * originalWidth + startPixelX + 1)

            if pixelIndex <= 0 or pixelIndex > #decodedImageJson.pixels then
                continue
            end

            local colorData = X.GetColor(decodedImageJson.pixels[pixelIndex])
            if not colorData or not colorData.Color then
                continue
            end

            required[imageBlockType] = (required[imageBlockType] or 0) + 1
        end
        if y % 10 == 0 then
            task.wait()
        end
    end

    X.ListBlockRequirements(required)
end

local shapeType = "Ball"
local blockType = "WoodBlock"
local radius = 5
local thickness = 1
local centerOnPlot = false
local smoothRotation = false
local blockSpacing = 2
local shapeHeight = 10
local shapeWidth = 10
local shapeDepth = 10

function X.CreatePreviewBlock(position, blockType, rotation)
    local clone = workspaceClone(BuildingParts[blockType])
    local cframe = X.CFrame_new(position)
    if rotation then
        cframe = cframe * rotation
    end
    
    if clone:IsA("Model") and clone.PrimaryPart then
        clone:SetPrimaryPartCFrame(cframe)
    else
        for _, child in ipairs(clone:GetDescendants()) do
            if child:IsA("BasePart") then
                child.CFrame = cframe
                break
            end
        end
    end
    
    clone.Health.Value = ""
    clone.Parent = BuildPreview
    
    -- Apply properties to all parts
    local allParts = clone:GetDescendants()
    for _, part in ipairs(allParts) do
        if part:IsA("BasePart") then
            part.Transparency = 0
            part.CanCollide = true
            part.Anchored = true
            part.CastShadow = true
        end
    end
    
    return clone
end

function X.GetCircleRotation(position, center)
    local direction = (position - center).Unit
    return CFrame.fromMatrix(Vector3.new(), 
        Vector3.new(direction.X, 0, direction.Z),
        Vector3.new(0, 1, 0),
        Vector3.new(-direction.Z, 0, direction.X))
end

function X.RotationFromNormal(normal)
    if not normal then return nil end
    if normal.Magnitude <= 0.001 then return nil end
    local upVector = math.abs(normal.Y) > 0.9 and Vector3_new(0, 0, 1) or Vector3_new(0, 1, 0)
    local rightVector = normal:Cross(upVector).Unit
    upVector = rightVector:Cross(normal).Unit
    return CFrame.fromMatrix(Vector3_new(), rightVector, upVector, normal)
end

function X.GenerateBall(center, radius, blockType, spacing)
    local blocks = {}
    local blockPositions = {}

    -- Use denser segmentation for a smoother sphere similar to Dome
    local verticalSegments = math.max(12, X.math_floor(radius * 6))
    local horizontalSegments = math.max(16, verticalSegments * 2)

    for v = 0, verticalSegments do
        local verticalAngle = (v / verticalSegments) * math.pi
        local y = center.Y + radius * math.cos(verticalAngle)
        local sliceRadius = radius * math.sin(verticalAngle)

        for h = 0, horizontalSegments do
            local horizontalAngle = (h / horizontalSegments) * math.pi * 2
            local x = center.X + sliceRadius * math.cos(horizontalAngle)
            local z = center.Z + sliceRadius * math.sin(horizontalAngle)

            local position = Vector3_new(x, y, z)
            if not blockPositions[tostring(position)] then
                local rotation = smoothRotation and X.RotationFromNormal((position - center).Unit) or nil
                local clone = X.CreatePreviewBlock(position, blockType, rotation)
                X.table_insert(blocks, clone)
                blockPositions[tostring(position)] = true
            end
        end
    end

    return blocks
end

function X.GenerateTorus(center, majorRadius, minorRadius, blockType, spacing)
    local blocks = {}
    local blockPositions = {}
    
    local majorCircumference = 2 * math.pi * majorRadius
    local minorCircumference = 2 * math.pi * minorRadius
    local majorSegments = math.max(8, X.math_floor(majorCircumference / spacing))
    local minorSegments = math.max(8, X.math_floor(minorCircumference / spacing))
    
    for major = 0, majorSegments do
        local majorAngle = (major / majorSegments) * math.pi * 2
        local majorX = math.cos(majorAngle)
        local majorZ = math.sin(majorAngle)
        
        for minor = 0, minorSegments do
            local minorAngle = (minor / minorSegments) * math.pi * 2
            local minorX = math.cos(minorAngle)
            local minorY = math.sin(minorAngle)
            
            local x = center.X + (majorRadius + minorRadius * minorX) * majorX
            local y = center.Y + minorRadius * minorY
            local z = center.Z + (majorRadius + minorRadius * minorX) * majorZ
            
            local position = Vector3.new(x, y, z)
            if not blockPositions[tostring(position)] then
                local rotation = smoothRotation and X.RotationFromNormal((position - center).Unit) or nil
                local clone = X.CreatePreviewBlock(position, blockType, rotation)
                X.table_insert(blocks, clone)
                blockPositions[tostring(position)] = true
            end
        end
    end
    
    return blocks
end

-- Spiral generator removed to simplify shape builder

function X.GenerateDome(center, radius, blockType, spacing)
    local blocks = {}
    local blockPositions = {}
    
    local circumference = 2 * math.pi * radius
    local verticalSegments = math.max(8, X.math_floor(circumference / spacing))
    local horizontalSegments = math.max(8, X.math_floor(circumference / spacing))
    
    for v = 0, verticalSegments / 2 do
        local verticalAngle = (v / verticalSegments) * math.pi
        local y = center.Y + radius * math.cos(verticalAngle)
        local sliceRadius = radius * math.sin(verticalAngle)
        
        for h = 0, horizontalSegments do
            local horizontalAngle = (h / horizontalSegments) * math.pi * 2
            local x = center.X + sliceRadius * math.cos(horizontalAngle)
            local z = center.Z + sliceRadius * math.sin(horizontalAngle)
            
            local position = Vector3.new(x, y, z)
            if not blockPositions[tostring(position)] then
                local rotation = smoothRotation and X.RotationFromNormal((position - center).Unit) or nil
                local clone = X.CreatePreviewBlock(position, blockType, rotation)
                X.table_insert(blocks, clone)
                blockPositions[tostring(position)] = true
            end
        end
    end
    
    return blocks
end

function X.GenerateWave(center, width, height, length, blockType, spacing)
    local blocks = {}
    local blockPositions = {}
    
    local halfWidth = width / 2
    local waveLength = length * 2 * math.pi
    local segments = math.max(8, X.math_floor(waveLength / spacing))
    
    for s = 0, segments do
        local x = (s / segments) * length
        local y = height * math.sin(x)
        
        for w = -halfWidth, halfWidth, spacing do
            local position = center + Vector3.new(x, y, w)
            if not blockPositions[tostring(position)] then
                local rotation = nil
                if smoothRotation then
                    local tangent = Vector3_new(1, height * math.cos(x), 0).Unit
                    local normal = Vector3_new(-height * math.cos(x), 1, 0).Unit
                    local binormal = tangent:Cross(normal).Unit
                    rotation = CFrame.fromMatrix(Vector3_new(), tangent, binormal, normal)
                end
                local clone = X.CreatePreviewBlock(position, blockType, rotation)
                X.table_insert(blocks, clone)
                blockPositions[tostring(position)] = true
            end
        end
    end
    
    return blocks
end

function X.PreviewShape()
    X.ClearPreview()
    
    local plot = X.GetPlot()
    if not plot then
        return
    end
    
    local center = centerOnPlot and plot.Position or player.Character and player.Character.HumanoidRootPart.Position or plot.Position
    center = center + Vector3.new(0, radius + 5, 0)
    
    local blocks = {}
    local blockPositions = {}
    
    if shapeType == "Circle" then
        local circumference = 2 * math.pi * radius
        local segmentLength = 2
        local segments = math.max(8, X.math_floor(circumference / segmentLength))
        
        for i = 1, segments do
            local angle = (i / segments) * math.pi * 2
            local x = math.cos(angle) * radius
            local z = math.sin(angle) * radius
            
            local position = Vector3.new(x, 0, z)
            position = center + position
            
            for t = 1, thickness do
                local offset = (t - 1) * 2
                local offsetPos = position + Vector3.new(0, offset, 0)
                
                if not blockPositions[tostring(offsetPos)] then
                    local rotation = smoothRotation and X.GetCircleRotation(offsetPos, center) or nil
                    local clone = X.CreatePreviewBlock(offsetPos, blockType, rotation)
                    X.table_insert(blocks, clone)
                    blockPositions[tostring(offsetPos)] = true
                end
            end
        end
        
    elseif shapeType == "Ball" then
        blocks = X.GenerateBall(center, radius, blockType, blockSpacing)
        
    elseif shapeType == "Cylinder" then
        local height = radius * 2
        local halfHeight = height / 2
        local circumference = 2 * math.pi * radius
        local segmentLength = blockSpacing
        local segments = math.max(8, X.math_floor(circumference / segmentLength))
        
        for h = -halfHeight, halfHeight, blockSpacing do
            for i = 1, segments do
                local angle = (i / segments) * math.pi * 2
                local x = math.cos(angle) * radius
                local z = math.sin(angle) * radius
                
                local position = center + Vector3.new(x, h, z)
                
                if not blockPositions[tostring(position)] then
                    local rotation = smoothRotation and X.GetCircleRotation(position, center) or nil
                    local clone = X.CreatePreviewBlock(position, blockType, rotation)
                    X.table_insert(blocks, clone)
                    blockPositions[tostring(position)] = true
                end
            end
        end
        
    elseif shapeType == "Torus" then
        blocks = X.GenerateTorus(center, radius, thickness, blockType, blockSpacing)
        
    elseif shapeType == "Dome" then
        blocks = X.GenerateDome(center, radius, blockType, blockSpacing)
        
    elseif shapeType == "Wave" then
        blocks = X.GenerateWave(center, shapeWidth, shapeHeight, shapeDepth, blockType, blockSpacing)
    end
end

X.TextSettings = {
    Content = "When Boat Blitz v3?",
    BlockType = "WoodBlock",
    BlockSize = 2,  -- Default block size (standard block)
    Scale = 1.0,    -- Overall scale multiplier
    LetterSpacing = 1.2, -- Extra space between letters (in blocks, not studs)
    WordSpacing = 4.5,   -- Extra space between words (in blocks)
    LineHeight = 1.2,  -- Line height multiplier for multi-line text
    FontWidth = 5,
    FontHeight = 5,
}

-- Enhanced 5x5 font with better spacing
X.FONT_DEFINITIONS_5X5 = {
    -- Letters
    ["A"] = { {0,1,1,1,0}, {1,0,0,0,1}, {1,1,1,1,1}, {1,0,0,0,1}, {1,0,0,0,1} },
    ["B"] = { {1,1,1,1,0}, {1,0,0,0,1}, {1,1,1,1,0}, {1,0,0,0,1}, {1,1,1,1,0} },
    ["C"] = { {0,1,1,1,0}, {1,0,0,0,1}, {1,0,0,0,0}, {1,0,0,0,1}, {0,1,1,1,0} },
    ["D"] = { {1,1,1,1,0}, {1,0,0,0,1}, {1,0,0,0,1}, {1,0,0,0,1}, {1,1,1,1,0} },
    ["E"] = { {1,1,1,1,1}, {1,0,0,0,0}, {1,1,1,0,0}, {1,0,0,0,0}, {1,1,1,1,1} },
    ["F"] = { {1,1,1,1,1}, {1,0,0,0,0}, {1,1,1,0,0}, {1,0,0,0,0}, {1,0,0,0,0} },
    ["G"] = { {0,1,1,1,0}, {1,0,0,0,0}, {1,0,1,1,1}, {1,0,0,0,1}, {0,1,1,1,0} },
    ["H"] = { {1,0,0,0,1}, {1,0,0,0,1}, {1,1,1,1,1}, {1,0,0,0,1}, {1,0,0,0,1} },
    ["I"] = { {1,1,1,1,1}, {0,0,1,0,0}, {0,0,1,0,0}, {0,0,1,0,0}, {1,1,1,1,1} },
    ["J"] = { {1,1,1,1,1}, {0,0,0,0,1}, {0,0,0,0,1}, {1,0,0,0,1}, {0,1,1,1,0} },
    ["K"] = { {1,0,0,0,1}, {1,0,0,1,0}, {1,1,1,0,0}, {1,0,0,1,0}, {1,0,0,0,1} },
    ["L"] = { {1,0,0,0,0}, {1,0,0,0,0}, {1,0,0,0,0}, {1,0,0,0,0}, {1,1,1,1,1} },
    ["M"] = { {1,0,0,0,1}, {1,1,0,1,1}, {1,0,1,0,1}, {1,0,0,0,1}, {1,0,0,0,1} },
    ["N"] = { {1,0,0,0,1}, {1,1,0,0,1}, {1,0,1,0,1}, {1,0,0,1,1}, {1,0,0,0,1} },
    ["O"] = { {0,1,1,1,0}, {1,0,0,0,1}, {1,0,0,0,1}, {1,0,0,0,1}, {0,1,1,1,0} },
    ["P"] = { {1,1,1,1,0}, {1,0,0,0,1}, {1,1,1,1,0}, {1,0,0,0,0}, {1,0,0,0,0} },
    ["Q"] = { {0,1,1,1,0}, {1,0,0,0,1}, {1,0,1,0,1}, {1,0,0,1,0}, {0,1,1,0,1} },
    ["R"] = { {1,1,1,1,0}, {1,0,0,0,1}, {1,1,1,1,0}, {1,0,0,1,0}, {1,0,0,0,1} },
    ["S"] = { {0,1,1,1,1}, {1,0,0,0,0}, {0,1,1,1,0}, {0,0,0,0,1}, {1,1,1,1,0} },
    ["T"] = { {1,1,1,1,1}, {0,0,1,0,0}, {0,0,1,0,0}, {0,0,1,0,0}, {0,0,1,0,0} },
    ["U"] = { {1,0,0,0,1}, {1,0,0,0,1}, {1,0,0,0,1}, {1,0,0,0,1}, {0,1,1,1,0} },
    ["V"] = { {1,0,0,0,1}, {1,0,0,0,1}, {1,0,0,0,1}, {0,1,0,1,0}, {0,0,1,0,0} },
    ["W"] = { {1,0,0,0,1}, {1,0,0,0,1}, {1,0,1,0,1}, {1,1,0,1,1}, {1,0,0,0,1} },
    ["X"] = { {1,0,0,0,1}, {0,1,0,1,0}, {0,0,1,0,0}, {0,1,0,1,0}, {1,0,0,0,1} },
    ["Y"] = { {1,0,0,0,1}, {0,1,0,1,0}, {0,0,1,0,0}, {0,0,1,0,0}, {0,0,1,0,0} },
    ["Z"] = { {1,1,1,1,1}, {0,0,0,1,0}, {0,0,1,0,0}, {0,1,0,0,0}, {1,1,1,1,1} },
    
    -- Numbers
    ["0"] = { {0,1,1,1,0}, {1,0,0,0,1}, {1,0,0,0,1}, {1,0,0,0,1}, {0,1,1,1,0} },
    ["1"] = { {0,0,1,0,0}, {0,1,1,0,0}, {0,0,1,0,0}, {0,0,1,0,0}, {0,1,1,1,0} },
    ["2"] = { {0,1,1,1,0}, {1,0,0,0,1}, {0,0,1,1,0}, {0,1,0,0,0}, {1,1,1,1,1} },
    ["3"] = { {1,1,1,1,0}, {0,0,0,0,1}, {0,1,1,1,0}, {0,0,0,0,1}, {1,1,1,1,0} },
    ["4"] = { {1,0,0,1,0}, {1,0,0,1,0}, {1,1,1,1,1}, {0,0,0,1,0}, {0,0,0,1,0} },
    ["5"] = { {1,1,1,1,1}, {1,0,0,0,0}, {1,1,1,1,0}, {0,0,0,0,1}, {1,1,1,1,0} },
    ["6"] = { {0,1,1,1,0}, {1,0,0,0,0}, {1,1,1,1,0}, {1,0,0,0,1}, {0,1,1,1,0} },
    ["7"] = { {1,1,1,1,1}, {0,0,0,1,0}, {0,0,1,0,0}, {0,1,0,0,0}, {1,0,0,0,0} },
    ["8"] = { {0,1,1,1,0}, {1,0,0,0,1}, {0,1,1,1,0}, {1,0,0,0,1}, {0,1,1,1,0} },
    ["9"] = { {0,1,1,1,0}, {1,0,0,0,1}, {0,1,1,1,1}, {0,0,0,0,1}, {0,1,1,1,0} },
    
    -- Special characters
    [" "] = { {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0} },
    ["!"] = { {0,0,1,0,0}, {0,0,1,0,0}, {0,0,1,0,0}, {0,0,0,0,0}, {0,0,1,0,0} },
    ["?"] = { {0,1,1,1,0}, {1,0,0,0,1}, {0,0,1,1,0}, {0,0,0,0,0}, {0,0,1,0,0} },
    ["."] = { {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,1,0,0} },
    [","] = { {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,1,0,0}, {0,1,0,0,0} },
    [":"] = { {0,0,0,0,0}, {0,0,1,0,0}, {0,0,0,0,0}, {0,0,1,0,0}, {0,0,0,0,0} },
    [";"] = { {0,0,0,0,0}, {0,0,1,0,0}, {0,0,0,0,0}, {0,0,1,0,0}, {0,1,0,0,0} },
    ["-"] = { {0,0,0,0,0}, {0,0,0,0,0}, {0,1,1,1,0}, {0,0,0,0,0}, {0,0,0,0,0} },
    ["+"] = { {0,0,0,0,0}, {0,0,1,0,0}, {0,1,1,1,0}, {0,0,1,0,0}, {0,0,0,0,0} },
    ["="] = { {0,0,0,0,0}, {0,1,1,1,0}, {0,0,0,0,0}, {0,1,1,1,0}, {0,0,0,0,0} },
    ["*"] = { {0,0,0,0,0}, {1,0,1,0,1}, {0,1,1,1,0}, {1,0,1,0,1}, {0,0,0,0,0} },
    ["/"] = { {0,0,0,0,1}, {0,0,0,1,0}, {0,0,1,0,0}, {0,1,0,0,0}, {1,0,0,0,0} },
    ["\\"] = { {1,0,0,0,0}, {0,1,0,0,0}, {0,0,1,0,0}, {0,0,0,1,0}, {0,0,0,0,1} },
    ["|"] = { {0,0,1,0,0}, {0,0,1,0,0}, {0,0,1,0,0}, {0,0,1,0,0}, {0,0,1,0,0} },
    ["("] = { {0,0,1,0,0}, {0,1,0,0,0}, {0,1,0,0,0}, {0,1,0,0,0}, {0,0,1,0,0} },
    [")"] = { {0,0,1,0,0}, {0,0,0,1,0}, {0,0,0,1,0}, {0,0,0,1,0}, {0,0,1,0,0} },
    ["["] = { {0,1,1,1,0}, {0,1,0,0,0}, {0,1,0,0,0}, {0,1,0,0,0}, {0,1,1,1,0} },
    ["]"] = { {0,1,1,1,0}, {0,0,0,1,0}, {0,0,0,1,0}, {0,0,0,1,0}, {0,1,1,1,0} },
    ["{"] = { {0,0,1,1,0}, {0,0,1,0,0}, {0,1,0,0,0}, {0,0,1,0,0}, {0,0,1,1,0} },
    ["}"] = { {0,1,1,0,0}, {0,0,1,0,0}, {0,0,0,1,0}, {0,0,1,0,0}, {0,1,1,0,0} },
    ["<"] = { {0,0,0,1,0}, {0,0,1,0,0}, {0,1,0,0,0}, {0,0,1,0,0}, {0,0,0,1,0} },
    [">"] = { {0,1,0,0,0}, {0,0,1,0,0}, {0,0,0,1,0}, {0,0,1,0,0}, {0,1,0,0,0} },
    ["@"] = { {0,1,1,1,0}, {1,0,0,0,1}, {1,0,1,1,1}, {1,0,1,0,1}, {0,1,1,1,0} },
    ["#"] = { {0,1,0,1,0}, {1,1,1,1,1}, {0,1,0,1,0}, {1,1,1,1,1}, {0,1,0,1,0} },
    ["$"] = { {0,1,1,1,0}, {1,0,1,0,0}, {0,1,1,1,0}, {0,0,1,0,1}, {0,1,1,1,0} },
    ["%"] = { {1,0,0,0,1}, {0,0,0,1,0}, {0,0,1,0,0}, {0,1,0,0,0}, {1,0,0,0,1} },
    ["^"] = { {0,0,1,0,0}, {0,1,0,1,0}, {1,0,0,0,1}, {0,0,0,0,0}, {0,0,0,0,0} },
    ["&"] = { {0,1,1,0,0}, {1,0,0,1,0}, {0,1,1,0,1}, {1,0,0,1,0}, {0,1,1,0,1} },
    ["'"] = { {0,0,1,0,0}, {0,0,1,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0} },
    ['"'] = { {0,1,0,1,0}, {0,1,0,1,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0} },
    ["_"] = { {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {1,1,1,1,1} },
    ["~"] = { {0,1,0,0,0}, {1,0,1,0,0}, {0,1,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0} },
    ["`"] = { {0,0,1,0,0}, {0,0,0,1,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0} },
}

function X.GetLetterDefinition(char)
    -- Try to get the character, default to space if not found
    local def = X.FONT_DEFINITIONS_5X5[string.upper(char)]
    if def then return def end
    
    -- Return a filled block for unknown characters (debug mode)
    return { {1,1,1,1,1}, {1,1,1,1,1}, {1,1,1,1,1}, {1,1,1,1,1}, {1,1,1,1,1} }
end

function X.CalculateTextDimensions(text)
    if not text or text == "" then
        return 0, 0, {}
    end
    
    local lines = {}
    local lineWidths = {}
    local maxLineWidth = 0
    
    -- Handle multi-line text (split by \n)
    for line in string.gmatch(text .. "\n", "(.-)\n") do
        if line ~= "" or #lines > 0 then
            table.insert(lines, line)
        end
    end
    
    if #lines == 0 then
        lines = {text}
    end
    
    -- Calculate width for each line
    for lineIdx, line in ipairs(lines) do
        local lineWidth = 0
        local isFirstChar = true
        
        for i = 1, #line do
            local char = line:sub(i, i)
            
            if char == " " then
                -- Space: add word spacing
                lineWidth = lineWidth + (X.TextSettings.WordSpacing * X.TextSettings.BlockSize * X.TextSettings.Scale)
            else
                -- Regular character
                if not isFirstChar then
                    -- Add letter spacing between characters (not before first)
                    lineWidth = lineWidth + (X.TextSettings.LetterSpacing * X.TextSettings.BlockSize * X.TextSettings.Scale)
                end
                
                local letterDef = X.GetLetterDefinition(char)
                local charWidth = #letterDef[1] * X.TextSettings.BlockSize * X.TextSettings.Scale
                lineWidth = lineWidth + charWidth
            end
            
            isFirstChar = false
        end
        
        lineWidths[lineIdx] = lineWidth
        if lineWidth > maxLineWidth then
            maxLineWidth = lineWidth
        end
    end
    
    -- Calculate total height
    local totalHeight = #lines * (X.TextSettings.FontHeight * X.TextSettings.BlockSize * X.TextSettings.Scale * X.TextSettings.LineHeight)
    
    return maxLineWidth, totalHeight, {lines = lines, widths = lineWidths}
end

function X.GenerateTextPreview()
    if X.TextSettings.Content == "" then
        if X.listing then X.listing:Clear() end
        return
    end

    local plot = X.GetPlot()
    if not plot then
        if X.listing then X.listing:Clear() end
        return
    end

    local totalWidth, totalHeight, lineData = X.CalculateTextDimensions(X.TextSettings.Content)
    local plotCenter = plot.Position
    local startX = plotCenter.X - totalWidth / 2
    local startY = plotCenter.Y + 10 - totalHeight / 2
    local startZ = plotCenter.Z
    local blockSize = X.TextSettings.BlockSize * X.TextSettings.Scale

    local descriptors = {}

    for lineIdx, line in ipairs(lineData.lines) do
        local lineY = startY + ((lineIdx - 1) * X.TextSettings.FontHeight * blockSize * X.TextSettings.LineHeight)
        local lineX = startX
        local isFirstChar = true

        for i = 1, #line do
            local char = line:sub(i, i)

            if char == " " then
                lineX = lineX + (X.TextSettings.WordSpacing * blockSize)
                isFirstChar = true
            else
                if not isFirstChar then
                    lineX = lineX + (X.TextSettings.LetterSpacing * blockSize)
                end

                local letterDef = X.GetLetterDefinition(char)

                for row = 1, X.TextSettings.FontHeight do
                    for col = 1, X.TextSettings.FontWidth do
                        if letterDef[row] and letterDef[row][col] == 1 then
                            local posX = lineX + (col - 1) * blockSize + (blockSize / 2)
                            local posY = lineY + ((X.TextSettings.FontHeight - row) * blockSize) + (blockSize / 2)
                            X.table_insert(descriptors, {
                                blockType = X.TextSettings.BlockType,
                                position = Vector3.new(posX, posY, startZ),
                                size = Vector3.new(blockSize, blockSize, blockSize),
                                canCollide = false,
                                castShadow = true,
                            })
                        end
                    end
                end

                lineX = lineX + (X.TextSettings.FontWidth * blockSize)
                isFirstChar = false
            end
        end
    end

    local placedBlocks = X.ChunkedPreviewLoad(descriptors, { batchSize = 50 })
    print(string.format("Text preview generated: %d blocks", placedBlocks))
    X.ListTextBlocks()
end

function X.ListTextBlocks()
    if X.TextSettings.Content == "" then
        X.listing:Clear()
        return
    end
    
    local totalBlocks = 0
    
    -- Count blocks needed
    for i = 1, #X.TextSettings.Content do
        local char = X.TextSettings.Content:sub(i, i)
        if char ~= " " then
            local letterDef = X.GetLetterDefinition(char)
            if letterDef then
                for row = 1, #letterDef do
                    for col = 1, #letterDef[row] do
                        if letterDef[row][col] == 1 then
                            totalBlocks = totalBlocks + 1
                        end
                    end
                end
            end
        end
    end
    
    X.ListBlockRequirements({ [X.TextSettings.BlockType] = totalBlocks })

    return totalBlocks
end

function X.UpdateTextSetting(settingName, value)
    X.TextSettings[settingName] = value
    X.GenerateTextPreview()
    X.ListTextBlocks()
end

local UiColor = "53, 63, 119"
local r, g, b = string.match(UiColor, "(%d+),%s*(%d+),%s*(%d+)")
local mainColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))

local window = X.library.new({
    text = "Voltara Auto Build",
    size = Vector2.new(360, 538),
    shadow = 0,
    transparency = 0.25,
    color = mainColor,
    boardcolor = Color3.fromRGB(21, 22, 23),
    rounding = 5,
    animation = 0.1,
    position = UDim2.new(0, 310, 0, 40),
})

window.open()

local mainTab = window.new({ text = "Main" })

mainTab:show()

local fileDropdown
local selectedFile
local firstRefreshDone = false 
local isManualRefresh = false

local dropdownObjects = {} 
local nameToPathMap = {}

local function refreshFiles()
    if not fileDropdown then
        fileDropdown = mainTab.new("dropdown", {
            text = "Files",
        })
        fileDropdown.event:Connect(function(option)
            selectedFile = nameToPathMap[option]
        end)
    end

    if isManualRefresh then
        task.wait(0.1)
    end

    local currentBuilds = X.ListBuilds()

    local namesToRemove = {}
    for name, path in pairs(nameToPathMap) do
        local found = false
        for _, newBuild in ipairs(currentBuilds) do
            if newBuild.name == name and newBuild.path == path then
                found = true
                break
            end
        end
        if not found then
            table.insert(namesToRemove, name)
        end
    end

    for _, name in ipairs(namesToRemove) do
        local objToRemove = dropdownObjects[name]
        if objToRemove then
            if objToRemove.object and objToRemove.object.Parent then
                objToRemove.object.Parent = nil
            end
            if type(objToRemove.Destroy) == "function" then
                objToRemove:Destroy()
            end
        end
        dropdownObjects[name] = nil
        nameToPathMap[name] = nil
    end

    local namesToAdd = {}
    for _, newBuild in ipairs(currentBuilds) do
        if not nameToPathMap[newBuild.name] then 
            table.insert(namesToAdd, newBuild)
        end
    end

    for _, buildInfo in ipairs(namesToAdd) do
        local createdItemObj = fileDropdown.new(buildInfo.name)
        
        if createdItemObj then
            dropdownObjects[buildInfo.name] = createdItemObj
            nameToPathMap[buildInfo.name] = buildInfo.path
        end
    end

    if not selectedFile and #currentBuilds > 0 then
        local randomIndex = math.random(1, #currentBuilds)
        local randomBuild = currentBuilds[randomIndex]
        
        selectedFile = randomBuild.path

        local dropdownObj = dropdownObjects[randomBuild.name]
        if dropdownObj then
            if type(dropdownObj.Select) == "function" then
                dropdownObj.Select()

            end
        end
    end
end

refreshFiles()

mainTab.new("button", {
    text = "Refresh Files",
}).event:Connect(function()
    isManualRefresh = true
    task.spawn(function()
        refreshFiles()
        isManualRefresh = false
    end)
end)

local saveFolder = mainTab.new("folder", {
    text = "Saving",
})

saveFolder.new("input", {
    text = "File Name",
    placeholder = "Enter File Name",
}).event:Connect(function(text)
    saveFileName = text .. ".Build"
end)

local teamDropdown = saveFolder.new("dropdown", {
    text = "Team",
})

local teamOptions = {}
teamOptions["My Team"] = teamDropdown.new("My Team")
teamOptions["white"] = teamDropdown.new("white")
teamOptions["blue"] = teamDropdown.new("blue")
teamOptions["green"] = teamDropdown.new("green")
teamOptions["red"] = teamDropdown.new("red")
teamOptions["black"] = teamDropdown.new("black")
teamOptions["yellow"] = teamDropdown.new("yellow")
teamOptions["magenta"] = teamDropdown.new("magenta")

teamDropdown.event:Connect(function(option)
    if option == "My Team" then
        saveTeam = tostring(player.Team)
    else
        saveTeam = option
    end
end)

teamOptions["My Team"]:Select()

saveFolder.new("button", {
    text = "Save To File",
}).event:Connect(function()
    if not saveFileName or not saveTeam then
        warn("Please enter a file name and select a team!")
        return
    end
    X.SavePlot(saveFileName, saveTeam)
    refreshFiles()
end)
saveFolder.open()

local settingsFolder = mainTab.new("folder", {
    text = "Build Settings",
})



settingsFolder.new("switch", {
    text = "Safe Mode",
}).event:Connect(function(state)
    X.Config.safeMode = state
end)

local speedDropdown = settingsFolder.new("dropdown", {
    text = "Speed",
})

local speedOptions = {}
speedOptions["Ultra"] = speedDropdown.new("Ultra")
speedOptions["Very Fast"] = speedDropdown.new("Very Fast")
speedOptions["Fast"] = speedDropdown.new("Fast")
speedOptions["Medium"] = speedDropdown.new("Medium")
speedOptions["Slow"] = speedDropdown.new("Slow")
speedOptions["Auto"] = speedDropdown.new("Auto")

speedDropdown.event:Connect(function(option)
    if option == "Ultra" then
        X.Config.speedMode = -1
    elseif option == "Very Fast" then
        X.Config.speedMode = 0
    elseif option == "Fast" then
        X.Config.speedMode = 1
    elseif option == "Medium" then
        X.Config.speedMode = 2
    elseif option == "Slow" then
        X.Config.speedMode = 3
    elseif option == "Auto" then
        X.Config.speedMode = 4
    end
    speedDropdown:close()
end)

speedOptions["Auto"]:Select()

settingsFolder.new("input", {
    text = "",
    placeholder = "Size %",
}).event:Connect(function(value)
    sizePercent = tonumber(value) / 100
end)

local coloredLabel = settingsFolder:new("label", {
    text = "Auto loading speed recommended, as it is based on",
    color = Color3.fromRGB(240, 50, 60) 
})
local coloredLabel = settingsFolder:new("label", {
    text = "the current device and server performance. \n ",
    color = Color3.fromRGB(240, 50, 60) 
})
settingsFolder.open()

local builderFolder = mainTab.new("folder", {
    text = "Builder",
})

builderFolder.new("button", {
    text = "List Blocks",
}).event:Connect(function()
    X.ListBuild(selectedFile, sizePercent)
end)

builderFolder.new("button", {
    text = "Preview",
}).event:Connect(function()
    if #workspaceChildren(BuildPreview) <= 0 then
        X.PreviewFile(selectedFile, sizePercent)
        X.ListBuild(selectedFile, sizePercent)
    else
        X.ClearPreview(true)
        X.listing:Clear()
    end
end)

builderFolder.new("button", {
    text = "Load File",
}).event:Connect(function()
    X.LoadFile(selectedFile, sizePercent or 1)
end)
builderFolder.open()



local imagesTab = window.new({ text = "Image" })
local loadersTab = window.new({ text = "Loaders" })

imagesTab.new("label", {
    text = "You can Adjust the Image in the Ajusters Tab.",
})
imagesTab.new("label", {
    text = "\nResolution:\nHiger = Bad Image Quality + Less Blocks\nLower = Better Image Quallity + More Blocks",
})
imagesTab.new("label", { text = "" })

local mainSettings = imagesTab.new("folder", {
    text = "Main Settings",
})
mainSettings.new("input", {
    text = "URL",
    placeholder = "Image URL",
}).event:Connect(function(url)
    imageUrl = url
end)
mainSettings.open()

local imageSettings = imagesTab.new("folder", {
    text = "Build Settings",
})
imageSettings.new("input", {
    text = "Block Size",
    placeholder = "0.5",
}).event:Connect(function(size)
    imageBlockSize = tonumber(size)
    X.ClearPreview()
end)

imageSettings.new("input", {
    text = "Resolution",
    placeholder = "5",
}).event:Connect(function(res)
    resolution = tonumber(res)
    X.ClearPreview()
end)

local imageBlockTypeDropdown = imageSettings.new("dropdown", {
    text = "Block Type",
})
imageBlockTypeDropdown.event:Connect(function(blockTypeOption)
    imageBlockType = blockTypeOption
    X.ClearPreview()
end)

for _, part in next, workspaceChildren(BuildingParts), nil do
    local name = part.Name
    if string.sub(name, #name - 4, #name) == "Block" then
        imageBlockTypeDropdown.new(name)
    end
end
imageSettings.open()

local imageBuilder = imagesTab.new("folder", {
    text = "Builder",
})
imageBuilder.new("button", {
    text = "List Blocks",
}).event:Connect(function()
    X.ListImageBlocks()
end)

imageBuilder.new("button", {
    text = "Preview",
}).event:Connect(function()
    if #workspaceChildren(BuildPreview) > 0 then
        X.ClearPreview(true)
        X.listing:Clear()
    else
        X.ProcessImage(imageUrl, imageBlockType, imageBlockSize, resolution, true)
        X.ListImageBlocks()
    end
end)

imageBuilder.new("button", {
    text = "Load Image",
}).event:Connect(function()
    X.ProcessImage(imageUrl, imageBlockType, imageBlockSize, resolution, false)
end)
imageBuilder.open()


loadersTab.new("label", {
    text = " ",
})

loadersTab.new("label", {
    text = "Warning: Loader are still under Development, \nthere are maybe some Bugs.\nYou can Adjust the Preview in the Ajusters Tab. \n ",
})

loadersTab.new("label", {
    text = " ",
})

local shapesFolder = loadersTab.new("folder", {
    text = "Shape Loader",
})

local shapeSettingsFolder = shapesFolder.new("folder", {
    text = "Shape Settings",
})

local shapeTypeDropdown = shapeSettingsFolder.new("dropdown", {
    text = "Shape Type",
})
    shapeTypeDropdown.new("Circle")
    shapeTypeDropdown.new("Ball")
    shapeTypeDropdown.new("Cylinder")
    shapeTypeDropdown.new("Torus")
    shapeTypeDropdown.new("Dome")
    shapeTypeDropdown.new("Wave")
shapeTypeDropdown.event:Connect(function(option)
    shapeType = option
end)

local shapeBlockTypeDropdown = shapeSettingsFolder.new("dropdown", {
    text = "Block Type",
})
shapeBlockTypeDropdown.event:Connect(function(option)
    blockType = option
end)

for _, part in next, workspaceChildren(BuildingParts), nil do
    local name = part.Name
    if string.sub(name, #name - 4, #name) == "Block" then
        shapeBlockTypeDropdown.new(name)
    end
end

shapeSettingsFolder.open()

local shapeDimensionsFolder = shapesFolder.new("folder", {
    text = "Dimensions",
})

shapeDimensionsFolder.new("input", {
    text = "Radius/Size",
    placeholder = "5",
}).event:Connect(function(value)
    radius = tonumber(value) or 5
end)

shapeDimensionsFolder.new("input", {
    text = "Width",
    placeholder = "10",
}).event:Connect(function(value)
    shapeWidth = tonumber(value) or 10
end)

shapeDimensionsFolder.new("input", {
    text = "Height",
    placeholder = "10",
}).event:Connect(function(value)
    shapeHeight = tonumber(value) or 10
end)

shapeDimensionsFolder.new("input", {
    text = "Depth",
    placeholder = "10",
}).event:Connect(function(value)
    shapeDepth = tonumber(value) or 10
end)

shapeDimensionsFolder.new("input", {
    text = "Thickness",
    placeholder = "1",
}).event:Connect(function(value)
    thickness = tonumber(value) or 1
end)

shapeDimensionsFolder.open()

local shapeOptionsFolder = shapesFolder.new("folder", {
    text = "Options",
})

shapeOptionsFolder.new("input", {
    text = "Block Spacing",
    placeholder = "2",
}).event:Connect(function(value)
    blockSpacing = math.max(1, tonumber(value) or 2)
end)

shapeOptionsFolder.new("switch", {
    text = "Center on Plot",
}).event:Connect(function(state)
    centerOnPlot = state
end)

shapeOptionsFolder.new("switch", {
    text = "Smooth Rotation",
    value = true,
}).event:Connect(function(state)
    smoothRotation = state
end)

shapeOptionsFolder.open()

local function listShapeBlocks()
    local blocksInPreview = X.GetPreviewBlocks()
    local required = {}

    if #blocksInPreview > 0 then
        local standardBlockVolume = 8 -- 2x2x2
        for _, block in ipairs(blocksInPreview) do
            local ppart = block:FindFirstChild("PPart")
            local blocksNeeded = 1
            if ppart then
                local size = ppart.Size
                local baseTemplate = BuildingParts:FindFirstChild(block.Name)
                local baseSize = baseTemplate and baseTemplate:FindFirstChild("PPart") and baseTemplate.PPart.Size or Vector3.new(2, 2, 2)
                local baseVolume = baseSize.X * baseSize.Y * baseSize.Z
                local volume = size.X * size.Y * size.Z
                blocksNeeded = math.max(1, math.ceil(volume / baseVolume))
            end
            required[block.Name] = (required[block.Name] or 0) + blocksNeeded
        end
    else
        local plot = X.GetPlot()
        if plot then
            local center = centerOnPlot and plot.Position or player.Character and player.Character.HumanoidRootPart.Position or plot.Position
            center = center + Vector3.new(0, radius + 5, 0)

            if shapeType == "Ball" then
                local volume = (4/3) * math.pi * math.pow(radius, 3)
                local blockVolume = math.pow(blockSpacing, 3)
                required[blockType] = math.ceil(volume / blockVolume)
            elseif shapeType == "Cylinder" then
                local height = radius * 2
                local baseArea = math.pi * math.pow(radius, 2)
                local blocksHeight = math.ceil(height / blockSpacing)
                local blocksBase = math.ceil(baseArea / math.pow(blockSpacing, 2))
                required[blockType] = blocksHeight * blocksBase
            elseif shapeType == "Circle" then
                local circumference = 2 * math.pi * radius
                local segments = math.max(8, X.math_floor(circumference / blockSpacing))
                required[blockType] = segments * thickness
            else
                required[blockType] = math.ceil((radius * 2) / blockSpacing) ^ 2
            end
        end
    end

    X.ListBlockRequirements(required)
end

local previewButton = shapesFolder.new("button", {
    text = "Preview Shape",
})

previewButton.event:Connect(function()
    if #workspaceChildren(BuildPreview) > 0 then
        X.ClearPreview(true)
        X.listing:Clear()
    else
        X.PreviewShape()
        listShapeBlocks()
    end
end)

shapesFolder.new("button", {
    text = "Build Shape",
}).event:Connect(function()
    X.BuildFromPreview({ previewFn = X.PreviewShape })
end)

shapesFolder.new("button", {
    text = "List Blocks",
}).event:Connect(listShapeBlocks)

local textFolder = loadersTab.new("folder", {
    text = "Text Loader",
})

local textSettingsFolder = textFolder.new("folder", {
    text = "Text Settings",
})

textSettingsFolder.new("input", {
    text = "Text Content",
    placeholder = X.TextSettings.Content,
}).event:Connect(function(text)
    X.UpdateTextSetting("Content", text)
end)

local textBlockTypeDropdown = textSettingsFolder.new("dropdown", {
    text = "Block Type",
})
for _, part in next, workspaceChildren(BuildingParts), nil do
    local name = part.Name
    if string.sub(name, #name - 4, #name) == "Block" then
        textBlockTypeDropdown.new(name)
    end
end
textBlockTypeDropdown.event:Connect(function(blockTypeOption)
    X.UpdateTextSetting("BlockType", blockTypeOption)
end)

textSettingsFolder.open()

local textDimensionsFolder = textFolder.new("folder", {
    text = "Dimensions",
})

textDimensionsFolder.new("input", {
    text = "Block Size",
    placeholder = tostring(X.TextSettings.BlockSize),
}).event:Connect(function(size)
    local val = tonumber(size)
    if val and val > 0 then
        X.UpdateTextSetting("BlockSize", val)
    end
end)

textDimensionsFolder.new("input", {
    text = "Scale",
    placeholder = tostring(X.TextSettings.Scale),
}).event:Connect(function(scale)
    local val = tonumber(scale)
    if val and val > 0 then
        X.UpdateTextSetting("Scale", val)
    end
end)

local textOptionsFolder = textFolder.new("folder", {
    text = "Options",
})

textOptionsFolder.new("input", {
    text = "Letter Spacing",
    placeholder = tostring(X.TextSettings.LetterSpacing),
}).event:Connect(function(spacing)
    local val = tonumber(spacing)
    if val and val >= 0 then
        X.UpdateTextSetting("LetterSpacing", val)
    end
end)

textOptionsFolder.new("input", {
    text = "Word Spacing",
    placeholder = tostring(X.TextSettings.WordSpacing),
}).event:Connect(function(spacing)
    local val = tonumber(spacing)
    if val and val >= 0 then
        X.UpdateTextSetting("WordSpacing", val)
    end
end)

textDimensionsFolder.open()
textOptionsFolder.open()

textFolder.new("button", {
    text = "Preview Text",
}).event:Connect(X.GenerateTextPreview)

textFolder.new("button", {
    text = "Clear Preview Text",
}).event:Connect(function()
    X.ClearPreview()
    X.listing:Clear()
end)

textFolder.new("button", {
    text = "List Blocks",
}).event:Connect(X.ListTextBlocks)

textFolder.new("button", {
    text = "Load Text",
}).event:Connect(function()
    X.BuildFromPreview({ previewFn = X.GenerateTextPreview, clearAfter = true })
end)
--]]


local terrainFolder = loadersTab.new("folder", {
    text = "Terrain Loader",
})

terrainFolder.new("label", {
    text = "Terrain Loader Update Soon",
})

local terrainSettings = {
    Type = "Mountain",
    BlockType = "GrassBlock",
    Width = 20,
    Height = 10,
    Depth = 20,
    Scale = 2,
    Roughness = 0.5,
    Seed = 0,  -- 0 = random each time
    BlockSize = 2,
    SmoothRotation = false,
    EdgeSmoothing = false,
    DetailDensity = 0.4,
}

local terrainSettingsFolder = terrainFolder.new("folder", {
    text = "Terrain Settings",
})

local terrainTypeDropdown = terrainSettingsFolder.new("dropdown", {
    text = "Terrain Type",
})
terrainTypeDropdown.new("Mountain")
terrainTypeDropdown.new("Hill")
terrainTypeDropdown.new("Valley")
terrainTypeDropdown.new("Plateau")
terrainTypeDropdown.new("Crater")
terrainTypeDropdown.new("Ridge")
terrainTypeDropdown.new("Canyon")
terrainTypeDropdown.new("Dunes")
terrainTypeDropdown.event:Connect(function(option)
    terrainSettings.Type = option
end)

local terrainBlockTypeDropdown = terrainSettingsFolder.new("dropdown", {
    text = "Block Type",
})
terrainBlockTypeDropdown.event:Connect(function(option)
    terrainSettings.BlockType = option
end)

for _, part in next, workspaceChildren(BuildingParts), nil do
    local name = part.Name
    if string.sub(name, #name - 4, #name) == "Block" then
        terrainBlockTypeDropdown.new(name)
    end
end

terrainSettingsFolder.open()

local terrainDimensionsFolder = terrainFolder.new("folder", {
    text = "Dimensions",
})

terrainDimensionsFolder.new("input", {
    text = "Width",
    placeholder = tostring(terrainSettings.Width),
}).event:Connect(function(value)
    terrainSettings.Width = math.max(1, tonumber(value) or terrainSettings.Width)
end)

terrainDimensionsFolder.new("input", {
    text = "Height",
    placeholder = tostring(terrainSettings.Height),
}).event:Connect(function(value)
    terrainSettings.Height = math.max(1, tonumber(value) or terrainSettings.Height)
end)

terrainDimensionsFolder.new("input", {
    text = "Depth",
    placeholder = tostring(terrainSettings.Depth),
}).event:Connect(function(value)
    terrainSettings.Depth = math.max(1, tonumber(value) or terrainSettings.Depth)
end)

terrainDimensionsFolder.open()

local terrainOptionsFolder = terrainFolder.new("folder", {
    text = "Options",
})

terrainOptionsFolder.new("input", {
    text = "Roughness",
    placeholder = tostring(terrainSettings.Roughness),
}).event:Connect(function(value)
    terrainSettings.Roughness = math.max(0.1, math.min(1, tonumber(value) or terrainSettings.Roughness))
end)

terrainOptionsFolder.new("input", {
    text = "Detail Density (0-1)",
    placeholder = "0.4",
}).event:Connect(function(value)
    terrainSettings.DetailDensity = math.max(0, math.min(1, tonumber(value) or 0.4))
end)

terrainOptionsFolder.new("switch", {
    text = "Smooth Rotation",
    value = false,
}).event:Connect(function(state)
    terrainSettings.SmoothRotation = state
end)

terrainOptionsFolder.new("switch", {
    text = "Smooth Edges & Corners",
    value = true,
}).event:Connect(function(state)
    terrainSettings.EdgeSmoothing = state
end)

terrainOptionsFolder.open()

-- Cached permutation table for consistent, fast noise
local cachedPermSeed = nil
local perm = {}

local function buildPermTable(seed)
    if cachedPermSeed == seed then return end
    cachedPermSeed = seed
    local random = Random.new(seed)
    for i = 0, 255 do
        perm[i] = i
    end
    for i = 255, 1, -1 do
        local j = math.floor(random:NextNumber() * (i + 1))
        perm[i], perm[j] = perm[j], perm[i]
    end
    for i = 0, 255 do
        perm[256 + i] = perm[i]
    end
end

local function perlinNoise(x, y, seed)
    buildPermTable(seed)

    local function fade(t)
        return t * t * t * (t * (t * 6 - 15) + 10)
    end

    local function lerp(t, a, b)
        return a + t * (b - a)
    end

    local function grad(hash, gx, gy)
        local h = hash % 8
        local u = h < 4 and gx or gy
        local v = h < 4 and gy or gx
        return ((h % 2 == 0) and u or -u) + ((h % 4 < 2) and v or -v)
    end

    local xi = math.floor(x) % 255
    local yi = math.floor(y) % 255

    local xf = x - math.floor(x)
    local yf = y - math.floor(y)

    local u = fade(xf)
    local v = fade(yf)

    local A = perm[xi] + yi
    local AA = perm[A]
    local AB = perm[A + 1]
    local B = perm[xi + 1] + yi
    local BA = perm[B]
    local BB = perm[B + 1]

    return lerp(v, lerp(u, grad(perm[AA], xf, yf),
                          grad(perm[BA], xf - 1, yf)),
                   lerp(u, grad(perm[AB], xf, yf - 1),
                          grad(perm[BB], xf - 1, yf - 1)))
end

-- Fractal brownian motion for natural-looking terrain
local function fbm(x, y, seed, octaves, lacunarity, gain)
    octaves = octaves or 6
    lacunarity = lacunarity or 2.0
    gain = gain or 0.5

    local total = 0
    local amplitude = 1
    local frequency = 1
    local maxValue = 0

    for i = 1, octaves do
        total = total + perlinNoise(x * frequency, y * frequency, seed + i * 100) * amplitude
        maxValue = maxValue + amplitude
        amplitude = amplitude * gain
        frequency = frequency * lacunarity
    end

    return total / maxValue
end


local function getTerrainHeight(x, z, terrainType, width, depth, height, scale, roughness, seed)
    local normalizedX = x / width * scale
    local normalizedZ = z / depth * scale

    local octaves = math.floor(4 + roughness * 4)
    local baseNoise = fbm(normalizedX, normalizedZ, seed, octaves, 2.0, roughness)
    local detailNoise = fbm(normalizedX * 3, normalizedZ * 3, seed + 500, math.max(2, octaves - 2), 2.0, roughness * 0.7)

    local heightValue = baseNoise * 0.75 + detailNoise * 0.25

    local centerX = x - width / 2
    local centerZ = z - depth / 2
    local halfW = width / 2
    local halfD = depth / 2
    local centerDist = math.sqrt((centerX / halfW) ^ 2 + (centerZ / halfD) ^ 2)
    centerDist = math.min(centerDist, 1.4)

    -- Smooth edge falloff so terrain doesn't clip at borders
    local edgeFade = 1
    local edgeX = math.abs(centerX) / halfW
    local edgeZ = math.abs(centerZ) / halfD
    local edgeMax = math.max(edgeX, edgeZ)
    if edgeMax > 0.8 then
        edgeFade = 1 - ((edgeMax - 0.8) / 0.2)
        edgeFade = edgeFade * edgeFade * (3 - 2 * edgeFade)
        edgeFade = math.max(0, edgeFade)
    end

    if terrainType == "Mountain" then
        local peak = math.max(0, 1 - centerDist * 1.2)
        peak = peak * peak
        heightValue = (heightValue * 0.4 + 0.6) * peak
        return heightValue * height * edgeFade

    elseif terrainType == "Hill" then
        heightValue = (heightValue + 1) * 0.5
        return heightValue * height * 0.7 * edgeFade

    elseif terrainType == "Valley" then
        local valleyShape = centerDist * centerDist
        heightValue = (heightValue + 1) * 0.5
        heightValue = heightValue * 0.3 + valleyShape * 0.7
        return heightValue * height * 0.5 * edgeFade

    elseif terrainType == "Plateau" then
        local platShape = 1 - centerDist
        platShape = math.max(0, platShape)
        -- Smooth plateau top with slight noise
        local flatTop = platShape > 0.5 and (0.8 + heightValue * 0.1) or (platShape * 2 * (0.5 + heightValue * 0.3))
        return flatTop * height * edgeFade

    elseif terrainType == "Crater" then
        -- Ring shape: high at mid-distance, low at center and edges
        local ring = math.sin(centerDist * math.pi)
        ring = ring * ring
        heightValue = (heightValue + 1) * 0.5
        heightValue = ring * 0.7 + heightValue * 0.3
        return heightValue * height * 0.6 * edgeFade

    elseif terrainType == "Ridge" then
        local ridgeZ = math.abs(centerZ) / halfD
        local ridgeShape = math.exp(-ridgeZ * ridgeZ * 4)
        heightValue = (heightValue + 1) * 0.5
        heightValue = ridgeShape * 0.7 + heightValue * 0.3
        return heightValue * height * edgeFade

    elseif terrainType == "Canyon" then
        local canyonZ = math.abs(centerZ) / halfD
        -- Smooth canyon walls using sigmoid-like curve
        local canyonShape = 1 / (1 + math.exp(-12 * (canyonZ - 0.3)))
        heightValue = (heightValue + 1) * 0.5
        heightValue = canyonShape * 0.7 + heightValue * 0.3
        return heightValue * height * 0.8 * edgeFade

    elseif terrainType == "Dunes" then
        local duneWave = math.sin(normalizedX * 4 + heightValue * 2) * 0.5 + 0.5
        local crossWave = math.sin(normalizedZ * 2.5 + normalizedX * 1.5) * 0.3 + 0.5
        heightValue = (heightValue + 1) * 0.5
        local duneHeight = duneWave * 0.5 + crossWave * 0.3 + heightValue * 0.2
        return duneHeight * height * 0.6 * edgeFade
    end

    return ((heightValue + 1) * 0.5) * height * edgeFade
end

local function smoothHeightMap(sourceMap, w, d, passes)
    local current = sourceMap
    for pass = 1, passes do
        local dest = {}
        for x = 0, w - 1 do
            dest[x] = {}
            for z = 0, d - 1 do
                local sum = current[x][z] * 4
                local weight = 4
                -- Cardinal neighbors (weight 2)
                for _, off in ipairs({{1,0},{-1,0},{0,1},{0,-1}}) do
                    local nx, nz = x + off[1], z + off[2]
                    if current[nx] and current[nx][nz] then
                        sum = sum + current[nx][nz] * 2
                        weight = weight + 2
                    end
                end
                -- Diagonal neighbors (weight 1)
                for _, off in ipairs({{1,1},{-1,1},{1,-1},{-1,-1}}) do
                    local nx, nz = x + off[1], z + off[2]
                    if current[nx] and current[nx][nz] then
                        sum = sum + current[nx][nz]
                        weight = weight + 1
                    end
                end
                dest[x][z] = sum / weight
            end
        end
        current = dest
    end
    return current
end

local function generateTerrainPreview()
    local plot = X.GetPlot()
    if not plot then
        return
    end

    -- Random seed if set to 0
    local seed = terrainSettings.Seed
    if seed == 0 then
        seed = math.floor(os.clock() * 10000) % 999999 + 1
    end

    local center = plot.Position + Vector3.new(0, 10, 0)
    local descriptors = {}
    local bs = terrainSettings.BlockSize
    local w = terrainSettings.Width
    local d = terrainSettings.Depth

    -- Build height map at 2x resolution for smoother interpolation
    local res = 2  -- sub-steps per block
    local fineW = w * res
    local fineD = d * res
    local fineMap = {}
    for fx = 0, fineW - 1 do
        fineMap[fx] = {}
        for fz = 0, fineD - 1 do
            fineMap[fx][fz] = getTerrainHeight(
                fx / res, fz / res,
                terrainSettings.Type, w, d,
                terrainSettings.Height,
                terrainSettings.Scale,
                terrainSettings.Roughness,
                seed
            )
        end
    end

    -- Smooth the fine map
    local smoothPasses = terrainSettings.EdgeSmoothing and 5 or 0
    fineMap = smoothHeightMap(fineMap, fineW, fineD, smoothPasses)

    -- Downsample back to block grid using averaging
    local heightMap = {}
    for x = 0, w - 1 do
        heightMap[x] = {}
        for z = 0, d - 1 do
            local sum = 0
            local count = 0
            for sx = 0, res - 1 do
                for sz = 0, res - 1 do
                    local fx = x * res + sx
                    local fz = z * res + sz
                    if fineMap[fx] and fineMap[fx][fz] then
                        sum = sum + fineMap[fx][fz]
                        count = count + 1
                    end
                end
            end
            heightMap[x][z] = count > 0 and (sum / count) or 0
        end
    end

    -- Additional smoothing on the block-level map
    if terrainSettings.EdgeSmoothing then
        heightMap = smoothHeightMap(heightMap, w, d, 2)
    end

    -- Track placed positions to avoid duplicates
    local placed = {}
    local function posKey(x, y, z)
        return x .. "," .. y .. "," .. z
    end

    local function addBlock(x, y, z, rotation)
        local key = posKey(x, y, z)
        if placed[key] then return end
        placed[key] = true

        local position = center + Vector3.new(
            (x - w / 2) * bs,
            y * bs,
            (z - d / 2) * bs
        )

        X.table_insert(descriptors, {
            blockType = terrainSettings.BlockType,
            position = position,
            rotation = rotation,
        })
    end

    -- Convert to level map
    local levelMap = {}
    for x = 0, w - 1 do
        levelMap[x] = {}
        for z = 0, d - 1 do
            levelMap[x][z] = math.max(0, X.math_floor(heightMap[x][z] / bs + 0.5))
        end
    end

    -- Calculate surface normal rotation from heightMap gradient
    local function getSurfaceRotation(x, z)
        if not terrainSettings.SmoothRotation then return nil end

        local hL = (heightMap[x - 1] and heightMap[x - 1][z]) or heightMap[x][z]
        local hR = (heightMap[x + 1] and heightMap[x + 1][z]) or heightMap[x][z]
        local hD = heightMap[x][z - 1] or heightMap[x][z]
        local hU = heightMap[x][z + 1] or heightMap[x][z]

        local dx = (hR - hL) / (2 * bs)
        local dz = (hU - hD) / (2 * bs)

        -- If nearly flat, no rotation needed
        if math.abs(dx) < 0.01 and math.abs(dz) < 0.01 then return nil end

        local normal = Vector3.new(-dx, 1, -dz).Unit
        local upVec = math.abs(normal.Y) > 0.99 and Vector3.new(0, 0, 1) or Vector3.new(0, 1, 0)
        local rightVec = normal:Cross(upVec)
        if rightVec.Magnitude < 0.001 then return nil end
        rightVec = rightVec.Unit
        upVec = rightVec:Cross(normal).Unit
        return CFrame.fromMatrix(Vector3.new(), rightVec, normal, upVec)
    end

    -- Generate solid columns
    for x = 0, w - 1 do
        for z = 0, d - 1 do
            local level = levelMap[x][z]
            if level >= 0 and heightMap[x][z] >= bs * 0.05 then
                local surfaceRot = getSurfaceRotation(x, z)
                for y = 0, level do
                    -- Only top block gets surface rotation
                    addBlock(x, y, z, y == level and surfaceRot or nil)
                end
            end
        end
    end

    -- Fill gaps between neighbors so there are no holes
    if terrainSettings.EdgeSmoothing then
        for x = 0, w - 1 do
            for z = 0, d - 1 do
                local level = levelMap[x][z]
                if level < 0 then continue end

                -- Cardinal neighbors: fill all intermediate levels
                for _, off in ipairs({{1,0},{-1,0},{0,1},{0,-1}}) do
                    local nx, nz = x + off[1], z + off[2]
                    if levelMap[nx] and levelMap[nx][nz] ~= nil then
                        local nLevel = levelMap[nx][nz]
                        local low = math.min(level, nLevel)
                        local high = math.max(level, nLevel)
                        -- Fill the gap at both columns
                        for fillY = low + 1, high - 1 do
                            addBlock(x, fillY, z)
                            addBlock(nx, fillY, nz)
                        end
                    end
                end

                -- Diagonal neighbors: fill to prevent corner holes
                for _, off in ipairs({{1,1},{-1,1},{1,-1},{-1,-1}}) do
                    local nx, nz = x + off[1], z + off[2]
                    if levelMap[nx] and levelMap[nx][nz] ~= nil then
                        local nLevel = levelMap[nx][nz]
                        local diff = math.abs(level - nLevel)
                        if diff > 1 then
                            local low = math.min(level, nLevel)
                            local high = math.max(level, nLevel)
                            for fillY = low + 1, high - 1 do
                                addBlock(x, fillY, z)
                                addBlock(nx, fillY, nz)
                            end
                        end
                    end
                end
            end
        end
    end

    X.ChunkedPreviewLoad(descriptors, { batchSize = 100 })
end

local function listTerrainBlocks()
    local estimatedBlocks = 0
    local bs = terrainSettings.BlockSize
    local w = terrainSettings.Width
    local d = terrainSettings.Depth

    local seed = terrainSettings.Seed
    if seed == 0 then
        seed = 12345  -- Use fixed seed for estimation so it's consistent
    end

    -- Build height map at 2x resolution (mirrors generateTerrainPreview)
    local res = 2
    local fineW = w * res
    local fineD = d * res
    local fineMap = {}
    for fx = 0, fineW - 1 do
        fineMap[fx] = {}
        for fz = 0, fineD - 1 do
            fineMap[fx][fz] = getTerrainHeight(
                fx / res, fz / res,
                terrainSettings.Type, w, d,
                terrainSettings.Height,
                terrainSettings.Scale,
                terrainSettings.Roughness,
                seed
            )
        end
    end

    local smoothPasses = terrainSettings.EdgeSmoothing and 5 or 0
    fineMap = smoothHeightMap(fineMap, fineW, fineD, smoothPasses)

    local heightMap = {}
    for x = 0, w - 1 do
        heightMap[x] = {}
        for z = 0, d - 1 do
            local sum = 0
            local count = 0
            for sx = 0, res - 1 do
                for sz = 0, res - 1 do
                    local fx = x * res + sx
                    local fz = z * res + sz
                    if fineMap[fx] and fineMap[fx][fz] then
                        sum = sum + fineMap[fx][fz]
                        count = count + 1
                    end
                end
            end
            heightMap[x][z] = count > 0 and (sum / count) or 0
        end
    end

    if terrainSettings.EdgeSmoothing then
        heightMap = smoothHeightMap(heightMap, w, d, 2)
    end

    local levelMap = {}
    for x = 0, w - 1 do
        levelMap[x] = {}
        for z = 0, d - 1 do
            levelMap[x][z] = math.max(0, X.math_floor(heightMap[x][z] / bs + 0.5))
        end
    end

    local counted = {}
    local function countKey(x, y, z) return x .. "," .. y .. "," .. z end
    local function countBlock(x, y, z)
        local key = countKey(x, y, z)
        if counted[key] then return end
        counted[key] = true
        estimatedBlocks = estimatedBlocks + 1
    end

    -- Count main columns
    for x = 0, w - 1 do
        for z = 0, d - 1 do
            local level = levelMap[x][z]
            if level >= 0 and heightMap[x][z] >= bs * 0.05 then
                for y = 0, level do
                    countBlock(x, y, z)
                end
            end
        end
    end

    -- Count gap-fill blocks
    if terrainSettings.EdgeSmoothing then
        for x = 0, w - 1 do
            for z = 0, d - 1 do
                local level = levelMap[x][z]
                if level < 0 then continue end
                for _, off in ipairs({{1,0},{-1,0},{0,1},{0,-1},{1,1},{-1,1},{1,-1},{-1,-1}}) do
                    local nx, nz = x + off[1], z + off[2]
                    if levelMap[nx] and levelMap[nx][nz] ~= nil then
                        local nLevel = levelMap[nx][nz]
                        local low = math.min(level, nLevel)
                        local high = math.max(level, nLevel)
                        if high - low > 1 then
                            for fillY = low + 1, high - 1 do
                                countBlock(x, fillY, z)
                                countBlock(nx, fillY, nz)
                            end
                        end
                    end
                end
            end
        end
    end

    X.ListBlockRequirements({ [terrainSettings.BlockType] = estimatedBlocks })
end

local previewButton = terrainFolder.new("button", {
    text = "Preview Terrain",
})

previewButton.event:Connect(function()
    if #workspaceChildren(BuildPreview) > 0 then
        X.ClearPreview(true)
        X.listing:Clear()
    else
        generateTerrainPreview()
    end
end)

terrainFolder.new("button", {
    text = "List Blocks",
}).event:Connect(listTerrainBlocks)

terrainFolder.new("button", {
    text = "Build Terrain",
}).event:Connect(function()
    X.BuildFromPreview({ previewFn = generateTerrainPreview })
end)


-------------------------------------------------------------------------------------------------------- Music Hell
-------------------------------------------------------------------------------------------------------- Music Hell
-------------------------------------------------------------------------------------------------------- Music Hell



-------------------------------------------------------------------------------------------------------- Music Hell
-------------------------------------------------------------------------------------------------------- Music Hell
-------------------------------------------------------------------------------------------------------- Music Hell


local qrTab = loadersTab.new("folder", {
    text = "QR Code Loader",
})

qrTab.new("label", {
    text = "Currently Supporting Text and Links.",
})

local qrContent = nil
local qrBlockSize = 2

local qrMainSettings = qrTab.new("folder", {
    text = "Main Settings",
})
qrMainSettings.new("input", {
    text = "QR Content",
    placeholder = "Enter text or URL",
}).event:Connect(function(text)
    qrContent = text
end)

qrMainSettings.new("input", {
    text = "Block Size",
    placeholder = "2",
}).event:Connect(function(size)
    qrBlockSize = math.max(0.5, tonumber(size) or 2)
    X.ClearPreview()
end)
qrMainSettings.open()

local qrBuilder = qrTab.new("folder", {
    text = "Builder",
})

local function generateQRPreview()
    if not qrContent then
        print("No QR content provided")
        return false
    end

    local success, response = pcall(function()
        return request({
            Url = "https://babftserver-production.up.railway.app/qr-code",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["X-API-Key"] = apikey,
            },
            Body = X.HttpService:JSONEncode({
                text = qrContent,
                block_size = qrBlockSize,
                scale = 1,
                error_correction = "M"
            })
        })
    end)

    if not success or not response then
        print("Request failed")
        return false
    end

    local qrData
    success, qrData = pcall(function()
        return X.HttpService:JSONDecode(response.Body)
    end)

    if not success then
        print("JSON decode failed")
        return false
    end

    if qrData.error then
        print("Server error:", qrData.error)
        return false
    end

    if not qrData.matrix then
        print("No matrix data in response")
        return false
    end

    local matrix = qrData.matrix
    local size = qrData.size or #matrix
    local plot = X.GetPlot()

    if not plot then
        print("No plot found")
        return false
    end

    local center = plot.Position + Vector3.new(0, 15, 0)
    local totalSize = size * qrBlockSize
    local backgroundSize = totalSize + 8

    local descriptors = {}

    -- Background block (MetalBlock, white)
    X.table_insert(descriptors, {
        blockType = "MetalBlock",
        position = center,
        size = Vector3.new(backgroundSize, qrBlockSize, backgroundSize),
        color = Color3.new(1, 1, 1),
        canCollide = false,
    })

    -- QR code blocks (PlasticBlock, black)
    for y = 1, size do
        for x = 1, size do
            if matrix[y] and matrix[y][x] == 1 then
                local position = center + Vector3.new(
                    (x - size/2 - 0.5) * qrBlockSize,
                    qrBlockSize,
                    (y - size/2 - 0.5) * qrBlockSize
                )
                X.table_insert(descriptors, {
                    blockType = "PlasticBlock",
                    position = position,
                    size = Vector3.new(qrBlockSize, qrBlockSize, qrBlockSize),
                    color = Color3.new(0, 0, 0),
                    canCollide = false,
                })
            end
        end
    end

    X.ChunkedPreviewLoad(descriptors, { batchSize = 50 })
    return true
end

qrBuilder.new("button", {
    text = "Preview",
}).event:Connect(function()
    if #workspaceChildren(BuildPreview) > 0 then
        X.ClearPreview(true)
        X.listing:Clear()
    else
        generateQRPreview()
    end
end)

local function listQRBlocks()
    if not qrContent then
        return
    end
    
    local success, response = pcall(function()
        return request({
            Url = "https://babftserver-production.up.railway.app/qr-code",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["X-API-Key"] = apikey,
            },
            Body = X.HttpService:JSONEncode({
                text = qrContent,
                block_size = qrBlockSize,
                scale = 1,
                error_correction = "M"
            })
        })
    end)
    
    local qrBlocks = 0
    local size = 21
    
    if success and response then
        local qrData = X.HttpService:JSONDecode(response.Body)
        if qrData and qrData.block_count then
            qrBlocks = qrData.block_count
        end
        if qrData and qrData.size then
            size = qrData.size
        end
    else
        -- Estimate: QR codes are typically ~30% filled
        qrBlocks = math.ceil(size * size * 0.3)
    end
    
    X.ListBlockRequirements({
        ["MetalBlock"] = 1,
        ["PlasticBlock"] = qrBlocks,
    })

    X.UpdateProgression("Done")
end

qrBuilder.new("button", {
    text = "List Blocks",
}).event:Connect(listQRBlocks)

local function buildQRCode()
    X.BuildFromPreview({
        previewFn = generateQRPreview,
        clearAfter = true,
        postBuildFn = function()
            -- Wait a moment for blocks to be placed, then paint QR colors
            task.wait(2)
            local paintingTool = X.GetTool("PaintingTool")
            if paintingTool then
                local playerName = X.Players.LocalPlayer.Name
                local playerBlocks = workspace.Blocks:FindFirstChild(playerName)
                if playerBlocks then
                    local paintArgs = {}
                    for _, blockFolder in ipairs(playerBlocks:GetChildren()) do
                        if blockFolder:IsA("Model") and blockFolder:FindFirstChild("PPart") then
                            local blockName = blockFolder.Name
                            local targetColor = nil
                            if blockName == "MetalBlock" then
                                targetColor = Color3.new(1, 1, 1)
                            elseif blockName == "PlasticBlock" then
                                targetColor = Color3.new(0, 0, 0)
                            end
                            if targetColor and X.ShouldPaintBlock(blockName, targetColor) then
                                X.table_insert(paintArgs, { blockFolder, targetColor })
                            end
                        end
                    end
                    if #paintArgs > 0 then
                        remoteInvoke(paintingTool, paintArgs)
                    end
                end
            end
        end,
    })
end

qrBuilder.new("button", {
    text = "Load QR",
}).event:Connect(buildQRCode)
qrBuilder.open()

local objSettings = {
    SelectedFile = nil,
    BlockType = "WoodBlock",
    Scale = 1.0,
    Quality = "ULTRA",
    FillInterior = false,
    CloseGaps = 1,  -- morphological closing iterations (0-3)
    SmoothRotation = false,  -- align surface blocks to mesh surface normals
}

local OBJ_SERVER_URL = "https://babftserver3d-production.up.railway.app"

local QUALITY_PRESETS = {
    LOW = { VoxelSize = 4.0, Description = "Blocky, fast" },
    MEDIUM = { VoxelSize = 2.0, Description = "Standard block size" },
    HIGH = { VoxelSize = 1.0, Description = "Detailed" },
    ULTRA = { VoxelSize = 0.5, Description = "Fine detail" },
    EXTREME = { VoxelSize = 0.15, Description = "Maximum precision (heavy)" },
}


function X.SendOBJToServer(filePath, quality, fillInterior, closeGaps, smoothRotation, endpoint)
    if not isfile(filePath) then
        X.SetStatus("File not found")
        return nil
    end

    local preset = QUALITY_PRESETS[quality] or QUALITY_PRESETS.ULTRA
    local objContent = readfile(filePath)

    if not objContent or objContent == "" then
        X.SetStatus("File is empty")
        return nil
    end

    endpoint = endpoint or "/voxelize"
    X.SetStatus("Sending to server...")

    local requestBody = {
        obj_content = objContent,
        voxel_size = preset.VoxelSize,
        scale = objSettings.Scale or 1.0,
        fill_interior = fillInterior or false,
        close_gaps = closeGaps or 1,
        smooth_rotation = smoothRotation or false,
    }

    local success, response = pcall(function()
        return request({
            Url = OBJ_SERVER_URL .. endpoint,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["X-API-Key"] = apikey,
            },
            Body = X.HttpService:JSONEncode(requestBody),
            Timeout = 180
        })
    end)

    if not success or not response then
        X.SetStatus("Server connection failed")
        return nil
    end

    -- Handle specific HTTP status codes
    if response.StatusCode == 503 then
        local bodyData = nil
        pcall(function() bodyData = X.HttpService:JSONDecode(response.Body) end)
        local msg = (bodyData and bodyData.error) or "Server is busy, try again in a moment"
        X.SetStatus(msg)
        return nil
    end

    if response.StatusCode ~= 200 then
        local bodyData = nil
        pcall(function() bodyData = X.HttpService:JSONDecode(response.Body) end)
        local msg = (bodyData and bodyData.error) or ("Server error: " .. tostring(response.StatusCode))
        X.SetStatus(msg)
        return nil
    end

    local voxelData
    success, voxelData = pcall(function()
        return X.HttpService:JSONDecode(response.Body)
    end)

    if not success or not voxelData then
        X.SetStatus("Failed to parse server response")
        return nil
    end

    if voxelData.error then
        X.SetStatus("Error: " .. tostring(voxelData.error))
        return nil
    end

    print(string.format("Server: %d blocks (merged from %d voxels, %s reduction)",
        voxelData.voxel_count or 0,
        voxelData.raw_voxels or 0,
        voxelData.merge_ratio or "?"))

    return voxelData
end

-- ==================== OBJ Surface Rotation System ====================
-- Server computes per-voxel normals from actual triangle geometry:
--   - Area-weighted triangle normals accumulated per voxel
--   - Smoothed across surface neighbors for gradual transitions
--   - Axis-snapped on flat surfaces (no jitter on car roofs, walls, etc.)
--   - Normal-aware greedy meshing (only merges blocks with similar normals)
-- Client receives normals in the server response and converts to CFrame rotation.

-- The 6 axis directions. If a normal matches one of these exactly,
-- the block is on a flat axis-aligned surface and needs NO rotation.
local AXIS_NORMALS = {
    {1, 0, 0}, {-1, 0, 0},
    {0, 1, 0}, {0, -1, 0},
    {0, 0, 1}, {0, 0, -1},
}

function X.NormalToRotation(nx, ny, nz)
    -- Convert a surface normal vector to a CFrame rotation that aligns
    -- the block's outward face with the mesh surface.
    --
    -- Returns (rotation CFrame, angle from nearest axis) or (nil, 0)
    -- The angle is used for dynamic overlap scaling.

    local mag = math.sqrt(nx * nx + ny * ny + nz * nz)
    if mag < 0.001 then return nil, 0 end

    nx, ny, nz = nx / mag, ny / mag, nz / mag

    -- Check if this normal is axis-aligned (server snaps these).
    -- If so, no rotation needed - the block already tiles perfectly.
    local maxDot = 0
    for _, axis in ipairs(AXIS_NORMALS) do
        local dot = nx * axis[1] + ny * axis[2] + nz * axis[3]
        if dot > maxDot then maxDot = dot end
    end
    -- If within ~10° of an axis, skip rotation entirely (dot > 0.985 ≈ 10°)
    if maxDot > 0.985 then
        return nil, 0
    end

    local normal = Vector3_new(nx, ny, nz)

    -- Build an orthonormal basis where the normal is the UP direction (+Y).
    -- This makes the block's top face point outward along the mesh surface.
    -- For a sphere: each block's top face is tangent to the sphere surface.

    -- Pick a reference vector that isn't parallel to the normal
    local refVec
    if math.abs(ny) > 0.9 then
        refVec = Vector3_new(1, 0, 0)
    else
        refVec = Vector3_new(0, 1, 0)
    end

    -- Right = ref × normal (tangent to surface)
    local rightVec = refVec:Cross(normal)
    if rightVec.Magnitude < 0.001 then
        -- Fallback reference
        refVec = Vector3_new(0, 0, 1)
        rightVec = refVec:Cross(normal)
    end
    if rightVec.Magnitude < 0.001 then return nil, 0 end
    rightVec = rightVec.Unit

    -- Forward = normal × right (also tangent to surface)
    local forwardVec = normal:Cross(rightVec).Unit

    -- CFrame.fromMatrix(pos, rightVector, upVector, backVector)
    -- We want: up = normal (outward), right = tangent, back = -forward
    local angle = math.acos(math.min(1, maxDot))
    return CFrame.fromMatrix(Vector3_new(), rightVec, normal, -forwardVec), angle
end

function X.PreviewOBJModel()
    X.ClearPreview()

    if not objSettings.SelectedFile then
        X.SetStatus("No file selected")
        return
    end

    local smoothRotation = objSettings.SmoothRotation or false

    local voxelData = X.SendOBJToServer(
        objSettings.SelectedFile,
        objSettings.Quality,
        objSettings.FillInterior,
        objSettings.CloseGaps,
        smoothRotation
    )

    if not voxelData or not voxelData.voxels then
        X.SetStatus("Failed to get voxel data")
        return
    end

    local voxels = voxelData.voxels
    local blockTypeName = objSettings.BlockType or "MetalBlock"
    local blockTemplate = BuildingParts:FindFirstChild(blockTypeName)
    if not blockTemplate then
        blockTypeName = "MetalBlock"
        blockTemplate = BuildingParts[blockTypeName]
    end

    print(string.format("Previewing %d blocks (%s quality, gap closing: %d, rotation: %s)",
        #voxels, objSettings.Quality, objSettings.CloseGaps, tostring(smoothRotation)))

    local plot = X.GetPlot()
    if not plot then
        X.SetStatus("No plot found")
        return
    end

    local basePos = plot.Position + Vector3.new(0, 15, 0)
    local totalVoxels = #voxels

    X.SetStatus(string.format("Creating preview: 0/%d", totalVoxels))
    X.UpdateProgression(0)

    -- Use ChunkedPreviewLoad for efficient batch rendering
    local descriptors = {}
    local baseOverlap = 1.01  -- 1% overlap for non-rotated blocks (standard gap prevention)

    local skipped = 0
    for idx, voxel in ipairs(voxels) do
        if type(voxel) == "table" and voxel.position and type(voxel.position) == "table" then
            local pos = voxel.position
            local size = voxel.size or {1, 1, 1}

            local worldPos = basePos + Vector3_new(
                tonumber(pos[1]) or 0,
                tonumber(pos[2]) or 0,
                tonumber(pos[3]) or 0
            )

            -- Read surface normal from server response and convert to rotation
            local rotation = nil
            local overlap = baseOverlap
            if smoothRotation and voxel.normal and type(voxel.normal) == "table" then
                local n = voxel.normal
                local ok, rot, angle = pcall(X.NormalToRotation, tonumber(n[1]) or 0, tonumber(n[2]) or 0, tonumber(n[3]) or 0)
                if ok and rot then
                    rotation = rot
                    overlap = 1.02 + math.min(angle or 0, 0.8) * 0.075
                end
            end

            local blockSize = Vector3_new(
                (tonumber(size[1]) or 1) * overlap,
                (tonumber(size[2]) or 1) * overlap,
                (tonumber(size[3]) or 1) * overlap
            )

            X.table_insert(descriptors, {
                blockType = blockTypeName,
                position = worldPos,
                size = blockSize,
                rotation = rotation,
                canCollide = false,
                castShadow = true,
            })
        else
            skipped = skipped + 1
        end
    end
    if skipped > 0 then
        warn(string.format("Skipped %d invalid voxel entries", skipped))
    end

    local placed = X.ChunkedPreviewLoad(descriptors, {
        batchSize = 500,
        onProgress = function(current, total)
            local percent = X.math_floor((current / total) * 100)
            X.UpdateProgression(percent)
            X.SetStatus(string.format("Preview: %d/%d (%d%%)", current, total, percent))
        end
    })

    X.UpdateProgression(100)
    X.SetStatus(string.format("Preview done: %d blocks (merged)", placed))
end

function X.CountOBJBlocks()
    if not objSettings.SelectedFile then
        X.listing:Clear()
        X.SetStatus("No file selected")
        return
    end

    X.SetStatus("Counting blocks...")

    -- Use lightweight /count endpoint (no full voxel list returned = faster + less server memory)
    local voxelData = X.SendOBJToServer(
        objSettings.SelectedFile,
        objSettings.Quality,
        objSettings.FillInterior,
        objSettings.CloseGaps,
        objSettings.SmoothRotation or false,
        "/count"
    )

    if not voxelData or not voxelData.voxel_count then
        X.SetStatus("Could not get block count")
        X.listing:Clear()
        return
    end

    local estimatedBlocks = voxelData.voxel_count

    X.listing:Clear()
    X.listing:Add(objSettings.BlockType, estimatedBlocks)

    X.SetStatus(string.format("Need %d %s (merged %s)", estimatedBlocks, objSettings.BlockType, voxelData.merge_ratio or "?"))
end

function X.BuildOBJModel()
    -- Generate preview first if not already there
    if #workspaceChildren(BuildPreview) == 0 then
        X.PreviewOBJModel()
        if #workspaceChildren(BuildPreview) == 0 then
            X.SetStatus("No preview to build")
            return
        end
    end

    X.SetStatus("Preparing build data...")

    local previewBlocks = X.GetPreviewBlocks()
    if #previewBlocks == 0 then
        X.SetStatus("No blocks in preview")
        return
    end

    local blocks = {}
    for _, block in ipairs(previewBlocks) do
        if block:FindFirstChild("PPart") then
            X.table_insert(blocks, {
                Name = block.Name,
                PPart = {
                    CFrame = block.PPart.CFrame,
                    CastShadow = true,
                    CanCollide = true,
                    Anchored = true,
                    Transparency = 0,
                    Color = block.PPart.Color,
                    Size = block.PPart.Size,
                },
            })
        end
    end

    if #blocks == 0 then
        X.SetStatus("No valid blocks")
        return
    end

    X.SetStatus(string.format("Building %d blocks...", #blocks))
    X.UpdateProgression(0)

    local jsonTable = X.Encode(blocks)
    if jsonTable then
        local decoded = X.Decode(jsonTable, 1)
        if decoded and next(decoded) then
            X.LoadBlocks(decoded)
        end
    end

    X.ClearPreview()
end

function X.ClearOBJPreview()
    X.ClearPreview(true)
    X.listing:Clear()
    X.SetStatus("Preview cleared")
end

-- ==================== 3D Models Tab UI ====================

local objTab = window.new({ text = "3D Models" })

objTab.new("label", {
    text = " \n3D Loader using a Outdated Sever,\nalso extrem Quality is unavailable for first Alpha.",
})

objTab.new("label", {
    text = " ",
})

local objFileDropdown = objTab.new("dropdown", {
    text = "Select .OBJ File",
})

local objDropdownItems = {}
local objNameToPath = {}

local function refreshOBJFiles()
    local files = {}

    if isfolder("VoltaraBuildStorage") then
        for _, filePath in ipairs(listfiles("VoltaraBuildStorage")) do
            local fileName = filePath:match(".+[\\/](.+)") or filePath
            if string.lower(fileName:sub(-4)) == ".obj" then
                table.insert(files, { name = fileName:sub(1, -5), path = filePath })
            end
        end
    end

    for _, filePath in ipairs(listfiles("")) do
        local fileName = filePath:match(".+[\\/](.+)") or filePath
        if string.lower(fileName:sub(-4)) == ".obj" then
            local exists = false
            for _, f in ipairs(files) do
                if f.name == fileName:sub(1, -5) then exists = true; break end
            end
            if not exists then
                table.insert(files, { name = fileName:sub(1, -5), path = filePath })
            end
        end
    end

    for _, item in pairs(objDropdownItems) do
        if item and item.Remove then item:Remove() end
    end
    objDropdownItems = {}
    objNameToPath = {}

    for _, file in ipairs(files) do
        local item = objFileDropdown.new(file.name)
        if item then
            objDropdownItems[file.name] = item
            objNameToPath[file.name] = file.path
        end
    end

    if #files > 0 and not objSettings.SelectedFile then
        objSettings.SelectedFile = files[1].path
    end

    return #files
end

objFileDropdown.event:Connect(function(selectedName)
    objSettings.SelectedFile = objNameToPath[selectedName]
end)

objTab.new("button", {
    text = "Refresh File List",
}).event:Connect(refreshOBJFiles)

local objSettingsFolder = objTab.new("folder", {
    text = "Settings",
})

local objQualityDropdown = objSettingsFolder.new("dropdown", {
    text = "Quality Level",
})

objQualityDropdown.new("LOW")
objQualityDropdown.new("MEDIUM")
objQualityDropdown.new("HIGH")
objQualityDropdown.new("ULTRA")
--objQualityDropdown.new("EXTREME")

objQualityDropdown.event:Connect(function(option)
    if option:find("EXTREME") then objSettings.Quality = "EXTREME"
    elseif option:find("ULTRA") then objSettings.Quality = "ULTRA"
    elseif option:find("HIGH") then objSettings.Quality = "HIGH"
    elseif option:find("MEDIUM") then objSettings.Quality = "MEDIUM"
    else objSettings.Quality = "LOW" end
end)

local objBlockDropdown = objSettingsFolder.new("dropdown", {
    text = "Block Type",
})

for _, part in next, workspaceChildren(BuildingParts), nil do
    local name = part.Name
    if string.sub(name, #name - 4, #name) == "Block" then
        objBlockDropdown.new(name)
    end
end

objBlockDropdown.event:Connect(function(option)
    objSettings.BlockType = option
end)

objSettingsFolder.new("input", {
    text = "Model Scale",
    placeholder = "1.0",
}).event:Connect(function(value)
    objSettings.Scale = tonumber(value) or 1.0
end)

objSettingsFolder.new("switch", {
    text = "Fill Interior (solid model)",
    value = false,
}).event:Connect(function(state)
    objSettings.FillInterior = state
end)

objSettingsFolder.new("switch", {
    text = "Smooth Rotation (surface align)",
    value = false,
}).event:Connect(function(state)
    objSettings.SmoothRotation = state
end)

local objGapDropdown = objSettingsFolder.new("dropdown", {
    text = "Gap Closing (thin parts)",
})
objGapDropdown.new("None (0)")
objGapDropdown.new("Light (1) - recommended")
objGapDropdown.new("Medium (2)")
objGapDropdown.new("Heavy (3)")

objGapDropdown.event:Connect(function(option)
    if option:find("0") then objSettings.CloseGaps = 0
    elseif option:find("1") then objSettings.CloseGaps = 1
    elseif option:find("2") then objSettings.CloseGaps = 2
    elseif option:find("3") then objSettings.CloseGaps = 3
    end
end)

objSettingsFolder.open()

local objControlFolder = objTab.new("folder", {
    text = "Controls",
})
objControlFolder.open()

objControlFolder.new("button", {
    text = "Preview Model",
}).event:Connect(X.PreviewOBJModel)

objControlFolder.new("button", {
    text = "Count Required Blocks",
}).event:Connect(X.CountOBJBlocks)

objControlFolder.new("button", {
    text = "Build Model",
}).event:Connect(X.BuildOBJModel)

objControlFolder.new("button", {
    text = "Clear Preview",
}).event:Connect(X.ClearOBJPreview)


local adjustersTab = window.new({ text = "Adjusters" })

local positionFolder = adjustersTab.new("folder", {
    text = "Position Offset",
})
positionFolder.new("input", {
    text = "Move Multiplier",
    placeholder = "1",
}).event:Connect(function(value)
    moveMultiplier = tonumber(value) or 1
end)

positionFolder.new("button", {
    text = "Move Up",
}).event:Connect(function()
    X.UpdatePreview(Vector3_new(0, moveMultiplier, 0))
end)

positionFolder.new("button", {
    text = "Move Down",
}).event:Connect(function()
    X.UpdatePreview(Vector3_new(0, -moveMultiplier, 0))
end)

positionFolder.new("button", {
    text = "Move Left",
}).event:Connect(function()
    X.UpdatePreview(Vector3_new(moveMultiplier, 0, 0))
end)

positionFolder.new("button", {
    text = "Move Right",
}).event:Connect(function()
    X.UpdatePreview(Vector3_new(-moveMultiplier, 0, 0))
end)

positionFolder.new("button", {
    text = "Move Forwards",
}).event:Connect(function()
    X.UpdatePreview(Vector3_new(0, 0, moveMultiplier))
end)

positionFolder.new("button", {
    text = "Move Backwards",
}).event:Connect(function()
    X.UpdatePreview(Vector3_new(0, 0, -moveMultiplier))
end)
positionFolder.open()

local rotationFolder = adjustersTab.new("folder", {
    text = "Rotation Offset",
})
local rotXSlider = rotationFolder.new("slider", {
    text = "X",
    min = 0,
    max = 360,
    value = rotX,
})
rotXSlider.event:Connect(function(value)
    rotX = value
    X.UpdatePreview()
end)

local rotYSlider = rotationFolder.new("slider", {
    text = "Y",
    min = 0,
    max = 360,
    value = rotY,
})
rotYSlider.event:Connect(function(value)
    rotY = value
    X.UpdatePreview()
end)

local rotZSlider = rotationFolder.new("slider", {
    text = "Z",
    min = 0,
    max = 360,
    value = rotZ,
})
rotZSlider.event:Connect(function(value)
    rotZ = value
    X.UpdatePreview()
end)
rotationFolder.open()

local otherFolder = adjustersTab.new("folder", {
    text = "Other",
})
otherFolder.new("input", {
    text = "Size %",
    placeholder = "100",
}).event:Connect(function(value)
    X.ClearPreview()
    X.PreviewFile(selectedFile, tonumber(value) / 100)
end)

otherFolder.new("button", {
    text = "Mirror Build",
}).event:Connect(X.MirrorBuild)

otherFolder.new("button", {
    text = "Ground Build",
}).event:Connect(function()
    local previewBlocks = BuildPreview:GetChildren()
    if #previewBlocks == 0 then
        return
    end
    
    local lowestY = math.huge
    for _, block in ipairs(previewBlocks) do
        if block:FindFirstChild("PPart") then
            local part = block.PPart
            local partBottom = part.Position.Y - (part.Size.Y / 2)
            if partBottom < lowestY then
                lowestY = partBottom
            end
        end
    end
    
    local plot = X.GetPlot()
    if not plot then return end
    
    local groundLevel = plot.Position.Y + 5.1
    local moveAmount = groundLevel - lowestY
    
    for _, block in ipairs(previewBlocks) do
        if block:FindFirstChild("PPart") then
            block.PPart.CFrame = block.PPart.CFrame + Vector3.new(0, moveAmount, 0)
        end
    end
end)

otherFolder.new("button", {
    text = "Center Build",
}).event:Connect(function()
    local previewBlocks = BuildPreview:GetChildren()
    if #previewBlocks == 0 then
        return
    end    

    local plot = X.GetPlot()
    if not plot then
        return
    end
    
    local minX, minY, minZ = math.huge, math.huge, math.huge
    local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge
    
    for _, block in ipairs(previewBlocks) do
        local part = nil
        if block:FindFirstChild("PPart") then
            part = block.PPart
        elseif block:IsA("BasePart") then
            part = block
        end
        
        if part then
            local size = part.Size
            local position = part.Position
            
            local halfSize = size / 2
            minX = math.min(minX, position.X - halfSize.X)
            minY = math.min(minY, position.Y - halfSize.Y)
            minZ = math.min(minZ, position.Z - halfSize.Z)
            maxX = math.max(maxX, position.X + halfSize.X)
            maxY = math.max(maxY, position.Y + halfSize.Y)
            maxZ = math.max(maxZ, position.Z + halfSize.Z)
        end
    end
    
    local centerPosition = Vector3.new(
        (minX + maxX) / 2,
        (minY + maxY) / 2,
        (minZ + maxZ) / 2
    )
    
    local totalSize = Vector3.new(maxX - minX, maxY - minY, maxZ - minZ)
    
    local plotCenter = plot.Position
    local targetPosition = Vector3.new(
        plotCenter.X,
        plotCenter.Y + totalSize.Y / 2 + 5,
        plotCenter.Z
    )
    
    local offset = targetPosition - centerPosition
    
    for _, block in ipairs(previewBlocks) do
        if block:IsA("Model") then
            if block.PrimaryPart then
                local currentCF = block:GetPrimaryPartCFrame()
                block:SetPrimaryPartCFrame(currentCF + offset)
            else
                local mainPart = block:FindFirstChild("PPart") or block:FindFirstChildWhichIsA("BasePart")
                if mainPart then
                    mainPart.CFrame = mainPart.CFrame + offset
                end
            end
        elseif block:IsA("BasePart") then
            block.CFrame = block.CFrame + offset
        end
    end
    
    rotX = 0
    rotY = 0
    rotZ = 0
    
    if rotXSlider then rotXSlider.set(0) end
    if rotYSlider then rotYSlider.set(0) end
    if rotZSlider then rotZSlider.set(0) end
end)
otherFolder.open()

mainTab:show()

local function anchorTarget(instance)
    local target = instance

    if instance:IsA("Model") then
        target = instance:FindFirstChild("PPart")
    end

    if target and target:IsA("BasePart") and not target.Anchored then
        target.Anchored = true
    end
end

local function updateHighlight()
    local hasPreviewObjects = false

    for _, child in ipairs(BuildPreview:GetChildren()) do
        if child:IsA("Model") or child:IsA("BasePart") then
            hasPreviewObjects = true
            break
        end
    end

    if hasPreviewObjects then
        if MainHighlight.Adornee ~= BuildPreview then
            MainHighlight.Adornee = BuildPreview
        end
        MainHighlight.Enabled = true
    else
        MainHighlight.Enabled = false
        MainHighlight.Adornee = nil
    end
end

-- Initial setup
for _, child in ipairs(BuildPreview:GetChildren()) do
    anchorTarget(child)
end
updateHighlight()

-- Event-driven updates
BuildPreview.ChildAdded:Connect(function(child)
    if child:IsA("Model") or child:IsA("BasePart") then
        anchorTarget(child)
        updateHighlight()
    end
end)

BuildPreview.ChildRemoved:Connect(function()
    updateHighlight()
end)

-- Event-driven health replacement (replaces expensive polling loop)
local function replaceHealth(model)
    if not model:IsA("Model") then return end
    local healthVal = model:FindFirstChild("Health")
    if healthVal and healthVal:IsA("IntValue") then
        local stringValue = Instance.new("StringValue")
        stringValue.Name = "Health"
        stringValue.Value = model.Name
        stringValue.Parent = model
        healthVal:Destroy()
    end
end

-- Process existing blocks once
for _, folder in ipairs(workspace.Blocks:GetChildren()) do
    if folder:IsA("Folder") then
        for _, model in ipairs(folder:GetChildren()) do
            replaceHealth(model)
        end
        folder.ChildAdded:Connect(replaceHealth)
        folder.DescendantAdded:Connect(function(desc)
            if desc:IsA("IntValue") and desc.Name == "Health" then
                task.defer(function()
                    if desc.Parent and desc.Parent:IsA("Model") then
                        replaceHealth(desc.Parent)
                    end
                end)
            end
        end)
    end
end

workspace.Blocks.ChildAdded:Connect(function(folder)
    if folder:IsA("Folder") then
        for _, model in ipairs(folder:GetChildren()) do
            replaceHealth(model)
        end
        folder.ChildAdded:Connect(replaceHealth)
        folder.DescendantAdded:Connect(function(desc)
            if desc:IsA("IntValue") and desc.Name == "Health" then
                task.defer(function()
                    if desc.Parent and desc.Parent:IsA("Model") then
                        replaceHealth(desc.Parent)
                    end
                end)
            end
        end)
    end
end)
