local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vyrusspcs/weshkyv2/refs/heads/main/server/libtest.lua"))()

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local UiColor = "53, 63, 119"
local r, g, b = string.match(UiColor, "(%d+),%s*(%d+),%s*(%d+)")
local mainColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))

local window = library.new({
    text = "Second Module",
    size = Vector2.new(368, 540),
    shadow = 0,
    transparency = 0.25,
    color = mainColor,
    boardcolor = Color3.fromRGB(21, 22, 23),
    rounding = 5,
    animation = 0.1,
    position = UDim2.new(0, 678, 0, 40),
})

window.open()

local mainTab = window.new({ text = "Auto Farm" })
local databaseTab = window.new({ text = "Database" })
local specialTab = window.new({ text = "Special" })
local clientTab = window.new({ text = "Client" })
local creditsTab = window.new({ text = "Credits" })
mainTab:show()

--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------

local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")
local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger

local initialGold = 0
local initialGoldBlocks = 0
local goldBlocksUpdateThread = nil
local goldUpdateThread = nil
local farmStartTime = 0
local pausedTime = 0
local farmTimer = nil
local isTimerRunning = false

local weshkyPartsByName = {}

local positions = {
    Vector3.new(-72.31890106201172, 91.17544555664062, 1191.0478515625),   -- Weshky1
    Vector3.new(-52.304874420166016, 58.03061294555664, 1769.4705810546875), -- Weshky2
    Vector3.new(-27.725244522094727, 67.33195495605469, 2471.45361328125), -- Weshky3
    Vector3.new(-44.12211608886719, 69.04801177978516, 3165.256591796875), -- Weshky4
    Vector3.new(-53.77952194213867, 74.39949798583984, 3990.331298828125), -- Weshky5
    Vector3.new(-39.26005935668945, 83.18901824951172, 4824.65087890625), -- Weshky6
    Vector3.new(-52.22807312011719, 67.77399444580078, 5682.07421875), -- Weshky7
    Vector3.new(-82.22046661376953, 50.52703094482422, 6260.56982421875), -- Weshky8
    Vector3.new(-38.067955017089844, 105.63947296142578, 7167.95263671875), -- Weshky9
    Vector3.new(-49.93274688720703, 57.78563690185547, 7731.59375), -- Weshky0
}

local partNames = {
    "Weshky1", "Weshky2", "Weshky3", "Weshky4", "Weshky5",
    "Weshky6", "Weshky7", "Weshky8", "Weshky9", "Weshky0"
}

for i, pos in ipairs(positions) do
    local name = partNames[i]
    local part = Instance.new("Part")
    part.Name = name
    part.Anchored = true
    part.Transparency = 1
    part.Size = Vector3.new(6, 1, 6)
    part.BottomSurface = Enum.SurfaceType.Smooth
    part.TopSurface = Enum.SurfaceType.Smooth
    part.Position = pos
    part.Parent = workspace

    weshkyPartsByName[name] = part
end

local textureId = "rbxassetid://137722555800117"
local decalName = "Weshky doing its own thing?!"

for _, name in ipairs(partNames) do
    local part = weshkyPartsByName[name]
    if part then
        local decal = Instance.new("Decal")
        decal.Texture = textureId
        decal.Name = decalName
        decal.Face = Enum.NormalId.Top
        decal.Parent = part
    end
end

isFarming = false

local isFarmingThreadRunning = false
local shouldStopFarming = false
local farmLoopCount = 0
local TriggerChestOriginalCFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)

-- Auto-dismiss the RiverResults gold claim GUI whenever it appears
local function autoDismissResults()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return end
    local resultsGui = playerGui:FindFirstChild("RiverResults")
    if resultsGui then
        local frame = resultsGui:FindFirstChild("Frame")
        if frame and frame.Visible then
            workspace.ClaimRiverResultsGold:FireServer()
            frame.Visible = false
            pcall(function()
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
            end)
        end
    end
end

-- Wait for character to be alive and ready, handles respawns
local function waitForCharacter()
    local plr = game.Players.LocalPlayer
    local char = plr.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        char = plr.CharacterAdded:Wait()
        char:WaitForChild("HumanoidRootPart")
        task.wait(0.5)
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health <= 0 then
        char = plr.CharacterAdded:Wait()
        char:WaitForChild("HumanoidRootPart")
        task.wait(0.5)
    end
    return char
end

-- Teleport with validation - retries if character dies or isn't at target
local function safeTeleport(targetCFrame, maxRetries)
    maxRetries = maxRetries or 3
    for attempt = 1, maxRetries do
        if shouldStopFarming then return false end
        local char = waitForCharacter()
        if not char then return false end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end

        hrp.CFrame = targetCFrame
        task.wait(0.15)

        -- Verify we actually arrived
        hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and (hrp.Position - targetCFrame.Position).Magnitude < 20 then
            return true
        end
    end
    return false
end

-- Wait at a position, checking for stop signal and keeping character alive
local function holdPosition(duration)
    local elapsed = 0
    while elapsed < duration and not shouldStopFarming do
        -- Auto-dismiss results during waits
        autoDismissResults()
        task.wait(0.1)
        elapsed = elapsed + 0.1

        -- Re-anchor if character respawned
        local char = game.Players.LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health <= 0 then
                waitForCharacter()
                return false -- Need to restart this stage
            end
        end
    end
    return not shouldStopFarming
end

function StartFarmNormal()
    if isFarmingThreadRunning then return end
    isFarming = true
    isFarmingThreadRunning = true
    shouldStopFarming = false
    farmLoopCount = 0

    -- Stage waypoints in river order
    local stages = {
        { name = "Start",  part = weshkyPartsByName.Weshky1, wait = 2.4 },
        { name = "Stage1", part = weshkyPartsByName.Weshky2, wait = 2.3 },
        { name = "Stage2", part = weshkyPartsByName.Weshky3, wait = 2.3 },
        { name = "Stage3", part = weshkyPartsByName.Weshky4, wait = 2.3 },
        { name = "Stage4", part = weshkyPartsByName.Weshky5, wait = 2.3 },
        { name = "Stage5", part = weshkyPartsByName.Weshky6, wait = 2.3 },
        { name = "Stage6", part = weshkyPartsByName.Weshky7, wait = 2.3 },
        { name = "Stage7", part = weshkyPartsByName.Weshky8, wait = 2.3 },
        { name = "Stage8", part = weshkyPartsByName.Weshky9, wait = 2.3 },
        { name = "End",    part = weshkyPartsByName.Weshky0, wait = 1.5, isEnd = true },
    }

    while isFarming and not shouldStopFarming do

        -- Dismiss any leftover results GUI from previous loop
        autoDismissResults()

        -- Small delay between loops
        if farmLoopCount > 0 then
            holdPosition(5)
        end
        if shouldStopFarming then break end

        -- Make sure character is alive before starting a loop
        local char = waitForCharacter()
        if not char or shouldStopFarming then break end

        farmLoopCount = farmLoopCount + 1
        local loopFailed = false

        for _, stage in ipairs(stages) do
            if shouldStopFarming then break end
            if not stage.part then continue end

            local targetCFrame = stage.part.CFrame + Vector3.new(0, 2, 0)

            -- Teleport to stage
            local arrived = safeTeleport(targetCFrame, 5)
            if shouldStopFarming then break end
            if not arrived then
                loopFailed = true
                break
            end

            -- Hold position for stage completion
            local held = holdPosition(stage.wait)
            if shouldStopFarming then break end
            if not held then
                loopFailed = true
                break
            end

            -- End stage: grab the golden chest then claim
            if stage.isEnd then
                if TriggerChest and not shouldStopFarming then
                    local endChar = game.Players.LocalPlayer.Character
                    local hrp = endChar and endChar:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        -- Move chest to player
                        TriggerChest.CFrame = hrp.CFrame
                        holdPosition(1.2)
                        if shouldStopFarming then break end
                        -- Reset chest position
                        TriggerChest.CFrame = TriggerChestOriginalCFrame
                    end
                end

                -- Claim gold from results
                task.wait(0.3)
                pcall(function()
                    workspace.ClaimRiverResultsGold:FireServer()
                end)
                task.wait(0.5)

                -- Dismiss the GUI
                autoDismissResults()
                task.wait(0.3)
                autoDismissResults()
            end
        end

        -- If a stage failed (death, teleport fail), wait for respawn and retry
        if loopFailed and not shouldStopFarming then
            waitForCharacter()
            task.wait(1)
            autoDismissResults()
        end
    end

    isFarmingThreadRunning = false
    shouldStopFarming = false
end

function StopFarm()
    isFarming = false
    shouldStopFarming = true

    local plr = game.Players.LocalPlayer
    if not plr then return end

    task.wait(0.2)
    local character = plr.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = CFrame.new(0, -615, 0)
        end
    end
end


local function AntiAFK()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Vyrusspcs/weshkyv2/refs/heads/main/special/antiafk.lua"))()
end

local farmFolder = mainTab.new("folder", {
    text = "Autofarm",
})

local farmTimeLabel = farmFolder.new("label", { 
    text = "Farming time: 00:00:00" 
})

local currentGoldLabel = farmFolder.new("label", { 
    text = "Current Gold: 0" 
})

local farmedGoldBlocksLabel = farmFolder.new("label", { 
    text = "Gold Blocks Farmed: 0" 
})

local farmedGoldLabel = farmFolder.new("label", {
    text = "Gold Farmed: 0"
})

local farmLoopsLabel = farmFolder.new("label", {
    text = "Farm Loops: 0"
})

local function updateFarmTime()
    if isTimerRunning then
        local elapsedTime = (os.time() - farmStartTime) + pausedTime

        local hours = math.floor(elapsedTime / 3600)
        local minutes = math.floor((elapsedTime % 3600) / 60)
        local seconds = elapsedTime % 60

        farmTimeLabel.setText(string.format("Farming time: %02d:%02d:%02d", hours, minutes, seconds))
        farmLoopsLabel.setText("Farm Loops: " .. tostring(farmLoopCount))
    end
end

local function UpdateGoldDisplay()
    local success, result = pcall(function()
        local goldGui = player.PlayerGui:FindFirstChild("GoldGui")
        if goldGui and goldGui:FindFirstChild("Frame") then
            local amountLabel = goldGui.Frame:FindFirstChild("Amount")
            if amountLabel and amountLabel:IsA("TextLabel") then
                local cleanText = amountLabel.Text:gsub("[^%d]", "")
                local currentGold = tonumber(cleanText) or 0
                                
                if initialGold == 0 then
                    initialGold = currentGold
                end
                
                local farmed = currentGold - initialGold
                farmedGoldLabel.setText("Gold Farmed: " .. farmed)
            end
        end
    end)
end

-- Add this function after the UpdateGoldDisplay function (around line 210-220)
local function UpdateGoldBlocksDisplay()
    local success, result = pcall(function()
        local goldBlocksValue = game:GetService("Players").LocalPlayer.Data.GoldBlock.Value
        local currentGoldBlocks = tonumber(goldBlocksValue) or 0

        if initialGoldBlocks == 0 then
            initialGoldBlocks = currentGoldBlocks
        end

        local farmed = currentGoldBlocks - initialGoldBlocks
        farmedGoldBlocksLabel.setText("Gold Blocks Farmed: " .. farmed)
    end)
end

local function UpdateCurrentGoldDisplay()
    local success, result = pcall(function()
        local goldGui = player.PlayerGui:FindFirstChild("GoldGui")
        if goldGui and goldGui:FindFirstChild("Frame") then
            local amountLabel = goldGui.Frame:FindFirstChild("Amount")
            if amountLabel and amountLabel:IsA("TextLabel") then
                local cleanText = amountLabel.Text:gsub("[^%d]", "")
                local currentGold = tonumber(cleanText) or 0
                currentGoldLabel.setText("Current Gold: " .. currentGold)
            end
        end
    end)
end

local function StartGoldUpdate()
    if goldUpdateThread then return end
    
    goldUpdateThread = task.spawn(function()
        while true do
            UpdateGoldDisplay()
            UpdateGoldBlocksDisplay()
            task.wait(0.5)
        end
    end)
end

-- Also update the Reset Counters button to reset webhook stats
farmFolder.new("button", {
    text = "Reset Counters",
}).event:Connect(function()
    initialGold = 0
    initialGoldBlocks = 0
    farmStartTime = os.time()
    pausedTime = 0
    farmLoopCount = 0

    farmedGoldLabel.setText("Gold Farmed: 0")
    farmedGoldBlocksLabel.setText("Gold Blocks Farmed: 0")
    farmTimeLabel.setText("Farming time: 00:00:00")
    farmLoopsLabel.setText("Farm Loops: 0")
    
    -- Update current gold immediately
    UpdateCurrentGoldDisplay()
    
    -- Send webhook update when counters are reset
    if webhookEnabled then
        task.spawn(function()
            task.wait(1)
            SendWebhook()
        end)
    end
    
    if isTimerRunning then
        farmStartTime = os.time()
    end
end)

local currentGoldUpdateThread = nil
local function StartCurrentGoldUpdate()
    if currentGoldUpdateThread then return end
    
    currentGoldUpdateThread = task.spawn(function()
        while true do
            UpdateCurrentGoldDisplay()
            task.wait(1) -- Update every second when not farming
        end
    end)
end

farmFolder.new("switch", {
    text = "Autofarm",
}).event:Connect(function(state)
    if state then
        print("Autofarm started")
        isFarming = true
        isTimerRunning = true
        
        -- Reset initial counters when starting
        if initialGoldBlocks == 0 then
            local goldBlocksValue = game:GetService("Players").LocalPlayer.Data.GoldBlock.Value
            initialGoldBlocks = tonumber(goldBlocksValue) or 0
        end
        
        if initialGold == 0 then
            UpdateGoldDisplay() -- This will set initialGold
        end
        
        StartGoldUpdate()
        farmStartTime = os.time()
        
        if farmTimer then
            farmTimer:Disconnect()
        end
        
        farmTimer = game:GetService("RunService").Heartbeat:Connect(function()
            updateFarmTime()
        end)
        
        -- Background auto-claim: dismiss RiverResults GUI whenever it pops up
        task.spawn(function()
            while isFarming do
                autoDismissResults()
                task.wait(1)
            end
        end)

        -- Send webhook notification when farming starts
        if webhookEnabled then
            task.spawn(function()
                task.wait(2)
                SendWebhook()
            end)
        end

        StartFarmNormal()
    else
        print("Autofarm stopped")
        isFarming = false
        isTimerRunning = false
        
        pausedTime = (os.time() - farmStartTime) + pausedTime
        
        if farmTimer then
            farmTimer:Disconnect()
            farmTimer = nil
        end
        
        -- Stop the combined gold update thread when farming stops
        if goldUpdateThread then
            task.cancel(goldUpdateThread)
            goldUpdateThread = nil
        end
        
        -- Send webhook notification when farming stops
        if webhookEnabled then
            task.spawn(function()
                task.wait(1)
                SendWebhook()
            end)
        end
        
        StopFarm()
        updateFarmTime()
    end
end)

farmFolder.open()

local webhookUrl = ""
local webhookEnabled = false
local webhookInterval = 300 -- 5 minutes default
local webhookThread = nil
local lastWebhookTime = 0

-- Add this after the farmFolder creation (around line 170)
local webhookFolder = mainTab.new("folder", {
    text = "Webhook Notifications",
})

-- Add webhook input field
webhookFolder.new("input", {
    text = "Webhook URL",
    placeholder = "https://...",
}).event:Connect(function(value)
    webhookUrl = value
end)

-- Add interval slider
webhookFolder.new("slider", {
    text = "Update Interval (seconds)",
    min = 60,
    max = 3600,
    value = 300,
    floating = 0,
}).event:Connect(function(value)
    webhookInterval = value
    
    if webhookEnabled and webhookUrl ~= "" then
        StartWebhookUpdates()
    end
end)

-- Function to get current farming statistics
local function GetFarmingStats()
    local stats = {}
    
    -- Calculate farmed gold
    local currentGold = 0
    pcall(function()
        local goldGui = player.PlayerGui:FindFirstChild("GoldGui")
        if goldGui and goldGui:FindFirstChild("Frame") then
            local amountLabel = goldGui.Frame:FindFirstChild("Amount")
            if amountLabel and amountLabel:IsA("TextLabel") then
                local cleanText = amountLabel.Text:gsub("[^%d]", "")
                currentGold = tonumber(cleanText) or 0
            end
        end
    end)
    
    local goldFarmed = math.max(0, currentGold - initialGold)
    
    -- Calculate gold blocks farmed
    local goldBlocksFarmed = 0
    pcall(function()
        local goldBlocksValue = game:GetService("Players").LocalPlayer.Data.GoldBlock.Value
        local currentGoldBlocks = tonumber(goldBlocksValue) or 0
        goldBlocksFarmed = math.max(0, currentGoldBlocks - initialGoldBlocks)
    end)
    
    -- Calculate farming time
    local farmingTime = 0
    if isTimerRunning then
        farmingTime = (os.time() - farmStartTime) + pausedTime
    else
        farmingTime = pausedTime
    end
    
    -- Format time
    local hours = math.floor(farmingTime / 3600)
    local minutes = math.floor((farmingTime % 3600) / 60)
    local seconds = farmingTime % 60
    
    return {
        username = player.Name,
        goldFarmed = goldFarmed,
        currentGold = currentGold,
        goldBlocksFarmed = goldBlocksFarmed,
        farmingTime = string.format("%02d:%02d:%02d", hours, minutes, seconds),
        isFarming = isFarming,
        status = isFarming and "Farming" or "stopped"
    }
end

local soontm = "Unknown"

local function SendWebhook()
    if webhookUrl == "" or not webhookEnabled then
        return false
    end
    
    local stats = GetFarmingStats()
    
    -- Create embed
    local embed = {
        title = "Farming Statistics",
        color = 3485559, -- Red color
        fields = {
            {
                name = "Player",
                value = stats.username,
                inline = true
            },
            {
                name = "Status",
                value = soontm,
                inline = true
            },
            {
                name = "Farming Time",
                value = stats.farmingTime,
                inline = true
            },
            {
                name = "Gold Farmed",
                value = tostring(stats.goldFarmed),
                inline = true
            },
            {
                name = "Current Gold",
                value = tostring(stats.currentGold),
                inline = true
            },
            {
                name = "Gold Blocks Farmed",
                value = tostring(stats.goldBlocksFarmed),
                inline = true
            }
        },
        footer = {
            text = "Voltara Script • " .. os.date("%Y-%m-%d %H:%M:%S") .. " https://discord.gg/d46hKys4X7"
        }
    }
    
    local payload = {
        embeds = {embed},
        username = "Voltara Farming Stats",
        avatar_url = "https://i.ibb.co/S7cLXLMm/image-2.jpg"
    }
    
    local success, response = pcall(function()
        if request then
            local result = request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode(payload)
            })
            return result.StatusCode == 200 or result.StatusCode == 204
        elseif syn and syn.request then
            local result = syn.request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode(payload)
            })
            return result.StatusCode == 200 or result.StatusCode == 204
        else
            HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
            return true
        end
    end)
    
    if success then
        lastWebhookTime = os.time()
        return true
    else
        return false
    end
end

local function StartWebhookUpdates()
    if webhookThread then
        task.cancel(webhookThread)
        webhookThread = nil
        task.wait(0.1)
    end
    
    webhookThread = task.spawn(function()
        local threadId = tostring(math.random(1, 10000))
        
        SendWebhook()
        
        while true do
            if not webhookEnabled or webhookUrl == "" then
                break
            end
            
            local waitStart = os.time()
            while os.time() - waitStart < webhookInterval do
                if not webhookEnabled or webhookUrl == "" then
                    break
                end
                task.wait(1)
            end
            
            if webhookEnabled and webhookUrl ~= "" then
                SendWebhook()
            end
        end
        webhookThread = nil
    end)
end

webhookFolder.new("switch", {
    text = "Enable Webhook",
}).event:Connect(function(state)
    webhookEnabled = state
    
    if state then
        if webhookUrl == "" then
            print("Please enter a webhook URL before enabling")
            webhookEnabled = false
            return
        end
        
        print("Webhook enabled")
        
        StartWebhookUpdates()
    else
        if webhookThread then
            task.cancel(webhookThread)
            webhookThread = nil
        end
        print("Webhook disabled")
    end
end)

webhookFolder.open()

--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------


local BuildDatabase = databaseTab.new("dropdown", {
    text = "Select Build",
})

local dropdownObjects = {}
local selectedBuild = nil

local buildsFolder = "WeshkyBuildStorage"

local function listfiles(path)
    if not isfolder then return {} end
    if not isfolder(path) then return {} end
    return {}
end

local function isfolder(path)
    return pcall(function() readfile(path .. "/test.txt") end)
end

local function makefolder(path)
    if not isfolder(path) then
        pcall(function() writefile(path .. "/init.txt", "") end)
    end
end

if not isfolder(buildsFolder) then
    makefolder(buildsFolder)
end

local function fetchBuildsFromGitHub()
    local builds = {}
    local success, response = pcall(function()
        return game:HttpGet("https://api.github.com/repos/Vyrusspcs/weshkyv2/contents/database/builds")
    end)
    
    if success then
        local files = HttpService:JSONDecode(response)
        for _, file in ipairs(files) do
            if file.type == "file" and file.name:match("%.Build$") then
                table.insert(builds, {
                    name = file.name:gsub("%.Build$", ""),
                    download_url = file.download_url,
                    path = file.path
                })
            end
        end
    else
        warn("Failed to fetch builds from GitHub: " .. tostring(response))
    end
    
    return builds
end

local function downloadBuild(buildName, downloadUrl)
    print("Downloading build: " .. buildName)
    
    local success, content = pcall(function()
        return game:HttpGet(downloadUrl)
    end)
    
    if success then
        local filePath = buildsFolder .. "/" .. buildName .. ".Build"
        writefile(filePath, content)
        print("Build downloaded and saved: " .. filePath)
        return true
    else
        print("Failed to download build: " .. tostring(content))
        return false
    end
end

local function listLocalBuilds()
    local builds = {}
    pcall(function()
        for _, file in pairs(listfiles(buildsFolder)) do
            if file:match("%.Build$") then
                local fileName = file:match("[^\\/]+$")
                local buildName = fileName:gsub("%.Build$", "")
                table.insert(builds, {
                    name = buildName,
                    path = file,
                    isLocal = true
                })
            end
        end
    end)
    return builds
end

local function refreshBuildsList()
    if BuildDatabase.isopen then
        BuildDatabase:close()
    end
    
    dropdownObjects = {}
    
    local localBuilds = listLocalBuilds()
    for _, build in ipairs(localBuilds) do
        local dropdownObj = BuildDatabase.new(build.name .. " (Local)")
        dropdownObjects[build.name] = {object = dropdownObj, data = build}
    end
    
    local onlineBuilds = fetchBuildsFromGitHub()
    for _, build in ipairs(onlineBuilds) do
        local dropdownObj = BuildDatabase.new(build.name)
        dropdownObjects[build.name] = {object = dropdownObj, data = build}
    end
    
    if #localBuilds == 0 and #onlineBuilds == 0 then
        BuildDatabase.new("No builds found - Check GitHub")
    end
    
    if not BuildDatabase.isopen then
        BuildDatabase:open()
    end
end

BuildDatabase.event:Connect(function(option)
    if option:find("(Local)") then
        local buildName = option:gsub(" %(Local%)", "")
        if dropdownObjects[buildName] then
            selectedBuild = dropdownObjects[buildName].data
        end
    elseif option ~= "No builds found - Check GitHub" then
        if dropdownObjects[option] then
            selectedBuild = dropdownObjects[option].data
        end
    end
end)

databaseTab.new("button", {
    text = "Download Selected Build",
}).event:Connect(function()
    if not selectedBuild then
        print("No build selected")
        return
    end
    
    if selectedBuild.isLocal then
        print("Selected build is already downloaded: " .. selectedBuild.name)
        return
    end
    
    downloadBuild(selectedBuild.name, selectedBuild.download_url)
    task.wait(1)
    refreshBuildsList()
end)

refreshBuildsList()

local characterFolder = clientTab.new("folder", {
    text = "Character Settings",
})

local speedSlider = characterFolder.new("slider", {
    text = "Walkspeed",
    min = 0,
    max = 200,
    value = humanoid.WalkSpeed,
})

speedSlider.event:Connect(function(value)
    if humanoid then
        humanoid.WalkSpeed = value
    end
end)

local jumppowerSlider = characterFolder.new("slider", {
    text = "JumpPower",
    min = 0,
    max = 200,
    value = humanoid.JumpPower,
})

jumppowerSlider.event:Connect(function(value)
    if humanoid then
        humanoid.JumpPower = value
    end
end)

characterFolder.new("button", {
    text = "Reset to Default",
}).event:Connect(function()
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50

        speedSlider.set(16)
        jumppowerSlider.set(50)
    end
end)

characterFolder.open()

local mapFolder = clientTab.new("folder", {
    text = "Map Settings",
})

local blockStates = {} 
local hideBlocksUpdate = nil

local hideAllBlocks = mapFolder.new("switch", {
    text = "Hide all Blocks";
})

hideAllBlocks.event:Connect(function(enabled)
    local blocksFolder = workspace:FindFirstChild("Blocks")
    if not blocksFolder then return end
    
    if enabled then
        for _, playerFolder in pairs(blocksFolder:GetChildren()) do
            for _, block in pairs(playerFolder:GetDescendants()) do
                if block:IsA("BasePart") then
                    local id = block:GetDebugId()
                    
                    if not blockStates[id] then
                        blockStates[id] = {
                            Transparency = block.Transparency,
                            CanCollide = block.CanCollide,
                            Part = block 
                        }
                    end
                    
                    block.Transparency = 1
                    block.CanCollide = false
                end
            end
        end
        
        hideBlocksUpdate = task.spawn(function()
            while enabled do
                task.wait(0.2)
                
                for _, playerFolder in pairs(blocksFolder:GetChildren()) do
                    for _, block in pairs(playerFolder:GetChildren()) do
                        if block:IsA("Model") and block:FindFirstChild("PPart") then
                            local part = block.PPart
                            if part:IsA("BasePart") then
                                local id = part:GetDebugId()
                                
                                if not blockStates[id] then
                                    blockStates[id] = {
                                        Transparency = part.Transparency,
                                        CanCollide = part.CanCollide,
                                        Part = part
                                    }
                                    
                                    part.Transparency = 1
                                    part.CanCollide = false
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        if hideBlocksUpdate then
            task.cancel(hideBlocksUpdate)
            hideBlocksUpdate = nil
        end
        
        for id, state in pairs(blockStates) do
            if state.Part and state.Part.Parent then 
                state.Part.Transparency = state.Transparency
                state.Part.CanCollide = state.CanCollide
            end
        end
        
        blockStates = {}
    end
end)


local blockStatesOthers = {}
local hideOthersUpdate = nil

local hideOthersBlocks = mapFolder.new("switch", {
    text = "Hide Other Player Blocks";
})
hideOthersBlocks.set(false)

hideOthersBlocks.event:Connect(function(enabled)
    local blocksFolder = workspace:FindFirstChild("Blocks")
    local localPlayerName = game.Players.LocalPlayer.Name
    if not blocksFolder then return end
    
    if enabled then
        for _, playerFolder in pairs(blocksFolder:GetChildren()) do
            if playerFolder.Name ~= localPlayerName then
                for _, block in pairs(playerFolder:GetDescendants()) do
                    if block:IsA("BasePart") then
                        local id = block:GetDebugId()
                        
                        if not blockStatesOthers[id] then
                            blockStatesOthers[id] = {
                                Transparency = block.Transparency,
                                CanCollide = block.CanCollide,
                                Part = block
                            }
                        end
                        
                        block.Transparency = 1
                        block.CanCollide = false
                    end
                end
            end
        end
        
        hideOthersUpdate = task.spawn(function()
            while enabled do
                task.wait(0.2)
                
                for _, playerFolder in pairs(blocksFolder:GetChildren()) do
                    if playerFolder.Name ~= localPlayerName then
                        for _, block in pairs(playerFolder:GetChildren()) do
                            if block:IsA("Model") and block:FindFirstChild("PPart") then
                                local part = block.PPart
                                if part:IsA("BasePart") then
                                    local id = part:GetDebugId()
                                    
                                    if not blockStatesOthers[id] then
                                        blockStatesOthers[id] = {
                                            Transparency = part.Transparency,
                                            CanCollide = part.CanCollide,
                                            Part = part
                                        }
                                        
                                        part.Transparency = 1
                                        part.CanCollide = false
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        if hideOthersUpdate then
            task.cancel(hideOthersUpdate)
            hideOthersUpdate = nil
        end
        
        for id, state in pairs(blockStatesOthers) do
            if state.Part and state.Part.Parent then
                state.Part.Transparency = state.Transparency
                state.Part.CanCollide = state.CanCollide
            end
        end
        
        blockStatesOthers = {}
    end
end)

mapFolder.new("button", {
    text = "Remove Water Damage",
}).event:Connect(function()
    local water = workspace:FindFirstChild("Water")
    if water then
        water:Destroy()
    end
end)

mapFolder.open()

local fakeGoldFolder = clientTab.new("folder", {
    text = "Fake Gold Amount",
})

local GiveGoldAmount = nil

fakeGoldFolder.new("input", {
    text = "Gold Amount",
    placeholder = "2351981125",
}).event:Connect(function(value)
    GiveGoldAmount = tonumber(value)
end)

fakeGoldFolder.new("button", {
    text = "Set Fake Gold",
}).event:Connect(function()
    if GiveGoldAmount and type(GiveGoldAmount) == "number" then
        game:GetService("Players").LocalPlayer.Data.Gold.Value = GiveGoldAmount
    end
end)

fakeGoldFolder.open()

local function removeLock()
    local Teams = {"BlackZone", "CamoZone", "MagentaZone", "New YellerZone", "Really blueZone", "Really redZone", "WhiteZone"}

    for _, teamName in ipairs(Teams) do
        local teamPart = workspace:FindFirstChild(teamName)
        if teamPart then
            local lockFolder = teamPart:FindFirstChild("Lock")
            if lockFolder then
                lockFolder:Destroy()
            end
        end
    end
end

local previousPosition = nil
local counterIsoMODE = false

local function trackPlayerPosition()
    while counterIsoMODE do
        removeLock()
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                previousPosition = humanoidRootPart.CFrame
            end
        end
        task.wait(.1)
    end
end

local function onCharacterAdded(character)
    if counterIsoMODE then
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if previousPosition then
            humanoidRootPart.CFrame = previousPosition
        end
    end
end

player.CharacterAdded:Connect(onCharacterAdded)
task.spawn(trackPlayerPosition)

-------------------------------------------------------------------------------------------- Exclusive
-------------------------------------------------------------------------------------------- Exclusive
-------------------------------------------------------------------------------------------- Exclusive

local eggCanonFolder = specialTab.new("folder", {
    text = "Egg Canon Farm",
})

eggCanonFolder.new("label", {
    text = "",
})

eggCanonFolder.new("label", {
    text = "Requirements:\n1. After Teleport check if the Server is Empty, doesn't Work anyways!!\n2. Time: Please wait and don't Move, it takes about 8-10 Mins.",
})

eggCanonFolder.new("label", {
    text = "",
})

eggCanonFolder.new("button", {
    text = "Start Egg Canon Farm",
}).event:Connect(function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Vyrusspcs/weshkyv2/refs/heads/main/special/eggcanon.lua'),true))()
end)

local colorFolder = specialTab.new("folder", {
    text = "Color My Blocks",
})

local function GetTool(toolName)
    local tool = player.Backpack:FindFirstChild(toolName) or player.Character:FindFirstChild(toolName)
    if tool then
        return tool:FindFirstChild("RF") or tool
    end
    return nil
end

local colorAllFolder = colorFolder.new("folder", {
    text = "Color All",
})

local selectedColor = Color3.new(1, 0, 0) 

local colorPicker = colorAllFolder.new("color", {
    text = "Select Color",
    color = selectedColor,
})

colorPicker.event:Connect(function(color)
    selectedColor = color
end)

local function colorAllBlocksWithTool()
    local blocksFolder = workspace:FindFirstChild("Blocks")
    local localPlayerName = game.Players.LocalPlayer.Name
    
    if not blocksFolder then
        return
    end
    
    local playerFolder = blocksFolder:FindFirstChild(localPlayerName)
    if not playerFolder then
        return
    end
    
    local paintingTool = GetTool("PaintingTool")
    if not paintingTool then
        return
    end
    
    local blocksToPaint = {}
    
    for _, block in ipairs(playerFolder:GetDescendants()) do
        if block:IsA("Model") and block:FindFirstChild("PPart") then
            local part = block.PPart
            if part:IsA("BasePart") then
                table.insert(blocksToPaint, {block, selectedColor})
            end
        end
    end
    
    if #blocksToPaint > 0 then
        pcall(function()
            paintingTool:InvokeServer(blocksToPaint)
        end)
    end
end

colorAllFolder.new("button", {
    text = "Color All My Blocks",
}).event:Connect(colorAllBlocksWithTool)

local colorSpecificFolder = colorFolder.new("folder", {
    text = "Color Specific",
})

local specificColorPicker = colorSpecificFolder.new("color", {
    text = "Select Color",
    color = selectedColor,
})

specificColorPicker.event:Connect(function(color)
    selectedColor = color
end)

local blockTypeToColor = "WoodBlock"
local blockTypeDropdown = colorSpecificFolder.new("dropdown", {
    text = "Block Type",
})

local buildingParts = game:GetService("ReplicatedStorage"):FindFirstChild("BuildingParts")
if buildingParts then
    for _, part in ipairs(buildingParts:GetChildren()) do
        local name = part.Name  
        if string.sub(name, #name - 4, #name) == "Block" then
            blockTypeDropdown.new(name) 
        end
    end
else
    local commonBlocks = {"Problem Loading Blocks"}
    for _, blockName in ipairs(commonBlocks) do
        blockTypeDropdown.new(blockName)
    end
end

blockTypeDropdown.event:Connect(function(selectedType)
    blockTypeToColor = selectedType
end)

local function colorSpecificBlocksWithTool()
    local blocksFolder = workspace:FindFirstChild("Blocks")
    local localPlayerName = game.Players.LocalPlayer.Name
    
    if not blocksFolder then return end
    
    local playerFolder = blocksFolder:FindFirstChild(localPlayerName)
    if not playerFolder then return end
    
    local paintingTool = GetTool("PaintingTool")
    if not paintingTool then
        return
    end
    
    local blocksToPaint = {}
    
    for _, block in ipairs(playerFolder:GetChildren()) do
        if block.Name == blockTypeToColor and block:FindFirstChild("PPart") then
            local part = block.PPart
            if part:IsA("BasePart") then
                table.insert(blocksToPaint, {block, selectedColor})
            end
        end
    end
    
    if #blocksToPaint > 0 then
        pcall(function()
            paintingTool:InvokeServer(blocksToPaint)
        end)
    end
end

colorSpecificFolder.new("button", {
    text = "Color Specific Block Type",
}).event:Connect(colorSpecificBlocksWithTool)

local shopFolder = specialTab.new("folder", {
    text = "Developer Products",
})

local productIds = {
    DragonHarpoon = 1109792341,
    MegaThruster = 139121474,
    CandyHarpoon = 915766549,
    CookieWheel = 1126385328
}

local selectedProduct = "DragonHarpoon"

local productDropdown = shopFolder.new("dropdown", {
    text = "Developer Product",
})

for productName, _ in pairs(productIds) do
    productDropdown.new(productName)
end

productDropdown.event:Connect(function(selected)
    selectedProduct = selected
end)

shopFolder.new("button", {
    text = "Buy Developer Product",
}).event:Connect(function()
    local productId = productIds[selectedProduct]
    if productId then
        local success, result = pcall(function()
            workspace.PromptRobuxEvent:InvokeServer(productId, "Product")
        end)
        
        if success then
            print("Purchase prompt should appear for: " .. selectedProduct)
        else
            print("Failed to purchase product: " .. tostring(result))
        end
    else
        print("Invalid product selected")
    end
end)

local tpplace = specialTab.new("folder", {
    text = "Teleport Place",
})

tpplace.new("button", {
    text = "Inner Cloud",
}).event:Connect(function()
    TeleportService:Teleport(1930863474, game.Players.LocalPlayer)
end)

tpplace.new("button", {
    text = "Chrismas",
}).event:Connect(function()
    TeleportService:Teleport(1930866268, game.Players.LocalPlayer)
end)

tpplace.new("button", {
    text = "Halloween",
}).event:Connect(function()
    TeleportService:Teleport(1930665568, game.Players.LocalPlayer)
end)

local teleportFolder = specialTab.new("folder", {
    text = "Teleport Teams",
})

teleportFolder.new("button", {
    text = "Teleport White",
}).event:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(-49.8510132, -9.7000021, -552.37085, -1, 0, 0, 0, 1, 0, 0, 0, -1)
        else
            character:SetPrimaryPartCFrame(CFrame.new(-49.8510132, -9.7000021, -552.37085, -1, 0, 0, 0, 1, 0, 0, 0, -1))
        end
    end
end)

teleportFolder.new("button", {
    text = "Teleport Black",
}).event:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(-536.22843, -9.7000021, -69.433342, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        else
            character:SetPrimaryPartCFrame(CFrame.new(-536.22843, -9.7000021, -69.433342, 0, 0, -1, 0, 1, 0, 1, 0, 0))
        end
    end
end)

teleportFolder.new("button", {
    text = "Teleport Red",
}).event:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(430.697418, -9.7000021, -64.7801361, 0, 0, 1, 0, 1, -0, -1, 0, 0)
        else
            character:SetPrimaryPartCFrame(CFrame.new(430.697418, -9.7000021, -64.7801361, 0, 0, 1, 0, 1, -0, -1, 0, 0))
        end
    end
end)

teleportFolder.new("button", {
    text = "Teleport Blue",
}).event:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(430.697418, -9.7000021, 300.219849, 0, 0, 1, 0, 1, -0, -1, 0, 0)
        else
            character:SetPrimaryPartCFrame(CFrame.new(430.697418, -9.7000021, 300.219849, 0, 0, 1, 0, 1, -0, -1, 0, 0))
        end
    end
end)

teleportFolder.new("button", {
    text = "Teleport Green",
}).event:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(-535.82843, -9.7000021, 293.56665, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        else
            character:SetPrimaryPartCFrame(CFrame.new(-535.82843, -9.7000021, 293.56665, 0, 0, -1, 0, 1, 0, 1, 0, 0))
        end
    end
end)

teleportFolder.new("button", {
    text = "Teleport Yellow",
}).event:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(-537.82843, -9.7000021, 640.56665, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        else
            character:SetPrimaryPartCFrame(CFrame.new(-537.82843, -9.7000021, 640.56665, 0, 0, -1, 0, 1, 0, 1, 0, 0))
        end
    end
end)

-------------------------------------------------------------------------------------------- Credits
-------------------------------------------------------------------------------------------- Credits
-------------------------------------------------------------------------------------------- Credits

local creditsFolder = creditsTab.new("folder", {
    text = "Credits",
})
creditsFolder.new("label", {
    text = " ",
})
creditsFolder.new("label", {
    text = "Creator and Main Scripter: Sxirbes (Zenith) \nSten: Credits for the old original Source\nTheRealAsu: Nice Guy who helped with Properties saving",
})
creditsFolder.new("label", { text = "" })

creditsFolder.new("label", { text = "Join our Community Server for Build Files and help." })

creditsFolder.new("button", {
    text = "Join our Discord (copy invite to clipboard)",
}).event:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Vyrusspcs/weshkyv2/refs/heads/main/client/external/discord.lua"))()
end)

creditsFolder.open()

AntiAFK()

for i,v in next, getconnections(game:GetService("Players").LocalPlayer.Idled) do
                    v:Disable()
end

task.spawn(function()
    while true do
        wait(0.5)
        UpdateCurrentGoldDisplay()
    end
end)