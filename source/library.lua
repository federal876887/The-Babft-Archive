--[[
    rbimgui-2
    version 1.2
    by Singularity
    https://v3rmillion.net/member.php?action=profile&uid=947830
    Singularity#5490
    
    modified by Sxirbes
    https://github.com/Vyrusspcs/
    sxirbes32423
    Added inputs and fixed some stuff, better Organization, and more!
--]]

print("v2.1")

repeat wait() until game:GetService("Players").LocalPlayer
if game:GetService("CoreGui"):FindFirstChild("imgui2") then
    game:GetService("CoreGui"):FindFirstChild("imgui2"):Destroy()
end

local tzu = Enum.Font.GothamBold -- All
local tzu2 = Enum.Font.GothamBold -- Title
local tzu3 = Enum.Font.GothamBold  -- Tabs

do -- Load items
    local imgui2 = Instance.new("ScreenGui")
    local Presets = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local TabButton = Instance.new("TextButton")
    local Folder = Instance.new("Frame")
    local Folder_2 = Instance.new("ImageLabel")
    local Expand = Instance.new("ImageButton")
    local Title = Instance.new("TextLabel")
    local Items = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local Tab = Instance.new("Frame")
    local Items_2 = Instance.new("ScrollingFrame")
    local UIListLayout_2 = Instance.new("UIListLayout")
    local Padding = Instance.new("Frame")
    local Main = Instance.new("ImageLabel")
    local Frame = Instance.new("Frame")
    local Frame_2 = Instance.new("Frame")
    local Content = Instance.new("ImageLabel")
    local Frame_3 = Instance.new("Frame")
    local Message = Instance.new("ImageLabel")
    local Expand_2 = Instance.new("ImageButton")
    local Title_2 = Instance.new("TextLabel")
    local Shadow = Instance.new("ImageLabel")
    local Tabs = Instance.new("Frame")
    local Items_3 = Instance.new("Frame")
    local UIListLayout_3 = Instance.new("UIListLayout")
    local Frame_4 = Instance.new("Frame")
    local Layer = Instance.new("ImageLabel")
    local Dock = Instance.new("Frame")
    local UIListLayout_4 = Instance.new("UIListLayout")
    local Switch = Instance.new("Frame")
    local Button = Instance.new("TextButton")
    local ImageLabel = Instance.new("ImageLabel")
    local Layer_2 = Instance.new("ImageLabel")
    local Check = Instance.new("ImageLabel")
    local Text = Instance.new("TextLabel")
    local Slider = Instance.new("Frame")
    local Outer = Instance.new("ImageLabel")
    local Inner = Instance.new("ImageLabel")
    local Slider_2 = Instance.new("Frame")
    local Value = Instance.new("TextLabel")
    local Text_2 = Instance.new("TextLabel")
    local Button_2 = Instance.new("TextButton")
    local ImageLabel_2 = Instance.new("ImageLabel")
    local Layer_3 = Instance.new("ImageLabel")
    local Card = Instance.new("ImageLabel")
    local UIGradient = Instance.new("UIGradient")
    local ImageLabel_3 = Instance.new("ImageLabel")
    local Roundify = Instance.new("ImageLabel")
    local heading = Instance.new("TextLabel")
    local Frame_5 = Instance.new("ImageLabel")
    local SubHeading = Instance.new("TextLabel")
    local ColorPicker = Instance.new("Frame")
    local Button_3 = Instance.new("TextButton")
    local ImageLabel_4 = Instance.new("ImageLabel")
    local ImageLabel_5 = Instance.new("ImageLabel")
    local Layer_4 = Instance.new("ImageLabel")
    local Text_3 = Instance.new("TextLabel")
    local DropdownOption = Instance.new("TextButton")
    local ImageLabel_6 = Instance.new("ImageLabel")
    local DropdownWindow = Instance.new("ImageLabel")
    local Frame_6 = Instance.new("Frame")
    local Frame_7 = Instance.new("Frame")
    local Title_3 = Instance.new("TextLabel")
    local Shadow_2 = Instance.new("ImageLabel")
    local Layer_5 = Instance.new("ImageLabel")
    local Content_2 = Instance.new("ImageLabel")
    local Items_4 = Instance.new("ScrollingFrame")
    local UIListLayout_5 = Instance.new("UIListLayout")
    local Search = Instance.new("Frame")
    local Outer_2 = Instance.new("ImageLabel")
    local Inner_2 = Instance.new("ImageLabel")
    local ImageLabel_7 = Instance.new("ImageLabel")
    local TextBox = Instance.new("TextLabel")
    local Selected = Instance.new("TextLabel")
    local Expand_3 = Instance.new("ImageButton")
    local Cache = Instance.new("Frame")
    local ColorPickerWindow = Instance.new("ImageLabel")
    local Frame_8 = Instance.new("Frame")
    local Frame_9 = Instance.new("Frame")
    local Title_4 = Instance.new("TextLabel")
    local Shadow_3 = Instance.new("ImageLabel")
    local Layer_6 = Instance.new("ImageLabel")
    local Expand_4 = Instance.new("ImageButton")
    local Content_3 = Instance.new("ImageLabel")
    local Palette = Instance.new("ImageLabel")
    local Indicator = Instance.new("ImageLabel")
    local Saturation = Instance.new("ImageLabel")
    local Indicator_2 = Instance.new("Frame")
    local FinalColor = Instance.new("ImageLabel")
    local SaturationColor = Instance.new("ImageLabel")
    local PaletteColor = Instance.new("ImageLabel")
    local TextLabel = Instance.new("TextLabel")
    local Dropdown = Instance.new("Frame")
    local Outer_3 = Instance.new("ImageLabel")
    local Inner_3 = Instance.new("ImageButton")
    local ImageLabel_8 = Instance.new("ImageLabel")
    local Value_2 = Instance.new("TextLabel")
    local Text_4 = Instance.new("TextLabel")
    local Cache_2 = Instance.new("Frame")

    -- ========== Main Container ==========
    imgui2.Name = "imgui2"
    imgui2.Parent = game:GetService("CoreGui")

    -- ========== Presets Frame ==========
    Presets.Name = "Presets"
    Presets.Parent = imgui2
    Presets.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Presets.Size = UDim2.new(0, 100, 0, 100)
    Presets.Visible = false

    -- ========== Label Element ==========
    Label.Name = "Label"
    Label.Parent = Presets
    Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1.000
    Label.Size = UDim2.new(0, 91, 0, 15)
    Label.Font = tzu
    Label.Text = "Hello, World!"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13.000
    Label.TextXAlignment = Enum.TextXAlignment.Left

    -- ========== Tab Button ==========
    TabButton.Name = "TabButton"
    TabButton.Parent = Presets
    TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.BackgroundTransparency = 1.000
    TabButton.Size = UDim2.new(0, 32, 1, 0)
    TabButton.Font = tzu
    TabButton.Text = "Menu"
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 16.000

    -- ========== Folder Container ==========
    Folder.Name = "Folder"
    Folder.Parent = Presets
    Folder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Folder.BackgroundTransparency = 1.000
    Folder.ClipsDescendants = true
    Folder.Size = UDim2.new(1, 0, 0, 100)

    -- ========== Folder Header ==========
    Folder_2.Name = "Folder"
    Folder_2.Parent = Folder
    Folder_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Folder_2.BackgroundTransparency = 1.000
    Folder_2.Size = UDim2.new(1, 0, 0, 20)
    Folder_2.Image = "rbxassetid://3570695787"
    Folder_2.ImageColor3 = Color3.fromRGB(46, 45, 107)
    Folder_2.ScaleType = Enum.ScaleType.Slice
    Folder_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Folder_2.SliceScale = 0.050

    -- ========== Expand Icon ==========
    Expand.Name = "Expand"
    Expand.Parent = Folder_2
    Expand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Expand.BackgroundTransparency = 1.000
    Expand.Position = UDim2.new(0, 6, 0, 2)
    Expand.Size = UDim2.new(0, 16, 0, 16)
    Expand.ZIndex = 4
    Expand.Image = "rbxassetid://7671465363"

    -- ========== Title Label ==========
    Title.Name = "Title"
    Title.Parent = Folder_2
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0, 30, 0, 0)
    Title.Size = UDim2.new(1, -30, 1, 0)
    Title.Font = tzu
    Title.Text = "Folder"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- ========== Items Container ==========
    Items.Name = "Items"
    Items.Parent = Folder
    Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Items.BackgroundTransparency = 1.000
    Items.Position = UDim2.new(0, 10, 0, 25)
    Items.Size = UDim2.new(1, -10, 1, -25)

    -- ========== List Layout ==========
    UIListLayout.Parent = Items
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    -- ========== Main Tab ==========
    Tab.Name = "Tab"
    Tab.Parent = Presets
    Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tab.BackgroundTransparency = 1.000
    Tab.Position = UDim2.new(0, 0, 0, 30)
    Tab.Size = UDim2.new(1, 0, 1, -30)

    -- ========== Scrolling Items ==========
    Items_2.Name = "Items"
    Items_2.Parent = Tab
    Items_2.Active = true
    Items_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Items_2.BackgroundTransparency = 1.000
    Items_2.BorderSizePixel = 0
    Items_2.Position = UDim2.new(0, 10, 0, 0)
    Items_2.Size = UDim2.new(1, -20, 1, 0)
    Items_2.CanvasSize = UDim2.new(0, 0, 0, 0)
    Items_2.ScrollBarThickness = 6

    -- ========== Items Layout ==========
    UIListLayout_2.Parent = Items_2
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Padding = UDim.new(0, 5)

    -- ========== Padding Frame ==========
    Padding.Name = "Padding"
    Padding.Parent = Items_2
    Padding.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Padding.BackgroundTransparency = 1.000

    -- ========== Main Window ==========
    Main.Name = "Main"
    Main.Parent = Presets
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.BackgroundTransparency = 1.000
    Main.Position = UDim2.new(0.309293151, 0, 0.41276595, 0)
    Main.Size = UDim2.new(0, 300, 0, 22)
    Main.ZIndex = 4
    Main.Image = "rbxassetid://3570695787"
    Main.ImageColor3 = Color3.fromRGB(10, 10, 10)
    Main.ScaleType = Enum.ScaleType.Slice
    Main.SliceCenter = Rect.new(100, 100, 100, 100)
    Main.SliceScale = 0.050

    -- ========== Main Frame Border ==========
    Frame.Parent = Main
    Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0, 0, 1, -10)
    Frame.Size = UDim2.new(1, 0, 0, 10)
    Frame.ZIndex = 4

    -- ========== Frame Accent ==========
    Frame_2.Parent = Frame
    Frame_2.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
    Frame_2.BorderSizePixel = 0
    Frame_2.Position = UDim2.new(0, 0, 1, 0)
    Frame_2.Size = UDim2.new(1, 0, 0, 2)
    Frame_2.ZIndex = 2

    -- ========== Content Area ==========
    Content.Name = "Content"
    Content.Parent = Main
    Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Content.BackgroundTransparency = 1.000
    Content.ClipsDescendants = true
    Content.Position = UDim2.new(0, 0, 1, 0)
    Content.Size = UDim2.new(1, 0, 0, 200)
    Content.Image = "rbxassetid://3570695787"
    Content.ImageColor3 = Color3.fromRGB(21, 22, 23)
    Content.ScaleType = Enum.ScaleType.Slice
    Content.SliceCenter = Rect.new(100, 100, 100, 100)
    Content.SliceScale = 0.050

    -- ========== Content Frame ==========
    Frame_3.Parent = Content
    Frame_3.BackgroundColor3 = Color3.fromRGB(21, 22, 23)
    Frame_3.BorderSizePixel = 0
    Frame_3.Size = UDim2.new(1, 0, 0, 10)

    Message.Name = "Message"
    Message.Parent = Content
    Message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Message.BackgroundTransparency = 1.000
    Message.Position = UDim2.new(0, 0, 0, -22)
    Message.Size = UDim2.new(1, 0, 1, 22)
    Message.ZIndex = 3
    Message.Image = "rbxassetid://3570695787"
    Message.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Message.ImageTransparency = 1.000
    Message.ScaleType = Enum.ScaleType.Slice
    Message.SliceCenter = Rect.new(100, 100, 100, 100)
    Message.SliceScale = 0.050

    Expand_2.Name = "Expand"
    Expand_2.Parent = Main
    Expand_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Expand_2.BackgroundTransparency = 1.000
    Expand_2.Position = UDim2.new(0, 6, 0, 2)
    Expand_2.Rotation = 90.000
    Expand_2.Size = UDim2.new(0, 18, 0, 18)
    Expand_2.ZIndex = 4
    Expand_2.Image = "rbxassetid://7671465363"

    Title_2.Name = "Title"
    Title_2.Parent = Main
    Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_2.BackgroundTransparency = 1.000
    Title_2.Position = UDim2.new(0, 30, 0, 0)
    Title_2.Size = UDim2.new(1, -30, 1, 0)
    Title_2.ZIndex = 4
    Title_2.Font = tzu2
    Title_2.Text = "ImGui Demo"
    Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_2.TextSize = 15
    Title_2.TextWrapped = true
    Title_2.TextXAlignment = Enum.TextXAlignment.Left

    Shadow.Name = "Shadow"
    Shadow.Parent = Main
    Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow.BackgroundTransparency = 1.000
    Shadow.Position = UDim2.new(0, 10, 0, 10)
    Shadow.Size = UDim2.new(1, 0, 10.090909, 0)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://3570695787"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.500
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(100, 100, 100, 100)
    Shadow.SliceScale = 0.050

    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    Tabs.BorderSizePixel = 0
    Tabs.ClipsDescendants = true
    Tabs.Position = UDim2.new(0, 0, 1, 2)
    Tabs.Size = UDim2.new(1, 0, 0, 28)

    Items_3.Name = "Items"
    Items_3.Parent = Tabs
    Items_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Items_3.BackgroundTransparency = 1.000
    Items_3.Position = UDim2.new(0, 15, 0, 0)
    Items_3.Size = UDim2.new(1, -15, 1, -2)

    UIListLayout_3.Parent = Items_3
    UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_3.Padding = UDim.new(0, 15)

    Frame_4.Parent = Tabs
    Frame_4.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
    Frame_4.BorderSizePixel = 0
    Frame_4.Position = UDim2.new(0, 0, 1, -2)
    Frame_4.Size = UDim2.new(1, 0, 0, 2)
    Frame_4.ZIndex = 2

    Layer.Name = "Layer"
    Layer.Parent = Main
    Layer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer.BackgroundTransparency = 1.000
    Layer.Position = UDim2.new(0, 2, 0, 2)
    Layer.Size = UDim2.new(1, 0, 10.090909, 0)
    Layer.ZIndex = 0
    Layer.Image = "rbxassetid://3570695787"
    Layer.ImageColor3 = Color3.fromRGB(10, 10, 11)
    Layer.ScaleType = Enum.ScaleType.Slice
    Layer.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer.SliceScale = 0.050

    Dock.Name = "Dock"
    Dock.Parent = Presets
    Dock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dock.BackgroundTransparency = 1.000
    Dock.ClipsDescendants = true
    Dock.Size = UDim2.new(1, 0, 0, 22)

    UIListLayout_4.Parent = Dock
    UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_4.Padding = UDim.new(0, 5)

    Switch.Name = "Switch"
    Switch.Parent = Presets
    Switch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Switch.BackgroundTransparency = 1.000
    Switch.Size = UDim2.new(0, 70, 0, 20)

    Button.Name = "Button"
    Button.Parent = Switch
    Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundTransparency = 1.000
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0, 20, 0, 20)
    Button.ZIndex = 3
    Button.Font = tzu
    Button.Text = ""
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13.000

    ImageLabel.Parent = Button
    ImageLabel.Active = true
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1.000
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Selectable = true
    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.ZIndex = 2
    ImageLabel.Image = "rbxassetid://3570695787"
    ImageLabel.ImageColor3 = Color3.fromRGB(46, 45, 107)
    ImageLabel.ScaleType = Enum.ScaleType.Slice
    ImageLabel.SliceCenter = Rect.new(100, 100, 100, 100)
    ImageLabel.SliceScale = 0.050

    Layer_2.Name = "Layer"
    Layer_2.Parent = Button
    Layer_2.Active = true
    Layer_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Layer_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_2.BackgroundTransparency = 1.000
    Layer_2.Position = UDim2.new(0.5, 2, 0.5, 2)
    Layer_2.Selectable = true
    Layer_2.Size = UDim2.new(1, 0, 1, 0)
    Layer_2.Image = "rbxassetid://3570695787"
    Layer_2.ImageColor3 = Color3.fromRGB(21, 38, 63)
    Layer_2.ScaleType = Enum.ScaleType.Slice
    Layer_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_2.SliceScale = 0.050

    Check.Name = "Check"
    Check.Parent = Button
    Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Check.BackgroundTransparency = 1.000
    Check.Position = UDim2.new(0, 3, 0, 3)
    Check.Size = UDim2.new(1, -6, 1, -6)
    Check.ZIndex = 2
    Check.Image = "rbxassetid://7710220183"

    Text.Name = "Text"
    Text.Parent = Switch
    Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text.BackgroundTransparency = 1.000
    Text.Position = UDim2.new(0, 28, 0, 0)
    Text.Size = UDim2.new(0, 42, 1, 0)
    Text.Font = tzu
    Text.Text = "Switch"
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.TextSize = 13.000
    Text.TextXAlignment = Enum.TextXAlignment.Left

    Slider.Name = "Slider"
    Slider.Parent = Presets
    Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Slider.BackgroundTransparency = 1.000
    Slider.Size = UDim2.new(0, 150, 0, 20)

    Outer.Name = "Outer"
    Outer.Parent = Slider
    Outer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Outer.BackgroundTransparency = 1.000
    Outer.Size = UDim2.new(0, 150, 1, 0)
    Outer.Image = "rbxassetid://3570695787"
    Outer.ImageColor3 = Color3.fromRGB(59, 59, 68)
    Outer.ScaleType = Enum.ScaleType.Slice
    Outer.SliceCenter = Rect.new(100, 100, 100, 100)
    Outer.SliceScale = 0.050

    Inner.Name = "Inner"
    Inner.Parent = Outer
    Inner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Inner.BackgroundTransparency = 1.000
    Inner.Position = UDim2.new(0, 2, 0, 2)
    Inner.Size = UDim2.new(1, -4, 1, -4)
    Inner.Image = "rbxassetid://3570695787"
    Inner.ImageColor3 = Color3.fromRGB(46, 45, 107)
    Inner.ScaleType = Enum.ScaleType.Slice
    Inner.SliceCenter = Rect.new(100, 100, 100, 100)
    Inner.SliceScale = 0.050

    Slider_2.Name = "Slider"
    Slider_2.Parent = Inner
    Slider_2.BackgroundColor3 = Color3.fromRGB(49, 88, 146)
    Slider_2.BorderSizePixel = 0
    Slider_2.Position = UDim2.new(0, 10, 0, 0)
    Slider_2.Size = UDim2.new(0, 5, 1, 0)

    Value.Name = "Value"
    Value.Parent = Inner
    Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Value.BackgroundTransparency = 1.000
    Value.Size = UDim2.new(1, 0, 1, 0)
    Value.Font = tzu
    Value.Text = "6.00"
    Value.TextColor3 = Color3.fromRGB(255, 255, 255)
    Value.TextSize = 13.000

    Text_2.Name = "Text"
    Text_2.Parent = Slider
    Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text_2.BackgroundTransparency = 1.000
    Text_2.Position = UDim2.new(0, 158, 0, 0)
    Text_2.Size = UDim2.new(0, 42, 1, 0)
    Text_2.Font = tzu
    Text_2.Text = "Slider"
    Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text_2.TextSize = 13.000
    Text_2.TextXAlignment = Enum.TextXAlignment.Left

    Button_2.Name = "Button"
    Button_2.Parent = Presets
    Button_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button_2.BackgroundTransparency = 1.000
    Button_2.BorderSizePixel = 0
    Button_2.Size = UDim2.new(0, 72, 0, 20)
    Button_2.ZIndex = 3
    Button_2.Font = tzu
    Button_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button_2.TextSize = 13.000

    ImageLabel_2.Parent = Button_2
    ImageLabel_2.Active = true
    ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_2.BackgroundTransparency = 1.000
    ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel_2.Selectable = true
    ImageLabel_2.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel_2.ZIndex = 2
    ImageLabel_2.Image = "rbxassetid://3570695787"
    ImageLabel_2.ImageColor3 = Color3.fromRGB(46, 45, 107)
    ImageLabel_2.ScaleType = Enum.ScaleType.Slice
    ImageLabel_2.SliceCenter = Rect.new(100, 100, 100, 100)
    ImageLabel_2.SliceScale = 0.050

    Layer_3.Name = "Layer"
    Layer_3.Parent = Button_2
    Layer_3.Active = true
    Layer_3.AnchorPoint = Vector2.new(0.5, 0.5)
    Layer_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_3.BackgroundTransparency = 1.000
    Layer_3.Position = UDim2.new(0.5, 2, 0.5, 2)
    Layer_3.Selectable = true
    Layer_3.Size = UDim2.new(1, 0, 1, 0)
    Layer_3.Image = "rbxassetid://3570695787"
    Layer_3.ImageColor3 = Color3.fromRGB(21, 38, 63)
    Layer_3.ScaleType = Enum.ScaleType.Slice
    Layer_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_3.SliceScale = 0.050

    Card.Name = "Card"
    Card.Parent = Presets
    Card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Card.BackgroundTransparency = 1.000
    Card.Size = UDim2.new(1, 0, 0, 100)
    Card.Image = "rbxassetid://3570695787"
    Card.ScaleType = Enum.ScaleType.Slice
    Card.SliceCenter = Rect.new(100, 100, 100, 100)
    Card.SliceScale = 0.120

    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 129, 167)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 160, 168))}
    UIGradient.Rotation = 30
    UIGradient.Parent = Card

    ImageLabel_3.Parent = Card
    ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_3.BorderSizePixel = 0
    ImageLabel_3.Position = UDim2.new(0, 24, 0, 24)
    ImageLabel_3.Size = UDim2.new(0, 52, 1, -48)
    ImageLabel_3.ZIndex = 3
    ImageLabel_3.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

    Roundify.Name = "Roundify"
    Roundify.Parent = ImageLabel_3
    Roundify.AnchorPoint = Vector2.new(0.5, 0.5)
    Roundify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Roundify.BackgroundTransparency = 1.000
    Roundify.Position = UDim2.new(0.5, 0, 0.5, 0)
    Roundify.Size = UDim2.new(1, 24, 1, 24)
    Roundify.ZIndex = 3
    Roundify.Image = "rbxassetid://3570695787"
    Roundify.ImageColor3 = Color3.fromRGB(200, 200, 200)
    Roundify.ScaleType = Enum.ScaleType.Slice
    Roundify.SliceCenter = Rect.new(100, 100, 100, 100)
    Roundify.SliceScale = 0.120

    heading.Name = "heading"
    heading.Parent = Card
    heading.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    heading.BackgroundTransparency = 1.000
    heading.Position = UDim2.new(0, 100, 0, 24)
    heading.Size = UDim2.new(1, -100, 0, 50)
    heading.ZIndex = 3
    heading.Font = tzu
    heading.Text = "welcome, singularity"
    heading.TextColor3 = Color3.fromRGB(255, 255, 255)
    heading.TextSize = 13.000
    heading.TextXAlignment = Enum.TextXAlignment.Left
    heading.TextYAlignment = Enum.TextYAlignment.Top

    Frame_5.Name = "Frame"
    Frame_5.Parent = Card
    Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_5.BackgroundTransparency = 1.000
    Frame_5.Size = UDim2.new(1, 0, 1, 0)
    Frame_5.ZIndex = 2
    Frame_5.Image = "rbxassetid://3570695787"
    Frame_5.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Frame_5.ImageTransparency = 0.500
    Frame_5.ScaleType = Enum.ScaleType.Slice
    Frame_5.SliceCenter = Rect.new(100, 100, 100, 100)
    Frame_5.SliceScale = 0.120

    SubHeading.Name = "SubHeading"
    SubHeading.Parent = Card
    SubHeading.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SubHeading.BackgroundTransparency = 1.000
    SubHeading.Position = UDim2.new(0, 100, 0, 44)
    SubHeading.Size = UDim2.new(1, -100, 0, 50)
    SubHeading.ZIndex = 3
    SubHeading.Font = tzu
    SubHeading.Text = "subheading"
    SubHeading.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubHeading.TextSize = 13.000
    SubHeading.TextXAlignment = Enum.TextXAlignment.Left
    SubHeading.TextYAlignment = Enum.TextYAlignment.Top

    ColorPicker.Name = "ColorPicker"
    ColorPicker.Parent = Presets
    ColorPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ColorPicker.BackgroundTransparency = 1.000
    ColorPicker.Size = UDim2.new(0, 112, 0, 20)

    Button_3.Name = "Button"
    Button_3.Parent = ColorPicker
    Button_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button_3.BackgroundTransparency = 1.000
    Button_3.BorderSizePixel = 0
    Button_3.Size = UDim2.new(0, 20, 0, 20)
    Button_3.ZIndex = 3
    Button_3.Font = tzu
    Button_3.Text = ""
    Button_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button_3.TextSize = 13.000

    ImageLabel_4.Parent = Button_3
    ImageLabel_4.Active = true
    ImageLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_4.BackgroundTransparency = 1.000
    ImageLabel_4.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel_4.Selectable = true
    ImageLabel_4.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel_4.ZIndex = 2
    ImageLabel_4.Image = "rbxassetid://3570695787"
    ImageLabel_4.ImageColor3 = Color3.fromRGB(255, 0, 0)
    ImageLabel_4.ScaleType = Enum.ScaleType.Slice
    ImageLabel_4.SliceCenter = Rect.new(100, 100, 100, 100)
    ImageLabel_4.SliceScale = 0.050

    ImageLabel_5.Parent = ImageLabel_4
    ImageLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_5.BackgroundTransparency = 1.000
    ImageLabel_5.Position = UDim2.new(0, 4, 0, 4)
    ImageLabel_5.Size = UDim2.new(1, -8, 1, -8)
    ImageLabel_5.ZIndex = 2
    ImageLabel_5.Image = "rbxassetid://11144378537"

    Layer_4.Name = "Layer"
    Layer_4.Parent = Button_3
    Layer_4.Active = true
    Layer_4.AnchorPoint = Vector2.new(0.5, 0.5)
    Layer_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_4.BackgroundTransparency = 1.000
    Layer_4.Position = UDim2.new(0.5, 2, 0.5, 2)
    Layer_4.Selectable = true
    Layer_4.Size = UDim2.new(1, 0, 1, 0)
    Layer_4.Image = "rbxassetid://3570695787"
    Layer_4.ImageColor3 = Color3.fromRGB(127, 0, 0)
    Layer_4.ScaleType = Enum.ScaleType.Slice
    Layer_4.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_4.SliceScale = 0.050

    Text_3.Name = "Text"
    Text_3.Parent = ColorPicker
    Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text_3.BackgroundTransparency = 1.000
    Text_3.Position = UDim2.new(0, 28, 0, 0)
    Text_3.Size = UDim2.new(0, 84, 1, 0)
    Text_3.Font = tzu
    Text_3.Text = "Color Picker"
    Text_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text_3.TextSize = 13.000
    Text_3.TextXAlignment = Enum.TextXAlignment.Left

    DropdownOption.Name = "DropdownOption"
    DropdownOption.Parent = Presets
    DropdownOption.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropdownOption.BackgroundTransparency = 1.000
    DropdownOption.BorderSizePixel = 0
    DropdownOption.Size = UDim2.new(1, 0, 0, 20)
    DropdownOption.ZIndex = 3
    DropdownOption.Font = tzu
    DropdownOption.Text = "  Option"
    DropdownOption.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownOption.TextSize = 13.000
    DropdownOption.TextXAlignment = Enum.TextXAlignment.Left

    ImageLabel_6.Parent = DropdownOption
    ImageLabel_6.Active = true
    ImageLabel_6.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel_6.BackgroundTransparency = 1.000
    ImageLabel_6.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel_6.Selectable = true
    ImageLabel_6.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel_6.ZIndex = 2
    ImageLabel_6.Image = "rbxassetid://3570695787"
    ImageLabel_6.ImageColor3 = Color3.fromRGB(42, 44, 46)
    ImageLabel_6.ScaleType = Enum.ScaleType.Slice
    ImageLabel_6.SliceCenter = Rect.new(100, 100, 100, 100)
    ImageLabel_6.SliceScale = 0.050

    DropdownWindow.Name = "DropdownWindow"
    DropdownWindow.Parent = Presets
    DropdownWindow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropdownWindow.BackgroundTransparency = 1.000
    DropdownWindow.Position = UDim2.new(0.496228397, 0, 0.411765426, 0)
    DropdownWindow.Size = UDim2.new(0, 200, 0, 22)
    DropdownWindow.ZIndex = 4
    DropdownWindow.Image = "rbxassetid://3570695787"
    DropdownWindow.ImageColor3 = Color3.fromRGB(10, 10, 10)
    DropdownWindow.ScaleType = Enum.ScaleType.Slice
    DropdownWindow.SliceCenter = Rect.new(100, 100, 100, 100)
    DropdownWindow.SliceScale = 0.050

    Frame_6.Parent = DropdownWindow
    Frame_6.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Frame_6.BorderSizePixel = 0
    Frame_6.Position = UDim2.new(0, 0, 1, -10)
    Frame_6.Size = UDim2.new(1, 0, 0, 10)
    Frame_6.ZIndex = 4

    Frame_7.Parent = Frame_6
    Frame_7.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
    Frame_7.BorderSizePixel = 0
    Frame_7.Position = UDim2.new(0, 0, 1, 0)
    Frame_7.Size = UDim2.new(1, 0, 0, 2)
    Frame_7.ZIndex = 2

    Title_3.Name = "Title"
    Title_3.Parent = DropdownWindow
    Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_3.BackgroundTransparency = 1.000
    Title_3.Position = UDim2.new(0, 30, 0, 0)
    Title_3.Size = UDim2.new(1, -30, 1, 0)
    Title_3.ZIndex = 4
    Title_3.Font = tzu
    Title_3.Text = "Dropdown"
    Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_3.TextSize = 15.000
    Title_3.TextWrapped = true
    Title_3.TextXAlignment = Enum.TextXAlignment.Left

    Shadow_2.Name = "Shadow"
    Shadow_2.Parent = DropdownWindow
    Shadow_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow_2.BackgroundTransparency = 1.000
    Shadow_2.Position = UDim2.new(0, 10, 0, 10)
    Shadow_2.Size = UDim2.new(1, 0, 8.72700024, 10)
    Shadow_2.ZIndex = 0
    Shadow_2.Image = "rbxassetid://3570695787"
    Shadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow_2.ImageTransparency = 0.500
    Shadow_2.ScaleType = Enum.ScaleType.Slice
    Shadow_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Shadow_2.SliceScale = 0.050

    Layer_5.Name = "Layer"
    Layer_5.Parent = DropdownWindow
    Layer_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_5.BackgroundTransparency = 1.000
    Layer_5.Position = UDim2.new(0, 2, 0, 2)
    Layer_5.Size = UDim2.new(1, 0, 9, 2)
    Layer_5.ZIndex = 0
    Layer_5.Image = "rbxassetid://3570695787"
    Layer_5.ImageColor3 = Color3.fromRGB(10, 10, 11)
    Layer_5.ScaleType = Enum.ScaleType.Slice
    Layer_5.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_5.SliceScale = 0.050

    Content_2.Name = "Content"
    Content_2.Parent = DropdownWindow
    Content_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Content_2.BackgroundTransparency = 1.000
    Content_2.ClipsDescendants = true
    Content_2.Position = UDim2.new(0, 0, 1, 0)
    Content_2.Size = UDim2.new(1, 0, 0, 178)
    Content_2.Image = "rbxassetid://3570695787"
    Content_2.ImageColor3 = Color3.fromRGB(21, 22, 23)
    Content_2.ScaleType = Enum.ScaleType.Slice
    Content_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Content_2.SliceScale = 0.050

    Items_4.Name = "Items"
    Items_4.Parent = Content_2
    Items_4.Active = true
    Items_4.BackgroundColor3 = Color3.fromRGB(21, 22, 23)
    Items_4.BorderSizePixel = 0
    Items_4.Position = UDim2.new(0, 10, 0, 30)
    Items_4.Size = UDim2.new(1, -20, 1, -60)
    Items_4.CanvasSize = UDim2.new(0, 0, 0, 0)
    Items_4.ScrollBarThickness = 6

    UIListLayout_5.Parent = Items_4
    UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_5.Padding = UDim.new(0, 2)

    Search.Name = "Search"
    Search.Parent = Content_2
    Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Search.BackgroundTransparency = 1.000
    Search.Position = UDim2.new(0, 5, 0, 6)
    Search.Size = UDim2.new(1, -10, 0, 20)

    Outer_2.Name = "Outer"
    Outer_2.Parent = Search
    Outer_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Outer_2.BackgroundTransparency = 1.000
    Outer_2.Size = UDim2.new(1, 0, 1, 0)
    Outer_2.Image = "rbxassetid://3570695787"
    Outer_2.ImageColor3 = Color3.fromRGB(59, 59, 68)
    Outer_2.ScaleType = Enum.ScaleType.Slice
    Outer_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Outer_2.SliceScale = 0.050

    Inner_2.Name = "Inner"
    Inner_2.Parent = Outer_2
    Inner_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Inner_2.BackgroundTransparency = 1.000
    Inner_2.Position = UDim2.new(0, 2, 0, 2)
    Inner_2.Size = UDim2.new(1, -4, 1, -4)
    Inner_2.Image = "rbxassetid://3570695787"
    Inner_2.ImageColor3 = Color3.fromRGB(46, 45, 107)
    Inner_2.ScaleType = Enum.ScaleType.Slice
    Inner_2.SliceCenter = Rect.new(100, 100, 100, 100)
    Inner_2.SliceScale = 0.050

    TextBox.Name = "TextBox"
    TextBox.Parent = Inner_2
    TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.BackgroundTransparency = 1.000
    TextBox.Position = UDim2.new(0, 30, 0, 0)
    TextBox.Size = UDim2.new(1, -30, 1, 0)
    TextBox.Font = tzu
    TextBox.Text = "Search ..."
    TextBox.TextColor3 = Color3.fromRGB(178, 178, 178)
    TextBox.TextSize = 14.000
    TextBox.TextXAlignment = Enum.TextXAlignment.Left

    Selected.Name = "Selected"
    Selected.Parent = Content_2
    Selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Selected.BackgroundTransparency = 1.000
    Selected.Position = UDim2.new(0, 10, 1, -30)
    Selected.Size = UDim2.new(1, -10, 0, 30)
    Selected.Font = tzu
    Selected.Text = "Selected: [...]"
    Selected.TextColor3 = Color3.fromRGB(178, 178, 178)
    Selected.TextSize = 12.000
    Selected.TextXAlignment = Enum.TextXAlignment.Left

    Expand_3.Name = "Expand"
    Expand_3.Parent = DropdownWindow
    Expand_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Expand_3.BackgroundTransparency = 1.000
    Expand_3.Position = UDim2.new(0, 6, 0, 2)
    Expand_3.Rotation = 90.000
    Expand_3.Size = UDim2.new(0, 18, 0, 18)
    Expand_3.ZIndex = 4
    Expand_3.Image = "rbxassetid://7671465363"

    Cache.Name = "Cache"
    Cache.Parent = DropdownWindow
    Cache.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Cache.Size = UDim2.new(0, 100, 0, 100)
    Cache.Visible = false

    ColorPickerWindow.Name = "ColorPickerWindow"
    ColorPickerWindow.Parent = Presets
    ColorPickerWindow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ColorPickerWindow.BackgroundTransparency = 1.000
    ColorPickerWindow.Position = UDim2.new(0.712284446, 0, 0.110530853, 0)
    ColorPickerWindow.Size = UDim2.new(0, 200, 0, 22)
    ColorPickerWindow.ZIndex = 4
    ColorPickerWindow.Image = "rbxassetid://3570695787"
    ColorPickerWindow.ImageColor3 = Color3.fromRGB(10, 10, 10)
    ColorPickerWindow.ScaleType = Enum.ScaleType.Slice
    ColorPickerWindow.SliceCenter = Rect.new(100, 100, 100, 100)
    ColorPickerWindow.SliceScale = 0.050

    Frame_8.Parent = ColorPickerWindow
    Frame_8.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Frame_8.BorderSizePixel = 0
    Frame_8.Position = UDim2.new(0, 0, 1, -10)
    Frame_8.Size = UDim2.new(1, 0, 0, 10)
    Frame_8.ZIndex = 4

    Frame_9.Parent = Frame_8
    Frame_9.BackgroundColor3 = Color3.fromRGB(59, 59, 68)
    Frame_9.BorderSizePixel = 0
    Frame_9.Position = UDim2.new(0, 0, 1, 0)
    Frame_9.Size = UDim2.new(1, 0, 0, 2)
    Frame_9.ZIndex = 2

    Title_4.Name = "Title"
    Title_4.Parent = ColorPickerWindow
    Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_4.BackgroundTransparency = 1.000
    Title_4.Position = UDim2.new(0, 30, 0, 0)
    Title_4.Size = UDim2.new(1, -30, 1, 0)
    Title_4.ZIndex = 4
    Title_4.Font = tzu
    Title_4.Text = "Color Picker"
    Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_4.TextSize = 15.000
    Title_4.TextWrapped = true
    Title_4.TextXAlignment = Enum.TextXAlignment.Left

    Shadow_3.Name = "Shadow"
    Shadow_3.Parent = ColorPickerWindow
    Shadow_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow_3.BackgroundTransparency = 1.000
    Shadow_3.Position = UDim2.new(0, 10, 0, 10)
    Shadow_3.Size = UDim2.new(1, 0, 8.72700024, 10)
    Shadow_3.ZIndex = 0
    Shadow_3.Image = "rbxassetid://3570695787"
    Shadow_3.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow_3.ImageTransparency = 0.500
    Shadow_3.ScaleType = Enum.ScaleType.Slice
    Shadow_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Shadow_3.SliceScale = 0.050

    Layer_6.Name = "Layer"
    Layer_6.Parent = ColorPickerWindow
    Layer_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Layer_6.BackgroundTransparency = 1.000
    Layer_6.Position = UDim2.new(0, 2, 0, 2)
    Layer_6.Size = UDim2.new(1, 0, 9, 2)
    Layer_6.ZIndex = 0
    Layer_6.Image = "rbxassetid://3570695787"
    Layer_6.ImageColor3 = Color3.fromRGB(10, 10, 11)
    Layer_6.ScaleType = Enum.ScaleType.Slice
    Layer_6.SliceCenter = Rect.new(100, 100, 100, 100)
    Layer_6.SliceScale = 0.050

    Expand_4.Name = "Expand"
    Expand_4.Parent = ColorPickerWindow
    Expand_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Expand_4.BackgroundTransparency = 1.000
    Expand_4.Position = UDim2.new(0, 6, 0, 2)
    Expand_4.Rotation = 90.000
    Expand_4.Size = UDim2.new(0, 18, 0, 18)
    Expand_4.ZIndex = 4
    Expand_4.Image = "rbxassetid://7671465363"

    Content_3.Name = "Content"
    Content_3.Parent = ColorPickerWindow
    Content_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Content_3.BackgroundTransparency = 1.000
    Content_3.ClipsDescendants = true
    Content_3.Position = UDim2.new(0, 0, 1, 0)
    Content_3.Size = UDim2.new(1, 0, 0, 178)
    Content_3.Image = "rbxassetid://3570695787"
    Content_3.ImageColor3 = Color3.fromRGB(21, 22, 23)
    Content_3.ScaleType = Enum.ScaleType.Slice
    Content_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Content_3.SliceScale = 0.050

    Palette.Name = "Palette"
    Palette.Parent = Content_3
    Palette.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Palette.BackgroundTransparency = 1.000
    Palette.Position = UDim2.new(0, 10, 0, 10)
    Palette.Size = UDim2.new(1, -45, 1, -45)
    Palette.Image = "rbxassetid://698052001"

    Indicator.Name = "Indicator"
    Indicator.Parent = Palette
    Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Indicator.BackgroundTransparency = 1.000
    Indicator.Size = UDim2.new(0, 5, 0, 5)
    Indicator.Image = "rbxassetid://2851926732"

    Saturation.Name = "Saturation"
    Saturation.Parent = Content_3
    Saturation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Saturation.BackgroundTransparency = 1.000
    Saturation.Position = UDim2.new(1, -25, 0, 10)
    Saturation.Size = UDim2.new(0, 15, 1, -45)
    Saturation.Image = "rbxassetid://3641079629"

    Indicator_2.Name = "Indicator"
    Indicator_2.Parent = Saturation
    Indicator_2.BackgroundColor3 = Color3.fromRGB(49, 88, 146)
    Indicator_2.BorderSizePixel = 0
    Indicator_2.Size = UDim2.new(1, 0, 0, 2)

    FinalColor.Name = "FinalColor"
    FinalColor.Parent = Content_3
    FinalColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FinalColor.BackgroundTransparency = 1.000
    FinalColor.Position = UDim2.new(1, -25, 1, -25)
    FinalColor.Size = UDim2.new(0, 15, 0, 15)
    FinalColor.Image = "rbxassetid://3570695787"
    FinalColor.ScaleType = Enum.ScaleType.Slice
    FinalColor.SliceCenter = Rect.new(100, 100, 100, 100)
    FinalColor.SliceScale = 0.800

    SaturationColor.Name = "SaturationColor"
    SaturationColor.Parent = Content_3
    SaturationColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SaturationColor.BackgroundTransparency = 1.000
    SaturationColor.Position = UDim2.new(1, -50, 1, -25)
    SaturationColor.Size = UDim2.new(0, 15, 0, 15)
    SaturationColor.Image = "rbxassetid://3570695787"
    SaturationColor.ScaleType = Enum.ScaleType.Slice
    SaturationColor.SliceCenter = Rect.new(100, 100, 100, 100)
    SaturationColor.SliceScale = 0.800

    PaletteColor.Name = "PaletteColor"
    PaletteColor.Parent = Content_3
    PaletteColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PaletteColor.BackgroundTransparency = 1.000
    PaletteColor.Position = UDim2.new(1, -75, 1, -25)
    PaletteColor.Size = UDim2.new(0, 15, 0, 15)
    PaletteColor.Image = "rbxassetid://3570695787"
    PaletteColor.ScaleType = Enum.ScaleType.Slice
    PaletteColor.SliceCenter = Rect.new(100, 100, 100, 100)
    PaletteColor.SliceScale = 0.800

    TextLabel.Parent = Content_3
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0, 10, 1, -35)
    TextLabel.Size = UDim2.new(1, -10, 0, 35)
    TextLabel.Font = tzu
    TextLabel.Text = "Selected:"
    TextLabel.TextColor3 = Color3.fromRGB(178, 178, 178)
    TextLabel.TextSize = 12.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    Dropdown.Name = "Dropdown"
    Dropdown.Parent = Presets
    Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dropdown.BackgroundTransparency = 1.000
    Dropdown.Size = UDim2.new(0, 150, 0, 20)

    Outer_3.Name = "Outer"
    Outer_3.Parent = Dropdown
    Outer_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Outer_3.BackgroundTransparency = 1.000
    Outer_3.Size = UDim2.new(1, 0, 1, 0)
    Outer_3.Image = "rbxassetid://3570695787"
    Outer_3.ImageColor3 = Color3.fromRGB(59, 59, 68)
    Outer_3.ScaleType = Enum.ScaleType.Slice
    Outer_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Outer_3.SliceScale = 0.050

    Inner_3.Name = "Inner"
    Inner_3.Parent = Outer_3
    Inner_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Inner_3.BackgroundTransparency = 1.000
    Inner_3.Position = UDim2.new(0, 2, 0, 2)
    Inner_3.Size = UDim2.new(1, -4, 1, -4)
    Inner_3.Image = "rbxassetid://3570695787"
    Inner_3.ImageColor3 = Color3.fromRGB(46, 45, 107)
    Inner_3.ScaleType = Enum.ScaleType.Slice
    Inner_3.SliceCenter = Rect.new(100, 100, 100, 100)
    Inner_3.SliceScale = 0.050

    Value_2.Name = "Value"
    Value_2.Parent = Inner_3
    Value_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Value_2.BackgroundTransparency = 1.000
    Value_2.Position = UDim2.new(0, 10, 0, 0)
    Value_2.Size = UDim2.new(1, -10, 1, 0)
    Value_2.Font = tzu
    Value_2.Text = "Selected"
    Value_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Value_2.TextSize = 13.000
    Value_2.TextXAlignment = Enum.TextXAlignment.Left

    Text_4.Name = "Text"
    Text_4.Parent = Dropdown
    Text_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Text_4.BackgroundTransparency = 1.000
    Text_4.Position = UDim2.new(0, 158, 0, 0)
    Text_4.Size = UDim2.new(0, 56, 1, 0)
    Text_4.Font = tzu
    Text_4.Text = "Dropdown"
    Text_4.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text_4.TextSize = 13.000
    Text_4.TextXAlignment = Enum.TextXAlignment.Left

    Cache_2.Name = "Cache"
    Cache_2.Parent = imgui2
    Cache_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Cache_2.Size = UDim2.new(0, 100, 0, 100)
    Cache_2.Visible = false
end

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local ScreenGui = CoreGui:FindFirstChild("imgui2")
local Presets = ScreenGui:FindFirstChild("Presets")
local ScreenGuiCache = ScreenGui:FindFirstChild("Cache")

-- ========== Input Tracking ==========
local colorpicking = false
local sliding = false
local uiInputFocused = false  -- Track if any UI input field is focused

-- ========== Event System ==========
local event = { } do
    function event.new()
        local event event = setmetatable({
            Alive = true,
        }, {
            __tostring = function()
                return "Event"
            end,
            __call = function(...)
                event:Fire(...)
            end,
        })
        local BindableEvent = Instance.new("BindableEvent")

        function event:Connect(callback)
            local c = { }
            local Connection = BindableEvent.Event:Connect(callback)
            c.Connected = true
            function c:Disconnect()
                Connection:Disconnect()
                c.Connected = false
            end

            return c
        end

        function event:Fire(...)
            BindableEvent:Fire(...)
        end

        function event:Destroy()
            event.Alive = false
            BindableEvent:Destroy()
        end

        return event
    end
end

-- ========== Mouse Input System ==========
local mouse = { } do
    mouse.held = false
    mouse.InputBegan = event.new()
    mouse.InputEnded = event.new()
    UserInputService.InputBegan:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
            mouse.held = true
            mouse.InputBegan:Fire()
        end
    end)
    UserInputService.InputEnded:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
            mouse.held = false
            mouse.InputEnded:Fire()
        end
    end)
end

-- ========== Utility Functions ==========
local function getMouse()
    local success, result = pcall(function()
        return UserInputService:GetMouseLocation()
    end)
    
    if success and result then
        return Vector2.new(result.X + 1, result.Y - 35)
    end
    return Vector2.new(0, 0)  -- Fallback if mouse fetch fails
end

local function resize(part, new, _delay)
	_delay = _delay or 0.5
	local tweenInfo = TweenInfo.new(_delay, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = game:GetService("TweenService"):Create(part, tweenInfo, new)
	tween:Play()
end

-- ========== Window Management ==========
local windowHistory = { }
local windowCache = { }
local mouseCache = { }
local browsingWindow = { }

local function updateWindowHistory()
    for i, v in next, windowHistory do
        if i and i.Parent then  -- Check if window still exists
            local offset = 9e3 - v * 100
            i.ZIndex = rawget(windowCache[i], i) + offset
            for i2, v2 in next, i:GetDescendants() do
                if pcall(function() return v2.ZIndex end) then
                    if rawget(windowCache[i], v2) then
                        v2.ZIndex = rawget(windowCache[i], v2) + offset
                    end
                end
            end
        end
    end
end

local function cacheWindowHistory(window)
    rawset(windowCache, window, { })
    rawset(windowCache[window], window, window.ZIndex)
    for i, v in next, window:GetDescendants() do
        if pcall(function() return v.ZIndex end) then
            rawset(windowCache[window], v, v.ZIndex)
        end
    end
    window.DescendantAdded:Connect(function(descendant)
        if pcall(function() return descendant.ZIndex end) then
            rawset(windowCache[window], descendant, descendant.ZIndex)
            updateWindowHistory()
        end
    end)
end

local function setTopMost(window)
    local copy = { }
    local n = 2
    for i, v in next, windowHistory do
        if i ~= window then
            windowHistory[i] = v + 1
        end
    end
    windowHistory[window] = 1
    updateWindowHistory()
end

local function isTopMost(window)
    return rawget(windowHistory, window) == 1
end

local function isBrowsing(window)
    return not not (rawget(browsingWindow, window) or rawget(mouseCache, window))
end

local function findBrowsingTopMost()
    local copy = { }
    for i, v in next, windowHistory do
        if isBrowsing(i) then
            copy[i] = v
        end
    end
    local level, result = math.huge
    for i, v in next, copy do
        if v < level then
            level = v
            result = i
        end
    end
    return result
end

-- ========== Window Dragging System ==========
local dragger = {} do
    local draggerCache = { }
    local isDragging = false

    function dragger.new(frame)
        local held = false
        frame.Active = true

        if not frame then return end

        local mouseLeaveConn = frame.MouseLeave:connect(function()
            draggerCache[frame] = false
        end)

        local mouseEnterConn = frame.MouseEnter:connect(function()
            draggerCache[frame] = true
        end)

        mouse.InputBegan:Connect(function()
            if findBrowsingTopMost() == frame then
                if (not colorpicking) and (not sliding) and not isDragging and rawget(draggerCache, frame) then
                    isDragging = true
                    local objectPosition = Vector2.new(getMouse().X - frame.AbsolutePosition.X, getMouse().Y - frame.AbsolutePosition.Y)
                    while mouse.held and isDragging do
                        pcall(function()
                            local mousePos = getMouse()
                            local newX = mousePos.X - objectPosition.X + (frame.Size.X.Offset * frame.AnchorPoint.X)
                            local newY = mousePos.Y - objectPosition.Y + (frame.Size.Y.Offset * frame.AnchorPoint.Y)
                            
                            -- Clamp to screen bounds
                            local screenSize = frame.Parent.AbsoluteSize
                            newX = math.max(0, math.min(newX, screenSize.X - frame.AbsoluteSize.X))
                            newY = math.max(0, math.min(newY, screenSize.Y - frame.AbsoluteSize.Y))
                            
                            resize(frame, { Position = UDim2.new(0, newX, 0, newY) }, 0.1)
                        end)
                        RunService.Heartbeat:Wait()
                    end
                    isDragging = false
                end
            end
        end)
    end
end

local function betweenOpenInterval(n, n1, n2)
    return n <= n2 and n >= n1
end

local function betweenClosedInterval(n, n1, n2)
    return n < n2 and n > n1
end

local function rgbtohsv(color)
    if not color then
        return 0, 0, 0
    end
    
    -- Safe color extraction
    local r, g, b
    pcall(function()
        r = math.clamp(color.r or 0, 0, 1)
        g = math.clamp(color.g or 0, 0, 1)
        b = math.clamp(color.b or 0, 0, 1)
    end)
    
    r, g, b = r or 0, g or 0, b or 0
    
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, v = 0, 0, 0
    v = max

    local d = max - min
    if max == 0 then
        s = 0
    else
        s = d / max
    end

    if max == min then
        h = 0
    else
        if max == r then
            h = (g - b) / d
            if g < b then
                h = h + 6
            end
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end

    return h, s, v
end
local function new(n)
    return Presets:FindFirstChild(n):Clone()
end

local function tint(c)
    return Color3.new(c.R * 0.5, c.G * 0.5, c.B * 0.5)
end

local function bleach(c)
    return Color3.new(c.R * 1.2, c.G * 1.2, c.B * 1.2)
end

local function hoverColor(object)
    local originalColor = object.ImageColor3
    object.MouseEnter:Connect(function()
        object.ImageColor3 = tint(originalColor)
    end)
    object.MouseLeave:Connect(function()
        object.ImageColor3 = originalColor
    end)
end

-- ========== Settings & Configuration ==========
local settings = {
    new = function(default)
        local function l(r)
            return tostring(r):lower()
        end
        return { handle = function(options)
            local self = { }
            options = typeof(options) == "table" and options or { }
            
            -- Validate and set defaults
            for i, v in next, default do
                self[l(i)] = v
            end
            
            -- Override with provided options (type-safe)
            for i, v in next, options do
                local key = l(i)
                if typeof(default[key]) == typeof(options[l(i)]) or typeof(options[l(i)]) == "nil" then
                    self[key] = v
                else
                    warn(string.format("Type mismatch for option '%s': expected %s, got %s", i, typeof(default[key]), typeof(v)))
                end
            end
            
            return self
        end }
    end,
}

-- ========== Main Library Object ==========
local library library = {
    isInputFocused = function()
        return uiInputFocused
    end,
    
    clearUI = function()
        for i, v in next, windowHistory do
            v:Destroy()
        end
        windowHistory = {}
        windowCache = {}
        mouseCache = {}
        browsingWindow = {}
    end,
    
    getWindowCount = function()
        local count = 0
        for _ in next, windowHistory do
            count = count + 1
        end
        return count
    end,
    
    new = function(options)
        local cache = { }
        local self = {
            isopen = true,
        }

        options = settings.new({
            text = "New Window",
            size = Vector2.new(300, 200),
            shadow = 10,
            transparency = 0.2,
            color = Color3.fromRGB(46, 45, 107),
            boardcolor = Color3.fromRGB(21, 22, 23),
            rounding = 5,
            animation = 0.1,
            position = UDim2.new(0, 100, 0, 100),
        }).handle(options)

        local main = new("Main") main.Parent = ScreenGui
        local content = main:FindFirstChild("Content")
        local tabs = main:FindFirstChild("Tabs")
        local shadow = main:FindFirstChild("Shadow")
        local layer = main:FindFirstChild("Layer")
        local expand = main:FindFirstChild("Expand")

        main.Position = options.position
        content.ImageTransparency = options.transparency
        layer.ImageTransparency = options.transparency
        shadow.ImageTransparency = 0.6 * (options.transparency + 1)

        expand.MouseButton1Click:Connect(function()
            if self.isopen then
                self.close()
            else
                self.open()
            end
        end)

        dragger.new(main)
        main:FindFirstChild("Title").Text = options.text
        main.ImageColor3 = options.color
        main:FindFirstChild("Frame").BackgroundColor3 = options.color
        main.Size = UDim2.new(0, options.size.X, 0, main.Size.Y.Offset)
        main.SliceScale = options.rounding / 100

        content.ImageColor3 = options.boardcolor
        content.Size = UDim2.new(1, 0, 0, options.size.Y)
        content.SliceScale = options.rounding / 100

        function cache.update_layers(y)
            shadow.Position = UDim2.new(0, options.shadow, 0, options.shadow)
            shadow.Size = UDim2.new(1, 0, 0, y)
            shadow.SliceScale = options.rounding / 100
            layer.Size = UDim2.new(1, 0, 0, y)
            layer.SliceScale = options.rounding / 100
        end cache.update_layers(main.AbsoluteSize.Y + content.AbsoluteSize.Y)

        content:GetPropertyChangedSignal("Size"):Connect(function()
            cache.update_layers(main.AbsoluteSize.Y + content.AbsoluteSize.Y)
        end)

        function self.new(tabOptions)
            local self = { }
            tabOptions = settings.new({
                text = "New Tab",
            }).handle(tabOptions)

            local tabbutton = new("TabButton")
            local tabbuttons = tabs:FindFirstChild("Items")
            tabbutton.Parent = tabbuttons
            tabbutton.Text = tabOptions.text
            tabbutton.Font = tzu3
            tabbutton.TextSize = 15
            tabbutton.Size = UDim2.new(0, tabbutton.TextBounds.X, 1, 0)
            tabbutton.TextColor3 = Color3.new(0.4, 0.4, 0.4)
            tabbutton.MouseButton1Click:Connect(function()
                self.show()
            end)

            local tab = new("Tab")
            tab.Parent = content
            local items = tab:FindFirstChild("Items")
            tab.Visible = false

            local function countSize(o, horizontal)
                if not o:FindFirstChildOfClass("UIListLayout") then
                    return
                end
                local padding = o:FindFirstChildOfClass("UIListLayout").Padding.Offset
                local X, Y = 0, 0
                local _horizontal = 0
                for i, v in next, o:GetChildren() do
                    if not v:IsA("UIListLayout") then
                        Y = Y + v.AbsoluteSize.Y + padding
                        if v.AbsoluteSize.X > X then
                            X = v.AbsoluteSize.X
                        end
                        _horizontal = _horizontal + v.AbsoluteSize.X + padding
                    end
                end
                if horizontal then
                    return Vector2.new(_horizontal, 0)
                end
                return Vector2.new(X, Y)
            end

            local function updateCanvas()
                local XY = countSize(items)
                if XY then
                    items.CanvasSize = UDim2.new(0, XY.X, 0, XY.Y)
                end
            end

            items.ScrollBarImageColor3 = Color3.new()
            items.ChildAdded:Connect(updateCanvas)
            items.ChildRemoved:Connect(updateCanvas)

            local types = { } do
                function types.label(labelOptions)
                    local self = { }

                    labelOptions = settings.new({
                        text = "New Label",
                        color = Color3.new(1, 1, 1),
                    }).handle(labelOptions)

                    local label = new("Label")
                    label.Parent = items 
                    label.Text = labelOptions.text
                    label.TextSize = 13
                    label.Size = UDim2.new(0, label.TextBounds.X, 0, label.Size.Y.Offset)
                    label.TextColor3 = labelOptions.color

                    function self.setText(text)
                        label.Text = text
                        label.Size = UDim2.new(0, label.TextBounds.X, 0, label.Size.Y.Offset)
                    end

                    function self.setColor(color)
                        label.TextColor3 = color
                    end

                    function self:Destroy()
                        label:Destroy()
                    end

                    self.self = label
                    return self
                end

                function types.button(buttonOptions)
                    local self = { }
                    self.eventBlock = false

                    buttonOptions = settings.new({
                        text = "New Button",
                        color = options.color,
                        rounding = options.rounding,
                    }).handle(buttonOptions)

                    local button = new("Button")
                    button.Parent = items
                    button.Text = buttonOptions.text
                    button.Size = UDim2.new(0, button.TextBounds.X + 20, 0, 20)
                    button.MouseButton1Click:Connect(function()
                        if not self.eventBlock then
                            self.event:Fire()
                        end
                    end)

                    local ImageLabel = button:FindFirstChild("ImageLabel")
                    local Layer = button:FindFirstChild("Layer")
                    ImageLabel.ImageColor3 = buttonOptions.color
                    Layer.ImageColor3 = tint(buttonOptions.color)
                    ImageLabel.SliceScale = buttonOptions.rounding / 100
                    Layer.SliceScale = buttonOptions.rounding / 100
                    hoverColor(ImageLabel)

                    function self.setColor(color)
                        ImageLabel.ImageColor3 = color
                        Layer.ImageColor3 = tint(color)
                    end

                    function self.getColor()
                        return ImageLabel.ImageColor3
                    end

                    function self:Destroy()
                        button:Destroy()
                    end

                    self.options = buttonOptions
                    self.self = button
                    self.event = event.new()
                    return self
                end

                function types.switch(switchOptions)
                    local self = { }
                    self.on = false

                    switchOptions = settings.new({
                        text = "New Switch",
                        on = false,
                        color = options.color,
                        rounding = options.rounding,
                        animation = options.animation,
                    }).handle(switchOptions)
                    self.on = switchOptions.on
                    self.eventBlock = false

                    local switch = new("Switch")
                    switch.Parent = items
                    local button = switch:FindFirstChild("Button")
                    local text = switch:FindFirstChild("Text")
                    local check = button:FindFirstChild("Check")
                    local ImageLabel = button:FindFirstChild("ImageLabel")
                    local layer = button:FindFirstChild("Layer")
                    ImageLabel.ImageColor3 = switchOptions.color
                    layer.ImageColor3 = tint(switchOptions.color)
                    ImageLabel.SliceScale = switchOptions.rounding / 100
                    layer.SliceScale = switchOptions.rounding / 100

                    text:GetPropertyChangedSignal("Text"):Connect(function()
                        switch.Size = UDim2.new(0, 28 + text.TextBounds.X, 0, 20)
                    end)

                    text.Text = switchOptions.text
                    check.ImageTransparency = self.on and 0 or 1

                    button.MouseButton1Click:Connect(function()
                        self.switch()
                    end)

                    function self.switch()
                        self.set(not self.on)
                    end

                    function self.set(boolean)
                        if (not not boolean) == self.on then return end
                        self.on = not not boolean
                        resize(check, { ImageTransparency = self.on and 0 or 1 }, switchOptions.animation)
                        if not self.eventBlock then
                            self.event:Fire(self.on)
                        end
                    end

                    function self.setColor(color)
                        ImageLabel.ImageColor3 = switchOptions.color
                        Layer.ImageColor3 = tint(switchOptions.color)
                    end

                    function self.getColor()
                        return ImageLabel.ImageColor3
                    end

                    function self:Destroy()
                        switch:Destroy()
                    end

                    self.options = switchOptions
                    self.self = switch
                    self.event = event.new()
                    return self
                end

                function types.slider(sliderOptions)
                    local self = { }

                    sliderOptions = settings.new({
                        text = "New Slider",
                        size = 150,
                        min = 0,
                        max = 100,
                        value = 0,
                        color = options.color,
                        barcolor = bleach(options.color),
                        rounding = options.rounding,
                        animation = options.animation,
                    }).handle(sliderOptions)
                    
                    -- Validate min/max
                    if sliderOptions.min == sliderOptions.max then
                        sliderOptions.max = sliderOptions.min + 1
                    end
                    
                    self.value = math.clamp(sliderOptions.value, math.min(sliderOptions.min, sliderOptions.max), math.max(sliderOptions.min, sliderOptions.max))
                    self.event = event.new()
                    self.eventBlock = false
                    
                    local function round(x, n)
                        if x == 0 then
                            return "0"
                        end
                        local a = tostring(x * 10^n)
                        return a:sub(1, -(n + 1)) .. "." .. a:sub(-n)
                    end

                    local slider = new("Slider")
                    slider.Parent = items

                    local text = slider:FindFirstChild("Text")
                    local outer = slider:FindFirstChild("Outer")
                    local inner = outer:FindFirstChild("Inner")
                    local _slider = inner:FindFirstChild("Slider")
                    local value = inner:FindFirstChild("Value")
                    inner.ClipsDescendants = true

                    outer.SliceScale = sliderOptions.rounding / 100
                    inner.SliceScale = sliderOptions.rounding / 100
                    inner.ImageColor3 = sliderOptions.color
                    _slider.BackgroundColor3 = sliderOptions.barcolor

                    function self.setColor(color)
                        inner.ImageColor3 = color
                        _slider.BackgroundColor3 = bleach(color)
                    end

                    function self.getColor(color)
                        return inner.ImageColor3
                    end

                    text.Text = sliderOptions.text
                    outer.Size = UDim2.new(0, sliderOptions.size, 0, 20)
                    text.Position = UDim2.new(0, sliderOptions.size + 8, 0, 0)
                    slider.Size = UDim2.new(0, sliderOptions.size + 8 + text.TextBounds.X, 0, 20)

                    local function set(p)
                        resize(_slider, { Position = UDim2.new(math.clamp(p, 0, 1), -2.5, 0, 0) }, sliderOptions.animation)
                    end

                    value.Text = round(self.value, 2)
                    local old

                    function self.set(n)
                        n = tonumber(n)
                        if not n then return end
                        
                        local min, max
                        if sliderOptions.max > sliderOptions.min then
                            max = sliderOptions.max
                            min = sliderOptions.min
                            n = math.clamp(n, sliderOptions.min, sliderOptions.max)
                        else
                            max = sliderOptions.min
                            min = sliderOptions.max
                            n = math.clamp(n, sliderOptions.max, sliderOptions.min)
                        end
                        
                        self.value = n
                        if self.value ~= old then
                            if not self.eventBlock then
                                self.event:Fire(self.value)
                            end
                        end
                        old = self.value
                        value.Text = round(self.value, 2)
                        local d = math.abs(max - min)
                        if d > 0 then
                            local p = (n - min) / d
                            set(p)
                        end
                    end
                    self.set(self.value)

                    local inside = false
                    inner.MouseEnter:Connect(function()
                        inside = true
                    end)
                    inner.MouseLeave:Connect(function()
                        inside = false
                    end)

                    mouse.InputBegan:Connect(function()
                        spawn(function()
                            if inside and findBrowsingTopMost() == main then
                                while mouse.held do
                                    sliding = true
                                    local p = getMouse()
                                    local x = math.floor(math.clamp(p.X - inner.AbsolutePosition.X, 0, sliderOptions.size))
                                    local m = sliderOptions.size / math.max(1, math.abs(sliderOptions.max - sliderOptions.min))
                                    local v = math.floor(x / m)
                                    self.set(v + (sliderOptions.min < sliderOptions.max and sliderOptions.min or sliderOptions.max))
                                    RunService.Heartbeat:Wait()
                                end
                            end
                        end)
                    end)
                    mouse.InputEnded:Connect(function()
                        sliding = false
                    end)

                    function self:Destroy()
                        slider:Destroy()
                    end

                    updateCanvas()
                    self.options = sliderOptions
                    self.self = slider
                    return self
                end

                function types.color(colorOptions)
                    local self = { }
                    self.event = event.new()
                    self.isopen = true
                    self.visible = false
                    self.eventBlock = false

                    colorOptions = settings.new({
                        text = "New Color Picker",
                        color = Color3.new(1, 0, 0),
                        position = UDim2.new(0, 100, 0, 100),
                    }).handle(colorOptions)

                    local colorPickerButton = new("ColorPicker")
                    colorPickerButton.Parent = items
                    local colorPicker = new("ColorPickerWindow")
                    colorPicker.Parent = ScreenGui
                    colorPicker.Visible = self.visible
                    dragger.new(colorPicker)

                    local text = colorPickerButton:FindFirstChild("Text")
                    local button = colorPickerButton:FindFirstChild("Button")
                    local ImageLabel = button:FindFirstChild("ImageLabel")
                    local layer = button:FindFirstChild("Layer")

                    text:GetPropertyChangedSignal("Text"):Connect(function()
                        colorPickerButton.Size = UDim2.new(0, 28 + text.TextBounds.X, 0, 20)
                        colorPicker:FindFirstChild("Title").Text = text.Text
                    end)

                    text.Text = colorOptions.text

                    button.MouseButton1Click:Connect(function()
                        self.visible = not self.visible
                        colorPicker.Visible = self.visible
                        if self.visible then
                            colorPicker.Position = UDim2.new(0, colorPickerButton.AbsolutePosition.X + colorPickerButton.AbsoluteSize.X, 0, colorPickerButton.AbsolutePosition.Y)
                            self.open()
                            setTopMost(colorPicker)
                        end
                    end)

                    local colorCache = { }
                    function self.close()
                        if not self.isopen then return end
                        self.isopen = false

                        resize(colorPicker:FindFirstChild("Expand"), { Rotation = 0 }, options.animation)
                        colorCache.content_size = 200
                        colorCache.tabs_size = tabs.Size.Y.Offset
                        resize(colorPicker:FindFirstChild("Content"), { Size = UDim2.new(1, 0, 0, 0) }, options.animation)
                    end

                    function self.open()
                        if self.isopen then return end
                        self.isopen = true

                        resize(colorPicker:FindFirstChild("Expand"), { Rotation = 90 }, options.animation)
                        resize(colorPicker:FindFirstChild("Content"), { Size = UDim2.new(1, 0, 0, colorCache.content_size) }, options.animation)
                    end

                    function colorCache.update_layers(y)
                        colorPicker:FindFirstChild("Shadow").Position = UDim2.new(0, options.shadow, 0, options.shadow)
                        colorPicker:FindFirstChild("Shadow").Size = UDim2.new(1, 0, 0, y)
                        colorPicker:FindFirstChild("Shadow").SliceScale = options.rounding / 100
                        colorPicker:FindFirstChild("Layer").Size = UDim2.new(1, 0, 0, y)
                        colorPicker:FindFirstChild("Layer").SliceScale = options.rounding / 100
                    end colorCache.update_layers(colorPicker.AbsoluteSize.Y + colorPicker:FindFirstChild("Content").AbsoluteSize.Y)

                    colorPicker:FindFirstChild("Content"):GetPropertyChangedSignal("Size"):Connect(function()
                        colorCache.update_layers(main.AbsoluteSize.Y + colorPicker:FindFirstChild("Content").AbsoluteSize.Y)
                    end)

                    do -- Start closed, then open
                        local old = options.animation
                        options.animation = 0
                        self.open()
                        options.animation = old
                    end

                    colorPicker:FindFirstChild("Expand").MouseButton1Click:Connect(function()
                        if self.isopen then
                            self.close()
                        else
                            self.open()
                        end
                    end)

                    do -- color picking
                        local content = colorPicker:FindFirstChild("Content")
                        local palette = content:FindFirstChild("Palette")
                        local saturation = content:FindFirstChild("Saturation")

                        local paletteIndicator = palette:FindFirstChild("Indicator")
                        local saturationIndicator = saturation:FindFirstChild("Indicator")

                        local h = 0
                        local s = 1
                        local v = 1

                        function self.get()
                            return Color3.fromHSV(h, s, v)
                        end

                        local function update()
                            local color = self.get()
                            button:FindFirstChild("ImageLabel").ImageColor3 = color
                            button:FindFirstChild("Layer").ImageColor3 = tint(color)
                            content:FindFirstChild("FinalColor").ImageColor3 = color
                            content:FindFirstChild("PaletteColor").ImageColor3 = Color3.fromHSV(h, s, 1)
                            content:FindFirstChild("SaturationColor").ImageColor3 = Color3.fromHSV(0, 0, v)
                            local v2 = v < 0.5 and 1 or 0
                            ImageLabel:FindFirstChild("ImageLabel").ImageColor3 = Color3.fromHSV(0, 0, v2)
                            if not self.eventBlock then
                                self.event:Fire(color)
                            end
                        end

                        local Entered1, Entered2 = false, false
                        palette.MouseEnter:Connect(function()
                            Entered1 = true
                        end)
                        palette.MouseLeave:Connect(function()
                            Entered1 = false
                        end)
                        saturation.MouseEnter:Connect(function()
                            Entered2 = true
                        end)
                        saturation.MouseLeave:Connect(function()
                            Entered2 = false
                        end)

                        mouse.InputBegan:Connect(function()
                            if Entered1 and findBrowsingTopMost() == colorPicker then
                                spawn(function()
                                    colorpicking = true
                                    while mouse.held do -- palette
                                        local p = getMouse()
                                        local x1 = math.clamp(p.X - palette.AbsolutePosition.X, 0, palette.AbsoluteSize.X)
                                        local v1 = x1 / palette.AbsoluteSize.X
                                        local x2 = math.clamp(p.Y - palette.AbsolutePosition.Y, 0, palette.AbsoluteSize.Y)
                                        local v2 = x2 / palette.AbsoluteSize.Y
                                        h = 1 - v1
                                        s = 1 - v2

                                        local sv1 = math.clamp(v1, 0, (palette.AbsoluteSize.X - 6) / palette.AbsoluteSize.X)
                                        local sv2 = math.clamp(v2, 0, (palette.AbsoluteSize.Y - 6) / palette.AbsoluteSize.Y)
                                        resize(paletteIndicator, { Position = UDim2.new(sv1, 0, sv2, 0) }, options.animation)

                                        update()
                                        RunService.Heartbeat:Wait()
                                    end
                                end)
                            end
                            if Entered2 and findBrowsingTopMost() == colorPicker then
                                spawn(function()
                                    colorpicking = true
                                    while mouse.held do -- saturation
                                        local p = getMouse()
                                        local x1 = math.clamp(p.Y - saturation.AbsolutePosition.Y, 0, saturation.AbsoluteSize.Y)
                                        local v1 = x1 / saturation.AbsoluteSize.Y
                                        v = 1 - v1

                                        local sv1 = math.clamp(v1, 0, (palette.AbsoluteSize.Y - 2) / palette.AbsoluteSize.Y)
                                        resize(saturationIndicator, { Position = UDim2.new(0, 0, sv1, 0) }, options.animation)

                                        update()
                                        RunService.Heartbeat:Wait()
                                    end
                                end)
                            end
                        end)

                        mouse.InputEnded:Connect(function()
                            colorpicking = false
                        end)

                        function self.set(color)
                            local h2, s2, v2 = rgbtohsv(color)
                            h = h2
                            s = s2
                            v = v2

                            local hx = math.clamp(1 - h, 0, (palette.AbsoluteSize.X - 6) / palette.AbsoluteSize.X)
                            local sx = math.clamp(1 - s, 0, (palette.AbsoluteSize.Y - 6) / palette.AbsoluteSize.Y)
                            local vx = math.clamp(1 - v, 0, (saturation.AbsoluteSize.Y - 2) / saturation.AbsoluteSize.Y)
                            resize(paletteIndicator, { Position = UDim2.new(hx, 0, sx, 0) }, options.animation)
                            resize(saturationIndicator, { Position = UDim2.new(0, 0, vx, 0) }, options.animation)

                            update()
                        end

                        update()
                    end

                    function self.setPosition(position)
                        colorPicker.Position = position
                    end

                    function self:Destroy()
                        colorPickerButton:Destroy()
                        colorPicker:Destroy()
                    end

                    self.self = colorPickerButton
                    if colorOptions.color ~= Color3.new(1, 0, 0) then
                        self.set(colorOptions.color)
                    end
                    self.close()
                    return self
                end

                function types.dropdown(dropdownOptions)
                    local self = { }
                    self.isopen = true
                    self.visible = false
                    self.selected = nil
                    self.event = event.new()
                    self.eventBlock = false

                    dropdownOptions = settings.new({
                        text = "New Dropdown",
                        size = 150,
                        color = Color3.fromRGB(53, 63, 119),
                        rounding = options.rounding,
                        selectioncolor = Color3.fromRGB(53, 63, 119),
                    }).handle(dropdownOptions)

                    local dropdownButton = new("Dropdown")
                    local dropdownWindow = new("DropdownWindow")
                    dropdownWindow.Parent = ScreenGui
                    dropdownWindow.Visible = self.visible
                    dragger.new(dropdownWindow)
                    dropdownButton.Parent = items

                    local text = dropdownButton:FindFirstChild("Text")
                    local outer = dropdownButton:FindFirstChild("Outer")
                    local inner = outer:FindFirstChild("Inner")
                    inner.ImageColor3 = dropdownOptions.color
                    outer.SliceScale = dropdownOptions.rounding / 100
                    inner.SliceScale = dropdownOptions.rounding / 100
                    inner:FindFirstChild("Value").Text = "[ ... ]"

                    text.Text = dropdownOptions.text
                    dropdownWindow:FindFirstChild("Title").Text = dropdownOptions.text
                    outer.Size = UDim2.new(0, dropdownOptions.size, 0, 20)
                    text.Position = UDim2.new(0, dropdownOptions.size + 8, 0, 0)

                    inner.MouseButton1Click:Connect(function()
                        self.visible = not self.visible
                        dropdownWindow.Visible = self.visible
                        if self.visible then
                            dropdownWindow.Position = UDim2.new(0, dropdownButton.AbsolutePosition.X + dropdownButton.AbsoluteSize.X, 0, dropdownButton.AbsolutePosition.Y)
                            self.open()
                            setTopMost(dropdownWindow)
                        end
                    end)

                    dropdownWindow:FindFirstChild("Expand").MouseButton1Click:Connect(function()
                        if self.isopen then
                            self.close()
                        else
                            self.open()
                        end
                    end)

                    local dropdownCache = { }
                    function self.close()
                        if not self.isopen then return end
                        self.isopen = false

                        resize(dropdownWindow:FindFirstChild("Expand"), { Rotation = 0 }, options.animation)
                        dropdownCache.content_size = 200
                        dropdownCache.tabs_size = tabs.Size.Y.Offset
                        resize(dropdownWindow:FindFirstChild("Content"), { Size = UDim2.new(1, 0, 0, 0) }, options.animation)
                    end

                    function self.open()
                        if self.isopen then return end
                        self.isopen = true

                        resize(dropdownWindow:FindFirstChild("Expand"), { Rotation = 90 }, options.animation)
                        resize(dropdownWindow:FindFirstChild("Content"), { Size = UDim2.new(1, 0, 0, dropdownCache.content_size) }, options.animation)
                    end

                    function dropdownCache.update_layers(y)
                        dropdownWindow:FindFirstChild("Shadow").Position = UDim2.new(0, options.shadow, 0, options.shadow)
                        dropdownWindow:FindFirstChild("Shadow").Size = UDim2.new(1, 0, 0, y)
                        dropdownWindow:FindFirstChild("Shadow").SliceScale = options.rounding / 100
                        dropdownWindow:FindFirstChild("Layer").Size = UDim2.new(1, 0, 0, y)
                        dropdownWindow:FindFirstChild("Layer").SliceScale = options.rounding / 100
                    end dropdownCache.update_layers(dropdownWindow.AbsoluteSize.Y + dropdownWindow:FindFirstChild("Content").AbsoluteSize.Y)

                    dropdownWindow:FindFirstChild("Content"):GetPropertyChangedSignal("Size"):Connect(function()
                        dropdownCache.update_layers(main.AbsoluteSize.Y + dropdownWindow:FindFirstChild("Content").AbsoluteSize.Y)
                    end)

                    local dropdownItems = dropdownWindow:FindFirstChild("Content"):FindFirstChild("Items")
                    local function updateCanvas()
                        local XY = countSize(dropdownItems)
                        if XY then
                            dropdownItems.CanvasSize = UDim2.new(0, 0, 0, XY.Y)
                        end
                    end

                    dropdownItems.ScrollBarImageColor3 = Color3.new()
                    dropdownItems.ChildAdded:Connect(updateCanvas)
                    dropdownItems.ChildRemoved:Connect(updateCanvas)

                    local dropdownObjects = { }
                    function self.new(name)
                        local dropdownObject = { }
                        dropdownObject.selected = false
                        dropdownObject.name = name
                        assert(rawget(dropdownObjects, name) == nil, string.format("object already exists in dropdown '%s'", dropdownOptions.text))
                        rawset(dropdownObjects, name, dropdownObject)

                        local dropdownOption = new("DropdownOption")
                        dropdownObject.object = dropdownOption
                        local content = dropdownWindow:FindFirstChild("Content")
                        dropdownOption.Parent = dropdownItems
                        dropdownOption.Text = "  " .. name
                        dropdownOption.Font = tzu
                        dropdownOption.TextColor3 = Color3.fromRGB(178, 178, 178)
                        dropdownOption.MouseButton1Click:Connect(function()
                            if findBrowsingTopMost() == dropdownWindow then
                                dropdownObject:Select()
                            end
                        end)

                        function dropdownObject.Select()
                            self.selected = name
                            for i, v in next, dropdownObjects do
                                v.selected = false
                                resize(v.object, { TextColor3 = Color3.fromRGB(178, 178, 178) }, 0.1)
                                resize(v.object:GetChildren()[1], { ImageColor3 = Color3.fromRGB(42, 44, 46) }, 0.1)
                            end
                            dropdownObjects[name].selected = true
                            resize(dropdownOption, { TextColor3 = Color3.new(1, 1, 1) }, 0.1)
                            resize(dropdownOption:GetChildren()[1], { ImageColor3 = dropdownOptions.selectioncolor }, 0.1)
                            inner:FindFirstChild("Value").Text = string.format("[ %s ]", name)
                            dropdownWindow:FindFirstChild("Content"):FindFirstChild("Selected").Text = string.format("[ %s ]", name)
                            if not self.eventBlock then
                                self.event:Fire(name)
                            end
                        end

                        function dropdownObject.Destroy()
                            if rawget(dropdownObject, name) then
                                inner:FindFirstChild("Value").Text = "[ ... ]"
                                dropdownWindow:FindFirstChild("Content"):FindFirstChild("Selected").Text = "[ ... ]"
                            end
                            self.selected = nil
                            rawset(dropdownObject, name, nil)
                        end

                        return dropdownObject
                    end

                    do -- search bar
                        local searchFrame = dropdownWindow:FindFirstChild("Content"):FindFirstChild("Search")
                        local outer = searchFrame:FindFirstChild("Outer")
                        local inner = outer:FindFirstChild("Inner")
                        local TextBox = inner:FindFirstChild("TextBox")
                        
                        local searchText = ""
                        local canType = false
                        local showCursor = false
                        local lastTick = tick()
                        local searchConnections = {}

                        TextBox.Visible = false
                        
                        local displayText = Instance.new("TextLabel")
                        displayText.Size = UDim2.new(1, -30, 1, 0)
                        displayText.Position = UDim2.new(0, 30, 0, 0)
                        displayText.BackgroundTransparency = 1
                        displayText.Text = "Search ..."
                        displayText.TextColor3 = Color3.fromRGB(178, 178, 178)
                        displayText.TextXAlignment = Enum.TextXAlignment.Left
                        displayText.Font = Enum.Font.SourceSans
                        displayText.TextSize = 14
                        displayText.ZIndex = inner.ZIndex + 1
                        displayText.Parent = inner

                        local searchIcon = Instance.new("ImageLabel")
                        searchIcon.Size = UDim2.new(0, 16, 0, 16)
                        searchIcon.Position = UDim2.new(0, 7, 0.5, -8)
                        searchIcon.BackgroundTransparency = 1
                        searchIcon.Image = "rbxassetid://11144378537"
                        searchIcon.ImageColor3 = Color3.fromRGB(178, 178, 178)
                        searchIcon.ZIndex = inner.ZIndex + 1
                        searchIcon.Parent = inner

                        local searchCache = {}
                        local function performSearch(query)
                            query = query:lower()
                            local visibleCount = 0
                            
                            for name, obj in next, dropdownObjects do
                                local matches = query == "" or name:lower():find(query, 1, true)
                                obj.object.Visible = not not matches
                                if matches then visibleCount = visibleCount + 1 end
                            end
                            
                            updateCanvas()
                            return visibleCount
                        end

                        function self.search(query)
                            return performSearch(query)
                        end

                        local function updateTextDisplay()
                            if canType then
                                local txt = searchText
                                if showCursor then
                                    txt = txt .. "|"
                                end
                                displayText.Text = txt
                                displayText.TextColor3 = Color3.new(1, 1, 1)
                                searchIcon.ImageColor3 = Color3.new(1, 1, 1)
                            else
                                if searchText == "" then
                                    displayText.Text = "Search ..."
                                    displayText.TextColor3 = Color3.fromRGB(178, 178, 178)
                                    searchIcon.ImageColor3 = Color3.fromRGB(178, 178, 178)
                                else
                                    displayText.Text = searchText
                                    displayText.TextColor3 = Color3.new(1, 1, 1)
                                    searchIcon.ImageColor3 = Color3.new(1, 1, 1)
                                end
                            end
                        end

                        local clickArea = Instance.new("TextButton")
                        clickArea.Size = UDim2.new(1, 0, 1, 0)
                        clickArea.Position = UDim2.new(0, 0, 0, 0)
                        clickArea.BackgroundTransparency = 1
                        clickArea.Text = ""
                        clickArea.ZIndex = inner.ZIndex + 2
                        clickArea.Parent = inner

                        local cursorThread = nil
                        local clickConn = clickArea.MouseButton1Click:Connect(function()
                            if findBrowsingTopMost() == dropdownWindow then
                                if not canType then
                                    canType = true
                                    uiInputFocused = true
                                    updateTextDisplay()
                                    
                                    if cursorThread then pcall(function() task.cancel(cursorThread) end) end
                                    cursorThread = task.spawn(function()
                                        while canType do
                                            if tick() - lastTick >= 0.5 then
                                                lastTick = tick()
                                                showCursor = not showCursor
                                                updateTextDisplay()
                                            end
                                            RunService.Heartbeat:Wait()
                                        end
                                    end)
                                end
                            end
                        end)
                        table.insert(searchConnections, clickConn)

                        local inputConn = UserInputService.InputBegan:Connect(function(inputObject)
                            if canType and findBrowsingTopMost() == dropdownWindow then
                                local keycode = inputObject.KeyCode
                                local handled = false
                                
                                if keycode == Enum.KeyCode.Return or keycode == Enum.KeyCode.KeypadEnter then
                                    canType = false
                                    uiInputFocused = false
                                    showCursor = false
                                    updateTextDisplay()
                                    handled = true
                                elseif keycode == Enum.KeyCode.Escape then
                                    canType = false
                                    uiInputFocused = false
                                    searchText = ""
                                    showCursor = false
                                    performSearch("")
                                    updateTextDisplay()
                                    handled = true
                                elseif keycode == Enum.KeyCode.Backspace then
                                    searchText = searchText:sub(1, -2)
                                    performSearch(searchText)
                                    updateTextDisplay()
                                    handled = true
                                elseif keycode == Enum.KeyCode.Space then
                                    searchText = searchText .. " "
                                    performSearch(searchText)
                                    updateTextDisplay()
                                    handled = true
                                else
                                    local keyName = keycode.Name
                                    local char = nil
                                    
                                    if #keyName == 1 and keyName:match("%a") then
                                        local isShift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
                                        char = isShift and keyName or keyName:lower()
                                    end
                                    
                                    local numMap = {
                                        Zero = "0", One = "1", Two = "2", Three = "3", Four = "4",
                                        Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9"
                                    }
                                    if numMap[keyName] then char = numMap[keyName] end
                                    
                                    local kpMap = {
                                        KeypadZero = "0", KeypadOne = "1", KeypadTwo = "2", KeypadThree = "3", KeypadFour = "4",
                                        KeypadFive = "5", KeypadSix = "6", KeypadSeven = "7", KeypadEight = "8", KeypadNine = "9"
                                    }
                                    if kpMap[keyName] then char = kpMap[keyName] end
                                    
                                    if char then
                                        searchText = searchText .. char
                                        performSearch(searchText)
                                        updateTextDisplay()
                                        handled = true
                                    end
                                end
                                
                                if handled then
                                    return
                                end
                            end
                        end)
                        table.insert(searchConnections, inputConn)

                        local clearButton = Instance.new("TextButton")
                        clearButton.Size = UDim2.new(0, 20, 1, 0)
                        clearButton.Position = UDim2.new(1, -20, 0, 0)
                        clearButton.BackgroundTransparency = 1
                        clearButton.Text = "X"
                        clearButton.TextColor3 = Color3.fromRGB(178, 178, 178)
                        clearButton.Font = Enum.Font.SourceSansBold
                        clearButton.TextSize = 14
                        clearButton.ZIndex = inner.ZIndex + 2
                        clearButton.Parent = inner

                        local clearConn = clearButton.MouseButton1Click:Connect(function()
                            searchText = ""
                            canType = true
                            showCursor = false
                            performSearch("")
                            updateTextDisplay()
                        end)
                        table.insert(searchConnections, clearConn)

                        local enterConn = clearButton.MouseEnter:Connect(function()
                            clearButton.TextColor3 = Color3.new(1, 1, 1)
                        end)
                        table.insert(searchConnections, enterConn)

                        local leaveConn = clearButton.MouseLeave:Connect(function()
                            clearButton.TextColor3 = Color3.fromRGB(178, 178, 178)
                        end)
                        table.insert(searchConnections, leaveConn)

                        local clickOutConn = UserInputService.InputBegan:Connect(function(inputObject)
                            if inputObject.UserInputType == Enum.UserInputType.MouseButton1 and canType then
                                local mousePos = UserInputService:GetMouseLocation()
                                local innerAbsPos = inner.AbsolutePosition
                                local innerAbsSize = inner.AbsoluteSize
                                
                                if innerAbsPos and innerAbsSize and (not (mousePos.X >= innerAbsPos.X and mousePos.X <= innerAbsPos.X + innerAbsSize.X and
                                    mousePos.Y >= innerAbsPos.Y and mousePos.Y <= innerAbsPos.Y + innerAbsSize.Y)) then
                                    canType = false
                                    uiInputFocused = false
                                    showCursor = false
                                    updateTextDisplay()
                                end
                            end
                        end)
                        table.insert(searchConnections, clickOutConn)

                        -- Store cleanup function
                        local oldDestroy = self.Destroy or function() end
                        function self.Destroy()
                            if cursorThread then pcall(function() task.cancel(cursorThread) end) end
                            for _, conn in ipairs(searchConnections) do
                                if conn and conn.Connected then
                                    conn:Disconnect()
                                end
                            end
                            searchConnections = {}
                        end

                        updateTextDisplay()
                    end

                    function self.setPosition(position)
                        dropdownWindow.Position = position
                    end

                    function self:Destroy()
                        dropdownButton:Destroy()
                        dropdownWindow:Destroy()
                    end

                    self.self = dropdownButton
                    self.close()
                    return self
                end

                function types.input(inputOptions)
                    local self = {}

                    local UserInputService = game:GetService("UserInputService")
                    local RunService = game:GetService("RunService")
                    local TextService = game:GetService("TextService")

                    self.event = event.new()
                    self.eventBlock = false

                    inputOptions = settings.new({
                        text = "New Input",
                        placeholder = "Enter text...",
                        color = options.color,
                        rounding = options.rounding,
                        clearonfocus = true,
                        size = 150,
                        maxlength = 512,
                        numbersonly = false,
                        allowspaces = true,
                        selectable = false,
                    }).handle(inputOptions)

                    local input = new("Dropdown")
                    input.Parent = items

                    local outer = input:FindFirstChild("Outer")
                    local inner = outer:FindFirstChild("Inner")
                    local value = inner:FindFirstChild("Value")
                    local label = input:FindFirstChild("Text")

                    local textBox = Instance.new("TextBox")
                    textBox.Size = UDim2.new(0, 0, 0, 0)
                    textBox.Position = UDim2.new(-10, 0, -10, 0)
                    textBox.BackgroundTransparency = 1
                    textBox.Text = ""
                    textBox.TextColor3 = Color3.new(0, 0, 0)
                    textBox.ClearTextOnFocus = false
                    textBox.Parent = inner
                    textBox.Visible = false
                    textBox.MultiLine = false
                    textBox.ClipsDescendants = true

                    outer.SliceScale = inputOptions.rounding / 100
                    inner.SliceScale = inputOptions.rounding / 100
                    inner.ImageColor3 = inputOptions.color

                    label.Text = inputOptions.text
                    outer.Size = UDim2.new(0, inputOptions.size, 0, 20)
                    label.Position = UDim2.new(0, inputOptions.size + 8, 0, 0)
                    input.Size = UDim2.new(0, inputOptions.size + 8 + label.TextBounds.X, 0, 20)

                    local textValue = ""
                    local canType = false
                    local showCursor = false
                    local hasFocused = false
                    local lastTick = tick()
                    local textOffset = 0
                    local connections = {}

                    inner.Active = true
                    inner.AutoButtonColor = false
                    inner.Selectable = false

                    local function formatText(text)
                        if inputOptions.numbersonly then
                            return text:gsub("%D", "")
                        end
                        if not inputOptions.allowspaces then
                            return text:gsub(" ", "")
                        end
                        return text
                    end

                    local function getDisplayText(text, maxWidth)
                        if maxWidth <= 0 or #text == 0 then
                            return ""
                        end

                        local textSize = TextService:GetTextSize(text, value.TextSize, value.Font, Vector2.new(math.huge, math.huge))
                        
                        if textSize.X <= maxWidth then
                            return text
                        end

                        -- Calculate visible characters
                        local avgCharWidth = textSize.X / #text
                        local visibleChars = math.floor((maxWidth - 4) / avgCharWidth)
                        if visibleChars < 1 then visibleChars = 1 end
                        
                        -- Clamp text offset
                        if textOffset > #text - visibleChars then
                            textOffset = math.max(0, #text - visibleChars)
                        end
                        if textOffset < 0 then
                            textOffset = 0
                        end
                        
                        return text:sub(textOffset + 1, textOffset + visibleChars)
                    end

                    local function updateTextDisplay()
                        if not inner or not inner.Parent then return end
                        if canType then
                            local displayText = textValue
                            if showCursor then
                                displayText = displayText .. "|"
                            end
                            local maxWidth = math.max(20, inner.AbsoluteSize.X - 20)
                            value.Text = getDisplayText(displayText, maxWidth)
                            value.TextColor3 = Color3.new(1, 1, 1)
                        elseif textValue == "" then
                            value.Text = inputOptions.placeholder
                            value.TextColor3 = Color3.fromRGB(178, 178, 178)
                        else
                            local maxWidth = math.max(20, inner.AbsoluteSize.X - 20)
                            value.Text = getDisplayText(textValue, maxWidth)
                            value.TextColor3 = Color3.new(1, 1, 1)
                        end
                    end

                    local function updateDisplay()
                        textOffset = 0
                        updateTextDisplay()
                    end

                    local updateDisplayConn = inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateDisplay)
                    table.insert(connections, updateDisplayConn)

                    local clickConn = inner.MouseButton1Click:Connect(function()
                        if not canType then
                            canType = true
                            uiInputFocused = true

                            if inputOptions.clearonfocus and not hasFocused then
                                textValue = ""
                                textOffset = 0
                                hasFocused = true
                            end

                            textBox.Visible = true
                            textBox.Text = textValue
                            textBox:CaptureFocus()

                            updateTextDisplay()
                        end
                    end)
                    table.insert(connections, clickConn)

                    local focusConn = textBox.FocusLost:Connect(function()
                        if canType then
                            canType = false
                            uiInputFocused = false
                            showCursor = false
                            textBox.Visible = false
                            textOffset = 0

                            local finalText = formatText(textBox.Text):sub(1, inputOptions.maxlength)
                            textValue = finalText
                            if not self.eventBlock then
                                self.event:Fire(textValue)
                            end
                            updateTextDisplay()
                        end
                    end)
                    table.insert(connections, focusConn)

                    local textChangeConn = textBox:GetPropertyChangedSignal("Text"):Connect(function()
                        if canType then
                            local newText = formatText(textBox.Text)
                            if #newText > inputOptions.maxlength then
                                newText = newText:sub(1, inputOptions.maxlength)
                                textBox.Text = newText
                            end
                            textValue = newText
                            
                            -- Auto-scroll to show cursor at end
                            if #textValue > 0 then
                                local maxWidth = math.max(20, inner.AbsoluteSize.X - 20)
                                local textSize = TextService:GetTextSize(textValue, value.TextSize, value.Font, Vector2.new(math.huge, math.huge))
                                if textSize.X > maxWidth then
                                    local avgCharWidth = textSize.X / #textValue
                                    textOffset = math.max(0, #textValue - math.floor(maxWidth / avgCharWidth))
                                else
                                    textOffset = 0
                                end
                            end
                            
                            updateTextDisplay()
                            if not self.eventBlock then
                                self.event:Fire(textValue)
                            end
                        end
                    end)
                    table.insert(connections, textChangeConn)

                    -- Cursor blinking
                    local cursorThread = nil
                    local function startCursorBlink()
                        if cursorThread then pcall(function() task.cancel(cursorThread) end) end
                        cursorThread = task.spawn(function()
                            while canType do
                                if tick() - lastTick >= 0.5 then
                                    lastTick = tick()
                                    showCursor = not showCursor
                                    updateTextDisplay()
                                end
                                RunService.Heartbeat:Wait()
                            end
                        end)
                    end

                    -- Replace the old spawn with task-based approach
                    local oldFocus = textBox.FocusLost:Connect(function() end)
                    oldFocus:Disconnect()

                    local focusGainedConn = textBox.Focused:Connect(function()
                        if canType then
                            startCursorBlink()
                        end
                    end)
                    table.insert(connections, focusGainedConn)

                    function self.setText(text)
                        if text then
                            text = tostring(text)
                            text = formatText(text):sub(1, inputOptions.maxlength)
                            textValue = text
                            textBox.Text = text
                            textOffset = 0
                            updateTextDisplay()
                            if not self.eventBlock then
                                self.event:Fire(textValue)
                            end
                        end
                    end

                    function self.getText()
                        return textValue
                    end

                    function self.clear()
                        textValue = ""
                        textBox.Text = ""
                        textOffset = 0
                        updateTextDisplay()
                        if not self.eventBlock then
                            self.event:Fire("")
                        end
                    end

                    function self.setColor(color)
                        inner.ImageColor3 = color
                    end

                    function self.getColor()
                        return inner.ImageColor3
                    end

                    function self.setMaxLength(length)
                        inputOptions.maxlength = math.max(1, tonumber(length) or 512)
                        if #textValue > inputOptions.maxlength then
                            self.setText(textValue:sub(1, inputOptions.maxlength))
                        end
                    end

                    function self.setNumbersOnly(numbersOnly)
                        inputOptions.numbersonly = not not numbersOnly
                        if inputOptions.numbersonly then
                            self.setText(textValue)
                        end
                    end

                    function self.setPlaceholder(placeholder)
                        inputOptions.placeholder = tostring(placeholder)
                        updateTextDisplay()
                    end

                    function self:Destroy()
                        canType = false
                        uiInputFocused = false
                        if cursorThread then pcall(function() task.cancel(cursorThread) end) end
                        for _, conn in ipairs(connections) do
                            if conn and conn.Connected then
                                conn:Disconnect()
                            end
                        end
                        connections = {}
                        if textBox and textBox.Parent then
                            textBox:Destroy()
                        end
                        if input and input.Parent then
                            input:Destroy()
                        end
                    end

                    self.options = inputOptions
                    self.self = input

                    updateTextDisplay()

                    return self
                end
				
                function types.spacer(spacerOptions)
                    local self = {}

                    spacerOptions = settings.new({
                        size = 10,
                    }).handle(spacerOptions)

                    local spacer = Instance.new("Frame")
                    spacer.Parent = items
                    spacer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    spacer.BackgroundTransparency = 1
                    spacer.BorderSizePixel = 0
                    spacer.Size = UDim2.new(1, 0, 0, spacerOptions.size)

                    function self:Destroy()
                        spacer:Destroy()
                    end

                    self.self = spacer
                    return self
                end

                function types.separator(separatorOptions)
                    local self = {}

                    separatorOptions = settings.new({
                        color = Color3.fromRGB(59, 59, 68),
                        thickness = 1,
                        padding = 8,
                    }).handle(separatorOptions)

                    local container = Instance.new("Frame")
                    container.Parent = items
                    container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    container.BackgroundTransparency = 1
                    container.BorderSizePixel = 0
                    container.Size = UDim2.new(1, 0, 0, separatorOptions.padding * 2 + separatorOptions.thickness)

                    local separator = Instance.new("Frame")
                    separator.Parent = container
                    separator.BackgroundColor3 = separatorOptions.color
                    separator.BorderSizePixel = 0
                    separator.Size = UDim2.new(1, -20, 0, separatorOptions.thickness)
                    separator.Position = UDim2.new(0, 10, 0, separatorOptions.padding)

                    function self.setColor(color)
                        separator.BackgroundColor3 = color
                    end

                    function self:Destroy()
                        container:Destroy()
                    end

                    self.self = container
                    return self
                end
				
                function types.textbox(textboxOptions)
                    local self = {}
                    
                    local UserInputService = game:GetService("UserInputService")
                    local RunService = game:GetService("RunService")
                    local TextService = game:GetService("TextService")

                    self.event = event.new()
                    self.eventBlock = false

                    textboxOptions = settings.new({
                        text = "New TextBox",
                        placeholder = "Enter text...",
                        color = options.color,
                        rounding = options.rounding,
                        size = UDim2.new(1, -20, 0, 100),
                        maxlength = 2048,
                        numbersonly = false,
                    }).handle(textboxOptions)

                    local textboxContainer = Instance.new("Frame")
                    textboxContainer.Parent = items
                    textboxContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    textboxContainer.BackgroundTransparency = 1
                    textboxContainer.Size = textboxOptions.size
                    textboxContainer.BorderSizePixel = 0

                    local label = Instance.new("TextLabel")
                    label.Parent = textboxContainer
                    label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    label.BackgroundTransparency = 1
                    label.Size = UDim2.new(1, 0, 0, 15)
                    label.Font = tzu
                    label.Text = textboxOptions.text
                    label.TextColor3 = Color3.fromRGB(200, 200, 200)
                    label.TextSize = 12
                    label.TextXAlignment = Enum.TextXAlignment.Left

                    local outer = Instance.new("ImageLabel")
                    outer.Parent = textboxContainer
                    outer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    outer.BackgroundTransparency = 1
                    outer.Position = UDim2.new(0, 0, 0, 18)
                    outer.Size = UDim2.new(1, 0, 1, -18)
                    outer.Image = "rbxassetid://3570695787"
                    outer.ImageColor3 = Color3.fromRGB(59, 59, 68)
                    outer.ScaleType = Enum.ScaleType.Slice
                    outer.SliceCenter = Rect.new(100, 100, 100, 100)
                    outer.SliceScale = textboxOptions.rounding / 100

                    local inner = Instance.new("ImageLabel")
                    inner.Parent = outer
                    inner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    inner.BackgroundTransparency = 1
                    inner.Position = UDim2.new(0, 2, 0, 2)
                    inner.Size = UDim2.new(1, -4, 1, -4)
                    inner.Image = "rbxassetid://3570695787"
                    inner.ImageColor3 = Color3.fromRGB(46, 45, 107)
                    inner.ScaleType = Enum.ScaleType.Slice
                    inner.SliceCenter = Rect.new(100, 100, 100, 100)
                    inner.SliceScale = textboxOptions.rounding / 100
                    inner.ClipsDescendants = true

                    local textBox = Instance.new("TextBox")
                    textBox.Parent = inner
                    textBox.BackgroundColor3 = Color3.fromRGB(46, 45, 107)
                    textBox.BorderSizePixel = 0
                    textBox.Position = UDim2.new(0, 5, 0, 5)
                    textBox.Size = UDim2.new(1, -10, 1, -10)
                    textBox.Font = Enum.Font.SourceSans
                    textBox.TextColor3 = Color3.new(1, 1, 1)
                    textBox.TextSize = 13
                    textBox.TextWrapped = true
                    textBox.TextYAlignment = Enum.TextYAlignment.Top
                    textBox.ClearTextOnFocus = false
                    textBox.MultiLine = true
                    textBox.Text = ""

                    local textValue = ""
                    local connections = {}

                    local function formatText(text)
                        if textboxOptions.numbersonly then
                            return text:gsub("%D", "")
                        end
                        return text
                    end

                    local textChangeConn = textBox:GetPropertyChangedSignal("Text"):Connect(function()
                        local newText = formatText(textBox.Text)
                        if #newText > textboxOptions.maxlength then
                            newText = newText:sub(1, textboxOptions.maxlength)
                            textBox.Text = newText
                        end
                        textValue = newText
                        if not self.eventBlock then
                            self.event:Fire(textValue)
                        end
                    end)
                    table.insert(connections, textChangeConn)

                    local focusConn = textBox.FocusLost:Connect(function()
                        uiInputFocused = false
                    end)
                    table.insert(connections, focusConn)

                    local focusGainConn = textBox.Focused:Connect(function()
                        uiInputFocused = true
                    end)
                    table.insert(connections, focusGainConn)

                    function self.setText(text)
                        text = tostring(text)
                        text = formatText(text):sub(1, textboxOptions.maxlength)
                        textValue = text
                        textBox.Text = text
                        if not self.eventBlock then
                            self.event:Fire(textValue)
                        end
                    end

                    function self.getText()
                        return textValue
                    end

                    function self.clear()
                        textValue = ""
                        textBox.Text = ""
                        if not self.eventBlock then
                            self.event:Fire("")
                        end
                    end

                    function self.setColor(color)
                        inner.ImageColor3 = color
                        textBox.BackgroundColor3 = color
                    end

                    function self.getColor()
                        return inner.ImageColor3
                    end

                    function self.setMaxLength(length)
                        textboxOptions.maxlength = math.max(1, tonumber(length) or 2048)
                        if #textValue > textboxOptions.maxlength then
                            self.setText(textValue:sub(1, textboxOptions.maxlength))
                        end
                    end

                    function self:Destroy()
                        uiInputFocused = false
                        for _, conn in ipairs(connections) do
                            if conn and conn.Connected then
                                conn:Disconnect()
                            end
                        end
                        connections = {}
                        textBox:Destroy()
                        textboxContainer:Destroy()
                    end

                    self.options = textboxOptions
                    self.self = textboxContainer

                    return self
                end

                function types.number(numberOptions)
                    local self = {}
                    
                    local TextService = game:GetService("TextService")

                    self.event = event.new()
                    self.eventBlock = false

                    numberOptions = settings.new({
                        text = "Number",
                        value = 0,
                        min = 0,
                        max = 100,
                        step = 1,
                        color = options.color,
                        rounding = options.rounding,
                        size = 120,
                    }).handle(numberOptions)

                    local number = new("Dropdown")
                    number.Parent = items

                    local outer = number:FindFirstChild("Outer")
                    local inner = outer:FindFirstChild("Inner")
                    local value = inner:FindFirstChild("Value")
                    local label = number:FindFirstChild("Text")

                    outer.SliceScale = numberOptions.rounding / 100
                    inner.SliceScale = numberOptions.rounding / 100
                    inner.ImageColor3 = numberOptions.color

                    label.Text = numberOptions.text
                    outer.Size = UDim2.new(0, numberOptions.size, 0, 20)
                    label.Position = UDim2.new(0, numberOptions.size + 8, 0, 0)
                    number.Size = UDim2.new(0, numberOptions.size + 8 + label.TextBounds.X, 0, 20)

                    local currentValue = math.clamp(numberOptions.value, numberOptions.min, numberOptions.max)
                    local connections = {}

                    local buttonsContainer = Instance.new("Frame")
                    buttonsContainer.Parent = inner
                    buttonsContainer.BackgroundTransparency = 1
                    buttonsContainer.Size = UDim2.new(0, 40, 1, 0)
                    buttonsContainer.Position = UDim2.new(1, -40, 0, 0)
                    buttonsContainer.BorderSizePixel = 0

                    local btnDown = Instance.new("TextButton")
                    btnDown.Parent = buttonsContainer
                    btnDown.BackgroundColor3 = Color3.fromRGB(46, 45, 107)
                    btnDown.BorderSizePixel = 0
                    btnDown.Size = UDim2.new(0.5, 0, 1, 0)
                    btnDown.Position = UDim2.new(0, 0, 0, 0)
                    btnDown.Font = Enum.Font.SourceSansBold
                    btnDown.Text = "-"
                    btnDown.TextColor3 = Color3.new(1, 1, 1)
                    btnDown.TextSize = 14
                    btnDown.ZIndex = inner.ZIndex + 1

                    local btnUp = Instance.new("TextButton")
                    btnUp.Parent = buttonsContainer
                    btnUp.BackgroundColor3 = Color3.fromRGB(46, 45, 107)
                    btnUp.BorderSizePixel = 0
                    btnUp.Size = UDim2.new(0.5, 0, 1, 0)
                    btnUp.Position = UDim2.new(0.5, 0, 0, 0)
                    btnUp.Font = Enum.Font.SourceSansBold
                    btnUp.Text = "+"
                    btnUp.TextColor3 = Color3.new(1, 1, 1)
                    btnUp.TextSize = 14
                    btnUp.ZIndex = inner.ZIndex + 1

                    local function updateDisplay()
                        value.Text = tostring(currentValue)
                        value.TextColor3 = Color3.new(1, 1, 1)
                    end

                    local function setValue(newVal)
                        newVal = math.clamp(tonumber(newVal) or currentValue, numberOptions.min, numberOptions.max)
                        if newVal ~= currentValue then
                            currentValue = newVal
                            updateDisplay()
                            if not self.eventBlock then
                                self.event:Fire(currentValue)
                            end
                        end
                    end

                    local downConn = btnDown.MouseButton1Click:Connect(function()
                        setValue(currentValue - numberOptions.step)
                    end)
                    table.insert(connections, downConn)

                    local upConn = btnUp.MouseButton1Click:Connect(function()
                        setValue(currentValue + numberOptions.step)
                    end)
                    table.insert(connections, upConn)

                    local textBox = Instance.new("TextBox")
                    textBox.Parent = inner
                    textBox.Size = UDim2.new(1, -45, 1, 0)
                    textBox.Position = UDim2.new(0, 5, 0, 0)
                    textBox.BackgroundTransparency = 1
                    textBox.TextXAlignment = Enum.TextXAlignment.Center
                    textBox.Font = Enum.Font.SourceSans
                    textBox.TextColor3 = Color3.new(0, 0, 0)
                    textBox.TextSize = 13
                    textBox.ZIndex = inner.ZIndex

                    local textChangeConn = textBox:GetPropertyChangedSignal("Text"):Connect(function()
                        local txt = textBox.Text:gsub("%D", "")
                        if txt ~= textBox.Text then
                            textBox.Text = txt
                        end
                    end)
                    table.insert(connections, textChangeConn)

                    local focusLostConn = textBox.FocusLost:Connect(function()
                        local txt = textBox.Text
                        if txt ~= "" then
                            setValue(tonumber(txt))
                        else
                            updateDisplay()
                        end
                    end)
                    table.insert(connections, focusLostConn)

                    function self.set(val)
                        setValue(val)
                    end

                    function self.get()
                        return currentValue
                    end

                    function self.setColor(color)
                        inner.ImageColor3 = color
                        btnDown.BackgroundColor3 = color
                        btnUp.BackgroundColor3 = color
                    end

                    function self.getColor()
                        return inner.ImageColor3
                    end

                    function self:Destroy()
                        for _, conn in ipairs(connections) do
                            if conn and conn.Connected then
                                conn:Disconnect()
                            end
                        end
                        connections = {}
                        textBox:Destroy()
                        number:Destroy()
                    end

                    self.options = numberOptions
                    self.self = number
                    updateDisplay()

                    return self
                end

                function types.checkbox(checkboxOptions)
                    local self = {}
                    self.checked = false

                    checkboxOptions = settings.new({
                        text = "Checkbox",
                        checked = false,
                        color = options.color,
                        rounding = options.rounding,
                    }).handle(checkboxOptions)

                    self.checked = checkboxOptions.checked
                    self.eventBlock = false
                    self.event = event.new()

                    local checkbox = Instance.new("Frame")
                    checkbox.Parent = items
                    checkbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    checkbox.BackgroundTransparency = 1
                    checkbox.BorderSizePixel = 0
                    checkbox.Size = UDim2.new(1, 0, 0, 20)

                    local box = Instance.new("ImageLabel")
                    box.Parent = checkbox
                    box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    box.BackgroundTransparency = 1
                    box.Position = UDim2.new(0, 0, 0.5, -10)
                    box.Size = UDim2.new(0, 20, 0, 20)
                    box.Image = "rbxassetid://3570695787"
                    box.ImageColor3 = Color3.fromRGB(59, 59, 68)
                    box.ScaleType = Enum.ScaleType.Slice
                    box.SliceCenter = Rect.new(100, 100, 100, 100)
                    box.SliceScale = checkboxOptions.rounding / 100

                    local inner = Instance.new("ImageLabel")
                    inner.Parent = box
                    inner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    inner.BackgroundTransparency = 1
                    inner.Position = UDim2.new(0, 2, 0, 2)
                    inner.Size = UDim2.new(1, -4, 1, -4)
                    inner.Image = "rbxassetid://3570695787"
                    inner.ImageColor3 = checkboxOptions.color
                    inner.ScaleType = Enum.ScaleType.Slice
                    inner.SliceCenter = Rect.new(100, 100, 100, 100)
                    inner.SliceScale = checkboxOptions.rounding / 100

                    local check = Instance.new("ImageLabel")
                    check.Parent = inner
                    check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    check.BackgroundTransparency = 1
                    check.Position = UDim2.new(0, 2, 0, 2)
                    check.Size = UDim2.new(1, -4, 1, -4)
                    check.Image = "rbxassetid://7710220183"
                    check.ImageTransparency = self.checked and 0 or 1
                    check.ZIndex = inner.ZIndex + 1

                    local text = Instance.new("TextLabel")
                    text.Parent = checkbox
                    text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    text.BackgroundTransparency = 1
                    text.Position = UDim2.new(0, 28, 0, 0)
                    text.Size = UDim2.new(1, -28, 1, 0)
                    text.Font = tzu
                    text.Text = checkboxOptions.text
                    text.TextColor3 = Color3.fromRGB(255, 255, 255)
                    text.TextSize = 13
                    text.TextXAlignment = Enum.TextXAlignment.Left

                    local clickArea = Instance.new("TextButton")
                    clickArea.Parent = checkbox
                    clickArea.BackgroundTransparency = 1
                    clickArea.Size = UDim2.new(1, 0, 1, 0)
                    clickArea.Text = ""
                    clickArea.ZIndex = box.ZIndex + 1

                    local function updateCheck()
                        resize(check, { ImageTransparency = self.checked and 0 or 1 }, options.animation)
                    end

                    local clickConn = clickArea.MouseButton1Click:Connect(function()
                        if findBrowsingTopMost() == main then
                            self.checked = not self.checked
                            updateCheck()
                            if not self.eventBlock then
                                self.event:Fire(self.checked)
                            end
                        end
                    end)

                    function self.set(bool)
                        if (not not bool) == self.checked then return end
                        self.checked = not not bool
                        updateCheck()
                        if not self.eventBlock then
                            self.event:Fire(self.checked)
                        end
                    end

                    function self.toggle()
                        self.set(not self.checked)
                    end

                    function self.setColor(color)
                        inner.ImageColor3 = color
                    end

                    function self.getColor()
                        return inner.ImageColor3
                    end

                    function self:Destroy()
                        if clickConn and clickConn.Connected then
                            clickConn:Disconnect()
                        end
                        checkbox:Destroy()
                    end

                    self.options = checkboxOptions
                    self.self = checkbox

                    return self
                end

                function types.progressbar(progressOptions)
                    local self = {}
                    self.value = 0

                    progressOptions = settings.new({
                        text = "Progress",
                        value = 0,
                        max = 100,
                        size = 200,
                        color = Color3.fromRGB(49, 88, 146),
                        backgroundColor = Color3.fromRGB(59, 59, 68),
                        showtext = true,
                        animation = options.animation,
                    }).handle(progressOptions)

                    local container = Instance.new("Frame")
                    container.Parent = items
                    container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    container.BackgroundTransparency = 1
                    container.BorderSizePixel = 0
                    container.Size = UDim2.new(0, progressOptions.size + 50, 0, 35)

                    local label = Instance.new("TextLabel")
                    label.Parent = container
                    label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    label.BackgroundTransparency = 1
                    label.Size = UDim2.new(1, 0, 0, 15)
                    label.Font = tzu
                    label.Text = progressOptions.text
                    label.TextColor3 = Color3.fromRGB(200, 200, 200)
                    label.TextSize = 12
                    label.TextXAlignment = Enum.TextXAlignment.Left

                    local outer = Instance.new("ImageLabel")
                    outer.Parent = container
                    outer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    outer.BackgroundTransparency = 1
                    outer.Position = UDim2.new(0, 0, 0, 18)
                    outer.Size = UDim2.new(0, progressOptions.size, 0, 17)
                    outer.Image = "rbxassetid://3570695787"
                    outer.ImageColor3 = progressOptions.backgroundColor
                    outer.ScaleType = Enum.ScaleType.Slice
                    outer.SliceCenter = Rect.new(100, 100, 100, 100)
                    outer.SliceScale = 0.05

                    local inner = Instance.new("ImageLabel")
                    inner.Parent = outer
                    inner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    inner.BackgroundTransparency = 1
                    inner.Position = UDim2.new(0, 2, 0, 2)
                    inner.Size = UDim2.new(1, -4, 1, -4)
                    inner.Image = "rbxassetid://3570695787"
                    inner.ImageColor3 = progressOptions.backgroundColor
                    inner.ScaleType = Enum.ScaleType.Slice
                    inner.SliceCenter = Rect.new(100, 100, 100, 100)
                    inner.SliceScale = 0.05
                    inner.ClipsDescendants = true
                    inner.BorderSizePixel = 0

                    local bar = Instance.new("ImageLabel")
                    bar.Parent = inner
                    bar.BackgroundColor3 = progressOptions.color
                    bar.BorderSizePixel = 0
                    bar.Size = UDim2.new(0, 0, 1, 0)
                    bar.Image = "rbxassetid://3570695787"
                    bar.ImageColor3 = progressOptions.color
                    bar.ScaleType = Enum.ScaleType.Slice
                    bar.SliceCenter = Rect.new(100, 100, 100, 100)
                    bar.SliceScale = 0.05

                    local text = Instance.new("TextLabel")
                    text.Parent = container
                    text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    text.BackgroundTransparency = 1
                    text.Position = UDim2.new(0, progressOptions.size + 5, 0, 18)
                    text.Size = UDim2.new(0, 45, 0, 17)
                    text.Font = tzu
                    text.Text = "0%"
                    text.TextColor3 = Color3.new(1, 1, 1)
                    text.TextSize = 13

                    function self.set(val)
                        if progressOptions.max <= 0 then
                            progressOptions.max = 100
                        end
                        val = math.clamp(tonumber(val) or 0, 0, progressOptions.max)
                        self.value = val
                        local percent = math.clamp(val / progressOptions.max, 0, 1)
                        
                        resize(bar, { Size = UDim2.new(percent, 0, 1, 0) }, progressOptions.animation)
                        
                        if progressOptions.showtext then
                            text.Text = math.floor((percent * 100) + 0.5) .. "%"
                        end
                    end

                    function self.get()
                        return self.value
                    end

                    function self.setColor(color)
                        bar.BackgroundColor3 = color
                        bar.ImageColor3 = color
                    end

                    function self.setMax(max)
                        local newMax = math.max(1, tonumber(max) or 100)
                        if newMax <= 0 then newMax = 100 end
                        progressOptions.max = newMax
                        self.set(self.value)
                    end

                    function self:Destroy()
                        container:Destroy()
                    end

                    self.options = progressOptions
                    self.self = container
                    pcall(function()
                        self.set(progressOptions.value)
                    end)

                    return self
                end

                function types.dock(dockOptions)
                    local self = { }

                    dockOptions = settings.new({
                    }).handle(dockOptions)

                    local dock = new("Dock")
                    dock.Parent = items

                    dock.ChildAdded:Connect(function()
                        local size = countSize(dock, true).X
                        dock.Size = UDim2.new(0, size, 0, 22)
                        updateCanvas()
                    end)

                    function self.new(type, typeOptions, ...)
                        local rest = {...}
                        if type == self then
                            -- called with colon syntax: (self, type, typeOptions)
                            type = typeOptions
                            typeOptions = rest[1]
                        end

                        type = type and tostring(type) or "unknown"
                        assert(typeof(type) == "string", "expected string as #1 argument, got " .. typeof(type))
                        type = type:lower()
                        assert(type ~= "folder", "illegal type: cannot create folder in dock")

                        local p = rawget(types, type)
                        assert(p, "invalid type: " .. type)
                        local o = p(typeOptions)
                        o.type = type
                        o.self.Parent = self.self

                        return o
                    end

                    self.updated = event.new()
                    dock.ChildAdded:Connect(function() self.updated:Fire() end)
                    dock.ChildRemoved:Connect(function() self.updated:Fire() end)

                    function self:Destroy()
                        dock:Destroy()
                    end

                    self.options = dockOptions
                    self.self = dock
                    return self
                end

                function types.folder(folderOptions)
                    local self = { }
                    self.isopen = false

                    folderOptions = settings.new({
                        text = "New Folder",
                        isopen = false,
                        color = options.color,
                        rounding = options.rounding,
                        animation = options.animation,
                    }).handle(folderOptions)
                    self.isopen = folderOptions.isopen

                    local folder = new("Folder")
                    folder.Parent = items

                    local _folder = folder:FindFirstChild("Folder")
                    local folderItems = folder:FindFirstChild("Items")
                    _folder.SliceScale = folderOptions.rounding / 100
                    _folder.ImageColor3 = folderOptions.color

                    function self.setColor(color)
                        _folder.ImageColor3 = color
                    end

                    function self.getColor()
                        return _folder.ImageColor3
                    end

                    local title = _folder:FindFirstChild("Title")
                    local expand = _folder:FindFirstChild("Expand")
                    title.Text = folderOptions.text

                    function self.close()
                        resize(folder, { Size = UDim2.new(1, 0, 0, 20) }, folderOptions.animation)
                        resize(expand, { Rotation = 0 }, folderOptions.animation)
                        self.isopen = false
                    end

                    function self.open()
                        local size = countSize(folderItems, true).X
                        resize(folder, { Size = UDim2.new(1, 0, 0, 20 + countSize(folderItems).Y + 2) }, folderOptions.animation)
                        resize(expand, { Rotation = 90 }, folderOptions.animation)
                        self.isopen = true
                    end

                    function self.switch()
                        if self.isopen then
                            self.close()
                        else
                            self.open()
                        end
                    end

                    expand.MouseButton1Click:Connect(function()
                        self.switch()
                    end)

                    local folderCache = { }
                    function self.new(type, typeOptions, ...)
                        local rest = {...}
                        if type == self then
                            type = typeOptions
                            typeOptions = rest[1]
                        end

                        type = type and tostring(type) or "unknown"
                        assert(typeof(type) == "string", "expected string as #1 argument, got " .. typeof(type))
                        type = type:lower()
                        local p = rawget(types, type)
                        assert(p, "invalid type: " .. type)
                        local o = p(typeOptions)
                        table.insert(folderCache, o)
                        o.type = type
                        o.self.Parent = folderItems

                        if self.isopen then
                            self.open()
                        end

                        if o.type == "folder" then
                            o.updated:Connect(function()
                                if self.isopen then
                                    self.open()
                                end
                            end)
                        end

                        if o.type == "dock" then
                            o.updated:Connect(function()
                                if self.isopen then
                                    self.open()
                                end
                            end)
                        end

                        return o
                    end

                    self.updated = folder:GetPropertyChangedSignal("Size")

                    function self:Destroy()
                        for i, v in next, folderCache do
                            v:Destroy()
                        end
                        folder:Destroy()
                    end

                    function self:separator(separatorOptions)
                        local sepSelf = {}

                        separatorOptions = settings.new({
                            color = Color3.fromRGB(59, 59, 68),
                            thickness = 1,
                            padding = 8,
                        }).handle(separatorOptions)

                        local container = Instance.new("Frame")
                        container.Parent = folderItems
                        container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        container.BackgroundTransparency = 1
                        container.BorderSizePixel = 0
                        container.Size = UDim2.new(1, 0, 0, separatorOptions.padding * 2 + separatorOptions.thickness)

                        local separator = Instance.new("Frame")
                        separator.Parent = container
                        separator.BackgroundColor3 = separatorOptions.color
                        separator.BorderSizePixel = 0
                        separator.Size = UDim2.new(1, -20, 0, separatorOptions.thickness)
                        separator.Position = UDim2.new(0, 10, 0, separatorOptions.padding)

                        function sepSelf:setColor(color)
                            separator.BackgroundColor3 = color
                        end

                        function sepSelf:Destroy()
                            container:Destroy()
                        end

                        sepSelf.self = container
                        return sepSelf
                    end

                    function self:spacer(spacerOptions)
                        local spacerSelf = {}

                        spacerOptions = settings.new({
                            size = 10
                        }).handle(spacerOptions)

                        local spacer = Instance.new("Frame")
                        spacer.Parent = folderItems
                        spacer.BackgroundTransparency = 1
                        spacer.Size = UDim2.new(1, 0, 0, spacerOptions.size)

                        function spacerSelf:Destroy()
                            spacer:Destroy()
                        end

                        spacerSelf.self = spacer
                        return spacerSelf
                    end

                    self.close()
                    if self.isopen then
                        self.open()
                    end
                    self.options = folderOptions
                    self.self = folder
                    return self
                end
            end

            function self.new(type, typeOptions, ...)
                local rest = {...}
                if type == self then
                    type = typeOptions
                    typeOptions = rest[1]
                end

                type = type and tostring(type) or "unknown"
                assert(typeof(type) == "string", "expected string as #1 argument, got " .. typeof(type))
                type = type:lower()

                local p = rawget(types, type)
                assert(p, "invalid type: " .. type)
                local o = p(typeOptions)
                o.type = type

                if o.type == "folder" then
                    o.updated:Connect(updateCanvas)
                end

                if rawget(o, "event") then
                    return setmetatable(o, {
                        __index = function(self, idx)
                            return rawget(rawget(self, "event"), idx)
                        end,
                        __newindex = function()end,
                    })
                else
                    return o
                end
            end

            function self.clearAll()
                for _, child in ipairs(items:GetChildren()) do
                    if child ~= Padding and not child:IsA("UIListLayout") then
                        child:Destroy()
                    end
                end
                updateCanvas()
            end

            function self.getItemCount()
                local count = 0
                for _, child in ipairs(items:GetChildren()) do
                    if child ~= Padding and not child:IsA("UIListLayout") then
                        count = count + 1
                    end
                end
                return count
            end

            function self.separator(separatorOptions)
                return self.new("separator", separatorOptions)
            end

            function self.spacer(spacerOptions)
                return self.new("spacer", spacerOptions)
            end

            function self.show()
                for i, v in next, tabbuttons:GetChildren() do
                    if not v:IsA("UIListLayout") then
                        resize(v, { TextColor3 = Color3.new(0.4, 0.4, 0.4) }, options.animation)
                    end
                end
                for i, v in next, content:GetChildren() do
                    if v.Name == "Tab" then
                        v.Visible = false
                    end
                end
                resize(tabbutton, { TextColor3 = Color3.new(1, 1, 1) }, options.animation)
                tab.Visible = true
            end

            self.show()
            return self
        end

        function self.close()
            if not self.isopen then return end
            self.isopen = false

            resize(expand, { Rotation = 0 }, options.animation)
            cache.content_size = content.Size.Y.Offset
            cache.tabs_size = tabs.Size.Y.Offset
            resize(content, { Size = UDim2.new(1, 0, 0, 0) }, options.animation)
            resize(tabs, { Size = UDim2.new(1, 0, 0, 0) }, options.animation)
        end

        function self.open()
            if self.isopen then return end
            self.isopen = true

            resize(expand, { Rotation = 90 }, options.animation)
            resize(content, { Size = UDim2.new(1, 0, 0, cache.content_size) }, options.animation)
            resize(tabs, { Size = UDim2.new(1, 0, 0, cache.tabs_size) }, options.animation)
        end

        function self.setPosition(pos)
            main.Position = pos
        end

        function self.destroy()
            self.clearAll()
            main:Destroy()
            windowHistory[main] = nil
            windowCache[main] = nil
            mouseCache[main] = nil
            browsingWindow[main] = nil
        end

        do -- Start closed, then open
            local old = options.animation
            options.animation = 0
            self.close()
            options.animation = old
        end

        return self
    end,
}

-- ========== Window Z-Index Management ==========
do -- window history zindex
    ScreenGui.ChildAdded:Connect(function(window)
        local content = window:FindFirstChild("Content")
        if content then
            window.MouseEnter:Connect(function()
                mouseCache[window] = true
            end)
            content.MouseEnter:Connect(function()
                browsingWindow[window] = true
            end)
            window.MouseLeave:Connect(function()
                mouseCache[window] = false
            end)
            content.MouseLeave:Connect(function()
                browsingWindow[window] = false
            end)

            cacheWindowHistory(window)
            for i, v in next, windowHistory do
                windowHistory[i] = windowHistory[i] + 1
            end
            windowHistory[window] = 1
            updateWindowHistory()
        end
    end)

    mouse.InputBegan:Connect(function()
        wait()
        if (not colorpicking) and (not sliding) then
            local lastZIndex, focused = math.huge
            for i, v in next, mouseCache do
                if v and windowHistory[i] < lastZIndex then
                    lastZIndex = windowHistory[i]
                    focused = i
                end
            end
            if focused then
                setTopMost(focused)
            end
        end
    end)
end

return library