local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/UseUelessStorage/WLib/refs/heads/main/MySource.lua"))()

local Window = redzlib:MakeWindow({
  Title = "Weshky Baft",
  SubTitle = "Autofarm",
  SaveFolder = "SavesWeshky"
})

local Tab2 = Window:MakeTab({"Autofarm", "rbxassetid://10709811445"})
local Tab3 = Window:MakeTab({"Webhook", "rbxassetid://10723426722"})
local Tab4 = Window:MakeTab({"Extra Features", "rbxassetid://10709762058"})
local Tab5 = Window:MakeTab({"Credits And Discord", "rbxassetid://10709812159"})

local Section = Tab2:AddSection({"Autofarm:"})
local Section = Tab3:AddSection({"Webhook Informations:"})
local Section = Tab4:AddSection({"Extra Features:"})
local Section = Tab5:AddSection({"Credits And Discord:"}) 


local Paragraph = Tab3:AddParagraph({"Information This Feature Will Added Soon!!", "With this Feature you can use a Webhook for example a Discord Webhook to send your Autofarm Stats in your discord channel."})

local player = game.Players.LocalPlayer
local lastTime = tick()
local totalFarmTime = 0
local isFarming = false
local goldLabel = player.PlayerGui:FindFirstChild("GoldGui") and player.PlayerGui.GoldGui.Frame.Amount or nil
local Farmtime, FarmedGold

local initialGold = 0
local isInitialGoldSet = false
local isFirstRun = true
local goldBlocksGained = 0

local Autofarm = Tab2:AddToggle({
  Name = "Normal Autofarm",
  Description = "Information: After Turning Auto Farm Off, Wait some Seconds until the active run is Over!!",
  Default = false,
  Callback = function(state)
      if state then
          StartFarmNormal()
      else
          StopFarm()
      end
  end
})

local Autofarmblock = Tab2:AddToggle({
  Name = "Gold Block Autofarm",
  Description = "Toggle Gold Block Autofarm On/Off",
  Default = false,
  Callback = function(state)
      if state then
          StartFarmBlock()
      else
          StopFarmBlock()
      end
  end
})

-- local Section = Tab2:AddSection({"Special Farm:"})

-- local Halloween = Tab2:AddButton({
--  Name = "Candy Autofarm",
--  Description = "You can only farm candys on the Halloween Event!!",
--  Callback = function()
--      print("Hello, World")
--  end
-- })

local Section = Tab2:AddSection({"Settings:"})

local AntiAFKSe = Tab2:AddToggle({
  Name = "Anti Afk",
  Description = "Toggle Anti Afk On/ Off, Activate Else you will be Kicked after 20 Minutes inactivity!!",
  Default = false,
  Callback = function(state)
      if state then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/NoTwistedHere/Roblox/main/AntiAFK.lua"))()
      else
          task.wait(0.02)
      end
  end
})

local Section = Tab2:AddSection({"Farming Stats:"})
Farmtime = Tab2:AddParagraph({"Total Farming Time"})
local GoldBlocks = Tab2:AddParagraph({"Obtained Blocks: "})
GoldGained2 = Tab2:AddParagraph({"Obtained Gold: "})
TotalGold = Tab2:AddParagraph({"Total Gold"})

local Paragraph = Tab5:AddParagraph({"Weshky Credits", "Weshky Auto Farm Got Created For Weshky Discord Server, Enjoy Using Our Script.\n \nCredits: \nWeshky Owner: Sxirbes [Scripter] \nWeshky Co-Owner: frenzy.at"})

Tab5:AddDiscordInvite({
  Name = "Weshky Baft",
  Logo = "rbxassetid://138258387077137",
  Invite = "https://discord.gg/umS83EBEhs"
})

local Paragraph = Tab4:AddParagraph({"Extra Stuff", "These are some Scripts/ function, maybe some stuff is buggy or dosent work!!"})

local Section = Tab4:AddSection({"Limited Item Buyer:"})

local BuyPineTree = Tab4:AddButton({
  Name = "Buy Pine Tree",
  Description = "Buy Pine Tree Cost 80 Gold.",
  Callback = function()
      workspace.ItemBoughtFromShop:InvokeServer("PineTree", 1)
  end
})

local Section = Tab4:AddSection({"Extra Script:"})

local OpenDex = Tab4:AddButton({
  Name = "Just Opens Dex Exploder.",
  Description = "Just Opens Dex Exploder.",
  Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
  end
})

local AutoBuild = Tab4:AddButton({
  Name = "Good And Fast Autobuild Script.",
  Description = "Good And Fast Autobuild Script.",
  Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/suntisalts/BetaTesting/refs/heads/main/WeshkyAutoBuild.lua"))()
  end
})

-- local R6SKIN = Tab4:AddButton({
--  Name = "Fake R6 Charakter.",
--  Description = "Makes you charakter from R15 to R6.",
--  Callback = function()
--      loadstring(game:HttpGet("https://pastebin.com/raw/9BFcHqfK"))("Copyright ERROR_CODE ECCS Co")
--  end
--})


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")
local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger

local Weshky1 = Instance.new("Part")
Weshky1.Anchored = true
Weshky1.Transparency = 1
Weshky1.Size = Vector3.new(6, 1, 6)
Weshky1.BottomSurface = Enum.SurfaceType.Smooth
Weshky1.TopSurface = Enum.SurfaceType.Smooth
Weshky1.Name = "Weshky1"
Weshky1.Parent = game.Workspace

local Weshky2 = Instance.new("Part")
Weshky2.Anchored = true
Weshky2.Transparency = 1
Weshky2.Size = Vector3.new(6, 1, 6)
Weshky2.Size = Vector3.new(6, 1, 6)
Weshky2.BottomSurface = Enum.SurfaceType.Smooth
Weshky2.TopSurface = Enum.SurfaceType.Smooth
Weshky2.Name = "Weshky2"
Weshky2.Parent = game.Workspace

local Weshky3 = Instance.new("Part")
Weshky3.Anchored = true
Weshky3.Transparency = 1
Weshky3.Size = Vector3.new(6, 1, 6)
Weshky3.Size = Vector3.new(6, 1, 6)
Weshky3.BottomSurface = Enum.SurfaceType.Smooth
Weshky3.TopSurface = Enum.SurfaceType.Smooth
Weshky3.Name = "Weshky3"
Weshky3.Parent = game.Workspace

local Weshky4 = Instance.new("Part")
Weshky4.Anchored = true
Weshky4.Transparency = 1
Weshky4.Size = Vector3.new(6, 1, 6)
Weshky4.Size = Vector3.new(6, 1, 6)
Weshky4.BottomSurface = Enum.SurfaceType.Smooth
Weshky4.TopSurface = Enum.SurfaceType.Smooth
Weshky4.Name = "Weshky4"
Weshky4.Parent = game.Workspace

local Weshky5 = Instance.new("Part")
Weshky5.Anchored = true
Weshky5.Transparency = 1
Weshky5.Size = Vector3.new(6, 1, 6)
Weshky5.Size = Vector3.new(6, 1, 6)
Weshky5.BottomSurface = Enum.SurfaceType.Smooth
Weshky5.TopSurface = Enum.SurfaceType.Smooth
Weshky5.Name = "Weshky5"
Weshky5.Parent = game.Workspace

local Weshky6 = Instance.new("Part")
Weshky6.Anchored = true
Weshky6.Transparency = 1
Weshky6.Size = Vector3.new(6, 1, 6)
Weshky6.Size = Vector3.new(6, 1, 6)
Weshky6.BottomSurface = Enum.SurfaceType.Smooth
Weshky6.TopSurface = Enum.SurfaceType.Smooth
Weshky6.Name = "Weshky6"
Weshky6.Parent = game.Workspace

local Weshky7 = Instance.new("Part")
Weshky7.Anchored = true
Weshky7.Transparency = 1
Weshky7.Size = Vector3.new(6, 1, 6)
Weshky7.Size = Vector3.new(6, 1, 6)
Weshky7.BottomSurface = Enum.SurfaceType.Smooth
Weshky7.TopSurface = Enum.SurfaceType.Smooth
Weshky7.Name = "Weshky7"
Weshky7.Parent = game.Workspace

local Weshky8 = Instance.new("Part")
Weshky8.Anchored = true
Weshky8.Transparency = 1
Weshky8.Size = Vector3.new(6, 1, 6)
Weshky8.Size = Vector3.new(6, 1, 6)
Weshky8.BottomSurface = Enum.SurfaceType.Smooth
Weshky8.TopSurface = Enum.SurfaceType.Smooth
Weshky8.Name = "Weshky8"
Weshky8.Parent = game.Workspace

local Weshky9 = Instance.new("Part")
Weshky9.Anchored = true
Weshky9.Transparency = 1
Weshky9.Size = Vector3.new(6, 1, 6)
Weshky9.Size = Vector3.new(6, 1, 6)
Weshky9.BottomSurface = Enum.SurfaceType.Smooth
Weshky9.TopSurface = Enum.SurfaceType.Smooth
Weshky9.Name = "Weshky9"
Weshky9.Parent = game.Workspace

local Weshky0 = Instance.new("Part")
Weshky0.Anchored = true
Weshky0.Transparency = 1
Weshky0.Size = Vector3.new(6, 1, 6)
Weshky0.Size = Vector3.new(6, 1, 6)
Weshky0.BottomSurface = Enum.SurfaceType.Smooth
Weshky0.TopSurface = Enum.SurfaceType.Smooth
Weshky0.Name = "Weshky0"
Weshky0.Parent = game.Workspace

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky1

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky2

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky3

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky4

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky5

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky6

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky7

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky8

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky9
local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky0

local objectsToDelete = {
    ["PointedRock"] = true, ["PixelEnemy1"] = true, ["Log"] = true, ["Box"] = true, ["PaintBrush"] = true, ["PianoKey"] = true, ["Chip"] = true, 
    ["LED1"] = true, ["LED2"] = true, ["LED3"] = true, ["Resister1"] = true, ["Resister2"] = true, ["Traces"] = true, ["PixelEnemy2"] = true, 
    ["PixelEnemy3"] = true, ["PixelEnemy4"] = true, ["PixelEnemy5"] = true, ["PixelEnemy6"] = true, ["Pizza"] = true, ["Token"] = true, 
    ["MaskRock"] = true, ["Lily1"] = true, ["Lily2"] = true, ["Lily3"] = true, ["Film"] = true, ["Ticket"] = true, ["CrystalOre"] = true, 
    ["RockExplosive"] = true, ["CaveRoofSpike"] = true, ["Toxic Barrel"] = true, ["Acid"] = true, ["Rusted Iron"] = true, ["Rock"] = true, 
    ["HoneyRock1"] = true, ["HoneyRock2"] = true, ["HoneyStream"] = true, ["FallRock1"] = true, ["FallRock2"] = true, ["GrassyRock"] = true, 
    ["Pipe"] = true, ["Pipe1"] = true, ["UFO1"] = true, ["CardPurple"] = true, ["CardYellow"] = true, ["DiceWhite"] = true, ["CardGreen"] = true, 
    ["CardRed"] = true, ["DiceBlack"] = true, ["UFO"] = true, ["UFO2"] = true, ["UFO3"] = true, ["Pipe2"] = true, ["Popcorn"] = true, ["Pipe3"] = true, 
    ["Mine"] = true, ["PoisonMushroom"] = true, ["FireRock"] = true, ["GrassyRock1"] = true, ["GrassyRock2"] = true, ["Loly"] = true, 
    ["IceCreamCone"] = true, ["Popsicle"] = true, ["Tenticle"] = true, ["BowlingBall"] = true, ["BowlingBall1"] = true, ["BowlingBall2"] = true, 
    ["BowlingBall3"] = true, ["BowlingBall4"] = true, ["BowlingBall5"] = true, ["BowlingBall6"] = true, ["Gear"] = true, ["Rock1"] = true, 
    ["Rock2"] = true, ["Rock3"] = true, ["Hotdog"] = true, ["Pretzel"] = true, ["CottonCandy"] = true
}

Weshky1.Position = Vector3.new(-72.31890106201172,91.17544555664062,1191.0478515625)
Weshky2.Position = Vector3.new(-52.304874420166016,58.03061294555664,1769.4705810546875)
Weshky3.Position = Vector3.new(-27.725244522094727,67.33195495605469,2471.45361328125)
Weshky4.Position = Vector3.new(-44.12211608886719,69.04801177978516,3165.256591796875)
Weshky5.Position = Vector3.new(-53.77952194213867,74.39949798583984,3990.331298828125)
Weshky6.Position = Vector3.new(-39.26005935668945,83.18901824951172,4824.65087890625)
Weshky7.Position = Vector3.new(-52.22807312011719,67.77399444580078,5682.07421875)
Weshky8.Position = Vector3.new(-82.22046661376953,50.52703094482422,6260.56982421875)
Weshky9.Position = Vector3.new(-38.067955017089844,105.63947296142578,7167.95263671875)
Weshky0.Position = Vector3.new(-49.93274688720703,57.78563690185547,7731.59375)

local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger

isFarming = false
isFarmingB = false 

function StartFarmNormal()
    isFarming = true

    local function teleportAndClaim(position, waitTime)
        if game.Players.LocalPlayer.Character then
            local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = position.CFrame + Vector3.new(0, 2, 0)
                task.wait(waitTime)
                -- workspace.ClaimRiverResultsGold:FireServer() -- buggy
            else
                warn("HumanoidRootPart not Found!!")
            end
        end
    end

    local positions = {
        Weshky1, Weshky2, Weshky3, Weshky4, Weshky0, Weshky5, Weshky6, Weshky7, Weshky8, Weshky9
    }
    local waitTimes = {2.3, 2.3, 2.3, 2.3, 3.2, 2.3, 2.3, 2.3, 2.3, 2.3}

    while isFarming do
        task.wait(3)

        for i, pos in ipairs(positions) do
            if pos then
                teleportAndClaim(pos, waitTimes[i])

                local success, err = pcall(function()
                    UpdateStats()
                end)
                if not success then
                    warn("Update Problems: " .. tostring(err))
                end

                if pos == Weshky0 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        task.wait(2.3)
                        TriggerChest.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        task.wait(0.8)
                        goldBlocksGained = goldBlocksGained + 1
                        TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky1 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky2 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky3 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky4 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky5 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky6 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky7 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky8 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky9 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

            else
                warn("Warning Message: XC7C/X)C)/")
            end
        end
    end
end

function StopFarm()
    isFarming = false
end

function StartFarmBlock()
    isFarmingB = true
    while isFarmingB do
		task.wait(1)
		TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
		task.wait(2)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Weshky0.CFrame + Vector3.new(0, 2, 0)
		task.wait(3)
        goldBlocksGained = goldBlocksGained + 1

        local success, err = pcall(UpdateStats)
        if not success then
            warn("Fehler in UpdateStats: " .. tostring(err))
        end
        
		TriggerChest.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		task.wait(18)
		TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
    end
end


function StopFarmBlock()
    isFarmingB = false
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------- Anoying Stats System
---------------------------------------------------------------------------------------------------------------------------------------------------------------- Fuck It!!


local function FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local sec = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hours, minutes, sec)
end

local function GetGoldLabel()
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        return player.PlayerGui:FindFirstChild("GoldGui") and player.PlayerGui.GoldGui:FindFirstChild("Frame") and player.PlayerGui.GoldGui.Frame:FindFirstChild("Amount")
    end
    return nil
end

local function UpdateStats()
    if not lastTime then
        lastTime = tick()
    end

    local elapsedTime = tick() - lastTime
    lastTime = tick()

    if isFarming or isFarmingB then
        totalFarmTime = totalFarmTime + elapsedTime
    end

    local goldLabel = GetGoldLabel()
    local currentGoldAmount = 0
    if goldLabel and goldLabel.Parent then
        currentGoldAmount = tonumber(goldLabel.Text) or 0
    else
        task.wait(0.05)
    end

    if not isInitialGoldSet and (isFarming or isFarmingB) then
        initialGold = currentGoldAmount
        isInitialGoldSet = true
    end

    local goldGained = 0
    if isInitialGoldSet then
        goldGained = currentGoldAmount - initialGold
    end

    -- Update stats
    Farmtime:Set("Total Farming Time: " .. FormatTime(totalFarmTime))
    TotalGold:Set("Total Gold: " .. tostring(currentGoldAmount))
    GoldGained2:Set("Obtained Gold: " .. tostring(goldGained))
    GoldBlocks:Set("Obtained Gold Blocks: " .. tostring(goldBlocksGained)) 
end

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/UseUelessStorage/WLib/refs/heads/main/MySource.lua"))()

local Window = redzlib:MakeWindow({
  Title = "Weshky Baft",
  SubTitle = "Autofarm",
  SaveFolder = "SavesWeshky"
})

local Tab2 = Window:MakeTab({"Autofarm", "rbxassetid://10709811445"})
local Tab3 = Window:MakeTab({"Webhook", "rbxassetid://10723426722"})
local Tab4 = Window:MakeTab({"Extra Features", "rbxassetid://10709762058"})
local Tab5 = Window:MakeTab({"Credits And Discord", "rbxassetid://10709812159"})

local Section = Tab2:AddSection({"Autofarm:"})
local Section = Tab3:AddSection({"Webhook Informations:"})
local Section = Tab4:AddSection({"Extra Features:"})
local Section = Tab5:AddSection({"Credits And Discord:"}) 


local Paragraph = Tab3:AddParagraph({"Information This Feature Will Added Soon!!", "With this Feature you can use a Webhook for example a Discord Webhook to send your Autofarm Stats in your discord channel."})

local player = game.Players.LocalPlayer
local lastTime = tick()
local totalFarmTime = 0
local isFarming = false
local goldLabel = player.PlayerGui:FindFirstChild("GoldGui") and player.PlayerGui.GoldGui.Frame.Amount or nil
local Farmtime, FarmedGold

local initialGold = 0
local isInitialGoldSet = false
local isFirstRun = true
local goldBlocksGained = 0

local Autofarm = Tab2:AddToggle({
  Name = "Normal Autofarm",
  Description = "Information: After turning Autofarm off wait some seconds until the active run is over, the same for Autofarm Gold Blocks!!",
  Default = false,
  Callback = function(state)
      if state then
          StartFarmNormal()
      else
          StopFarm()
      end
  end
})

local Autofarmblock = Tab2:AddToggle({
  Name = "Gold Block Autofarm",
  Description = "Toggle Gold Block Autofarm On/Off",
  Default = false,
  Callback = function(state)
      if state then
          StartFarmBlock()
      else
          StopFarmBlock()
      end
  end
})

-- local Section = Tab2:AddSection({"Special Farm:"})

-- local Halloween = Tab2:AddButton({
--  Name = "Candy Autofarm",
--  Description = "You can only farm candys on the Halloween Event!!",
--  Callback = function()
--      print("Hello, World")
--  end
-- })

local Section = Tab2:AddSection({"Settings:"})

local AntiAFKSe = Tab2:AddToggle({
  Name = "Anti Afk",
  Description = "Toggle Anti Afk On/ Off, Activate Else you will be Kicked after 20 Minutes inactivity!!",
  Default = false,
  Callback = function(state)
      if state then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/NoTwistedHere/Roblox/main/AntiAFK.lua"))()
      else
          task.wait(0.02)
      end
  end
})

local Section = Tab2:AddSection({"Farming Stats:"})
Farmtime = Tab2:AddParagraph({"Total Farming Time"})
local GoldBlocks = Tab2:AddParagraph({"Obtained Blocks: "})
GoldGained2 = Tab2:AddParagraph({"Obtained Gold: "})
TotalGold = Tab2:AddParagraph({"Total Gold"})

local Paragraph = Tab5:AddParagraph({"Weshky Credits", "Weshky Auto Farm Got Created For Weshky Discord Server, Enjoy Using Our Script.\n \nCredits: \nWeshky Owner: Sxirbes [Scripter] \nWeshky Co-Owner: frenzy.at"})

Tab5:AddDiscordInvite({
  Name = "Weshky Baft",
  Logo = "rbxassetid://138258387077137",
  Invite = "https://discord.gg/umS83EBEhs"
})

local Paragraph = Tab4:AddParagraph({"Extra Stuff", "These are some Scripts/ function, maybe some stuff is buggy or dosent work!!"})

local Section = Tab4:AddSection({"Limited Item Buyer:"})

local BuyPineTree = Tab4:AddButton({
  Name = "Buy Pine Tree",
  Description = "Buy Pine Tree Cost 80 Gold.",
  Callback = function()
      workspace.ItemBoughtFromShop:InvokeServer("PineTree", 1)
  end
})

local Section = Tab4:AddSection({"Extra Script:"})

local OpenDex = Tab4:AddButton({
  Name = "Just Opens Dex Exploder.",
  Description = "Just Opens Dex Exploder.",
  Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
  end
})

local AutoBuild = Tab4:AddButton({
  Name = "Good And Fast Autobuild Script.",
  Description = "Good And Fast Autobuild Script.",
  Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/suntisalts/BetaTesting/refs/heads/main/WeshkyAutoBuild.lua"))()
  end
})

-- local R6SKIN = Tab4:AddButton({
--  Name = "Fake R6 Charakter.",
--  Description = "Makes you charakter from R15 to R6.",
--  Callback = function()
--      loadstring(game:HttpGet("https://pastebin.com/raw/9BFcHqfK"))("Copyright ERROR_CODE ECCS Co")
--  end
--})


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")
local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger

local Weshky1 = Instance.new("Part")
Weshky1.Anchored = true
Weshky1.Transparency = 1
Weshky1.Size = Vector3.new(6, 1, 6)
Weshky1.BottomSurface = Enum.SurfaceType.Smooth
Weshky1.TopSurface = Enum.SurfaceType.Smooth
Weshky1.Name = "Weshky1"
Weshky1.Parent = game.Workspace

local Weshky2 = Instance.new("Part")
Weshky2.Anchored = true
Weshky2.Transparency = 1
Weshky2.Size = Vector3.new(6, 1, 6)
Weshky2.Size = Vector3.new(6, 1, 6)
Weshky2.BottomSurface = Enum.SurfaceType.Smooth
Weshky2.TopSurface = Enum.SurfaceType.Smooth
Weshky2.Name = "Weshky2"
Weshky2.Parent = game.Workspace

local Weshky3 = Instance.new("Part")
Weshky3.Anchored = true
Weshky3.Transparency = 1
Weshky3.Size = Vector3.new(6, 1, 6)
Weshky3.Size = Vector3.new(6, 1, 6)
Weshky3.BottomSurface = Enum.SurfaceType.Smooth
Weshky3.TopSurface = Enum.SurfaceType.Smooth
Weshky3.Name = "Weshky3"
Weshky3.Parent = game.Workspace

local Weshky4 = Instance.new("Part")
Weshky4.Anchored = true
Weshky4.Transparency = 1
Weshky4.Size = Vector3.new(6, 1, 6)
Weshky4.Size = Vector3.new(6, 1, 6)
Weshky4.BottomSurface = Enum.SurfaceType.Smooth
Weshky4.TopSurface = Enum.SurfaceType.Smooth
Weshky4.Name = "Weshky4"
Weshky4.Parent = game.Workspace

local Weshky5 = Instance.new("Part")
Weshky5.Anchored = true
Weshky5.Transparency = 1
Weshky5.Size = Vector3.new(6, 1, 6)
Weshky5.Size = Vector3.new(6, 1, 6)
Weshky5.BottomSurface = Enum.SurfaceType.Smooth
Weshky5.TopSurface = Enum.SurfaceType.Smooth
Weshky5.Name = "Weshky5"
Weshky5.Parent = game.Workspace

local Weshky6 = Instance.new("Part")
Weshky6.Anchored = true
Weshky6.Transparency = 1
Weshky6.Size = Vector3.new(6, 1, 6)
Weshky6.Size = Vector3.new(6, 1, 6)
Weshky6.BottomSurface = Enum.SurfaceType.Smooth
Weshky6.TopSurface = Enum.SurfaceType.Smooth
Weshky6.Name = "Weshky6"
Weshky6.Parent = game.Workspace

local Weshky7 = Instance.new("Part")
Weshky7.Anchored = true
Weshky7.Transparency = 1
Weshky7.Size = Vector3.new(6, 1, 6)
Weshky7.Size = Vector3.new(6, 1, 6)
Weshky7.BottomSurface = Enum.SurfaceType.Smooth
Weshky7.TopSurface = Enum.SurfaceType.Smooth
Weshky7.Name = "Weshky7"
Weshky7.Parent = game.Workspace

local Weshky8 = Instance.new("Part")
Weshky8.Anchored = true
Weshky8.Transparency = 1
Weshky8.Size = Vector3.new(6, 1, 6)
Weshky8.Size = Vector3.new(6, 1, 6)
Weshky8.BottomSurface = Enum.SurfaceType.Smooth
Weshky8.TopSurface = Enum.SurfaceType.Smooth
Weshky8.Name = "Weshky8"
Weshky8.Parent = game.Workspace

local Weshky9 = Instance.new("Part")
Weshky9.Anchored = true
Weshky9.Transparency = 1
Weshky9.Size = Vector3.new(6, 1, 6)
Weshky9.Size = Vector3.new(6, 1, 6)
Weshky9.BottomSurface = Enum.SurfaceType.Smooth
Weshky9.TopSurface = Enum.SurfaceType.Smooth
Weshky9.Name = "Weshky9"
Weshky9.Parent = game.Workspace

local Weshky0 = Instance.new("Part")
Weshky0.Anchored = true
Weshky0.Transparency = 1
Weshky0.Size = Vector3.new(6, 1, 6)
Weshky0.Size = Vector3.new(6, 1, 6)
Weshky0.BottomSurface = Enum.SurfaceType.Smooth
Weshky0.TopSurface = Enum.SurfaceType.Smooth
Weshky0.Name = "Weshky0"
Weshky0.Parent = game.Workspace

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky1

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky2

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky3

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky4

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky5

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky6

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky7

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky8

local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky9
local Decal = Instance.new("Decal")
Decal.Texture = "rbxassetid://137722555800117"
Decal.Name = "Weshky Is Better Then Lexus!!"
Decal.Face = Enum.NormalId.Top
Decal.Parent = Weshky0

Weshky1.Position = Vector3.new(-72.31890106201172,91.17544555664062,1191.0478515625)
Weshky2.Position = Vector3.new(-52.304874420166016,58.03061294555664,1769.4705810546875)
Weshky3.Position = Vector3.new(-27.725244522094727,67.33195495605469,2471.45361328125)
Weshky4.Position = Vector3.new(-44.12211608886719,69.04801177978516,3165.256591796875)
Weshky5.Position = Vector3.new(-53.77952194213867,74.39949798583984,3990.331298828125)
Weshky6.Position = Vector3.new(-39.26005935668945,83.18901824951172,4824.65087890625)
Weshky7.Position = Vector3.new(-52.22807312011719,67.77399444580078,5682.07421875)
Weshky8.Position = Vector3.new(-82.22046661376953,50.52703094482422,6260.56982421875)
Weshky9.Position = Vector3.new(-38.067955017089844,105.63947296142578,7167.95263671875)
Weshky0.Position = Vector3.new(-49.93274688720703,57.78563690185547,7731.59375)

local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger

isFarming = false
isFarmingB = false 

function StartFarmNormal()
    isFarming = true

    local function teleportAndClaim(position, waitTime)
        if game.Players.LocalPlayer.Character then
            local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = position.CFrame + Vector3.new(0, 2, 0)
                task.wait(waitTime)
                -- workspace.ClaimRiverResultsGold:FireServer() -- buggy
            else
                warn("HumanoidRootPart not Found!!")
            end
        end
    end

    local positions = {
        Weshky1, Weshky2, Weshky3, Weshky4, Weshky0, Weshky5, Weshky6, Weshky7, Weshky8, Weshky9
    }
    local waitTimes = {0.01, 3.9, 2.9, 2.3, 3.5, 2.3, 2.3, 2.3, 2.3, 2.3}

    while isFarming do
        task.wait(2.8)

        for i, pos in ipairs(positions) do
            if pos then
                teleportAndClaim(pos, waitTimes[i])

                local success, err = pcall(function()
                    UpdateStats()
                end)
                if not success then
                    warn("Update Problems: " .. tostring(err))
                end

                if pos == Weshky0 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        task.wait(2.3)
                        TriggerChest.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        task.wait(0.8)
                        goldBlocksGained = goldBlocksGained + 1
                        TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
                        -- workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky1 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky2 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky3 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky4 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky5 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky6 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky7 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky8 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

                if pos == Weshky9 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        workspace.ClaimRiverResultsGold:FireServer()
                    end
                end

            else
                warn("Warning Message: XC7C/X)C)/")
            end
        end
    end
end

function StopFarm()
    isFarming = false
end

function StartFarmBlock()
    isFarmingB = true
    while isFarmingB do
		task.wait(1)
		TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
		task.wait(2)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Weshky0.CFrame + Vector3.new(0, 2, 0)
		task.wait(3)
        goldBlocksGained = goldBlocksGained + 1

        local success, err = pcall(UpdateStats)
        if not success then
            warn("Fehler in UpdateStats: " .. tostring(err))
        end
        
		TriggerChest.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		task.wait(18)
		TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
    end
end


function StopFarmBlock()
    isFarmingB = false
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------- Anoying Stats System
---------------------------------------------------------------------------------------------------------------------------------------------------------------- Fuck It!!


local function FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local sec = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", hours, minutes, sec)
end

local function GetGoldLabel()
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        return player.PlayerGui:FindFirstChild("GoldGui") and player.PlayerGui.GoldGui:FindFirstChild("Frame") and player.PlayerGui.GoldGui.Frame:FindFirstChild("Amount")
    end
    return nil
end

local function UpdateStats()
    if not lastTime then
        lastTime = tick()
    end

    local elapsedTime = tick() - lastTime
    lastTime = tick()

    if isFarming or isFarmingB then
        totalFarmTime = totalFarmTime + elapsedTime
    end

    local goldLabel = GetGoldLabel()
    local currentGoldAmount = 0
    if goldLabel and goldLabel.Parent then
        currentGoldAmount = tonumber(goldLabel.Text) or 0
    else
        task.wait(0.05)
    end

    if not isInitialGoldSet and (isFarming or isFarmingB) then
        initialGold = currentGoldAmount
        isInitialGoldSet = true
    end

    local goldGained = 0
    if isInitialGoldSet then
        goldGained = currentGoldAmount - initialGold
    end

    -- Update stats
    Farmtime:Set("Total Farming Time: " .. FormatTime(totalFarmTime))
    TotalGold:Set("Total Gold: " .. tostring(currentGoldAmount))
    GoldGained2:Set("Obtained Gold: " .. tostring(goldGained))
    GoldBlocks:Set("Obtained Gold Blocks: " .. tostring(goldBlocksGained)) 
end

local function OnCharacterAdded()
    task.wait(0.5)
    repeat task.wait(0.1) until GetGoldLabel()
end

game.Players.LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)

if isFirstRun then
    GoldGained2:Set("Obtained Gold: 0")
    isFirstRun = false
end

while true do
    local success, err = pcall(UpdateStats)
    if not success then
        warn("Error updating stats: " .. err)
    end
    wait(0.1)
end

local function OnCharacterAdded()
    task.wait(0.5)
    repeat task.wait(0.1) until GetGoldLabel()
end

game.Players.LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)

if isFirstRun then
    GoldGained2:Set("Obtained Gold: 0")
    isFirstRun = false
end

while true do
    local success, err = pcall(UpdateStats)
    if not success then
        warn("Error updating stats: " .. err)
    end
    wait(0.1)
end

