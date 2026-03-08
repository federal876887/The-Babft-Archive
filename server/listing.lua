local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local CONFIG = {
    MAIN_COLOR = Color3.fromRGB(53, 63, 119),
    BACKGROUND_COLOR = Color3.fromRGB(21, 22, 23),
    TEXT_COLOR = Color3.fromRGB(255, 255, 255),
    TRANSPARENCY = 0.2,
    POSITION = UDim2.new(0, 1053, 0, 40),
    SIZE = UDim2.new(0, 300, 0, 22),
    CONTENT_HEIGHT = 540
}

do
    local MainPart = game:GetService("CoreGui"):FindFirstChild("BlockListing")
    if MainPart then MainPart:Destroy() end
end

local tzu = Enum.Font.GothamBold
local tzu2 = Enum.Font.GothamBold
local tzu3 = Enum.Font.GothamBold

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BlockListing"

local Main = Instance.new("ImageLabel")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BackgroundTransparency = 1.000
Main.Position = CONFIG.POSITION
Main.Size = CONFIG.SIZE
Main.ZIndex = 4
Main.Image = "rbxassetid://3570695787"
Main.ImageColor3 = CONFIG.MAIN_COLOR
Main.ImageTransparency = 0
Main.ScaleType = Enum.ScaleType.Slice
Main.SliceCenter = Rect.new(100, 100, 100, 100)
Main.SliceScale = 0.050
Main.Active = true

local Frame = Instance.new("Frame")
Frame.Parent = Main
Frame.BackgroundColor3 = CONFIG.MAIN_COLOR
Frame.BackgroundTransparency = CONFIG.TRANSPARENCY
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 1, -10)
Frame.Size = UDim2.new(1, 0, 0, 10)
Frame.ZIndex = 4

local Frame_2 = Instance.new("Frame")
Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
Frame_2.BackgroundTransparency = CONFIG.TRANSPARENCY
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 0, 1, 0)
Frame_2.Size = UDim2.new(1, 0, 0, 2)
Frame_2.ZIndex = 2

local Content = Instance.new("ImageLabel")
Content.Name = "Content"
Content.Parent = Main
Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Content.BackgroundTransparency = 1.000
Content.ClipsDescendants = true
Content.Position = UDim2.new(0, 0, 1, 0)
Content.Size = UDim2.new(1, 0, 0, CONFIG.CONTENT_HEIGHT)
Content.Image = "rbxassetid://3570695787"
Content.ImageColor3 = CONFIG.BACKGROUND_COLOR
Content.ImageTransparency = CONFIG.TRANSPARENCY
Content.ScaleType = Enum.ScaleType.Slice
Content.SliceCenter = Rect.new(100, 100, 100, 100)
Content.SliceScale = 0.050

local Frame_3 = Instance.new("Frame")
Frame_3.Parent = Content
Frame_3.BackgroundColor3 = CONFIG.BACKGROUND_COLOR
Frame_3.BackgroundTransparency = CONFIG.TRANSPARENCY
Frame_3.BorderSizePixel = 0
Frame_3.Size = UDim2.new(1, 0, 0, 10)

local Expand = Instance.new("ImageButton")
Expand.Name = "Expand"
Expand.Parent = Main
Expand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Expand.BackgroundTransparency = 1.000
Expand.Position = UDim2.new(0, 6, 0, 2)
Expand.Rotation = 90.000
Expand.Size = UDim2.new(0, 18, 0, 18)
Expand.ZIndex = 4
Expand.Image = "rbxassetid://7671465363"

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 30, 0, 0)
Title.Size = UDim2.new(1, -30, 1, 0)
Title.ZIndex = 4
Title.Font = tzu2
Title.Text = "Block Listing"
Title.TextColor3 = CONFIG.TEXT_COLOR
Title.TextSize = 15
Title.TextWrapped = true
Title.TextXAlignment = Enum.TextXAlignment.Left

local DragBar = Instance.new("Frame")
DragBar.Name = "DragBar"
DragBar.Parent = Main
DragBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DragBar.BackgroundTransparency = 1
DragBar.Size = UDim2.new(1, 0, 1, 0)
DragBar.ZIndex = 10 
DragBar.Active = true
DragBar.Selectable = true

local Layer = Instance.new("ImageLabel")
Layer.Name = "Layer"
Layer.Parent = Main
Layer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Layer.BackgroundTransparency = 1.000
Layer.Position = UDim2.new(0, 2, 0, 2)
Layer.Size = UDim2.new(1, 0, 10.090909, 0)
Layer.ZIndex = 0
Layer.Image = "rbxassetid://3570695787"
Layer.ImageColor3 = Color3.fromRGB(10, 10, 11)
Layer.ImageTransparency = CONFIG.TRANSPARENCY
Layer.ScaleType = Enum.ScaleType.Slice
Layer.SliceCenter = Rect.new(100, 100, 100, 100)
Layer.SliceScale = 0.050

local Items = Instance.new("ScrollingFrame")
Items.Name = "Items"
Items.Parent = Content
Items.Active = true
Items.BackgroundColor3 = CONFIG.BACKGROUND_COLOR
Items.BackgroundTransparency = 1.000
Items.BorderSizePixel = 0
Items.Position = UDim2.new(0, 10, 0, 0)
Items.Size = UDim2.new(1, -20, 1, 0)
Items.CanvasSize = UDim2.new(0, 0, 0, 0)
Items.ScrollBarThickness = 6
Items.ScrollBarImageColor3 = Color3.new()
Items.AutomaticCanvasSize = Enum.AutomaticSize.Y

local UIListLayout = Instance.new("UIListLayout", Items)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local UIPadding = Instance.new("UIPadding", Items)
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingBottom = UDim.new(0, 10)

local ClearButton = Instance.new("TextButton")
ClearButton.Name = "Clear"
ClearButton.Parent = Main
ClearButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.BackgroundTransparency = 1.000
ClearButton.BorderSizePixel = 0
ClearButton.Position = UDim2.new(1, -70, 0, 2)
ClearButton.Size = UDim2.new(0, 65, 0, 18)
ClearButton.ZIndex = 5
ClearButton.Font = tzu
ClearButton.Text = "Clear"
ClearButton.TextColor3 = CONFIG.TEXT_COLOR
ClearButton.TextSize = 13.000

local ClearImageLabel = Instance.new("ImageLabel")
ClearImageLabel.Parent = ClearButton
ClearImageLabel.Active = true
ClearImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ClearImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClearImageLabel.BackgroundTransparency = 1.000
ClearImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ClearImageLabel.Selectable = true
ClearImageLabel.Size = UDim2.new(1, 0, 1, 0)
ClearImageLabel.ZIndex = 4
ClearImageLabel.Image = "rbxassetid://3570695787"
ClearImageLabel.ImageColor3 = Color3.fromRGB(122, 41, 41)
ClearImageLabel.ImageTransparency = CONFIG.TRANSPARENCY
ClearImageLabel.ScaleType = Enum.ScaleType.Slice
ClearImageLabel.SliceCenter = Rect.new(100, 100, 100, 100)
ClearImageLabel.SliceScale = 0.050

local ClearLayer = Instance.new("ImageLabel")
ClearLayer.Name = "Layer"
ClearLayer.Parent = ClearButton
ClearLayer.Active = true
ClearLayer.AnchorPoint = Vector2.new(0.5, 0.5)
ClearLayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClearLayer.BackgroundTransparency = 1.000
ClearLayer.Position = UDim2.new(0.5, 2, 0.5, 2)
ClearLayer.Selectable = true
ClearLayer.Size = UDim2.new(1, 0, 1, 0)
ClearLayer.Image = "rbxassetid://3570695787"
ClearLayer.ImageColor3 = Color3.fromRGB(61, 21, 21)
ClearLayer.ImageTransparency = CONFIG.TRANSPARENCY
ClearLayer.ScaleType = Enum.ScaleType.Slice
ClearLayer.SliceCenter = Rect.new(100, 100, 100, 100)
ClearLayer.SliceScale = 0.050

local NAME_ALIASES = {
    ["WoodBlock"] = "Wood Block",
    ["SmoothWoodBlock"] = "Smooth Wood Block",
    ["StoneBlock"] = "Stone Block",
    ["RustedBlock"] = "Rusted Block",
    ["MetalBlock"] = "Metal Block",
    ["NeonBlock"] = "Neon Block",
    ["GlassBlock"] = "Glass Block",
    ["ConcreteBlock"] = "Concrete Block",
    ["MarbleBlock"] = "Marble Block",
    ["TitaniumBlock"] = "Titanium Block",
    ["ObsidianBlock"] = "Obsidian Block",
    ["GoldBlock"] = "Gold Block",
    ["FabricBlock"] = "Fabric Block",
    ["BrickBlock"] = "Brick Block",
    ["BalloonBlock"] = "Balloon Block",
    ["PlasticBlock"] = "Plastic Block",
    ["ToyBlock"] = "Toy Block",
    ["IceBlock"] = "Ice Block",
    ["CoalBlock"] = "Coal Block",
    ["BouncyBlock"] = "Bouncy Block",
    ["SandBlock"] = "Sand Block",
    ["GrassBlock"] = "Grass Block",
    ["Motor"] = "Legacy Wheel",
    ["WoodRod"] = "Wood Rod",
    ["StoneRod"] = "Stone Rod",
    ["RustedRod"] = "Rusted Rod",
    ["MetalRod"] = "Metal Rod",
    ["ConcreteRod"] = "Concrete Rod",
    ["MarbleRod"] = "Marble Rod",
    ["TitaniumRod"] = "Titanium Rod",
    ["FrontWheel"] = "Front Wheel",
    ["HugeFrontWheel"] = "Huge Front Wheel",
    ["HugeBackWheel"] = "Huge Back Wheel",
    ["BackWheel"] = "Back Wheel",
    ["CarSeat"] = "Car Seat",
    ["PilotSeat"] = "Pilot Seat",
    ["UltraThruster"] = "Ultra Thruster",
    ["MegaThruster"] = "Mega Thruster",
    ["DragonHarpoon"] = "Dragon Harpoon",
    ["HarpoonGold"] = "Golden Harpoon",
    ["JetTurbine"] = "Jet Turbine",
    ["SonicJetTurbine"] = "Sonic Jet Turbine",
    ["ClassicFirework"] = "Classic Firework",
    ["FireworkD"] = "Classic Firework D",
    ["FireworkC"] = "Classic Firework C",
    ["FireworkA"] = "Classic Firework A",
    ["FireworkB"] = "Classic Firework B",
    ["CameraDome"] = "Dome Camera",
    ["BoatMotor"] = "Boat Motor",
    ["DualCaneHarpoon"] = "Dual Candy Harpoon",
    ["MiniGun"] = "Mini Gun",
    ["SpikeTrap"] = "Spike Trap",
    ["PineTree"] = "Pine Tree",
    ["BoatMotor"] = "Boat Motor",
    ["BigCanon"] = "Big Canon",
    ["EggCannon"] = "Egg Cannon",
    ["SnowballLauncher"] = "Snowball Launcher",
    ["LockedDoor"] = "Locked Door",
    ["CornerWedge"] = "Corner Wedge",
    ["SoccerBall"] = "Soccer Ball",
    ["BoatMotorUltra"] = "Ultra Boat Motor",
    ["LightBulb"] = "Light Bulb",
    ["ParachuteBlock"] = "Parachute Block",
    ["SticksOfTNT"] = "Dynamite",
    ["MusicNote"] = "Music Note",
    ["Bread"] = "Baskets Brain",
    ["UltraJetpack"] = "Ultra Jetpack",
    ["JetPack"] = "Jet Pack",
    ["MysteryBox"] = "Mystery Box",
    ["FrontWheelCookie"] = "Cookie Front Wheel",
    ["BackWheelCookie"] = "Cookie Back Wheel",
    ["FrontWheelMint"] = "Mint Front Wheel",
    ["BackWheelMint"] = "Mint Back Wheel",
    ["CannonMount"] = "Mounted Cannon",
    ["GunMount"] = "Mounted Gun",
    ["SwordMount"] = "Mounted Sword"
}

-- Gold Icon http://www.roblox.com/asset/?id=5445578732
-- workspace:WaitForChild("ItemBoughtFromShop"):InvokeServer("WoodBlock", 1)

local function getDisplayName(originalName)
    local alias = NAME_ALIASES[originalName]
    if alias then
        return alias
    end
    
    return originalName
end

local function CreateExampleBlock()
    local ExampleBlock = Instance.new("Frame")
    ExampleBlock.Name = "Block"
    ExampleBlock.Size = UDim2.new(1, 0, 0, 52)
    ExampleBlock.BackgroundTransparency = 1
    ExampleBlock.Visible = false
    
    local BlockOuter = Instance.new("ImageLabel")
    BlockOuter.Name = "Outer"
    BlockOuter.Size = UDim2.new(1, 0, 1, 0)
    BlockOuter.Image = "rbxassetid://3570695787"
    BlockOuter.ImageColor3 = Color3.fromRGB(59, 59, 68)
    BlockOuter.ImageTransparency = CONFIG.TRANSPARENCY
    BlockOuter.ScaleType = Enum.ScaleType.Slice
    BlockOuter.SliceCenter = Rect.new(100, 100, 100, 100)
    BlockOuter.SliceScale = 0.050
    BlockOuter.BackgroundTransparency = 1
    BlockOuter.ZIndex = 11
    BlockOuter.Parent = ExampleBlock

    local BlockInner = Instance.new("ImageLabel")
    BlockInner.Name = "Inner"
    BlockInner.AnchorPoint = Vector2.new(0.5, 0.5)
    BlockInner.Position = UDim2.new(0.5, 0, 0.5, 0)
    BlockInner.Size = UDim2.new(1, -6, 1, -6)
    BlockInner.BackgroundTransparency = 1
    BlockInner.Image = "rbxassetid://3570695787"
    BlockInner.ImageColor3 = Color3.fromRGB(41, 74, 122)
    BlockInner.ImageTransparency = CONFIG.TRANSPARENCY
    BlockInner.ScaleType = Enum.ScaleType.Slice
    BlockInner.SliceCenter = Rect.new(100, 100, 100, 100)
    BlockInner.SliceScale = 0.050
    BlockInner.ZIndex = 12
    BlockInner.Parent = BlockOuter
    
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Size = UDim2.new(1, 0, 1, 0)
    ContentContainer.Parent = BlockInner
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 42, 0, 42)
    Icon.Position = UDim2.new(0, 10, 0.5, 0)
    Icon.AnchorPoint = Vector2.new(0, 0.5)
    Icon.Image = "rbxassetid://845567732"
    Icon.BackgroundTransparency = 1
    Icon.ZIndex = 13
    Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Parent = ContentContainer
    
    local TextContainer = Instance.new("Frame")
    TextContainer.Name = "TextContainer"
    TextContainer.BackgroundTransparency = 1
    TextContainer.Position = UDim2.new(0, 60, 0, 0) 
    TextContainer.Size = UDim2.new(1, -60, 1, 0) 
    TextContainer.Parent = ContentContainer
    
    local BlockName = Instance.new("TextLabel")
    BlockName.Name = "BlockName"
    BlockName.Size = UDim2.new(1, 0, 0.5, 0)
    BlockName.Position = UDim2.new(0, 0, 0, 0)
    BlockName.BackgroundTransparency = 1
    BlockName.Font = Enum.Font.GothamBold
    BlockName.Text = "Block Name"
    BlockName.TextColor3 = CONFIG.TEXT_COLOR
    BlockName.TextSize = 14
    BlockName.TextXAlignment = Enum.TextXAlignment.Left
    BlockName.TextYAlignment = Enum.TextYAlignment.Bottom
    BlockName.ZIndex = 14
    BlockName.Parent = TextContainer
    
    local BlockInfo = Instance.new("TextLabel")
    BlockInfo.Name = "BlockInfo"
    BlockInfo.Size = UDim2.new(1, 0, 0.5, 0)
    BlockInfo.Position = UDim2.new(0, 0, 0.5, 0)
    BlockInfo.BackgroundTransparency = 1
    BlockInfo.Font = Enum.Font.Gotham
    BlockInfo.Text = "Needed: 0 Missing: 0"
    BlockInfo.TextColor3 = CONFIG.TEXT_COLOR
    BlockInfo.TextSize = 14
    BlockInfo.TextXAlignment = Enum.TextXAlignment.Left
    BlockInfo.TextYAlignment = Enum.TextYAlignment.Top
    BlockInfo.ZIndex = 14
    BlockInfo.Parent = TextContainer

    return ExampleBlock
end
local ExampleBlock = CreateExampleBlock()

local images = {}
local success, imagesData = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Vyrusspcs/weshkyv2/refs/heads/main/server/blocklist.lua"))()
end)

if success and type(imagesData) == "table" then
    images = imagesData
    print("Loaded", #images, "block images")
else
    print("problem loading block images:", imagesData)
end

local function Resize(part, newProps, speed)
    local tween = TweenInfo.new(speed or 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(part, tween, newProps):Play()
end

local originalContentSize = Content.Size
local originalMainSize = Main.Size
local isOpen = true

local function updateTransparency(transparency)
    CONFIG.TRANSPARENCY = math.clamp(transparency, 0, 1)
    Main.ImageTransparency = CONFIG.TRANSPARENCY
    Frame.BackgroundTransparency = CONFIG.TRANSPARENCY
    Frame_2.BackgroundTransparency = CONFIG.TRANSPARENCY
    Content.ImageTransparency = CONFIG.TRANSPARENCY
    Frame_3.BackgroundTransparency = CONFIG.TRANSPARENCY
    Layer.ImageTransparency = CONFIG.TRANSPARENCY
    ClearImageLabel.ImageTransparency = CONFIG.TRANSPARENCY
    ClearLayer.ImageTransparency = CONFIG.TRANSPARENCY
    
    for _, child in pairs(Items:GetChildren()) do
        if child:IsA("Frame") and child.Name == "Block" then
            local outer = child:FindFirstChild("Outer")
            local inner = outer and outer:FindFirstChild("Inner")
            if outer then
                outer.ImageTransparency = CONFIG.TRANSPARENCY
            end
            if inner then
                inner.ImageTransparency = CONFIG.TRANSPARENCY
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

Expand.MouseButton1Click:Connect(function()
    if isOpen then
        Resize(Expand, {Rotation = 0}, 0.1)
        Resize(Content, {Size = UDim2.new(1, 0, 0, 0)}, 0.1)
        Resize(Main, {Size = originalMainSize}, 0.1)
        isOpen = false
    else
        Resize(Expand, {Rotation = 90}, 0.1)
        Resize(Content, {Size = originalContentSize}, 0.1)
        Resize(Main, {Size = originalMainSize}, 0.1)
        isOpen = true
    end
end)

local function updateLayers()
    local y = Main.AbsoluteSize.Y + Content.AbsoluteSize.Y
    Layer.Size = UDim2.new(1, 0, 0, y)
    Layer.SliceScale = 0.050
end

Content:GetPropertyChangedSignal("Size"):Connect(updateLayers)
Main:GetPropertyChangedSignal("Size"):Connect(updateLayers)

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local expandHovered = false
local clearHovered = false

Expand.MouseEnter:Connect(function()
    expandHovered = true
end)

Expand.MouseLeave:Connect(function()
    expandHovered = false
end)

ClearButton.MouseEnter:Connect(function()
    clearHovered = true
end)

ClearButton.MouseLeave:Connect(function()
    clearHovered = false
end)

local function updateDrag(input)
    local delta = input.Position - dragStart
    local newPosition = UDim2.new(
        0, startPos.X.Offset + delta.X,
        0, startPos.Y.Offset + delta.Y
    )
    
    local screenSize = game:GetService("GuiService"):GetScreenResolution()
    newPosition = UDim2.new(
        0, math.clamp(newPosition.X.Offset, 0, screenSize.X - Main.AbsoluteSize.X),
        0, math.clamp(newPosition.Y.Offset, 0, screenSize.Y - Main.AbsoluteSize.Y)
    )
    
    Resize(Main, {Position = newPosition}, 0.05)
end

DragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if expandHovered or clearHovered then
            return
        end
        
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

DragBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        dragInput = nil
    end
end)

local Functions = {}

local COLORS = {
    RED = Color3.fromRGB(122, 41, 41),
    YELLOW = Color3.fromRGB(145, 103, 25), 
    GREEN = Color3.fromRGB(41, 122, 56),
    NEUTRAL = Color3.fromRGB(59, 59, 68),
}

function Functions:Clear()
    for _, child in pairs(Items:GetChildren()) do
        if not child:IsA("UIListLayout") and child.Name ~= "Padding" and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
    Items.CanvasSize = UDim2.new(0, 0, 0, 0)
end

function Functions:Add(name, needed, missing)
    if not name or name == "" then 
        name = "Unknown Block"
    end
    
    needed = tonumber(needed) or 0
    missing = tonumber(missing) or nil
    
    local displayName = getDisplayName(name)
    
    local block = ExampleBlock:Clone()
    block.Name = "Block"
    block.Visible = true
    block.Parent = Items
    
    local outer = block:FindFirstChild("Outer")
    if not outer then return end
    
    local inner = outer:FindFirstChild("Inner")
    if not inner then return end
    
    local contentContainer = inner:FindFirstChild("ContentContainer")
    if not contentContainer then return end
    
    local icon = contentContainer:FindFirstChild("Icon")
    local textContainer = contentContainer:FindFirstChild("TextContainer")
    
    if not icon or not textContainer then return end
    
    local blockNameLabel = textContainer:FindFirstChild("BlockName")
    local blockInfoLabel = textContainer:FindFirstChild("BlockInfo")
    
    if not blockNameLabel or not blockInfoLabel then return end
    
    outer.ImageTransparency = CONFIG.TRANSPARENCY
    inner.ImageTransparency = CONFIG.TRANSPARENCY
    
    if images[name] then
        icon.Image = images[name]
        icon.Visible = true
    else
        icon.Image = "rbxassetid://845567732"
        icon.Visible = true
    end
    
    blockNameLabel.Text = tostring(displayName)
    
    if missing and missing > 0 then
        blockInfoLabel.Text = string.format("Needed: %d  Missing: %d", needed, missing)
    else
        blockInfoLabel.Text = string.format("Needed: %d  Missing: 0", needed)
    end
    
    local color = COLORS.GREEN
    
    if needed > 0 then
        local missingCount = missing or 0
        local perc = missingCount / needed
        
        if missingCount == 0 then
            color = COLORS.GREEN
        elseif perc <= 0.5 then
            color = COLORS.YELLOW
        else
            color = COLORS.RED
        end
    elseif missing and missing > 0 then
        color = COLORS.RED
    end
    
    inner.ImageColor3 = color
end

function Functions:SetTransparency(transparency)
    updateTransparency(transparency)
end

function Functions:GetTransparency()
    return CONFIG.TRANSPARENCY
end

function Functions:UpdateConfig(newConfig)
    for key, value in pairs(newConfig) do
        if CONFIG[key] ~= nil then
            CONFIG[key] = value
        end
    end
    
    Main.ImageColor3 = CONFIG.MAIN_COLOR
    Content.ImageColor3 = CONFIG.BACKGROUND_COLOR
    Title.TextColor3 = CONFIG.TEXT_COLOR
    updateTransparency(CONFIG.TRANSPARENCY)
end

function Functions:AddAlias(originalName, displayName)
    if originalName and displayName then
        NAME_ALIASES[originalName] = displayName
    end
end

function Functions:RemoveAlias(originalName)
    if originalName then
        NAME_ALIASES[originalName] = nil
    end
end

function Functions:GetAliases()
    local aliases = {}
    for key, value in pairs(NAME_ALIASES) do
        aliases[key] = value
    end
    return aliases
end

ClearButton.MouseButton1Click:Connect(function()
    Functions:Clear()
end)

updateLayers()

task.spawn(function()
    wait(3)
    Main.Visible = true
end)

return Functions
