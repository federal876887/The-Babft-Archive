local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/suntisalts/UiTest/refs/heads/main/Backup.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "⛵️ Weshky Hub (Beta)",
    SubTitle = "Build a Boat for Treasure", 
    TabWidth = 160,
    Size = UDim2.fromOffset(740, 480),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl 
})

local Tabs = { -- https://lucide.dev/icons/
    Weshky = Window:AddTab({ Title = "Weshky Discord", Icon = "mail-warning" }),
    Autobuild = Window:AddTab({ Title = "Autobuild", Icon = "building-2" }),
    Imageloader = Window:AddTab({ Title = "Image loader", Icon = "image" }),
    ListBlocks = Window:AddTab({ Title = "List Blocks", Icon = "layers" }),
    Autofarm = Window:AddTab({ Title = "Autofarm", Icon = "compass" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Automatically = Window:AddTab({ Title = "Automatically", Icon = "clipboard-check" }),
    Clientside = Window:AddTab({ Title = "Clientside", Icon = "share-2" }),
    Exclusive = Window:AddTab({ Title = "Exclusive", Icon = "gem" }),
    Trolling = Window:AddTab({ Title = "Trolling", Icon = "cloud-lightning" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
    Credits = Window:AddTab({ Title = "Credits", Icon = "users" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local HttpService = cloneref(game:GetService("HttpService"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local JobId = game.JobId
local PlaceId = game.PlaceId
local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")
local Lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer
local Nplayer = game.Players.LocalPlayer.Name
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

if not isfolder("WeshkyBuildStorage") then
    makefolder("WeshkyBuildStorage")
end

if not isfolder("BABFT/HelloImAsuImGay") then
    makefolder("BABFT/HelloImAsuImGay")
end

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- AUTPBUILD FUNCTIONS -------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

_G.extraantilag = false
_G.Speed = 1
_G.Autofarming = false
_G.BuildSize = 1

localPlayer = game.Players.LocalPlayer
playerGui = localPlayer:WaitForChild("PlayerGui")
playerListFrame = playerGui:WaitForChild("PlayerListGui"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
TeamOwner = game.Players.LocalPlayer

RunService = game:GetService("RunService")
Players = game:GetService("Players")
player = Players.LocalPlayer

totalGoldGained = 0
initialAmount = 0

humanoidRootPart = nil

Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
UserInputService = game:GetService("UserInputService")
Backpack = LocalPlayer.Backpack
Character = LocalPlayer.Character
Data = LocalPlayer.Data
Blocks = workspace.Blocks

blockamounts = {}
prices = {}

RotationX, RotationY, RotationZ = 0, 0, 0
LocalPlayer = Players.LocalPlayer

Data = LocalPlayer.Data

-- Constants
RADIANS_TO_DEGREES = 57.29577951308232
DEFAULT_BLOCK_SIZE = Vector3.new(2, 2, 2)

-- Localization
Color3new = Color3.new
Color3rgb = Color3.fromRGB
Vector3new = Vector3.new
CFramenew = CFrame.new
CFrameAng = CFrame.Angles

floor = math.floor
ceil = math.ceil
rad = math.rad

split = string.split
gsub = string.gsub
find = string.find

insert = table.insert

loadstring = loadstring
unpack = unpack

SetPrimaryPartCFrame = Instance.new("Model").SetPrimaryPartCFrame

FindFirstChild = workspace.FindFirstChild
GetDescendants = workspace.GetDescendants
GetChildren = workspace.GetChildren
Clone = workspace.Clone

ToEulerAnglesXYZ = CFrame.new().ToEulerAnglesXYZ
ToObjectSpace = CFrame.new().ToObjectSpace

Redthing = nil
AutoBuildPreview = nil
ReplicatedStorage = game:GetService("ReplicatedStorage")
HttpService = game:GetService("HttpService")
Players = game:GetService("Players")

BuildingParts = ReplicatedStorage.BuildingParts
WorkService = game.Workspace
TeamColorName = LocalPlayer.TeamColor.Name
Zone = WorkService[TeamColorName .. "Zone"]
User = TeamOwner
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
UserInputService = game:GetService("UserInputService")
Backpack = LocalPlayer.Backpack
Character = LocalPlayer.Character
RF_BuildingTool = (Backpack:FindFirstChild("BuildingTool") and Backpack.BuildingTool:FindFirstChild("RF")) or (Character:FindFirstChild("BuildingTool") and Character.BuildingTool:FindFirstChild("RF"))

RF_ScalingTool = (Backpack:FindFirstChild("ScalingTool") and Backpack.ScalingTool:FindFirstChild("RF")) or (Character:FindFirstChild("ScalingTool") and Character.ScalingTool:FindFirstChild("RF"))

RF_PaintingTool = (Backpack:FindFirstChild("PaintingTool") and Backpack.PaintingTool:FindFirstChild("RF")) or (Character:FindFirstChild("PaintingTool") and Character.PatingTool:FindFirstChild("RF"))

Data = LocalPlayer.Data
Blocks = workspace.Blocks
WorkService = game.Workspace
TeamColorName = LocalPlayer.TeamColor.Name
Zone = WorkService[TeamColorName .. "Zone"]
RunService = game:GetService("RunService")

-----------------------------------------------------------------------------------------------
---------------------------------- Main Functions ---------------------------------------------
-----------------------------------------------------------------------------------------------

local blockListElements = {}
local analysisResults = {
    totalLabel = nil,
    fileLabel = nil
}

local function updateBlockList(blocks, fileName)
    local sectionAdded = false  
    if not sectionAdded then
        local clearSection = Tabs.ListBlocks:AddSection("Blocks: ")
        sectionAdded = true
    end    
    for _, element in ipairs(blockListElements) do
        element:Destroy()
    end
    blockListElements = {}

    local totalCount = 0
    local blockEntries = {}

    -- Zuerst in eine sortierbare Tabelle einfügen
    for blockName, blockList in pairs(blocks) do
        local count = #blockList
        totalCount = totalCount + count
        table.insert(blockEntries, { name = blockName, count = count })
    end

    -- Nach Anzahl sortieren (größte zuerst)
    table.sort(blockEntries, function(a, b)
        return a.count > b.count
    end)

    -- Zeilen-Strings bauen
    local blockLines = {}
    for _, entry in ipairs(blockEntries) do
        table.insert(blockLines, string.format("%s: %d", entry.name, entry.count))
    end

    -- Title + Content (mit Zeilenumbruch vor dem Inhalt)
    local titleText = string.format('Block list from "%s", Total Block: %d', fileName, totalCount)
    local contentText = "\n" .. table.concat(blockLines, "\n")

    -- Ein einziges UI-Element
    local blockListLabel = Tabs.ListBlocks:AddParagraph({
        Title = titleText,
        Content = contentText,
        RichText = false
    })
    table.insert(blockListElements, blockListLabel)

    -- Optional: Labels für Übersicht
    if analysisResults.totalLabel then
        analysisResults.totalLabel:SetDesc(tostring(totalCount))
        analysisResults.totalLabel:SetDesc(tostring(totalCount))
    else
        --analysisResults.totalLabel = Tabs.ListBlocks:AddParagraph({
        --    Title = "Total Blocks:",
        --    Content = tostring(totalCount)
        --})
    end

    if analysisResults.fileLabel then
        analysisResults.fileLabel:SetDesc(fileName)
    else
        --analysisResults.fileLabel = Tabs.ListBlocks:AddParagraph({
        --    Title = "Selected File:",
        --    Content = fileName
        --})
    end

    Window:SelectTab(3)
    Fluent:Notify({
        Title = "Listing Complete",
        Content = "Loaded " .. totalCount .. " blocks",
        Duration = 3
    })
end


local function L_95_func(L_381_arg0)
	for L_382_forvar0, L_383_forvar1 in ipairs(game.Players:GetPlayers()) do
		if L_383_forvar1.DisplayName == L_381_arg0 then
			return L_383_forvar1
		end
	end
	return nil
end

local function L_96_func()
	local L_384_ = "No Team"
	if localPlayer.Team then
		L_384_ = localPlayer.Team.TeamColor.Name
	end
	local L_385_ = game.Players:FindFirstChild(localPlayer.Name):FindFirstChild("Settings"):FindFirstChild("ShareBlocks").Value
	if not L_385_ then
		TeamOwner = localPlayer.Name
	else
		for L_386_forvar0, L_387_forvar1 in ipairs(playerListFrame:GetChildren()) do
			local L_388_ = L_387_forvar1:FindFirstChild("PlayerName")
			local L_389_ = L_387_forvar1:FindFirstChild("PlayerRank")
			if L_388_ and L_389_ then
				local L_390_ = L_388_.Text
				local L_391_ = L_95_func(L_390_)
				if L_391_ and L_389_.Image == "rbxassetid://1912631373" then
					local L_392_ = "No Team"
					if L_391_.Team then
						L_392_ = L_391_.Team.TeamColor.Name
					end
					if L_392_ == L_384_ then
						TeamOwner = L_391_.Name
						break
					end
				end
			end
		end
	end

end

function BetaInstantLoad()
	L_96_func()
	local L_416_ = false

    -- Retrieve necessary services and tools
	local L_418_ = game:GetService("Players")
	local L_419_ = L_418_.LocalPlayer
	local LocalPlayer = L_419_.Backpack
	local L_421_ = L_419_.Character or L_419_.CharacterAdded:Wait()
	local GetBuildingTool = LocalPlayer:FindFirstChild("BuildingTool") and (LocalPlayer.BuildingTool:FindFirstChild("RF") or L_421_.BuildingTool:FindFirstChild("RF"))
	local GetScalingTool = LocalPlayer:FindFirstChild("ScalingTool") and (LocalPlayer.ScalingTool:FindFirstChild("RF") or L_421_.ScalingTool:FindFirstChild("RF"))
	local GetPaintingTool = LocalPlayer:FindFirstChild("PaintingTool") and (LocalPlayer.PaintingTool:FindFirstChild("RF") or L_421_.PaintingTool:FindFirstChild("RF"))
	local GetPropertiesTool = LocalPlayer:FindFirstChild("PropertiesTool") and (LocalPlayer.PropertiesTool:FindFirstChild("SetPropertieRF"))

    -- Retrieve data and blocks
	local L_426_ = L_419_:FindFirstChild("Data")
	local Workspace = game:GetService("Workspace")
	local Blocks = Workspace:FindFirstChild("Blocks")
	local PreviewBuild = Workspace:FindFirstChild("BuildPreview")
	local L_430_ = L_419_.TeamColor.Name
	local L_431_ = Workspace:FindFirstChild(L_430_ .. "Zone")

    -- Table to store collected parts
	local L_432_ = {}
	local L_433_ = {}
	local L_434_ = {}
	local function L_435_func()
		L_432_ = {}
		L_433_ = {}
		L_434_ = {}
		if L_416_ then
			return
		end
		if PreviewBuild then
			for L_450_forvar0, L_451_forvar1 in pairs(PreviewBuild:GetChildren()) do
				for L_452_forvar0, L_453_forvar1 in pairs(L_451_forvar1:GetChildren()) do
					if L_453_forvar1.Name == "PPart" and L_453_forvar1.Parent then
						local L_454_ = L_451_forvar1.Name:lower()
						local L_455_ = L_453_forvar1.Transparency
						local L_456_ = L_455_ or nil
						local L_457_ = {
							Part = L_453_forvar1,
							ParentName = L_453_forvar1.Parent.Name,
							CFrame = L_453_forvar1.CFrame,
							Size = L_453_forvar1.Size,
							TransparencyLevel = L_456_,
							Collision = L_453_forvar1.CanCollide,
							Shadow = L_453_forvar1.CastShadow,
							DataValue = L_426_ and L_426_:FindFirstChild(L_453_forvar1.Name) and L_426_[L_453_forvar1.Name].Value or nil
						}
						table.insert(L_432_, L_457_)
						table.insert(L_434_, L_453_forvar1.Color)
					end
				end
			end
		end
	end

    -- Function to invoke the BuildingTool remote function
	local function L_436_func(L_458_arg0, L_459_arg1, L_460_arg2)
		local L_461_ = {
			[1] = L_458_arg0,
			[2] = L_459_arg1,
			[5] = true,
			[6] = L_460_arg2,
			[7] = false
		}
		GetBuildingTool:InvokeServer(unpack(L_461_))
	end

    -- Function to invoke the ScalingTool remote function
	local function L_437_func(L_462_arg0, L_463_arg1, L_464_arg2)
		local L_465_ = {
			[1] = L_462_arg0,
			[2] = L_463_arg1,
			[3] = L_464_arg2
		}
		GetScalingTool:InvokeServer(unpack(L_465_))
	end

    -- Function to invoke the PaintingTool remote function
	local function L_438_func(L_466_arg0)
		GetPaintingTool:InvokeServer(L_466_arg0)
	end

    -- Function to set properties using the PropertiesTool remote function
	local function L_439_func(L_467_arg0, L_468_arg1)
		local L_469_ = {
			[1] = L_467_arg0,
			[2] = L_468_arg1
		}
		GetPropertiesTool:InvokeServer(unpack(L_469_))
	end

    -- Function to rename a block instance
	local function L_440_func(L_470_arg0, L_471_arg1)
		L_470_arg0.Name = L_471_arg1
	end

    -- Function to process each part
	local function L_441_func(L_472_arg0, L_473_arg1)
		local L_474_ = L_472_arg0.ParentName
		local L_475_ = L_426_ and L_426_:FindFirstChild(L_474_) and L_426_[L_474_].Value or nil
		local L_476_ = 1000 + (L_473_arg1 * 1)
		local L_477_ = string.find(L_474_:lower(), "block") and L_431_.CFrame * CFrame.new(0, L_476_, 0) or L_472_arg0.CFrame
		L_436_func(L_474_, L_475_, L_477_)
	end

-- Initialize a counter variable
	local ProgressUsed = 0

-- Function to process each part after scaling
	local function L_443_func(L_478_arg0, L_479_arg1)
    -- Increment the counter each time the function is called
		ProgressUsed = ProgressUsed + 1
		local L_480_ = L_478_arg0.ParentName
		local L_481_ = Blocks:FindFirstChild(TeamOwner)
		local L_482_ = L_481_ and L_481_:FindFirstChild(L_480_)
		local L_483_ = L_482_ and L_482_.Name or "Unknown"
		local L_484_ = {}
		if L_482_ then
			local L_485_ = L_480_ .. tostring(L_479_arg1)
			L_440_func(L_482_, L_485_)
			L_437_func(L_482_, L_478_arg0.Size, L_478_arg0.CFrame)
			table.insert(L_484_, {
				L_482_,
				L_478_arg0.Color
			})
			if L_434_ and # L_434_ > 0 then
				local L_486_ = L_434_[L_479_arg1]
				table.insert(L_433_, {
					L_482_,
					L_486_
				})
			else
				warn("Test table is not defined or is empty")
			end
		end
		task.defer(
        function()
			if L_482_ then
				L_440_func(L_482_, L_483_)
			end
		end)
	end
	local function L_444_func()
		local startTime = tick()
		while tick() - startTime < 25 do 
			L_438_func(L_433_)
		end
	end

-- Function to process all parts
	local function ProcessAllParts()
		for L_487_forvar0, L_488_forvar1 in ipairs(L_432_) do
			task.spawn(
            function()
				L_441_func(L_488_forvar1, L_487_forvar0)
				task.defer(
                    function()
					L_443_func(L_488_forvar1, L_487_forvar0)
				end)
			end)
		end

    -- Ensure all parts have been processed
		repeat
			task.wait(0.5)
		until # L_432_ == ProgressUsed
		if # L_432_ == ProgressUsed then
			L_432_ = {}
            Fluent:Notify({
                Title = "Auto Build Information",
                Content = "",
                SubContent = "The Build has Benn Builded, please wait until the color Fully Loaded.",
                Duration = 5
            })
			L_444_func()
			ProgressUsed = 0
		end
	end


    -- Function to start the process
	local function L_446_func()
		if PreviewBuild and # PreviewBuild:GetChildren() == 0 then
            Fluent:Notify({
                Title = "Auto Build Information",
                Content = "",
                SubContent = "Please Preview the Build Before Loading it.",
                Duration = 5
            })
			L_416_ = true
			return
		end
		L_435_func()
		if PreviewBuild then
			for L_489_forvar0, L_490_forvar1 in pairs(PreviewBuild:GetChildren()) do
				task.spawn(
                    function()
					L_490_forvar1:Destroy()
					task.wait()
				end)
			end
		end
	end

    -- Start the process
	L_446_func()

    -- If not stopped, proceed with processing all parts
	if not L_416_ then
		-- NOTIFY: BUILD WILL START SHORTLY
		ProcessAllParts()
	end
end

local Teams = {
	["magenta"] = workspace["MagentaZone"],
	["yellow"] = workspace["New YellerZone"],
	["black"] = workspace["BlackZone"],
	["white"] = workspace["WhiteZone"],
	["green"] = workspace["CamoZone"],
	["blue"] = workspace["Really blueZone"],
	["red"] = workspace["Really redZone"]
}

function ClearPreview()
	AutoBuildPreview:ClearAllChildren()
end

if workspace:FindFirstChild("BuildPreview") then
	AutoBuildPreview = workspace.BuildPreview
else
	AutoBuildPreview = Instance.new("Model")
	AutoBuildPreview.Name = "BuildPreview"
	AutoBuildPreview.Parent = workspace
end

if workspace:FindFirstChild("BuildPreview"):FindFirstChild("BuildPreviewHighlight") then
	Redthing = workspace.BuildPreview.BuildPreviewHighlight
else
	Redthing = Instance.new("Highlight")
	Redthing.Name = "BuildPreviewHighlight"
	Redthing.Parent = workspace.BuildPreview or AutoBuildPreview
	Redthing.FillColor = Color3.fromRGB(100, 0, 0)
	Redthing.OutlineColor = Color3.fromRGB(0, 0, 0)
end

local function memoize(funct)
	local cached = setmetatable({}, {
		__mode = "v"
	})
	return function(a)
		local b = cached[a] or funct(a)
		cached[a] = b
		return b
	end
end

local intToRGBA
do
	local A, B, C = 16777216, 65536, 256
	intToRGBA = function(i)
		local r = floor(i / A)
		local g = floor((i - (r * A)) / B)
		local b = floor((i - (r * A) - (g * B)) / C)
		return {
			Color = Color3rgb(r, g, b), -- Rgb
			Alpha = floor((i - (r * A) - (g * B) - (b * V)) / 1) -- Alpha
		}
	end
end

intToRGBA = memoize(intToRGBA)

function AnglesString(L_572_arg0)
	local L_573_ = split(L_572_arg0, ",")
	return CFrameAng(rad(L_573_[1]), rad(L_573_[2]), rad(L_573_[3]))
end

function String(x)
	return gsub(tostring(x), " ", "")
end

--String = memoize(String)

function Raw(x)
	return unpack(split(x, ","))
end

--Raw = memoize(Raw)

function Floor(x, y)
	return floor((x * (10 ^ y)) + 0.5) / (10 ^ y)
end

function GetStringAngles(cframe)
	local X, Y, Z = ToEulerAnglesXYZ(cframe)
	X = X * RADIANS_TO_DEGREES
	Y = Y * RADIANS_TO_DEGREES
	Z = Z * RADIANS_TO_DEGREES
	return Floor(X, 5) .. "," .. Floor(Y, 5) .. "," .. Floor(Z, 5)
end

--GetStringAngles = memoize(GetStringAngles)

function GetAngles(cframe)
	local X, Y, Z = ToEulerAnglesXYZ(cframe)
	return CFrameAng(C, Y, Z)
end

--GetAngles = memoize(GetAngles)

function GetTeam()
	return tostring(LocalPlayer.Team)
end

function GetPlot()
	return Teams[tostring(LocalPlayer.Team)]
end

function GetTeamPlayers(team)
	local players = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if tostring(player.Team) == team then
			table.insert(players, player.Name)
		end
	end
	return players
end

function GetBlocks(team)
	local L_591_ = GetTeamPlayers(team)
	local players = {}
	for L_593_forvar0, L_594_forvar1 in ipairs(L_591_) do
		local L_595_ = workspace.Blocks:FindFirstChild(L_594_forvar1)
		if L_595_ then
			for L_596_forvar0, block in ipairs(L_595_:GetChildren()) do
				if block:FindFirstChild("Health") then
					table.insert(players, block)
				end
			end
		end
	end
	return players
end

function GetTeamBlocks(team)
	return GetBlocks(team)
end

function GetPlayerBlocks(L_599_arg0)
	return game.workspace.Blocks:FindFirstChild(L_599_arg0):GetChildren()
end

function GetPreviewBlocks()
	local Blocks = {}
	for _, block in next, GetChildren(AutoBuildPreview) do
		insert(Blocks, block)
	end
	return Blocks
end

function GetTool(name)
	return (FindFirstChild(LocalPlayer.Backpack, name) and LocalPlayer.Backpack[name].RF) or (FindFirstChild(LocalPlayer.Character, name) and LocalPlayer.Character[name].RF)
end

function Encode(blocks, team)
	local jsonTable = {}
	local teamPlate = team and Teams[team] or GetPlot()
	for _, v in ipairs(blocks) do
		local blockName = v.Name
		local PPart = v:FindFirstChild("PPart")

        -- Skip if PPart is not found
		if not PPart then
			continue
		end
		if not jsonTable[blockName] then
			jsonTable[blockName] = {}
		end
		local spacePosition = teamPlate.CFrame:ToObjectSpace(PPart.CFrame)

        -- Insert block data into jsonTable
		table.insert(
            jsonTable[blockName], {
			Rotation = GetStringAngles(spacePosition),
			Position = String(spacePosition.p),

			ShowShadow = PPart.CastShadow or true,
			CanCollide = PPart.CanCollide or true,
			Anchored = PPart.Anchored or true,

			Transparency = PPart.Transparency > 0 and PPart.Transparency or nil,
			Size = string.find(blockName, "Block") and PPart.Size ~= Vector3new(2, 2, 2) and String(PPart.Size) or nil,
			Color = PPart.Color ~= BuildingParts[blockName].PPart.Color and String(PPart.Color) or nil
		})
	end
	return HttpService:JSONEncode(jsonTable)
end

function Decode(json, size)
	local normalTable = {}
	size = size or 1
	local validJSON = xpcall(
        function()
			normalTable = HttpService:JSONDecode(json)
	end, function()
		warn("Invalid JSON")
	end)
	if (not validJSON) then
		return {}
	end
	for block, table in next, normalTable do
		if (FindFirstChild(BuildingParts, block)) then
			for i, v in next, table do
				local cloneTable = normalTable[block][i]
				cloneTable.Position = CFramenew(Vector3new(Raw(v.Position)) * size)
				cloneTable.Rotation = AnglesString(v.Rotation)
				cloneTable.Color = v.Color and Color3new(Raw(v.Color)) or nil
				cloneTable.Size = v.Size and v.Size ~= "2,2,2" and Vector3new(Raw(v.Size)) * size or nil
				normalTable[block][i] = cloneTable
			end
		else
			normalTable[block] = nil
		end
	end
	return normalTable
end

function Convert(file)
	local HttpService = game:GetService("HttpService") -- Get HttpService for JSON encoding
	local fileContent, jsonTable = readfile(file), {}

	if not fileContent:find("/") then
		return nil
	end

	local myPlot = GetPlot()

	for _, v in next, fileContent:split("/") do
		local info = v:split(":")
		if # info == 5 and FindFirstChild(BuildingParts, info[5]) then
			if not jsonTable[info[5]] then
				jsonTable[info[5]] = {}
			end
			local position = CFramenew(Raw(info[1])) * AnglesString(info[2])
			position = ToObjectSpace(CFramenew(0, - 17.9999924, 0), position)
			local showShadow  = info[7] == "true" and true or false
			local canCollide  = info[8] == "true" and true or false
			table.insert(
                jsonTable[info[5]], {
				Color = info[3] ~= "-" and info[3] or nil,
				Size = info[4] ~= "-" and info[4] or nil,
				Position = String(position.p),
				Rotation = GetStringAngles(position),
				Transparency = info[6] and tonumber(info[6]) or nil,
				ShowShadow = showShadow ,
				CanCollide = canCollide ,
				Anchored = true
                    -- Add other properties as needed
			})
		end
	end
	jsonTable = HttpService:JSONEncode(jsonTable)

    -- Uncomment this later (Preventing from having to Convert every time)
    -- writefile(file, jsonTable)
	return jsonTable
end

function SavePlot(file, team)
    if not file or not team then
        --warn("Fehlende Datei oder Teamangabe!")
        return
    end
    
    --print("Versuche Build zu speichern...")
    --print("Dateiname:", file)
    --print("Team:", team)
    
    local Blocks = GetTeamBlocks(team)
    if not Blocks or #Blocks == 0 then
        --warn("Keine Blöcke im Team gefunden!")
        return
    end
    
    local jsonTable = Encode(Blocks, team)
    if not jsonTable then
        --warn("Fehler beim Kodieren der Blöcke!")
        return
    end
    
    local filePath = "WeshkyBuildStorage/" .. file
    --print("Speichere unter:", filePath)
    
    if not isfolder("WeshkyBuildStorage") then
        makefolder("WeshkyBuildStorage")
    end
    
    local success, err = pcall(function()
        writefile(filePath, jsonTable)
    end)
    
    if success then
        Fluent:Notify({
            Title = "Build got Saved",
            Content = "The Build got Successfully in "..file.." Saved.",
            Duration = 5
        })
    else
        warn("Fehler beim Speichern:", err)
        Fluent:Notify({
            Title = "Save Problem",
            Content = "The Build Didnt got Saved: "..tostring(err),
            Duration = 5
        })
    end
end

function PreviewFile(file, size, team)
	if workspace:FindFirstChild("BuildPreview"):FindFirstChild("BuildPreviewHighlight") then
		Redthing.Parent = workspace.BuildPreview
	else
		Redthing = Instance.new("Highlight")
		Redthing.Name = "BuildPreviewHighlight"
		Redthing.Parent = workspace.BuildPreview or AutoBuildPreview
		Redthing.FillColor = Color3.fromRGB(100, 0, 0)
		Redthing.OutlineColor = Color3.fromRGB(0, 0, 0)
	end
	local jsonTable = Convert(file) or readfile(file)
	local blockInfo = Decode(jsonTable, size)
	local myPlot = team and Teams[team] or GetPlot()
	for blockType, table in pairs(blockInfo) do
		for _, block in pairs(table) do
			task.spawn(
                function()
				local clonedBlock = Clone(BuildingParts[blockType])
				local newPosition = myPlot.CFrame * (block.Position * block.Rotation)
				SetPrimaryPartCFrame(clonedBlock, newPosition)
				clonedBlock.Health.Value = ""
				clonedBlock.Parent = AutoBuildPreview
				clonedBlock.PPart.Size = block.Size or clonedBlock.PPart.Size
				clonedBlock.PPart.Anchored = true
				clonedBlock.PPart.Transparency = 0 --block.Transparency or 0
                    --clonedBlock.PPart.Transparency = 0
				clonedBlock.PPart.CastShadow = block.ShowShadow or false
				clonedBlock.PPart.CanCollide = block.CanCollide or false
				if block.Color then
					for _, v in pairs(GetDescendants(clonedBlock)) do
						if v:IsA("BasePart") then
							v.Color = block.Color
						end
					end
				end
				task.wait()
			end)
		end
	end
end

local Primary = Instance.new("Part", AutoBuildPreview)
do
	Primary.Transparency = 1
	Primary.Anchored = true
	Primary.CanCollide = false
end

function reflectVec(v, axis)
	return v - 2 * (axis * v:Dot(axis))
end

function ReflectCFrame(originalCFrame, mirrorCFrame, reflectVector)
    local mirrorPosition = mirrorCFrame.Position

    local mirrorNormal = mirrorCFrame.LookVector

    local originalPosition = originalCFrame.Position
    local originalX, originalY, originalZ = originalPosition.X, originalPosition.Y, originalPosition.Z

    local reflectedPosition = mirrorPosition + reflectVector(Vector3.new(originalX, originalY, originalZ) - mirrorPosition, mirrorNormal)

    local originalXVector = originalCFrame.XVector
    local originalYVector = originalCFrame.YVector
    local originalZVector = originalCFrame.ZVector

    originalXVector = -reflectVector(originalXVector, mirrorNormal)
    originalYVector = reflectVector(originalYVector, mirrorNormal)
    originalZVector = reflectVector(originalZVector, mirrorNormal)

    return CFrame.new(
        reflectedPosition.X, reflectedPosition.Y, reflectedPosition.Z,
        originalXVector.X, originalYVector.X, originalZVector.X,
        originalXVector.Y, originalYVector.Y, originalZVector.Y,
        originalXVector.Z, originalYVector.Z, originalZVector.Z
    )
end

function CenterBuild()
    local teamZone = team and Teams[team] or GetPlot()
    local boundingBoxCenter, boundingBoxSize = AutoBuildPreview:GetBoundingBox()
    local teamZoneCFrame = teamZone.CFrame

    Primary.CFrame = boundingBoxCenter
    Primary.Parent = AutoBuildPreview
    AutoBuildPreview.PrimaryPart = Primary

    local offset = CFrame.new(0, 100, 0)
    AutoBuildPreview:SetPrimaryPartCFrame(teamZoneCFrame * offset)

    Primary.Parent = workspace
end

function UpdatePreview(offset)
    local boundingBoxCenter, boundingBoxSize = AutoBuildPreview:GetBoundingBox()

    offset = offset or Vector3.new()

    local newCFrame = (offset and CFrame.new(boundingBoxCenter.Position) or boundingBoxCenter) *
                      CFrame.Angles(math.rad(RotationX), math.rad(RotationY), math.rad(RotationZ)) +
                      offset

    Primary.CFrame = boundingBoxCenter
    Primary.Parent = AutoBuildPreview
    AutoBuildPreview.PrimaryPart = Primary

    AutoBuildPreview:SetPrimaryPartCFrame(newCFrame)

    Primary.Parent = workspace
end

-----------------------------------------------------------------------------------------------
--------------------------------------- Main --------------------------------------------------
-----------------------------------------------------------------------------------------------

local L_841_, L_842_ = nil, nil

local section = Tabs.Autobuild:AddSection("Save Build: ")

local Teamsel = Tabs.Autobuild:AddDropdown("Dropdown", {
    Title = "Selecte Team",
    Values = {"My Team", "white", "blue", "green", "red", "black", "yellow", "magenta"},
    Multi = false,
    Default = "My Team",
})

Teamsel:OnChanged(function(Value)
    if Value == "My Team" then
        Value = game.Players.LocalPlayer.Team.Name
    end
    L_842_ = Value
end)

local SaveName = Tabs.Autobuild:AddInput("Input", {
    Title = "File Name",
    Default = "",
    Placeholder = "Enter File Name",
    Numeric = false,
    Finished = false, -- Nur bei Enter gedrückt
    Callback = function(Value)
        L_841_ = Value .. ".Build"
    end
})

local lastSaveTime = 0

Tabs.Autobuild:AddButton({
    Title = "Save Build",
    Description = "",
    Callback = function()
        if tick() - lastSaveTime < 2 then  -- 2 Sekunden Cooldown
            Fluent:Notify({
                Title = "Please Wait",
                Content = "Wait Some Seconds before saving a new Build",
                Duration = 2
            })
            return
        end
        lastSaveTime = tick()
        SavePlot(L_841_, L_842_)
    end  
})

---------------------------------------------------------------------- Preview Stuff
---------------------------------------------------------------------- Preview Stuff

local selectedFile = nil

local section = Tabs.Autobuild:AddSection("Selecte Build: ")

local buildFilesDropdown = Tabs.Autobuild:AddDropdown("Dropdown", {
    Title = "Build Files",
    Values = {},
    Multi = false,
    Default = "Select"
})

local fileEntries = {}
local alphabeticalOrder = true

local loadingUI = Instance.new("ScreenGui")
loadingUI.Name = "BuildLoaderUI"
loadingUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
loadingUI.IgnoreGuiInset = true

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 1, 0, 1)
loadingFrame.Position = UDim2.new(0, 10, 1, -50)
loadingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
loadingFrame.BackgroundTransparency = 1
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = loadingUI

Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 10)

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 1, 1, 1)
loadingText.Position = UDim2.new(0.5, -100, 0.5, -10)
loadingText.BackgroundTransparency = 1
loadingText.TextColor3 = Color3.new(1, 1, 1)
loadingText.TextScaled = true
loadingText.Text = "loading files 0%"
loadingText.Parent = loadingFrame

local sortToggle = Instance.new("TextButton")
sortToggle.Size = UDim2.new(0, 1, 0, 1)
sortToggle.Position = UDim2.new(0, 120, 0, 10)
sortToggle.TextTransparency = 1
sortToggle.Text = "Sort: Alphabetical"
sortToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
sortToggle.TextColor3 = Color3.new(1, 1, 1)
sortToggle.Parent = loadingUI

sortToggle.MouseButton1Click:Connect(function()
    alphabeticalOrder = not alphabeticalOrder
    sortToggle.Text = alphabeticalOrder and "Sort: Alphabetical" or "Sort: Size"
    refreshBuildFiles()
end)

local function isAlphanumeric(str)
    return str:match("^[%w%s]+$") ~= nil
end

local function formatFileSize(size)
    if size < 1024 then
        return string.format("%d bytes", size)
    elseif size < 1024 * 1024 then
        return string.format("%.1f KB", size / 1024)
    elseif size < 1024 * 1024 * 1024 then
        return string.format("%.1f MB", size / (1024 * 1024))
    else
        return string.format("%.1f GB", size / (1024 * 1024 * 1024))
    end
end

local function getFileSize(filePath)
    local size = 0
    local success, content = pcall(readfile, filePath)
    if success and content then
        size = #content
    end
    return size
end

local function parseBuildFile(filePath)
    local fileName = string.match(filePath, "([^/\\]+)%.Build$")
    if fileName then
        local size = getFileSize(filePath)
        local formattedSize = (size > 0) and formatFileSize(size) or "corrupt"
        return {
            name = fileName,
            size = size,
            formattedSize = formattedSize,
            path = filePath
        }
    end
    return nil
end

buildFilesDropdown:OnChanged(function(Value)
    selectedFile = string.match(Value, "^(.-)%s*%-%s*")
    if selectedFile then
        print("Selected build file:", selectedFile)
    end
end)

local function refreshBuildFiles()
    loadingFrame.Visible = true
    fileEntries = {}
    
    local allFiles = {}
    local seenFiles = {} 
    
    local function addUniqueFiles(files)
        for _, filePath in ipairs(files) do
            local fileName = string.match(filePath, "([^/\\]+)%.Build$")
            if fileName and not seenFiles[fileName] then
                seenFiles[fileName] = true
                table.insert(allFiles, filePath)
            end
        end
    end
    
    addUniqueFiles(listfiles("WeshkyBuildStorage/") or {})
    addUniqueFiles(listfiles("") or {})
    
    local validFiles = {}
    local totalFiles = #allFiles
    local processedFiles = 0
    local batchSize = 5
    
    local function processBatch(startIndex)
        local endIndex = math.min(startIndex + batchSize - 1, totalFiles)
        for i = startIndex, endIndex do
            local filePath = allFiles[i]
            if string.sub(filePath, -6) == ".Build" then
                local fileInfo = parseBuildFile(filePath)
                if fileInfo then
                    table.insert(validFiles, fileInfo)
                end
            end
            processedFiles = processedFiles + 1
            local progress = math.floor((processedFiles / totalFiles) * 100)
            loadingText.Text = "loading files " .. progress .. "%"
        end
    end
    
    local function finalizeList()
        if alphabeticalOrder then
            table.sort(validFiles, function(a, b)
                local aValid = isAlphanumeric(a.name)
                local bValid = isAlphanumeric(b.name)
                if aValid ~= bValid then
                    return aValid 
                end
                return a.name:lower() < b.name:lower()
            end)
        else
            table.sort(validFiles, function(a, b)
                return a.size > b.size
            end)
        end
        
        local dropdownOptions = {}
        for _, file in ipairs(validFiles) do
            table.insert(dropdownOptions, string.format("%s - %s", file.name, file.formattedSize))
        end
        
        buildFilesDropdown:SetValues(dropdownOptions)
        fileEntries = validFiles
        loadingFrame.Visible = false
    end
    
    local currentIndex = 1
    local function processNextBatch()
        if currentIndex <= totalFiles then
            task.spawn(function()
                processBatch(currentIndex)
                currentIndex = currentIndex + batchSize
                task.wait()
                processNextBatch()
            end)
        else
            finalizeList()
        end
    end
    
    processNextBatch()
end

task.spawn(refreshBuildFiles)

Tabs.Autobuild:AddButton({
    Title = "Refresh List",
    Description = "",
    Callback = function()
        refreshBuildFiles()
    end  
})

Tabs.Autobuild:AddButton({
    Title = "List Blocks",
    Description = "",
    Callback = function()
        if not selectedFile then
            Fluent:Notify({
                Title = "Warning",
                Content = "Please select a file first",
                Duration = 5
            })
            return
        end
        
        local filePaths = {
            "WeshkyBuildStorage/" .. selectedFile .. ".Build",
            selectedFile .. ".Build",
            "WeshkyBuildStorage/" .. selectedFile,
            selectedFile
        }
        
        local foundFile
        for _, path in ipairs(filePaths) do
            if isfile(path) then
                foundFile = path
                break
            end
        end
        
        if foundFile then
            local content = readfile(foundFile)
            local success, decoded = pcall(function()
                return HttpService:JSONDecode(content)
            end)
            
            if success and decoded then
                Window:SelectTab(3) 
                updateBlockList(decoded, selectedFile)
            else
                Fluent:Notify({
                    Title = "Error",
                    Content = "Invalid build file",
                    SubContent = "The file may be corrupted",
                    Duration = 5
                })
            end
        else
            Fluent:Notify({
                Title = "Error",
                Content = "File not found",
                SubContent = selectedFile,
                Duration = 5
            })
        end
    end
})

local section = Tabs.Autobuild:AddSection("Preview Build: ")

Tabs.Autobuild:AddButton({
    Title = "Preview Build",
    Description = "",
    Callback = function()
        if not selectedFile then
            Fluent:Notify({
                Title = "Warning",
                Content = "Please Selecte a File",
                Duration = 5
            })
            return
        end
        
        local filePaths = {
            "WeshkyBuildStorage/" .. selectedFile .. ".Build",
            selectedFile .. ".Build",
            "WeshkyBuildStorage/" .. selectedFile,
            selectedFile
        }
        
        local foundFile
        for _, path in ipairs(filePaths) do
            if isfile(path) then
                foundFile = path
                break
            end
        end
        
        if foundFile then
            ClearPreview()
            PreviewFile(foundFile, _G.BuildSize)
            Fluent:Notify({
                Title = "Previewing File",
                Content = "Previewing Build: '"..selectedFile.."' ",
                Duration = 5
            })
        else
            Fluent:Notify({
                Title = "Auto Build Information",
                Content = "Build not found or Corrupted: "..selectedFile,
                Duration = 5
            })
        end
    end  
})

Tabs.Autobuild:AddButton({
    Title = "Clear Preview",
    Description = "",
    Callback = function()
        if # AutoBuildPreview:GetChildren() > 0 then
            ClearPreview()
        end
    end
})

local section = Tabs.Autobuild:AddSection("Autobuild: ")

Tabs.Autobuild:AddButton({
    Title = "Build Selected File",
    Description = "",
    Callback = function()
        if not selectedFile then
            PreviewFile(foundFile, _G.BuildSize)
                -- Useless
            return
        end
        
        local filePaths = {
            "WeshkyBuildStorage/" .. selectedFile .. ".Build",
            selectedFile .. ".Build",
            "WeshkyBuildStorage/" .. selectedFile,
            selectedFile
        }
        
        local foundFile
        for _, path in ipairs(filePaths) do
            if isfile(path) then
                foundFile = path
                break
            end
        end
        
        if foundFile then
            ClearPreview()
            PreviewFile(foundFile, _G.BuildSize)
            --task.wait(0.1)
            BetaInstantLoad()
        end
    end  
})

Tabs.Autobuild:AddButton({
    Title = "Delete Entired Plot",
    Description = "",
    Callback = function()
        workspace:WaitForChild("ClearAllPlayersBoatParts"):FireServer()
    end
})

local section = Tabs.Autobuild:AddSection("Adjusters: ")

local L_852_ = 5

local MultiMove = Tabs.Autobuild:AddInput("Input", {
    Title = "Move Multiplier",
    Default = "5",
    Placeholder = "Enter File Name",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        L_852_ = Value
    end
})

Tabs.Autobuild:AddButton({
    Title = "Center Build (Buggy)",
    Description = "",
    Callback = function()
        CenterBuild()
    end
})

Tabs.Autobuild:AddButton({
    Title = "Move Up",
    Description = "",
    Callback = function()
        UpdatePreview(Vector3new(0, L_852_, 0))
    end
})

Tabs.Autobuild:AddButton({
    Title = "Move Down",
    Description = "",
    Callback = function()
        UpdatePreview(Vector3new(0, - L_852_, 0))
    end
})

Tabs.Autobuild:AddButton({
    Title = "Move Left",
    Description = "",
    Callback = function()
        UpdatePreview(Vector3new(L_852_, 0, 0))
    end
})

Tabs.Autobuild:AddButton({
    Title = "Move Right",
    Description = "",
    Callback = function()
        UpdatePreview(Vector3new(- L_852_, 0, 0))
    end
})

Tabs.Autobuild:AddButton({
    Title = "Move Forwards",
    Description = "",
    Callback = function()
        UpdatePreview(Vector3new(0, 0, L_852_))
    end
})

Tabs.Autobuild:AddButton({
    Title = "Move Backwards",
    Description = "",
    Callback = function()
        UpdatePreview(Vector3new(0, 0, - L_852_))
    end
})

local section = Tabs.Autobuild:AddSection("Rotation Adjusters:")

-- Slider für X-Rotation
Tabs.Autobuild:AddSlider("RotationXSlider", {
    Title = "X Rotation",
    Description = "",
    Default = 0,
    Min = -180,
    Max = 180,
    Rounding = 1,
    Callback = function(value)
        RotationX = value
        UpdatePreview()
    end
})

-- Slider für Y-Rotation
Tabs.Autobuild:AddSlider("RotationYSlider", {
    Title = "Y Rotation",
    Description = "",
    Default = 0,
    Min = -180,
    Max = 180,
    Rounding = 1,
    Callback = function(value)
        RotationY = value
        UpdatePreview()
    end
})

-- Slider für Z-Rotation
Tabs.Autobuild:AddSlider("RotationZSlider", {
    Title = "Z Rotation",
    Description = "",
    Default = 0,
    Min = -180,
    Max = 180,
    Rounding = 1,
    Callback = function(value)
        RotationZ = value
        UpdatePreview()
    end
})

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------- IMAGELOADER FUNCTIONS ------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------- LISTBLOCKS FUNCTIONS -------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

--local clearSection = Tabs.ListBlocks:AddSection("Importand: ")

--[[
Tabs.ListBlocks:AddButton({
    Title = "List Blocks",
    Description = "\n1. Please Selecte a Build file and Press List Blocks.\n2. List Blocks mostly only works on at Build that got Saved by Weshky Autobuild.",
    Callback = function()
        if not selectedFile then
            Fluent:Notify({
                Title = "Warning",
                Content = "Please select a file first",
                Duration = 5
            })
            return
        end
        
        local filePaths = {
            "WeshkyBuildStorage/" .. selectedFile .. ".Build",
            selectedFile .. ".Build",
            "WeshkyBuildStorage/" .. selectedFile,
            selectedFile
        }
        
        local foundFile
        for _, path in ipairs(filePaths) do
            if isfile(path) then
                foundFile = path
                break
            end
        end
        
        if foundFile then
            local content = readfile(foundFile)
            local success, decoded = pcall(function()
                return HttpService:JSONDecode(content)
            end)
            
            if success and decoded then
                Window:SelectTab(3) 
                updateBlockList(decoded, selectedFile)
            else
                Fluent:Notify({
                    Title = "Error",
                    Content = "Invalid build file",
                    SubContent = "The file may be corrupted",
                    Duration = 5
                })
            end
        else
            Fluent:Notify({
                Title = "Error",
                Content = "File not found",
                SubContent = selectedFile,
                Duration = 5
            })
        end
    end
})

--]]

--analysisResults.fileLabel = Tabs.ListBlocks:AddParagraph({
--    Title = "Selected File:",
--    Content = "None"
--})

--analysisResults.totalLabel = Tabs.ListBlocks:AddParagraph({
--    Title = "Total Blocks:",
--    Content = "0"
--})

local clearSection = Tabs.ListBlocks:AddSection("Importand: ")

analysisResults.NiggaSecond = Tabs.ListBlocks:AddParagraph({
    Title = "Informations: ",
    Content = "1. Selecte a Build File and press List Blocks.\n2. Many files are broken and cannot be listed."
})

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- AUTOFARM FUNCTIONS --------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

local startTime = 0
local totalFarmTime = 0
local isTrackingTime = false
local lastUpdate = 0
local FarmedGoldBlocks = 0
local initialGold = 0
local currentGold = 0

isFarming = false
isFarmingB = false 

local section = Tabs.Autofarm:AddSection("Farm Optionen:")

local autoFarmToggle = Tabs.Autofarm:AddToggle("AutoFarmToggle", {
    Title = "Normal Autofarm",
    Description = "After You Turned Gold Autofarm off wait until the current run Stops",
    Default = false,
    Callback = function(state)
        if state then
            print("Start")
            startTime = tick()
            isTrackingTime = true
            lastUpdate = startTime
            StartFarmNormal()
            Fluent:Notify({
                Title = "Autofarm Has Been Started",
                Content = "",
                SubContent = "Autofarm will start shortly. Remember to activate Anti-AFK if you're farming for an extended period.",
                Duration = 5
            })
        else
            print("Stop")
            isTrackingTime = false
            StopFarm()
            Fluent:Notify({
                Title = "Autofarm Has Been Stoped",
                Content = "",
                SubContent = "Please wait a few seconds until the current run finishes.",
                Duration = 5
            })
        end
    end
})

local autoFarmblockToggle = Tabs.Autofarm:AddToggle("AutoFarmBlockToggle", {
    Title = "Block Autofarm",
    Description = "Toggle Gold Block Autofarm On/Off",
    Default = false,
    Callback = function(state)
        if state then
            startTime = tick()
            isTrackingTime = true
            lastUpdate = startTime
            StartFarmBlock()
            Fluent:Notify({
                Title = "Autofarm Has Been Started",
                Content = "",
                SubContent = "Autofarm will start shortly. Remember to activate Anti-AFK if you're farming for an extended period.",
                Duration = 5
            })
        else
            isTrackingTime = false
            StopFarmBlock()
            Fluent:Notify({
                Title = "Autofarm Has Been Stoped",
                Content = "",
                SubContent = "Please wait a few seconds until the current run finishes.",
                Duration = 5
            })
        end
    end
})

local section = Tabs.Autofarm:AddSection("Farm Settings:")

local ANTIAFK = Tabs.Autofarm:AddToggle("ANTIAFK", {
    Title = "Enable Anti Afk",
    Description = "Toggle Anti Afk On/ Off, Activate Else you will be Kicked after 20 Minutes inactivity",
    Default = false,
    Callback = function(state)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/suntisalts/BetaTesting/refs/heads/main/AntiAFK.lua"))()
    end
})

local HideAllBool

local HideAllToggle = Tabs.Autofarm:AddToggle("hideuselessparts", {
    Title = "Delete Map",
    Description = "Hides Terrain (Temp). This is great for long AFK farming sessions as it boosts your FPS.",
    Default = false,
    Callback = function(Value)
        HideAllBool = Value
        local Stuff = {
            "Blocks",
            "Challenge",
            "TempStuff",
            --"Teams",
            "MainTerrain",
            "OtherStages",
            --"BlackZone",
            --"CamoZone",
            --"MagentaZone",
            --"New YellerZone",
            --"Really blueZone",
            --"Really redZone",
            "Sand",
            "Water",
            --"WhiteZone",
            "WaterMask"
        }

        if Value then
            -- Hide all parts
            for _, v in ipairs(Stuff) do
                local object = workspace:FindFirstChild(v) or workspace.BoatStages:FindFirstChild(v)
                if object then
                    if v == "OtherStages" then
                        object.Parent = ReplicatedStorage
                    else
                        object.Parent = ReplicatedStorage
                    end
                end
            end
        else
            -- Show all parts
            for _, v in ipairs(Stuff) do
                local object = ReplicatedStorage:FindFirstChild(v)
                if object then
                    if v == "OtherStages" then
                        object.Parent = workspace.BoatStages
                    else
                        object.Parent = workspace
                    end
                end
            end
        end
    end
})

local section = Tabs.Autofarm:AddSection("Farm Stats:")

local Farmtime = Tabs.Autofarm:AddParagraph({
    Title = "Total Farming Time: ",
    Content = "00:00:00"
})

local FarmedGoldBlocksParagraph = Tabs.Autofarm:AddParagraph({
    Title = "Obtained Blocks: ",
    Content = "0"
})

local FarmedGold = Tabs.Autofarm:AddParagraph({
    Title = "Obtained Gold: ",
    Content = "0"
})

local TotalGold = Tabs.Autofarm:AddParagraph({
    Title = "Current Gold: ",
    Content = "0"
})

local goldUpdateThread = nil

local function UpdateGoldDisplay()
    local success, err = pcall(function()
        local goldGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("GoldGui")
        if goldGui then
            local frame = goldGui:FindFirstChild("Frame")
            if frame then
                local amountLabel = frame:FindFirstChild("Amount")
                if amountLabel and amountLabel:IsA("TextLabel") then
                    local amountText = amountLabel.Text:gsub(",", "")
                    currentGold = tonumber(amountText) or 0
                    TotalGold:SetDesc(tostring(currentGold))

                    if initialGold == 0 then
                        initialGold = currentGold
                    end

                    local farmed = currentGold - initialGold
                    FarmedGold:SetDesc(tostring(farmed))
                end
            end
        end
    end)

    if not success then
        warn("Fehler beim Aktualisieren der Gold-Anzeige: " .. tostring(err))
    end
end

local function StartGoldUpdate()
    if goldUpdateThread then
        task.cancel(goldUpdateThread)
    end
    
    goldUpdateThread = task.spawn(function()
        while true do
            UpdateGoldDisplay()
            task.wait(0.1)
        end
    end)
end

StartGoldUpdate()

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    StartGoldUpdate()
end)

game:GetService("Players").LocalPlayer.CharacterRemoving:Connect(function()
    if goldUpdateThread then
        task.cancel(goldUpdateThread)
        goldUpdateThread = nil
    end
end)

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

local isFarmingThreadRunning = false
local lastFarmTick = 0

function StartFarmNormal()
    print("Test123")
    if isFarmingThreadRunning then return end
    isFarming = true
    isFarmingThreadRunning = true

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
    local waitTimes = {0, 2.3, 2.3, 2.3, 2.3, 2.3, 2.3, 2.3, 2.3, 2.3}  -- all 2.3 = 330     

    while isFarming do
        task.wait(6)

        for i, pos in ipairs(positions) do
            if pos then
                teleportAndClaim(pos, waitTimes[i])

                local success, err = pcall(function()
                    --UpdateStats()
                end)
                if not success then
                    --warn("Update Problems: " .. tostring(err))
                end

                if pos == Weshky0 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        task.wait(1)
                        TriggerChest.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        task.wait(1.3)
                        TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
                        workspace.ClaimRiverResultsGold:FireServer()
                        FarmedGoldBlocks += 1
                        FarmedGoldBlocksParagraph:SetDesc(tostring(FarmedGoldBlocks))
                    end
                end

                if pos == Weshky1 then
                    local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
                    if TriggerChest then
                        --TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
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
            end
        end
        isFarmingThreadRunning = false
    end
end

function StopFarm()
    isFarming = false
end

function StartFarmBlock()
    if isFarmingThreadRunning then return end
    isFarmingB = true
    isFarmingThreadRunning = true

    while isFarmingB do
		task.wait(6)
		TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
		task.wait(3.25)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Weshky0.CFrame + Vector3.new(0, 2, 0)
		task.wait(3)
        FarmedGoldBlocks += 1
        FarmedGoldBlocksParagraph:SetDesc(tostring(FarmedGoldBlocks))

        local success, err = pcall(UpdateStats)
        if not success then
            --warn("Fehler in UpdateStats: " .. tostring(err))
        end
        
		TriggerChest.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        task.wait(1)
        workspace.ClaimRiverResultsGold:FireServer()
		task.wait(9)
		TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
    end
    isFarmingThreadRunning = false
end


function StopFarmBlock()
    isFarmingB = false
end

local function updateFarmTimeDisplay()
    local currentTime = tick()
    if isTrackingTime then
        totalFarmTime = totalFarmTime + (currentTime - lastUpdate)
    end
    lastUpdate = currentTime

    local hours = math.floor(totalFarmTime / 3600)
    local minutes = math.floor((totalFarmTime % 3600) / 60)
    local seconds = math.floor(totalFarmTime % 60)
    local timeString = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    
    Farmtime:SetDesc(timeString)
end

local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    if isTrackingTime then
        updateFarmTimeDisplay()
    end
end)

local RunService = game:GetService("RunService")
local lastGoldUpdate = 0


RunService.Heartbeat:Connect(function()
    if tick() - lastGoldUpdate >= 1 then
        lastGoldUpdate = tick()
        --FarmedGoldBlocks += 1
        --print("FarmedGoldBlocks:", FarmedGoldBlocks)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------- Webhook
------------------------------------------------------------------------------------------------------------------------------------------- System

local webhookEnabled = false
local webhookUrl = ""
local reportInterval = 300 -- Default 5 minutes (in seconds)
local lastReportTime = 0

local function sendWebhookUpdate()
    if not webhookEnabled or webhookUrl == "" then return end
    
    -- Calculate farming time
    local hours = math.floor(totalFarmTime / 3600)
    local minutes = math.floor((totalFarmTime % 3600) / 60)
    local seconds = math.floor(totalFarmTime % 60)
    local timeString = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    
    local goldGained = currentGold - initialGold
    
    -- Create embed
    local embed = {
        {
            ["title"] = "Weshky Hub Autofarm Stats",
            ["description"] = "Autofarm statistics update",
            ["color"] = 0xFF0000, -- Red 
            ["fields"] = {
                {
                    ["name"] = "Total Farming Time",
                    ["value"] = timeString,
                    ["inline"] = true
                },
                {
                    ["name"] = "Gold Blocks Collected",
                    ["value"] = tostring(FarmedGoldBlocks),
                    ["inline"] = true
                },
                {
                    ["name"] = "Gold Gained",
                    ["value"] = tostring(goldGained),
                    ["inline"] = true
                },
                {
                    ["name"] = "Current Gold",
                    ["value"] = tostring(currentGold),
                    ["inline"] = true
                }
            },
            ["footer"] = {
                ["text"] = "Weshky Hub | " .. os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }
    
    local success, err = pcall(function()
        httprequest({
            Url = webhookUrl,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = game:GetService('HttpService'):JSONEncode({
                embeds = embed,
                content = ""
            })
        })
    end)
    
    if not success then
        warn("Failed to send webhook: " .. tostring(err))
    end
end

local section = Tabs.Autofarm:AddSection("Webhook Settings")

local webhookToggle = Tabs.Autofarm:AddToggle("WebhookToggle", {
    Title = "Enable Webhook Reports",
    Default = false,
    Callback = function(state)
        webhookEnabled = state
        if state and webhookUrl ~= "" then
            Fluent:Notify({
                Title = "Webhook Enabled",
                Content = "Reports will be sent every " .. reportInterval .. " seconds",
                Duration = 5
            })
        end
    end
})

local webhookInput = Tabs.Autofarm:AddInput("WebhookInput", {
    Title = "Webhook URL",
    Default = "",
    Placeholder = "Enter Discord webhook URL",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        webhookUrl = Value
        if Value ~= "" then
            Fluent:Notify({
                Title = "Webhook URL Set",
                Content = "Webhook URL has been saved",
                Duration = 3
            })
        end
    end
})

local intervalInput = Tabs.Autofarm:AddInput("IntervalInput", {
    Title = "Report Interval (seconds)",
    Default = "300",
    Placeholder = "Enter interval in seconds",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        local num = tonumber(Value)
        if num and num > 0 then
            reportInterval = num
            Fluent:Notify({
                Title = "Interval Updated",
                Content = "Reports will be sent every " .. num .. " seconds",
                Duration = 5
            })
        else
            Fluent:Notify({
                Title = "Invalid Interval",
                Content = "Please enter a positive number",
                Duration = 5
            })
        end
    end
})

Tabs.Autofarm:AddButton({
    Title = "Test Webhook",
    Description = "Send a test message to the webhook",
    Callback = function()
        if webhookUrl == "" then
            Fluent:Notify({
                Title = "Error",
                Content = "Please enter a webhook URL first",
                Duration = 5
            })
            return
        end
        
        local success, err = pcall(function()
            httprequest({
                Url = webhookUrl,
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json'
                },
                Body = game:GetService('HttpService'):JSONEncode({
                    content = "Weshky Hub - Webhook test successful! The Webhook is working correctly."
                })
            })
        end)
        
        if success then
            Fluent:Notify({
                Title = "Test Sent",
                Content = "A test message was sent to the webhook",
                Duration = 5
            })
        else
            Fluent:Notify({
                Title = "Error",
                Content = "Failed to send test: " .. tostring(err),
                Duration = 5
            })
        end
    end
})

RunService.Heartbeat:Connect(function()
    if webhookEnabled and webhookUrl ~= "" and isTrackingTime then
        local currentTime = tick()
        if currentTime - lastReportTime >= reportInterval then
            lastReportTime = currentTime
            sendWebhookUpdate()
        end
    end
end)

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- SHOP SECTION/TAB ---------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

local section = Tabs.Shop:AddSection("Standart Shop:")

local StandardItemBuying = nil
local StartItemBuyAmount  = nil

local DevItemBuying = nil
local DevItemBuyAmount  = nil

local ItemBuy = Tabs.Shop:AddDropdown("Dropdown", {
    Title = "Selecte Item",
    Values = {"ConcreteBlock", "GlassBlock", "WoodBlock", "TitaniumBlock", "StoneBlock", "SandBlock", "RustedBlock", "PlasticBlock", "ObsidianBlock", "MetalBlock", "MarbleBlock", "IceBlock", "GrassBlock", "FabricBlock", "CoalBlock", "BrickBlock", "SmoothWoodBlock", "BalloonBlock", "Chair", "Throne", "Thruster", "Window", "Lamp", "Potions", "Glue", "Camera", "Switch", "Sign", "CameraDome", "PineTree",},
    Multi = false,
    Default = "WoodBlock",
})

ItemBuy:OnChanged(function(Value)
    StandardItemBuying = Value
end)

local standardAmount = Tabs.Shop:AddInput("Input", {
    Title = "Amount",
    Default = "1",
    Placeholder = "Placeholder",
    Numeric = true, -- Only allows numbers
    Finished = false, -- Only calls callback when you press enter
    Callback = function(Value)
        StartItemBuyAmount = tonumber(Value)
    end
})

Tabs.Shop:AddButton({
    Title = "Buy Block",
    Description = "",
    Callback = function()
        --print(StandardItemBuying)
        --print(StartItemBuyAmount)
        workspace.ItemBoughtFromShop:InvokeServer(StandardItemBuying, StartItemBuyAmount)
        Fluent:Notify({
            Title = "Shop Information",
            Content = "",
            SubContent = "The Selected item has been bought.",
            Duration = 5
        })
    end  
})

local section = Tabs.Shop:AddSection("Developer Product Shop:")

local selectedProduct = "DragonHarpoon" 

local DevProduct = Tabs.Shop:AddDropdown("Dropdown", {
    Title = "Select Item Developer Product",
    Values = {"DragonHarpoon", "MegaThruster", "CookieWheel", "CandyHarpoon",},
    Multi = false,
    Default = selectedProduct,
})

DevProduct:OnChanged(function(Value)
    selectedProduct = Value
end)

Tabs.Shop:AddButton({
    Title = "Buy Developer Product",
    Description = "",
    Callback = function()
        local productIds = {
            DragonHarpoon = 1109792341,
            MegaThruster = 139121474,
            CandyHarpoon = 915766549,
            CookieWheel = 1126385328
        }

        local productId = productIds[selectedProduct]
        if productId then
            workspace.PromptRobuxEvent:InvokeServer(productId, "Product")
            Fluent:Notify({
                Title = "Shop Information",
                Content = "",
                SubContent = "The Selected Dev Product has been bought.",
                Duration = 5
            })
        else
            Fluent:Notify({
                Title = "Shop Warning",
                Content = "",
                SubContent = "Please Selecte a Dev Product before Buying.",
                Duration = 5
            })
        end
    end  
})

local DevInfo = Tabs.Shop:AddParagraph({
    Title = "Developer Product Information",
    Content = "Frequently asked question: When you buy the product, the item is also added to your inventory"
})

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ Automatically SECTION/TAB ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

local function LPTEAM2()
    local teamName = player.Team.Name

    local zoneMapping = {
        black = "BlackZone",
        blue = "Really blueZone",
        green = "CamoZone",
        red = "Really redZone",
        white = "WhiteZone",
        yellow = "New YellerZone",
        magenta = "MagentaZone"
    }

    local selectedZoneName = zoneMapping[teamName]

    if selectedZoneName then
        local zone = workspace:FindFirstChild(selectedZoneName)
        if zone then
            return zone.Name
        end
    end
end

local section = Tabs.Automatically:AddSection("Auto Finish Quests: ")

Tabs.Automatically:AddButton({
    Title = "Complete Target Quest",
    Description = "",
    Callback = function()
        local Team = LPTEAM2()
        workspace.QuestMakerEvent:FireServer(2)
        workspace:FindFirstChild(Team):WaitForChild("Quest")
        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), workspace:FindFirstChild(Team).Quest.Target.Part.TouchInterest.Parent, 0)
        Fluent:Notify({
            Title = "Quest Information",
            Content = "",
            SubContent = "Quest Ends, Automatically Redeeming the Rewards",
            Duration = 5
        })
    end  
})

Tabs.Automatically:AddButton({
    Title = "Complete Ramp Quest",
    Description = "",
    Callback = function()
        local Team = LPTEAM2()
        workspace.QuestMakerEvent:FireServer(3)
        workspace:FindFirstChild(Team):WaitForChild("Quest")
        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), workspace:FindFirstChild(Team).Quest.Ramp:GetChildren()[20].TouchInterest.Parent, 0)
        Fluent:Notify({
            Title = "Quest Information",
            Content = "",
            SubContent = "Quest Ends, Automatically Redeeming the Rewards",
            Duration = 5
        })
    end  
})

Tabs.Automatically:AddButton({
    Title = "Complete Cloud Quest",
    Description = "",
    Callback = function()
        local Team = LPTEAM2()
        workspace.QuestMakerEvent:FireServer(1)
        workspace:FindFirstChild(Team):WaitForChild("Quest")
        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), workspace:FindFirstChild(Team).Quest.Cloud.Part1, 0)
        Fluent:Notify({
            Title = "Quest Information",
            Content = "",
            SubContent = "Quest Ends, Automatically Redeeming the Rewards",
            Duration = 5
        })
    end  
})

--local section = Tabs.Automatically:AddSection("Auto Finish Easter Eggs: ")

local section = Tabs.Automatically:AddSection("Other Stuff: ")

Tabs.Automatically:AddButton({
    Title = "Redeem Available Codes",
    Description = "",
    Callback = function()
        workspace.CheckCodeFunction:InvokeServer("=D")
        wait(1)
        workspace.CheckCodeFunction:InvokeServer("=p")
        wait(1)
        workspace.CheckCodeFunction:InvokeServer("hi")
        wait(1)
        workspace.CheckCodeFunction:InvokeServer("squid army")
        wait(1)
        workspace.CheckCodeFunction:InvokeServer("chillthrill709 was here")
        wait(0.5)
        Fluent:Notify({
            Title = "Code Information",
            Content = "",
            SubContent = "All available codes have been redeemed (if not already done so).",
            Duration = 5
        })
    end  
})

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------- CLIENTSIDE SECTION/TAB ------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

local section = Tabs.Clientside:AddSection("Fake Gold:")

local GiveGoldAmount = nil

local GoldInput = Tabs.Clientside:AddInput("GoldInput", {
    Title = "Fake Gold Amount",
    Default = "",
    Placeholder = "Enter Gold Amount",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        GiveGoldAmount = tonumber(Value)
    end
})

Tabs.Clientside:AddButton({
    Title = "Set Fake Gold Amount",
    Description = "Applies the entered gold amount.",
    Callback = function()
        if GiveGoldAmount and type(GiveGoldAmount) == "number" then
            game:GetService("Players").LocalPlayer.Data.Gold.Value = GiveGoldAmount
            Fluent:Notify({
                Title = "Fake Gold Set",
                Content = "",
                SubContent = "Gold set to: " .. GiveGoldAmount,
                Duration = 5
            })
        else
            Fluent:Notify({
                Title = "Error",
                Content = "",
                SubContent = "Invalid gold amount! Enter a number first.",
                Duration = 5
            })
        end
    end
})

--local section = Tabs.Clientside:AddSection("Map Changes:")

local section = Tabs.Clientside:AddSection("Other Client Stuff:")

local CRTFBHewrSF = Tabs.Clientside:AddParagraph({
    Title = "Other Clientside Stuff: ",
})
local defaultSpeed = 16
local defaultJumpPower = 50
local defaultGravity = 196.1999

Tabs.Clientside:AddSlider("SpeedSet", {
    Title = "Speed",
    Description = "",
    Default = defaultSpeed,
    Min = 1,
    Max = 255,
    Rounding = 1,
    Callback = function(value)
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
})

Tabs.Clientside:AddSlider("JumppowerSet", {
    Title = "Jump Power",
    Description = "",
    Default = defaultJumpPower,
    Min = 0.1,
    Max = 255,
    Rounding = 0.1,
    Callback = function(value)
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = value
        end
    end
})

Tabs.Clientside:AddSlider("GravitySet", {
    Title = "Gravity",
    Description = "",
    Default = defaultGravity,
    Min = 1,
    Max = 255,
    Rounding = 1,
    Callback = function(value)
        workspace.Gravity = value
    end
})

Tabs.Clientside:AddButton({
    Title = "Reset Values",
    Description = "",
    Callback = function()
        local player = game.Players.LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = defaultSpeed
            humanoid.JumpPower = defaultJumpPower
        end
        workspace.Gravity = defaultGravity
    end
})

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- TROLLING SECTION/TAB ------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

local section = Tabs.Trolling:AddSection("Trolling Stuff:")

local autoFarmblockToggle = Tabs.Trolling:AddToggle("ForceShare", {
    Title = "Force Share Mode",
    Description = "",
    Default = false,
    Callback = function(state)
        workspace.SettingFunction:InvokeServer("ShareBlocks", state)
    end
})


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
    while FcMaster == true do
        if counterIsoMODE then
            removeLock()
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    previousPosition = humanoidRootPart.CFrame
                end
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

local autoFarmblockToggle = Tabs.Trolling:AddToggle("IsoBeam", {
    Title = "Deactivate Isolation (Client, All Teams)",
    Description = "",
    Default = false,
    Callback = function(state)
        counterIsoMODE = state
    end
})

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- CREDITS SECTION/TAB -------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

function farmcandys()
    for _, house in workspace.Houses:GetChildren() do
        if house:FindFirstChild("Door") and house.Door:FindFirstChild("DoorInnerTouch") then
            pcall(firetouchinterest, root, house.Door.DoorInnerTouch, 0)
        end
    end
end

local section = Tabs.Exclusive:AddSection("Autofarm EggCanons")

local CRTFB454HewrSF = Tabs.Exclusive:AddParagraph({
    Title = "How to Use ",
    Content = "Please Read Everything or it might doesn't work!!",
})

local CRTFBHew5454rSF = Tabs.Exclusive:AddParagraph({
    Title = "Requirements ",
    Content = "1. After you got Teleported check if the Server is Empty, else it doesn't gonna Work!!\n2. Time: Please wait and don't Move, it takes about 8-10 Minutes."
})

local CRTFBHew5454434rSF = Tabs.Exclusive:AddParagraph({
    Title = "Executor Warning: ",
    Content = "Weshky Egg Canon farm Script needs a function called 'queue_on_teleport' if your executor dosent have this function it wont work.",
})

Tabs.Exclusive:AddButton({
    Title = "Start Eggcanon Autofarm",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/suntisalts/WeshkyHub/refs/heads/main/Extra/Eggcanon.lua'),true))()
    end
})

local section = Tabs.Exclusive:AddSection("Other Exclusive's")

Tabs.Exclusive:AddButton({
    Title = "Autofarm Candys",
    Description = "",
    Callback = function()
        farmcandys() --loadstring(game:HttpGet(('https://raw.githubusercontent.com/suntisalts/BetaTesting/refs/heads/main/Candys.lua'),true))()
    end
})

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- TELEPORT SECTION/TAB ------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

local section = Tabs.Teleport:AddSection("Teleport Places: ")

Tabs.Teleport:AddButton({
    Title = "Inner Cloud",
    Description = "",
    Callback = function()
        TeleportService:Teleport(1930863474, game.Players.LocalPlayer)
    end
})

Tabs.Teleport:AddButton({
    Title = "Christmas",
    Description = "",
    Callback = function()
        TeleportService:Teleport(1930866268, game.Players.LocalPlayer)
    end
})

Tabs.Teleport:AddButton({
    Title = "Halloween",
    Description = "",
    Callback = function()
        TeleportService:Teleport(1930665568, game.Players.LocalPlayer)
    end
})

local section = Tabs.Teleport:AddSection("Teleport Teams: ")

Tabs.Teleport:AddButton({
    Title = "Teleport White",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(-49.8510132, -9.7000021, -552.37085, -1, 0, 0, 0, 1, 0, 0, 0, -1))
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Black",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(-536.22843, -9.7000021, -69.433342, 0, 0, -1, 0, 1, 0, 1, 0, 0))
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Red",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(430.697418, -9.7000021, -64.7801361, 0, 0, 1, 0, 1, -0, -1, 0, 0))
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Blue",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(430.697418, -9.7000021, 300.219849, 0, 0, 1, 0, 1, -0, -1, 0, 0))
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Green",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(-535.82843, -9.7000021, 293.56665, 0, 0, -1, 0, 1, 0, 1, 0, 0))
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport Yellow",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(-537.82843, -9.7000021, 640.56665, 0, 0, -1, 0, 1, 0, 1, 0, 0))
    end
})

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- CREDITS SECTION/TAB -------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

local CRTFBHSF = Tabs.Credits:AddParagraph({
    Title = "Weshky Credits:",
    Content = "Thanks Weshky Community for Supporting me and the Staff Team.\nWeshky Owner: Sxirbes\nCo-Owner: frenzy.at\nManager: Minegoo (Hes Gay)\nManager: xeon_.06"
})

local CRTFBHewrSF = Tabs.Credits:AddParagraph({
    Title = "Script Credits:",
    Content = "Main Scripter: Sxirbes \nUi Library: Discoart"
})

Tabs.Credits:AddButton({
    Title = "Wesky Discord Server: ",
    Description = "Copy our Discord Server Invite link",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/suntisalts/BetaTesting/refs/heads/main/DiscordInvite.lua"))()
        Fluent:Notify({
            Title = "Discord Invite",
            Content = "",
            SubContent = "The Weshky invite link has been copied to your clipboard!",
            Duration = 7
        })
    end
})

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- SETTINGS FUNCTIONS --------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/BuildaBoatForTreasure")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Other SECTION/STUFF -------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

local CRTFBeeHewrSF = Tabs.Imageloader:AddParagraph({
    Title = "Information:",
    Content = "Image Loader is Work in progress, please wait it will be added soon."
})

local CRTFBHSF = Tabs.Weshky:AddParagraph({
    Title = "Discord Warning:",
    Content = "Weshky Discord Server got deleted, join our new discord Server."
})

Tabs.Weshky:AddButton({
    Title = "Copy Discord Invite",
    Description = "Copy our new discord server invite link",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/suntisalts/WeshkyHub/refs/heads/main/Extra/DiscordInvite.lua"))()
        Fluent:Notify({
            Title = "Discord Invite",
            Content = "",
            SubContent = "The Weshky invite link has been copied to your clipboard!",
            Duration = 7
        })
    end
})

--local response = httprequest({
--    Url = '',
--    Method = 'POST',
--    Headers = {
--        ['Content-Type'] = 'application/json'
--    },
--    Body = game:GetService('HttpService'):JSONEncode({
--        content = 'Someone Executed Weshky Hub Script!'
--    })
--})

Fluent:Notify({
    Title = "The Ui has Successfully Loaded",
    Content = "",
    SubContent = "Thanks for using our Script, Check out Weshkys Discord for more Updates and more!!",
    Duration = 5
})

Window:SelectTab(1)