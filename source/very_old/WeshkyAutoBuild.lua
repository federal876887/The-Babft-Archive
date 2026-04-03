local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local shooting = false
local farming = false
local isFarming = false
local isShooting = false

-- Create ScreenGui
local gui = Instance.new('ScreenGui')
gui.Name = 'Eps1llonHub'
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild('PlayerGui')

-- Main Frame (shortened height)
local mainFrame = Instance.new('Frame', gui)
mainFrame.Size = UDim2.new(0, 650, 0, 300) -- Reduced height
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -150) -- Adjusted position for balance
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new('UICorner', mainFrame).CornerRadius = UDim.new(0, 8)

-- UIScale for bounce
local UIScale = Instance.new('UIScale', mainFrame)
UIScale.Scale = 1

-- Header
local headerFrame = Instance.new('Frame', mainFrame)
headerFrame.Size = UDim2.new(1, -20, 0, 30) -- Reduced height of header
headerFrame.Position = UDim2.new(0, 10, 0, 0)
headerFrame.BackgroundTransparency = 1

-- Title Text ("Eps1llon Hub || Beta")
local title = Instance.new('TextLabel', headerFrame)
title.Size = UDim2.new(1, -35, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = 'Eps1llon Hub || Beta'
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

-- Blue Underline (Top Line)
local underline = Instance.new('Frame', mainFrame)
underline.Size = UDim2.new(1, -20, 0, 2) -- Thin line
underline.Position = UDim2.new(0, 10, 0, 30) -- Positioned slightly under the title
underline.BackgroundColor3 = Color3.fromRGB(31, 81, 138) -- Blue color
underline.BorderSizePixel = 0

-- Close Button
local close = Instance.new('TextButton', headerFrame)
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -25, 0, 2) -- Adjusted position for closer placement
close.Text = 'X'
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundTransparency = 1
close.BorderSizePixel = 0
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Sidebar (shortened height)
local sidebar = Instance.new('Frame', mainFrame)
sidebar.Size = UDim2.new(0, 140, 0, 220) -- Reduced height here
sidebar.Position = UDim2.new(0, 10, 0, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.BackgroundTransparency = 0.1
sidebar.BorderSizePixel = 0
Instance.new('UICorner', sidebar).CornerRadius = UDim.new(0, 6)

-- Add outline around the entire sidebar
local outline = Instance.new('UIStroke', sidebar)
outline.Thickness = 2
outline.Color = Color3.fromRGB(31, 81, 138) -- Your specified color (blue)
outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Content frame (adjusted height and width shortened from the left)
local contentFrame = Instance.new('Frame', mainFrame)
contentFrame.Size = UDim2.new(0, 480, 0, 220) -- Width shortened by reducing from the left side
contentFrame.Position = UDim2.new(0, 160, 0, 50) -- Position adjusted to match sidebar's start
contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
contentFrame.BackgroundTransparency = 0.7 -- Further adjusted to make it more transparent
contentFrame.BorderSizePixel = 0
Instance.new('UICorner', contentFrame).CornerRadius = UDim.new(0, 6)

-- Add outline around the contentFrame (right part of the GUI) with same thickness as sidebar
local outlineContentFrame = Instance.new('UIStroke', contentFrame)
outlineContentFrame.Thickness = 2 -- Same thickness as the sidebar outline
outlineContentFrame.Color = Color3.fromRGB(31, 81, 138) -- Your exact specified color
outlineContentFrame.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Section Creator (Keep only the sections you want)
local function createSection(name)
    local section = Instance.new('Frame')
    section.Name = name
    section.Size = UDim2.new(1, 0, 1, 0)
    section.BackgroundTransparency = 1
    section.Visible = false
    section.Parent = contentFrame

    return section
end

-- Updated button names (only the sections you want to keep)
local sections = {}
local buttonNames = {
    'Configuration', -- Keep only these
    'Hunt',
    'Inventory',
    'Teleports',
    'UI Settings',
}

for _, name in ipairs(buttonNames) do
    sections[name] = createSection(name)
end

-- Sidebar Buttons
local function createSidebarButton(text, yPos)
    local button = Instance.new('TextButton', sidebar)
    button.Size = UDim2.new(1, 0, 0, 30) -- Reduced height for buttons
    button.Position = UDim2.new(0, 0, 0, yPos)
    button.Text = '    ' .. text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundTransparency = 1
    button.TextXAlignment = Enum.TextXAlignment.Left

    button.MouseButton1Click:Connect(function()
        -- Hide all sections
        for _, sec in pairs(sections) do
            sec.Visible = false
        end
        -- Show the selected section
        sections[text].Visible = true
    end)

    return button
end

for i, name in ipairs(buttonNames) do
    createSidebarButton(name, 10 + (i - 1) * 35) -- Reduced vertical spacing
end

-- Default visibility
sections['Configuration'].Visible = true

-- UI Toggle with Animation
local function toggleUI()
    uiEnabled = not uiEnabled
    mainFrame.Visible = uiEnabled

    local targetTransparency = uiEnabled and 0.1 or 1
    local targetScale = uiEnabled and 1 or 0.8
    local targetPosition = uiEnabled and UDim2.new(0.5, -325, 0.5, -150)
        or UDim2.new(0.5, -325, 0.5, -200)

    -- Add opening/closing animation
    TweenService
        :Create(
            mainFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {
                BackgroundTransparency = targetTransparency,
                Position = targetPosition,
            }
        )
        :Play()

    TweenService
        :Create(UIScale, TweenInfo.new(0.4), { Scale = targetScale })
        :Play()
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        toggleUI()
    end
end)

-- New Button to Open Color Selector GUI
local function createColorSelectionButton(parent)
    local button = Instance.new('TextButton', parent)
    button.Size = UDim2.new(0, 200, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 30) -- Adjusted position (move up and left)
    button.Text = 'GUI Color'
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold -- Big bold font
    button.TextSize = 20 -- Increased text size
    button.BackgroundTransparency = 1 -- No background
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextXAlignment = Enum.TextXAlignment.Center

    -- Create mini GUI for color options
    local colorPanel = Instance.new('Frame', parent)
    colorPanel.Size = UDim2.new(0, 200, 0, 120)
    colorPanel.Position = UDim2.new(0, 10, 0, 90)
    colorPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    colorPanel.BackgroundTransparency = 0.5
    colorPanel.Visible = false
    Instance.new('UICorner', colorPanel).CornerRadius = UDim.new(0, 6)

    -- List of colors
    local colorList = {
        Red = Color3.fromRGB(255, 0, 0),
        Green = Color3.fromRGB(0, 255, 0),
        Yellow = Color3.fromRGB(255, 255, 0),
        Purple = Color3.fromRGB(128, 0, 128),
        Blue = Color3.fromRGB(31, 81, 138),
        Pink = Color3.fromRGB(255, 105, 180),
        Gray = Color3.fromRGB(169, 169, 169),
    }

    local colorButtons = {}

    for colorName, colorValue in pairs(colorList) do
        local colorButton = Instance.new('TextButton', colorPanel)
        colorButton.Size = UDim2.new(1, 0, 0, 30)
        colorButton.Text = colorName
        colorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        colorButton.BackgroundColor3 = colorValue
        colorButton.Font = Enum.Font.Gotham
        colorButton.TextSize = 14

        colorButton.MouseButton1Click:Connect(function()
            -- Change the background of the UI to the selected color
            mainFrame.BackgroundColor3 = colorValue
        end)

        table.insert(colorButtons, colorButton)
    end

    button.MouseButton1Click:Connect(function()
        -- Toggle color selection visibility
        colorPanel.Visible = not colorPanel.Visible
    end)
end

createColorSelectionButton(mainFrame)
