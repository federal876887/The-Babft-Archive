do
	local StartUi = game:GetService("CoreGui"):FindFirstChild("StartUi") -- AntiSpam And Dupe
	if StartUi then
		StartUi:Destroy()
	end
end

local StartUi = Instance.new("ScreenGui")
local Background = Instance.new("Frame")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Frame_3 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local Holder = Instance.new("Frame")
local Exit = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local Discord = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")

StartUi.Parent = game.CoreGui
StartUi.Name = "StartUi"
StartUi.ZIndexBehavior = Enum.ZIndexBehavior.Global
StartUi.DisplayOrder = 9

Background.Name = "Background"
Background.Parent = StartUi
Background.BackgroundColor3 = Color3.fromRGB(19, 19, 19)
Background.BackgroundTransparency = 0.08
Background.Position = UDim2.new(-0.506535947, 0, -0.446384043, 0)
Background.Size = UDim2.new(2, 0, 2, 0)

Frame.Parent = StartUi
Frame.BackgroundColor3 = Color3.fromRGB(36, 32, 32)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -130, 0.5, -40)
Frame.Size = UDim2.new(0, 260, 0, 75)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Frame_2.Position = UDim2.new(0, 0, -0.129999995, 0)
Frame_2.Size = UDim2.new(1, 0, 0, 24)

UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = Frame_2

Frame_3.Parent = Frame_2
Frame_3.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0, 0, 0.5, 0)
Frame_3.Size = UDim2.new(1, 0, 0.5, 0)

TextLabel.Parent = Frame_2
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "Need files? Join the server!"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000

UICorner_2.CornerRadius = UDim.new(0, 6)
UICorner_2.Parent = Frame

Holder.Name = "Holder"
Holder.Parent = Frame
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.BackgroundTransparency = 1.000
Holder.Position = UDim2.new(0, 0, 0, 12)
Holder.Size = UDim2.new(1, 0, 1, -12)

Exit.Name = "Exit"
Exit.Parent = Holder
Exit.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
Exit.Position = UDim2.new(0, 3, 1, -28)
Exit.Size = UDim2.new(1, -6, 0, 24)
Exit.Font = Enum.Font.GothamBold
Exit.Text = "Continue"
Exit.TextColor3 = Color3.fromRGB(255, 255, 255)
Exit.TextSize = 14.000

UICorner_3.CornerRadius = UDim.new(0, 3)
UICorner_3.Parent = Exit

Discord.Name = "Discord"
Discord.Parent = Holder
Discord.BackgroundColor3 = Color3.fromRGB(23, 172, 13)
Discord.Position = UDim2.new(0, 3, 0.109999999, 0)
Discord.Size = UDim2.new(1, -6, 0, 24)
Discord.Font = Enum.Font.GothamBold
Discord.Text = "Discord\b"
Discord.TextColor3 = Color3.fromRGB(255, 255, 255)
Discord.TextSize = 14.000

UICorner_4.CornerRadius = UDim.new(0, 3)
UICorner_4.Parent = Discord

local request = (syn and syn.request) or (fluxus and fluxus.request) or request or http_request
local setclipboard = setclipboard or toclipboard

local discordLink = "https://discord.gg/wvswdjBnH9"

Discord.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(discordLink)
        Discord.Text = "Discord link has been Copied!"
    else
        Discord.Text = "Copy manually!"
    end

    if syn and syn.request then
        syn.request({
            Url = discordLink,
            Method = "GET"
        })
    elseif request then
        request({
            Url = discordLink,
            Method = "GET"
        })
    end
end)

Exit.MouseButton1Click:Connect(function()
	StartUi:Destroy()
end)

local L_1_ = loadstring(game:HttpGet("https://raw.githubusercontent.com/VortexSource/UiStuff/refs/heads/main/MainModule.lua"))()
local L_2_ = loadstring(game:HttpGet("https://raw.githubusercontent.com/VortexSource/UiStuff/refs/heads/main/ClientNotify.lua"))()

_G.baseColor = Color3.fromRGB(77, 80, 144)

-- Darker shades
--local darkShade1 = _G.baseColor:lerp(Color3.new(0, 0, 0), 0.2)
--local darkShade2 = _G.baseColor:lerp(Color3.new(0, 0, 0), 0.3)
--local darkShade3 = _G.baseColor:lerp(Color3.new(0, 0, 0), 0.4)
--local darkShade4 = _G.baseColor:lerp(Color3.new(0, 0, 0), 0.5)

local function printTest()
	L_827_:AddButton("Preview", function()
		local L_916_ = "WeshkyBuildStorage/" .. L_773_ .. ".Build"
		local L_917_ = isfile(L_916_)
		if L_917_ then
			ClearPreview()
			print(L_916_, _G.BuildSize)
			PreviewFile(L_916_, _G.BuildSize)
		elseif isfile(L_773_ .. ".Build") then
			ClearPreview()
			print(L_773_ .. ".Build", _G.BuildSize)
			PreviewFile(L_773_ .. ".Build", _G.BuildSize)
		else
			print("Bruh")
		end
	end)
end

local L_3_ = {
	main_Pos = UDim2.new(0, 100, 0, 100),
	main_color = Color3.fromRGB(200, 44, 44),
	min_size = Vector2.new(400, 700),
	can_resize = true,
	main_text_color = Color3.fromRGB(255, 255, 255)
}
local L_4_ = (typeof(options) == "table") and options or L_3_

do
	local L_107_ = game:GetService("CoreGui"):FindFirstChild("imgui")
	if L_107_ then
		L_107_:Destroy()
	end
end

local L_5_ = Instance.new("ScreenGui")
local L_6_ = Instance.new("Frame")
local L_7_ = Instance.new("TextLabel")
local L_8_ = Instance.new("ImageLabel")
local L_9_ = Instance.new("Frame")
local L_10_ = Instance.new("Frame")
local L_11_ = Instance.new("ImageButton")
local L_12_ = Instance.new("ImageLabel")
local L_13_ = Instance.new("ImageLabel")
local L_14_ = Instance.new("Frame")
local L_15_ = Instance.new("TextLabel")
local L_16_ = Instance.new("ImageLabel")
local L_17_ = Instance.new("Frame")
local L_18_ = Instance.new("UIListLayout")
local L_19_ = Instance.new("Frame")
local L_20_ = Instance.new("Frame")
local L_21_ = Instance.new("UIListLayout")
local L_22_ = Instance.new("TextBox")
local L_23_ = Instance.new("ImageLabel")
local L_24_ = Instance.new("ImageLabel")
local L_25_ = Instance.new("TextLabel")
local L_26_ = Instance.new("ImageLabel")
local L_27_ = Instance.new("TextLabel")
local L_28_ = Instance.new("TextLabel")
local L_29_ = Instance.new("TextLabel")
local L_30_ = Instance.new("ImageLabel")
local L_31_ = Instance.new("UIListLayout")
local L_32_ = Instance.new("TextButton")
local L_33_ = Instance.new("ImageLabel")
local L_34_ = Instance.new("ImageButton")
local L_35_ = Instance.new("ScrollingFrame")
local L_36_ = Instance.new("UIListLayout")
local L_37_ = Instance.new("ImageLabel")
local L_38_ = Instance.new("TextButton")
local L_39_ = Instance.new("ImageLabel")
local L_40_ = Instance.new("ImageLabel")
local L_41_ = Instance.new("TextButton")
local L_42_ = Instance.new("ImageLabel")
local L_43_ = Instance.new("ImageLabel")
local L_44_ = Instance.new("Frame")
local L_45_ = Instance.new("UIListLayout")
local L_46_ = Instance.new("Frame")
local L_47_ = Instance.new("UIListLayout")
local L_48_ = Instance.new("ImageLabel")
local L_49_ = Instance.new("ScrollingFrame")
local L_50_ = Instance.new("TextBox")
local L_51_ = Instance.new("TextLabel")
local L_52_ = Instance.new("TextLabel")
local L_53_ = Instance.new("TextLabel")
local L_54_ = Instance.new("TextLabel")
local L_55_ = Instance.new("TextLabel")
local L_56_ = Instance.new("TextLabel")
local L_57_ = Instance.new("TextLabel")
local L_58_ = Instance.new("TextLabel")
local L_59_ = Instance.new("TextLabel")
local L_60_ = Instance.new("ImageLabel")
local L_61_ = Instance.new("ImageLabel")
local L_62_ = Instance.new("ImageLabel")
local L_63_ = Instance.new("ImageLabel")
local L_64_ = Instance.new("ImageLabel")
local L_65_ = Instance.new("Frame")
local L_66_ = Instance.new("TextButton")
local L_67_ = Instance.new("ImageLabel")
local L_68_ = Instance.new("TextLabel")
local L_69_ = Instance.new("TextButton")
local L_70_ = Instance.new("ImageLabel")
local L_71_ = Instance.new("TextButton")
local L_72_ = Instance.new("ImageLabel")
local L_73_ = Instance.new("TextLabel")
local L_74_ = Instance.new("TextButton")
local L_75_ = Instance.new("ImageLabel")
local L_76_ = Instance.new("Frame")

L_5_.Name = "imgui"
L_5_.Parent = game:GetService("CoreGui")

L_6_.Name = "Prefabs"
L_6_.Parent = L_5_
L_6_.BackgroundColor3 = Color3.new(1, 1, 1)
L_6_.Visible = false

L_7_.Name = "Label"
L_7_.Parent = L_6_
L_7_.BackgroundColor3 = Color3.new(1, 1, 1)
L_7_.BackgroundTransparency = 1
L_7_.Size = UDim2.new(0, 200, 0, 20)
L_7_.Font = Enum.Font.GothamSemibold
L_7_.Text = "Hello, world 123"
L_7_.TextColor3 = L_4_.main_text_color
L_7_.TextSize = 14
L_7_.TextXAlignment = Enum.TextXAlignment.Left

L_8_.Name = "Window"
L_8_.Parent = L_6_
L_8_.Active = true
L_8_.BackgroundColor3 = Color3.new(1, 1, 1)
L_8_.BackgroundTransparency = 1
L_8_.ClipsDescendants = true
L_8_.Position = UDim2.new(0, 222, 0, 222)
L_8_.Selectable = true
L_8_.Size = UDim2.new(0, 200, 0, 200)
L_8_.Image = "rbxassetid://2851926732"
L_8_.ImageColor3 = Color3.new(0.0823529, 0.0862745, 0.0901961)
L_8_.ScaleType = Enum.ScaleType.Slice
L_8_.SliceCenter = Rect.new(12, 12, 12, 12)

L_9_.Name = "Resizer"
L_9_.Parent = L_8_
L_9_.Active = true
L_9_.BackgroundColor3 = Color3.new(1, 1, 1)
L_9_.BackgroundTransparency = 1
L_9_.BorderSizePixel = 0
L_9_.Position = UDim2.new(1, -20, 1, -20)
L_9_.Size = UDim2.new(0, 20, 0, 20)

L_10_.Name = "Bar"
L_10_.Parent = L_8_
L_10_.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_10_.BorderSizePixel = 0
L_10_.Position = UDim2.new(0, 0, 0, 5)
L_10_.Size = UDim2.new(1, 0, 0, 15)

L_11_.Name = "Toggle"
L_11_.Parent = L_10_
L_11_.BackgroundColor3 = Color3.new(1, 1, 1)
L_11_.BackgroundTransparency = 1
L_11_.Position = UDim2.new(0, 5, 0, -2)
L_11_.Rotation = 90
L_11_.Size = UDim2.new(0, 20, 0, 20)
L_11_.ZIndex = 2
L_11_.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"

L_12_.Name = "Base"
L_12_.Parent = L_10_
L_12_.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_12_.BorderSizePixel = 0
L_12_.Position = UDim2.new(0, 0, 0.800000012, 0)
L_12_.Size = UDim2.new(1, 0, 0, 10)
L_12_.Image = "rbxassetid://2851926732"
L_12_.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_12_.ScaleType = Enum.ScaleType.Slice
L_12_.SliceCenter = Rect.new(12, 12, 12, 12)

L_13_.Name = "Top"
L_13_.Parent = L_10_
L_13_.BackgroundColor3 = Color3.new(1, 1, 1)
L_13_.BackgroundTransparency = 1
L_13_.Position = UDim2.new(0, 0, 0, -5)
L_13_.Size = UDim2.new(1, 0, 0, 10)
L_13_.Image = "rbxassetid://2851926732"
L_13_.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_13_.ScaleType = Enum.ScaleType.Slice
L_13_.SliceCenter = Rect.new(12, 12, 12, 12)

L_14_.Name = "Tabs"
L_14_.Parent = L_8_
L_14_.BackgroundColor3 = Color3.new(1, 1, 1)
L_14_.BackgroundTransparency = 1
L_14_.Position = UDim2.new(0, 15, 0, 60)
L_14_.Size = UDim2.new(1, -30, 1, -60)

L_15_.Name = "Title"
L_15_.Parent = L_8_
L_15_.BackgroundColor3 = Color3.new(1, 1, 1)
L_15_.BackgroundTransparency = 1
L_15_.Position = UDim2.new(0, 30, 0, 3)
L_15_.Size = UDim2.new(0, 200, 0, 20)
L_15_.Font = Enum.Font.GothamBold
L_15_.Text = "Gamer Time"
L_15_.TextColor3 = L_4_.main_text_color
L_15_.TextSize = 14
L_15_.TextXAlignment = Enum.TextXAlignment.Left

L_16_.Name = "TabSelection"
L_16_.Parent = L_8_
L_16_.BackgroundColor3 = Color3.new(1, 1, 1)
L_16_.BackgroundTransparency = 1
L_16_.Position = UDim2.new(0, 15, 0, 30)
L_16_.Size = UDim2.new(1, -30, 0, 25)
L_16_.Visible = false
L_16_.Image = "rbxassetid://2851929490"
L_16_.ImageColor3 = Color3.new(0.145098, 0.14902, 0.156863)
L_16_.ScaleType = Enum.ScaleType.Slice
L_16_.SliceCenter = Rect.new(4, 4, 4, 4)

L_17_.Name = "TabButtons"
L_17_.Parent = L_16_
L_17_.BackgroundColor3 = Color3.new(1, 1, 1)
L_17_.BackgroundTransparency = 1
L_17_.Size = UDim2.new(1, 0, 1, 0)

L_18_.Parent = L_17_
L_18_.FillDirection = Enum.FillDirection.Horizontal
L_18_.SortOrder = Enum.SortOrder.LayoutOrder
L_18_.Padding = UDim.new(0, 2)

L_19_.Parent = L_16_
L_19_.BackgroundColor3 = Color3.new(0.12549, 0.227451, 0.372549)
L_19_.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
L_19_.BorderSizePixel = 0
L_19_.Position = UDim2.new(0, 0, 1, 0)
L_19_.Size = UDim2.new(1, 0, 0, 2)

L_20_.Name = "Tab"
L_20_.Parent = L_6_
L_20_.BackgroundColor3 = Color3.new(1, 1, 1)
L_20_.BackgroundTransparency = 1
L_20_.Size = UDim2.new(1, 0, 1, 0)
L_20_.Visible = false

L_21_.Parent = L_20_
L_21_.SortOrder = Enum.SortOrder.LayoutOrder
L_21_.Padding = UDim.new(0, 5)

L_22_.Parent = L_6_
L_22_.BackgroundColor3 = Color3.new(1, 1, 1)
L_22_.BackgroundTransparency = 1
L_22_.BorderSizePixel = 0
L_22_.Size = UDim2.new(1, 0, 0, 20)
L_22_.ZIndex = 2
L_22_.Font = Enum.Font.GothamSemibold
L_22_.PlaceholderColor3 = Color3.new(0.698039, 0.698039, 0.698039)
L_22_.PlaceholderText = "Input Text"
L_22_.Text = ""
L_22_.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
L_22_.TextSize = 14

L_23_.Name = "TextBox_Roundify_4px"
L_23_.Parent = L_22_
L_23_.BackgroundColor3 = Color3.new(1, 1, 1)
L_23_.BackgroundTransparency = 1
L_23_.Size = UDim2.new(1, 0, 1, 0)
L_23_.Image = "rbxassetid://2851929490"
L_23_.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
L_23_.ScaleType = Enum.ScaleType.Slice
L_23_.SliceCenter = Rect.new(4, 4, 4, 4)

L_24_.Name = "Slider"
L_24_.Parent = L_6_
L_24_.BackgroundColor3 = Color3.new(1, 1, 1)
L_24_.BackgroundTransparency = 1
L_24_.Position = UDim2.new(0, 0, 0.178571433, 0)
L_24_.Size = UDim2.new(1, 0, 0, 20)
L_24_.Image = "rbxassetid://2851929490"
L_24_.ImageColor3 = Color3.new(0.145098, 0.14902, 0.156863)
L_24_.ScaleType = Enum.ScaleType.Slice
L_24_.SliceCenter = Rect.new(4, 4, 4, 4)

L_25_.Name = "Title"
L_25_.Parent = L_24_
L_25_.BackgroundColor3 = Color3.new(1, 1, 1)
L_25_.BackgroundTransparency = 1
L_25_.Position = UDim2.new(0.5, 0, 0.5, -10)
L_25_.Size = UDim2.new(0, 0, 0, 20)
L_25_.ZIndex = 2
L_25_.Font = Enum.Font.GothamBold
L_25_.Text = "Slider"
L_25_.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
L_25_.TextSize = 14

L_26_.Name = "Indicator"
L_26_.Parent = L_24_
L_26_.BackgroundColor3 = Color3.new(1, 1, 1)
L_26_.BackgroundTransparency = 1
L_26_.Size = UDim2.new(0, 0, 0, 20)
L_26_.Image = "rbxassetid://2851929490"
L_26_.ImageColor3 = Color3.new(0.254902, 0.262745, 0.278431)
L_26_.ScaleType = Enum.ScaleType.Slice
L_26_.SliceCenter = Rect.new(4, 4, 4, 4)

L_27_.Name = "Value"
L_27_.Parent = L_24_
L_27_.BackgroundColor3 = Color3.new(1, 1, 1)
L_27_.BackgroundTransparency = 1
L_27_.Position = UDim2.new(1, -55, 0.5, -10)
L_27_.Size = UDim2.new(0, 50, 0, 20)
L_27_.Font = Enum.Font.GothamBold
L_27_.Text = "0%"
L_27_.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
L_27_.TextSize = 14

L_28_.Parent = L_24_
L_28_.BackgroundColor3 = Color3.new(1, 1, 1)
L_28_.BackgroundTransparency = 1
L_28_.Position = UDim2.new(1, -20, - 0.75, 0)
L_28_.Size = UDim2.new(0, 26, 0, 50)
L_28_.Font = Enum.Font.GothamBold
L_28_.Text = "]"
L_28_.TextColor3 = Color3.new(0.627451, 0.627451, 0.627451)
L_28_.TextSize = 14

L_29_.Parent = L_24_
L_29_.BackgroundColor3 = Color3.new(1, 1, 1)
L_29_.BackgroundTransparency = 1
L_29_.Position = UDim2.new(1, -65, - 0.75, 0)
L_29_.Size = UDim2.new(0, 26, 0, 50)
L_29_.Font = Enum.Font.GothamBold
L_29_.Text = "["
L_29_.TextColor3 = Color3.new(0.627451, 0.627451, 0.627451)
L_29_.TextSize = 14

L_30_.Name = "Circle"
L_30_.Parent = L_6_
L_30_.BackgroundColor3 = Color3.new(1, 1, 1)
L_30_.BackgroundTransparency = 1
L_30_.Image = "rbxassetid://266543268"
L_30_.ImageTransparency = 0.5

L_31_.Parent = L_6_
L_31_.FillDirection = Enum.FillDirection.Horizontal
L_31_.SortOrder = Enum.SortOrder.LayoutOrder
L_31_.Padding = UDim.new(0, 20)

L_32_.Name = "Dropdown"
L_32_.Parent = L_6_
L_32_.BackgroundColor3 = Color3.new(1, 1, 1)
L_32_.BackgroundTransparency = 1
L_32_.BorderSizePixel = 0
L_32_.Position = UDim2.new(- 0.055555556, 0, 0.0833333284, 0)
L_32_.Size = UDim2.new(1, 0, 0, 20)
L_32_.ZIndex = 2
L_32_.Font = Enum.Font.GothamBold
L_32_.Text = "      Dropdown"
L_32_.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
L_32_.TextSize = 14
L_32_.TextXAlignment = Enum.TextXAlignment.Left

L_33_.Name = "Indicator"
L_33_.Parent = L_32_
L_33_.BackgroundColor3 = Color3.new(1, 1, 1)
L_33_.BackgroundTransparency = 1
L_33_.Position = UDim2.new(0.899999976, -10, 0.100000001, 0)
L_33_.Rotation = -90
L_33_.Size = UDim2.new(0, 15, 0, 15)
L_33_.ZIndex = 2
L_33_.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4744658743"

L_34_.Name = "Box"
L_34_.Parent = L_32_
L_34_.BackgroundColor3 = Color3.new(1, 1, 1)
L_34_.BackgroundTransparency = 1
L_34_.Position = UDim2.new(0, 0, 0, 25)
L_34_.Size = UDim2.new(1, 0, 0, 150)
L_34_.ZIndex = 3
L_34_.Image = "rbxassetid://2851929490"
L_34_.ImageColor3 = Color3.new(0.129412, 0.133333, 0.141176)
L_34_.ScaleType = Enum.ScaleType.Slice
L_34_.SliceCenter = Rect.new(4, 4, 4, 4)

L_35_.Name = "Objects"
L_35_.Parent = L_34_
L_35_.BackgroundColor3 = Color3.new(1, 1, 1)
L_35_.BackgroundTransparency = 1
L_35_.BorderSizePixel = 0
L_35_.Size = UDim2.new(1, 0, 1, 0)
L_35_.ZIndex = 3
L_35_.CanvasSize = UDim2.new(0, 0, 0, 0)
L_35_.ScrollBarThickness = 8

L_36_.Parent = L_35_
L_36_.SortOrder = Enum.SortOrder.LayoutOrder

L_37_.Name = "TextButton_Roundify_4px"
L_37_.Parent = L_32_
L_37_.BackgroundColor3 = Color3.new(1, 1, 1)
L_37_.BackgroundTransparency = 1
L_37_.Size = UDim2.new(1, 0, 1, 0)
L_37_.Image = "rbxassetid://2851929490"
L_37_.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
L_37_.ScaleType = Enum.ScaleType.Slice
L_37_.SliceCenter = Rect.new(4, 4, 4, 4)

L_38_.Name = "TabButton"
L_38_.Parent = L_6_
L_38_.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_38_.BackgroundTransparency = 1
L_38_.BorderSizePixel = 0
L_38_.Position = UDim2.new(0.185185179, 0, 0, 0)
L_38_.Size = UDim2.new(0, 71, 0, 20)
L_38_.ZIndex = 2
L_38_.Font = Enum.Font.GothamSemibold
L_38_.Text = "Test tab"
L_38_.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
L_38_.TextSize = 14

L_39_.Name = "TextButton_Roundify_4px"
L_39_.Parent = L_38_
L_39_.BackgroundColor3 = Color3.new(1, 1, 1)
L_39_.BackgroundTransparency = 1
L_39_.Size = UDim2.new(1, 0, 1, 0)
L_39_.Image = "rbxassetid://2851929490"
L_39_.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
L_39_.ScaleType = Enum.ScaleType.Slice
L_39_.SliceCenter = Rect.new(4, 4, 4, 4)

L_40_.Name = "Folder"
L_40_.Parent = L_6_
L_40_.BackgroundColor3 = Color3.new(1, 1, 1)
L_40_.BackgroundTransparency = 1
L_40_.Position = UDim2.new(0, 0, 0, 50)
L_40_.Size = UDim2.new(1, 0, 0, 20)
L_40_.Image = "rbxassetid://2851929490"
L_40_.ImageColor3 = Color3.new(0.0823529, 0.0862745, 0.0901961)
L_40_.ScaleType = Enum.ScaleType.Slice
L_40_.SliceCenter = Rect.new(4, 4, 4, 4)

L_41_.Name = "Button"
L_41_.Parent = L_40_
L_41_.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_41_.BackgroundTransparency = 1
L_41_.BorderSizePixel = 0
L_41_.Size = UDim2.new(1, 0, 0, 20)
L_41_.ZIndex = 2
L_41_.Font = Enum.Font.GothamSemibold
L_41_.Text = "      Folder"
L_41_.TextColor3 = L_4_.main_text_color
L_41_.TextSize = 14
L_41_.TextXAlignment = Enum.TextXAlignment.Left

L_42_.Name = "TextButton_Roundify_4px"
L_42_.Parent = L_41_
L_42_.BackgroundColor3 = Color3.new(1, 1, 1)
L_42_.BackgroundTransparency = 1
L_42_.Size = UDim2.new(1, 0, 1, 0)
L_42_.Image = "rbxassetid://2851929490"
L_42_.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_42_.ScaleType = Enum.ScaleType.Slice
L_42_.SliceCenter = Rect.new(4, 4, 4, 4)

L_43_.Name = "Toggle"
L_43_.Parent = L_41_
L_43_.BackgroundColor3 = Color3.new(1, 1, 1)
L_43_.BackgroundTransparency = 1
L_43_.Position = UDim2.new(0, 5, 0, 0)
L_43_.Size = UDim2.new(0, 20, 0, 20)
L_43_.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"

L_44_.Name = "Objects"
L_44_.Parent = L_40_
L_44_.BackgroundColor3 = Color3.new(1, 1, 1)
L_44_.BackgroundTransparency = 1
L_44_.Position = UDim2.new(0, 10, 0, 25)
L_44_.Size = UDim2.new(1, -10, 1, -25)
L_44_.Visible = false

L_45_.Parent = L_44_
L_45_.SortOrder = Enum.SortOrder.LayoutOrder
L_45_.Padding = UDim.new(0, 5)

L_46_.Name = "HorizontalAlignment"
L_46_.Parent = L_6_
L_46_.BackgroundColor3 = Color3.new(1, 1, 1)
L_46_.BackgroundTransparency = 1
L_46_.Size = UDim2.new(1, 0, 0, 20)

L_47_.Parent = L_46_
L_47_.FillDirection = Enum.FillDirection.Horizontal
L_47_.SortOrder = Enum.SortOrder.LayoutOrder
L_47_.Padding = UDim.new(0, 5)

L_48_.Name = "Console"
L_48_.Parent = L_6_
L_48_.BackgroundColor3 = Color3.new(1, 1, 1)
L_48_.BackgroundTransparency = 1
L_48_.Size = UDim2.new(1, 0, 0, 200)
L_48_.Image = "rbxassetid://2851928141"
L_48_.ImageColor3 = Color3.new(0.129412, 0.133333, 0.141176)
L_48_.ScaleType = Enum.ScaleType.Slice
L_48_.SliceCenter = Rect.new(8, 8, 8, 8)

L_49_.Parent = L_48_
L_49_.BackgroundColor3 = Color3.new(1, 1, 1)
L_49_.BackgroundTransparency = 1
L_49_.BorderSizePixel = 0
L_49_.Size = UDim2.new(1, 0, 1, 1)
L_49_.CanvasSize = UDim2.new(0, 0, 0, 0)
L_49_.ScrollBarThickness = 4

L_50_.Name = "Source"
L_50_.Parent = L_49_
L_50_.BackgroundColor3 = Color3.new(1, 1, 1)
L_50_.BackgroundTransparency = 1
L_50_.Position = UDim2.new(0, 40, 0, 0)
L_50_.Size = UDim2.new(1, -40, 0, 10000)
L_50_.ZIndex = 3
L_50_.ClearTextOnFocus = false
L_50_.Font = Enum.Font.Code
L_50_.MultiLine = true
L_50_.PlaceholderColor3 = Color3.new(0.8, 0.8, 0.8)
L_50_.Text = ""
L_50_.TextColor3 = L_4_.main_text_color
L_50_.TextSize = 15
L_50_.TextStrokeColor3 = Color3.new(1, 1, 1)
L_50_.TextWrapped = true
L_50_.TextXAlignment = Enum.TextXAlignment.Left
L_50_.TextYAlignment = Enum.TextYAlignment.Top

L_51_.Name = "Comments"
L_51_.Parent = L_50_
L_51_.BackgroundColor3 = Color3.new(1, 1, 1)
L_51_.BackgroundTransparency = 1
L_51_.Size = UDim2.new(1, 0, 1, 0)
L_51_.ZIndex = 5
L_51_.Font = Enum.Font.Code
L_51_.Text = ""
L_51_.TextColor3 = Color3.new(0.231373, 0.784314, 0.231373)
L_51_.TextSize = 15
L_51_.TextXAlignment = Enum.TextXAlignment.Left
L_51_.TextYAlignment = Enum.TextYAlignment.Top

L_52_.Name = "Globals"
L_52_.Parent = L_50_
L_52_.BackgroundColor3 = Color3.new(1, 1, 1)
L_52_.BackgroundTransparency = 1
L_52_.Size = UDim2.new(1, 0, 1, 0)
L_52_.ZIndex = 5
L_52_.Font = Enum.Font.Code
L_52_.Text = ""
L_52_.TextColor3 = Color3.new(0.517647, 0.839216, 0.968628)
L_52_.TextSize = 15
L_52_.TextXAlignment = Enum.TextXAlignment.Left
L_52_.TextYAlignment = Enum.TextYAlignment.Top

L_53_.Name = "Keywords"
L_53_.Parent = L_50_
L_53_.BackgroundColor3 = Color3.new(1, 1, 1)
L_53_.BackgroundTransparency = 1
L_53_.Size = UDim2.new(1, 0, 1, 0)
L_53_.ZIndex = 5
L_53_.Font = Enum.Font.Code
L_53_.Text = ""
L_53_.TextColor3 = Color3.new(0.972549, 0.427451, 0.486275)
L_53_.TextSize = 15
L_53_.TextXAlignment = Enum.TextXAlignment.Left
L_53_.TextYAlignment = Enum.TextYAlignment.Top

L_54_.Name = "RemoteHighlight"
L_54_.Parent = L_50_
L_54_.BackgroundColor3 = Color3.new(1, 1, 1)
L_54_.BackgroundTransparency = 1
L_54_.Size = UDim2.new(1, 0, 1, 0)
L_54_.ZIndex = 5
L_54_.Font = Enum.Font.Code
L_54_.Text = ""
L_54_.TextColor3 = Color3.new(0, 0.568627, 1)
L_54_.TextSize = 15
L_54_.TextXAlignment = Enum.TextXAlignment.Left
L_54_.TextYAlignment = Enum.TextYAlignment.Top

L_55_.Name = "Strings"
L_55_.Parent = L_50_
L_55_.BackgroundColor3 = Color3.new(1, 1, 1)
L_55_.BackgroundTransparency = 1
L_55_.Size = UDim2.new(1, 0, 1, 0)
L_55_.ZIndex = 5
L_55_.Font = Enum.Font.Code
L_55_.Text = ""
L_55_.TextColor3 = Color3.new(0.678431, 0.945098, 0.584314)
L_55_.TextSize = 15
L_55_.TextXAlignment = Enum.TextXAlignment.Left
L_55_.TextYAlignment = Enum.TextYAlignment.Top

L_56_.Name = "Tokens"
L_56_.Parent = L_50_
L_56_.BackgroundColor3 = Color3.new(1, 1, 1)
L_56_.BackgroundTransparency = 1
L_56_.Size = UDim2.new(1, 0, 1, 0)
L_56_.ZIndex = 5
L_56_.Font = Enum.Font.Code
L_56_.Text = ""
L_56_.TextColor3 = L_4_.main_text_color
L_56_.TextSize = 15
L_56_.TextXAlignment = Enum.TextXAlignment.Left
L_56_.TextYAlignment = Enum.TextYAlignment.Top

L_57_.Name = "Numbers"
L_57_.Parent = L_50_
L_57_.BackgroundColor3 = Color3.new(1, 1, 1)
L_57_.BackgroundTransparency = 1
L_57_.Size = UDim2.new(1, 0, 1, 0)
L_57_.ZIndex = 4
L_57_.Font = Enum.Font.Code
L_57_.Text = ""
L_57_.TextColor3 = Color3.new(1, 0.776471, 0)
L_57_.TextSize = 15
L_57_.TextXAlignment = Enum.TextXAlignment.Left
L_57_.TextYAlignment = Enum.TextYAlignment.Top

L_58_.Name = "Info"
L_58_.Parent = L_50_
L_58_.BackgroundColor3 = Color3.new(1, 1, 1)
L_58_.BackgroundTransparency = 1
L_58_.Size = UDim2.new(1, 0, 1, 0)
L_58_.ZIndex = 5
L_58_.Font = Enum.Font.Code
L_58_.Text = ""
L_58_.TextColor3 = Color3.new(0, 0.635294, 1)
L_58_.TextSize = 15
L_58_.TextXAlignment = Enum.TextXAlignment.Left
L_58_.TextYAlignment = Enum.TextYAlignment.Top

L_59_.Name = "Lines"
L_59_.Parent = L_49_
L_59_.BackgroundColor3 = Color3.new(1, 1, 1)
L_59_.BackgroundTransparency = 1
L_59_.BorderSizePixel = 0
L_59_.Size = UDim2.new(0, 40, 0, 10000)
L_59_.ZIndex = 4
L_59_.Font = Enum.Font.Code
L_59_.Text = "1\n"
L_59_.TextColor3 = L_4_.main_text_color
L_59_.TextSize = 15
L_59_.TextWrapped = true
L_59_.TextYAlignment = Enum.TextYAlignment.Top

L_60_.Name = "ColorPicker"
L_60_.Parent = L_6_
L_60_.BackgroundColor3 = Color3.new(1, 1, 1)
L_60_.BackgroundTransparency = 1
L_60_.Size = UDim2.new(0, 180, 0, 110)
L_60_.Image = "rbxassetid://2851929490"
L_60_.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
L_60_.ScaleType = Enum.ScaleType.Slice
L_60_.SliceCenter = Rect.new(4, 4, 4, 4)

L_61_.Name = "Palette"
L_61_.Parent = L_60_
L_61_.BackgroundColor3 = Color3.new(1, 1, 1)
L_61_.BackgroundTransparency = 1
L_61_.Position = UDim2.new(0.0500000007, 0, 0.0500000007, 0)
L_61_.Size = UDim2.new(0, 100, 0, 100)
L_61_.Image = "rbxassetid://698052001"
L_61_.ScaleType = Enum.ScaleType.Slice
L_61_.SliceCenter = Rect.new(4, 4, 4, 4)

L_62_.Name = "Indicator"
L_62_.Parent = L_61_
L_62_.BackgroundColor3 = Color3.new(1, 1, 1)
L_62_.BackgroundTransparency = 1
L_62_.Size = UDim2.new(0, 5, 0, 5)
L_62_.ZIndex = 2
L_62_.Image = "rbxassetid://2851926732"
L_62_.ImageColor3 = Color3.new(0, 0, 0)
L_62_.ScaleType = Enum.ScaleType.Slice
L_62_.SliceCenter = Rect.new(12, 12, 12, 12)

L_63_.Name = "Sample"
L_63_.Parent = L_60_
L_63_.BackgroundColor3 = Color3.new(1, 1, 1)
L_63_.BackgroundTransparency = 1
L_63_.Position = UDim2.new(0.800000012, 0, 0.0500000007, 0)
L_63_.Size = UDim2.new(0, 25, 0, 25)
L_63_.Image = "rbxassetid://2851929490"
L_63_.ScaleType = Enum.ScaleType.Slice
L_63_.SliceCenter = Rect.new(4, 4, 4, 4)

L_64_.Name = "Saturation"
L_64_.Parent = L_60_
L_64_.BackgroundColor3 = Color3.new(1, 1, 1)
L_64_.Position = UDim2.new(0.649999976, 0, 0.0500000007, 0)
L_64_.Size = UDim2.new(0, 15, 0, 100)
L_64_.Image = "rbxassetid://3641079629"

L_65_.Name = "Indicator"
L_65_.Parent = L_64_
L_65_.BackgroundColor3 = Color3.new(1, 1, 1)
L_65_.BorderSizePixel = 0
L_65_.Size = UDim2.new(0, 20, 0, 2)
L_65_.ZIndex = 2

L_66_.Name = "Switch"
L_66_.Parent = L_6_
L_66_.BackgroundColor3 = Color3.new(1, 1, 1)
L_66_.BackgroundTransparency = 1
L_66_.BorderSizePixel = 0
L_66_.Position = UDim2.new(0.229411766, 0, 0.20714286, 0)
L_66_.Size = UDim2.new(0, 20, 0, 20)
L_66_.ZIndex = 2
L_66_.Font = Enum.Font.SourceSans
L_66_.Text = ""
L_66_.TextColor3 = L_4_.main_text_color
L_66_.TextSize = 18

L_67_.Name = "TextButton_Roundify_4px"
L_67_.Parent = L_66_
L_67_.BackgroundColor3 = Color3.new(1, 1, 1)
L_67_.BackgroundTransparency = 1
L_67_.Size = UDim2.new(1, 0, 1, 0)
L_67_.Image = "rbxassetid://2851929490"
L_67_.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_67_.ImageTransparency = 0.5
L_67_.ScaleType = Enum.ScaleType.Slice
L_67_.SliceCenter = Rect.new(4, 4, 4, 4)

L_68_.Name = "Title"
L_68_.Parent = L_66_
L_68_.BackgroundColor3 = Color3.new(1, 1, 1)
L_68_.BackgroundTransparency = 1
L_68_.Position = UDim2.new(1.20000005, 0, 0, 0)
L_68_.Size = UDim2.new(0, 20, 0, 20)
L_68_.Font = Enum.Font.GothamSemibold
L_68_.Text = "Switch"
L_68_.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
L_68_.TextSize = 14
L_68_.TextXAlignment = Enum.TextXAlignment.Left

L_69_.Name = "Button"
L_69_.Parent = L_6_
L_69_.BackgroundColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_69_.BackgroundTransparency = 1
L_69_.BorderSizePixel = 0
L_69_.Size = UDim2.new(0, 91, 0, 20)
L_69_.ZIndex = 2
L_69_.Font = Enum.Font.GothamSemibold
L_69_.TextColor3 = L_4_.main_text_color
L_69_.TextSize = 14

L_70_.Name = "TextButton_Roundify_4px"
L_70_.Parent = L_69_
L_70_.BackgroundColor3 = Color3.new(1, 1, 1)
L_70_.BackgroundTransparency = 1
L_70_.Size = UDim2.new(1, 0, 1, 0)
L_70_.Image = "rbxassetid://2851929490"
L_70_.ImageColor3 = Color3.new(0.160784, 0.290196, 0.478431)
L_70_.ScaleType = Enum.ScaleType.Slice
L_70_.SliceCenter = Rect.new(4, 4, 4, 4)

L_71_.Name = "DropdownButton"
L_71_.Parent = L_6_
L_71_.BackgroundColor3 = Color3.new(0.129412, 0.133333, 0.141176)
L_71_.BorderSizePixel = 0
L_71_.Size = UDim2.new(1, 0, 0, 20)
L_71_.ZIndex = 3
L_71_.Font = Enum.Font.GothamBold
L_71_.Text = "      Button"
L_71_.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
L_71_.TextSize = 14
L_71_.TextXAlignment = Enum.TextXAlignment.Left

L_72_.Name = "Keybind"
L_72_.Parent = L_6_
L_72_.BackgroundColor3 = Color3.new(1, 1, 1)
L_72_.BackgroundTransparency = 1
L_72_.Size = UDim2.new(0, 200, 0, 20)
L_72_.Image = "rbxassetid://2851929490"
L_72_.ImageColor3 = Color3.new(0.203922, 0.207843, 0.219608)
L_72_.ScaleType = Enum.ScaleType.Slice
L_72_.SliceCenter = Rect.new(4, 4, 4, 4)

L_73_.Name = "Title"
L_73_.Parent = L_72_
L_73_.BackgroundColor3 = Color3.new(1, 1, 1)
L_73_.BackgroundTransparency = 1
L_73_.Size = UDim2.new(0, 0, 1, 0)
L_73_.Font = Enum.Font.GothamBold
L_73_.Text = "Keybind"
L_73_.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
L_73_.TextSize = 14
L_73_.TextXAlignment = Enum.TextXAlignment.Left

L_74_.Name = "Input"
L_74_.Parent = L_72_
L_74_.BackgroundColor3 = Color3.new(1, 1, 1)
L_74_.BackgroundTransparency = 1
L_74_.BorderSizePixel = 0
L_74_.Position = UDim2.new(1, -85, 0, 2)
L_74_.Size = UDim2.new(0, 80, 1, -4)
L_74_.ZIndex = 2
L_74_.Font = Enum.Font.GothamSemibold
L_74_.Text = "RShift"
L_74_.TextColor3 = Color3.new(0.784314, 0.784314, 0.784314)
L_74_.TextSize = 12
L_74_.TextWrapped = true

L_75_.Name = "Input_Roundify_4px"
L_75_.Parent = L_74_
L_75_.BackgroundColor3 = Color3.new(1, 1, 1)
L_75_.BackgroundTransparency = 1
L_75_.Size = UDim2.new(1, 0, 1, 0)
L_75_.Image = "rbxassetid://2851929490"
L_75_.ImageColor3 = Color3.new(0.290196, 0.294118, 0.313726)
L_75_.ScaleType = Enum.ScaleType.Slice
L_75_.SliceCenter = Rect.new(4, 4, 4, 4)

L_76_.Name = "Windows"
L_76_.Parent = L_5_
L_76_.BackgroundColor3 = Color3.new(1, 1, 1)
L_76_.BackgroundTransparency = 1
L_76_.Position = UDim2.new(0, 20, 0, 20)
L_76_.Size = UDim2.new(1, 20, 1, -20)
script.Parent = L_5_

local L_77_ = game:GetService("UserInputService")
local L_78_ = game:GetService("TweenService")
local L_79_ = game:GetService("RunService")
local L_80_ = game:GetService("Players")

local L_81_ = L_80_.LocalPlayer
local L_82_ = L_81_:GetMouse()

local L_83_ = script.Parent:WaitForChild("Prefabs")
local L_84_ = script.Parent:FindFirstChild("Windows")

local L_85_ = {
	["binding"] = false
}

local function L_86_func(L_108_arg0, L_109_arg1, L_110_arg2)
	L_110_arg2 = L_110_arg2 or 0.5
	local L_111_ = TweenInfo.new(L_110_arg2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local L_112_ = L_78_:Create(L_108_arg0, L_111_, L_109_arg1)
	L_112_:Play()
end

local function L_87_func(L_113_arg0, L_114_arg1, L_115_arg2) -- idk who made this function, but thanks
	L_113_arg0, L_114_arg1, L_115_arg2 = L_113_arg0 / 255, L_114_arg1 / 255, L_115_arg2 / 255
	local L_116_, L_117_ = math.max(L_113_arg0, L_114_arg1, L_115_arg2), math.min(L_113_arg0, L_114_arg1, L_115_arg2)
	local L_118_, L_119_, L_120_
	L_120_ = L_116_
	local L_121_ = L_116_ - L_117_
	if L_116_ == 0 then
		L_119_ = 0
	else
		L_119_ = L_121_ / L_116_
	end
	if L_116_ == L_117_ then
		L_118_ = 0
	else
		if L_116_ == L_113_arg0 then
			L_118_ = (L_114_arg1 - L_115_arg2) / L_121_
			if L_114_arg1 < L_115_arg2 then
				L_118_ = L_118_ + 6
			end
		elseif L_116_ == L_114_arg1 then
			L_118_ = (L_115_arg2 - L_113_arg0) / L_121_ + 2
		elseif L_116_ == L_115_arg2 then
			L_118_ = (L_113_arg0 - L_114_arg1) / L_121_ + 4
		end
		L_118_ = L_118_ / 6
	end
	return L_118_, L_119_, L_120_
end

local function L_88_func(L_122_arg0, L_123_arg1)
	local L_124_, L_125_ = pcall(
        function()
		return L_122_arg0[tostring(L_123_arg1)]
	end)
	if L_124_ then
		return L_125_
	end
end

local function L_89_func(L_126_arg0)
	return L_126_arg0.TextBounds.X + 15
end

local function L_90_func()
	return Vector2.new(L_77_:GetMouseLocation().X + 1, L_77_:GetMouseLocation().Y - 35)
end

local function L_91_func(L_127_arg0, L_128_arg1, L_129_arg2)
	spawn(
        function()
		L_127_arg0.ClipsDescendants = true
		local L_130_ = L_83_:FindFirstChild("Circle"):Clone()
		L_130_.Parent = L_127_arg0
		L_130_.ZIndex = 1000
		local L_131_ = L_128_arg1 - L_130_.AbsolutePosition.X
		local L_132_ = L_129_arg2 - L_130_.AbsolutePosition.Y
		L_130_.Position = UDim2.new(0, L_131_, 0, L_132_)
		local L_133_ = 0
		if L_127_arg0.AbsoluteSize.X > L_127_arg0.AbsoluteSize.Y then
			L_133_ = L_127_arg0.AbsoluteSize.X * 1.5
		elseif L_127_arg0.AbsoluteSize.X < L_127_arg0.AbsoluteSize.Y then
			L_133_ = L_127_arg0.AbsoluteSize.Y * 1.5
		elseif L_127_arg0.AbsoluteSize.X == L_127_arg0.AbsoluteSize.Y then
			L_133_ = L_127_arg0.AbsoluteSize.X * 1.5
		end
		L_130_:TweenSizeAndPosition(
                UDim2.new(0, L_133_, 0, L_133_), UDim2.new(0.5, - L_133_ / 2, 0.5, - L_133_ / 2), "Out", "Quad", 0.5, false, nil)
		L_86_func(L_130_, {
			ImageTransparency = 1
		}, 0.5)
		wait(0.5)
		L_130_:Destroy()
	end)
end

local L_92_ = 0
local L_93_ = {}

local function L_94_func()
	local L_134_ = L_83_:FindFirstChild("UIListLayout"):Clone()
	L_134_.Parent = L_84_
	local L_135_ = {}
	for L_136_forvar0, L_137_forvar1 in next, L_84_:GetChildren() do
		if not (L_137_forvar1:IsA("UIListLayout")) then
			L_135_[L_137_forvar1] = L_137_forvar1.AbsolutePosition
		end
	end
	L_134_:Destroy()
	for L_138_forvar0, L_139_forvar1 in next, L_135_ do
		L_138_forvar0.Position = UDim2.new(0, L_139_forvar1.X, 0, L_139_forvar1.Y)
	end
end

function L_93_:FormatWindows()
	L_94_func()
end

function L_93_:AddWindow(L_140_arg0, L_141_arg1)
	L_92_ = L_92_ + 1
	local L_142_ = false
	L_140_arg0 = tostring(L_140_arg0 or "New Window")
	L_141_arg1 = (typeof(L_141_arg1) == "table") and L_141_arg1 or L_3_
	L_141_arg1.tween_time = 0.1
	local L_143_ = L_83_:FindFirstChild("Window"):Clone()
	L_143_.Parent = L_84_
	L_143_:FindFirstChild("Title").Text = L_140_arg0
	L_143_.Size = UDim2.new(0, L_141_arg1.min_size.X, 0, L_141_arg1.min_size.Y)
	L_143_.Position = UDim2.new(0, L_141_arg1.main_Pos.X.Offset, 0, L_141_arg1.main_Pos.Y.Offset)
	L_143_.ZIndex = L_143_.ZIndex + (L_92_ * 10)
	do -- Altering Window Color
		local L_150_ = L_143_:FindFirstChild("Title")
		local L_151_ = L_143_:FindFirstChild("Bar")
		local L_152_ = L_151_:FindFirstChild("Base")
		local L_153_ = L_151_:FindFirstChild("Top")
		local L_154_ = L_143_:FindFirstChild("TabSelection"):FindFirstChild("Frame")
		local L_155_ = L_151_:FindFirstChild("Toggle")
		spawn(
            function()
			while true do
				L_141_arg1.main_color = _G.baseColor --HEREHEREHERE
				L_151_.BackgroundColor3 = L_141_arg1.main_color
				L_152_.BackgroundColor3 = L_141_arg1.main_color
				L_152_.ImageColor3 = L_141_arg1.main_color
				L_153_.ImageColor3 = L_141_arg1.main_color
				L_154_.BackgroundColor3 = L_141_arg1.main_color
				L_79_.Heartbeat:Wait()
			end
		end)
	end
	local L_144_ = L_143_:WaitForChild("Resizer")
	local L_145_ = {
		Hide = function()
			L_143_.Visible = false
		end,
		Show = function()
			L_143_.Visible = true
		end
	}
	local L_146_ = game:GetService("UserInputService")
	local L_147_ = game:GetService("RunService")
	local L_148_ = {}
	L_148_.__index = L_148_
	function L_148_.new(L_156_arg0)
		local L_157_ = setmetatable({}, L_148_)
		L_157_.frame = L_156_arg0
		L_157_.held = false
		L_157_.startPosition = nil
		L_157_.startInputPosition = nil
		L_157_.draggable = true
		L_157_.draggerCache = true
		L_157_.frame.Active = true
		L_157_.frame.MouseLeave:Connect(
            function()
			L_157_.draggerCache = false
		end)
		L_157_.frame.MouseEnter:Connect(
            function()
			L_157_.draggerCache = true
		end)
		function L_157_:onInputChanged(L_158_arg0)
			if L_157_.held then
				local L_159_ = L_158_arg0.Position
				local L_160_ = L_159_ - L_157_.startInputPosition
				local L_161_ = L_157_.startPosition + UDim2.new(0, L_160_.X, 0, L_160_.Y)
				L_157_.frame.Position = L_157_.frame.Position:Lerp(L_161_, 0.2)
			end
		end
		function L_157_:onInputEnded(L_162_arg0)
			if L_162_arg0.UserInputType == Enum.UserInputType.MouseButton1 or L_162_arg0.UserInputType == Enum.UserInputType.Touch then
				L_157_.held = false
			end
		end
		L_157_.frame.InputBegan:Connect(
            function(L_163_arg0)
			if L_163_arg0.UserInputType == Enum.UserInputType.MouseButton1 or L_163_arg0.UserInputType == Enum.UserInputType.Touch then
				if L_157_.draggerCache and L_157_.draggable then
					L_157_.held = true
					L_157_.startPosition = L_157_.frame.Position
					L_157_.startInputPosition = L_163_arg0.Position
					L_163_arg0.Changed:Connect(
                            function()
						if L_163_arg0.UserInputState == Enum.UserInputState.End then
							L_157_:onInputEnded(L_163_arg0)
						end
					end)
				end
			end
		end)
		L_146_.InputChanged:Connect(
            function(L_164_arg0)
			if L_164_arg0.UserInputType == Enum.UserInputType.MouseMovement or L_164_arg0.UserInputType == Enum.UserInputType.Touch then
				L_157_:onInputChanged(L_164_arg0)
			end
		end)
		return L_157_
	end
	function L_148_:setDraggable(L_165_arg0)
		self.draggable = L_165_arg0
	end
	local L_149_ = L_148_.new(L_143_)
	do
		local L_166_ = L_82_.Icon
		local L_167_ = false
		L_144_.MouseEnter:Connect(
            function()
			if L_141_arg1.can_resize then
				L_166_ = L_82_.Icon
                -- Optionally change mouse icon here
			end
			L_149_:setDraggable(false)
			L_167_ = true
		end)
		L_144_.MouseLeave:Connect(
            function()
			L_167_ = false
			if L_141_arg1.can_resize then
				L_82_.Icon = L_166_
			end
			L_149_:setDraggable(true)
		end)
		local L_168_ = false
		L_146_.InputBegan:Connect(
            function(L_169_arg0)
			if L_169_arg0.UserInputType == Enum.UserInputType.MouseButton1 or L_169_arg0.UserInputType == Enum.UserInputType.Touch then
				L_168_ = true
				spawn(
                        function()
                            -- Loop check
					if L_167_ and L_144_.Active and L_141_arg1.can_resize then
						while L_168_ and L_144_.Active do
							local L_170_ = L_90_func()
							local L_171_ = L_170_.X - L_143_.AbsolutePosition.X
							local L_172_ = L_170_.Y - L_143_.AbsolutePosition.Y
							if L_171_ >= L_141_arg1.min_size.X and L_172_ >= L_141_arg1.min_size.Y then
								L_86_func(L_143_, {
									Size = UDim2.new(0, L_171_, 0, L_172_)
								}, L_141_arg1.tween_time)
							elseif L_171_ >= L_141_arg1.min_size.X then
								L_86_func(
                                            L_143_, {
									Size = UDim2.new(0, L_171_, 0, L_141_arg1.min_size.Y)
								}, L_141_arg1.tween_time)
							elseif L_172_ >= L_141_arg1.min_size.Y then
								L_86_func(
                                            L_143_, {
									Size = UDim2.new(0, L_141_arg1.min_size.X, 0, L_172_)
								}, L_141_arg1.tween_time)
							else
								L_86_func(
                                            L_143_, {
									Size = UDim2.new(0, L_141_arg1.min_size.X, 0, L_141_arg1.min_size.Y)
								}, L_141_arg1.tween_time)
							end
							L_147_.Heartbeat:Wait()
						end
					end
				end)
			end
		end)
		L_146_.InputEnded:Connect(
            function(L_173_arg0)
			if L_173_arg0.UserInputType == Enum.UserInputType.MouseButton1 or L_173_arg0.UserInputType == Enum.UserInputType.Touch then
				L_168_ = false
			end
		end)
	end
	do -- [Open / Close] Window
		local L_174_ = L_143_:FindFirstChild("Bar"):FindFirstChild("Toggle")
		local L_175_ = true
		local L_176_ = true
		local L_177_ = {}
		local L_178_ = L_143_.AbsoluteSize.Y
		L_174_.Activated:Connect(
            function()
			if L_176_ then
				L_176_ = false
				if L_175_ then
                        -- Close
					L_177_ = {}
					for L_179_forvar0, L_180_forvar1 in next, L_143_:FindFirstChild("Tabs"):GetChildren() do
						L_177_[L_180_forvar1] = L_180_forvar1.Visible
						L_180_forvar1.Visible = false
					end
					L_144_.Active = false
					L_178_ = L_143_.AbsoluteSize.Y
					L_86_func(L_174_, {
						Rotation = 0
					}, L_141_arg1.tween_time)
					L_86_func(L_143_, {
						Size = UDim2.new(0, L_143_.AbsoluteSize.X, 0, 26)
					}, L_141_arg1.tween_time)
					L_174_.Parent:FindFirstChild("Base").Transparency = 1
				else
                        -- Open
					for L_181_forvar0, L_182_forvar1 in next, L_177_ do
						L_181_forvar0.Visible = L_182_forvar1
					end
					L_144_.Active = true
					L_86_func(L_174_, {
						Rotation = 90
					}, L_141_arg1.tween_time)
					L_86_func(L_143_, {
						Size = UDim2.new(0, L_143_.AbsoluteSize.X, 0, L_178_)
					}, L_141_arg1.tween_time)
					L_174_.Parent:FindFirstChild("Base").Transparency = 0
				end
				L_175_ = not L_175_
				wait(L_141_arg1.tween_time)
				L_176_ = true
			end
		end)
	end
	do -- UI Elements
		local L_183_ = L_143_:FindFirstChild("Tabs")
		local L_184_ = L_143_:FindFirstChild("TabSelection")
		local L_185_ = L_184_:FindFirstChild("TabButtons") -- Add Tab
		function L_145_:AddTab(L_186_arg0)
			local L_187_ = {}
			L_186_arg0 = tostring(L_186_arg0 or "New Tab")
			L_184_.Visible = true
			local L_188_ = L_83_:FindFirstChild("TabButton"):Clone()
			L_188_.Parent = L_185_
			L_188_.Text = L_186_arg0
			L_188_.Size = UDim2.new(0, L_89_func(L_188_), 0, 20)
			L_188_.ZIndex = L_188_.ZIndex + (L_92_ * 10)
			L_188_:GetChildren()[1].ZIndex = L_188_:GetChildren()[1].ZIndex + (L_92_ * 10)
			local L_189_ = L_83_:FindFirstChild("Tab"):Clone()
			L_189_.Parent = L_183_
			L_189_.ZIndex = L_189_.ZIndex + (L_92_ * 10)
			local L_190_ = false -- Assuming dropdown_open is a variable used elsewhere
			local function L_191_func()
				if L_190_ then
					return
				end
				L_143_.Visible = false
			end
			local function L_192_func()
				if L_190_ then
					return
				end
				for L_193_forvar0, L_194_forvar1 in next, L_185_:GetChildren() do
					if not L_194_forvar1:IsA("UIListLayout") then
						L_194_forvar1:GetChildren()[1].ImageColor3 = Color3.fromRGB(52, 53, 56)
						L_86_func(L_194_forvar1, {
							Size = UDim2.new(0, L_194_forvar1.AbsoluteSize.X, 0, 20)
						}, L_141_arg1.tween_time)
					end
				end
				for L_195_forvar0, L_196_forvar1 in next, L_183_:GetChildren() do
					L_196_forvar1.Visible = false
				end
				L_86_func(L_188_, {
					Size = UDim2.new(0, L_188_.AbsoluteSize.X, 0, 25)
				}, L_141_arg1.tween_time)
				L_188_:GetChildren()[1].ImageColor3 = Color3.fromRGB(73, 75, 79)
				L_189_.Visible = true
			end
			L_188_.Activated:Connect(
                    function()
				L_192_func()
			end)
			function L_187_:Show()
				L_192_func()
			end
			function L_187_:Hide()
				L_191_func()
			end
			do -- Tab Elements
				function L_187_:AddLabel(L_197_arg0) -- [Label]
					L_197_arg0 = tostring(L_197_arg0 or "New Label")
					local L_198_ = L_83_:FindFirstChild("Label"):Clone()
					L_198_.Parent = L_189_
					L_198_.Text = L_197_arg0
					L_198_.Size = UDim2.new(0, L_89_func(L_198_), 0, 20)
					L_198_.ZIndex = L_198_.ZIndex + (L_92_ * 10)
					return L_198_
				end

                    -- Example usage:
				function L_187_:AddButton(L_199_arg0, L_200_arg1) -- [Button]
					L_199_arg0 = tostring(L_199_arg0 or "New Button")
					L_200_arg1 = typeof(L_200_arg1) == "function" and L_200_arg1 or function()
					end
					local L_201_ = L_83_:FindFirstChild("Button"):Clone()
					L_201_.Parent = L_189_
					L_201_.Text = L_199_arg0
					L_201_.Size = UDim2.new(0, L_89_func(L_201_), 0, 20)
					L_201_.ZIndex = L_201_.ZIndex + (L_92_ * 10)
					L_201_:GetChildren()[1].ZIndex = L_201_:GetChildren()[1].ZIndex + (L_92_ * 10)
					spawn(
                            function()
						while true do
							if L_201_ and L_201_:GetChildren()[1] then
								local L_202_ = _G.baseColor:lerp(Color3.new(0, 0, 0), 0.4)
								button_color = L_202_
								L_201_:GetChildren()[1].ImageColor3 = button_color
							end
							L_79_.Heartbeat:Wait()
						end
					end)
					L_201_.Activated:Connect(
                            function()
						L_91_func(L_201_, L_82_.X, L_82_.Y)
						pcall(L_200_arg1)
					end)
					return L_201_
				end
				function L_187_:AddSwitch(L_203_arg0, L_204_arg1) -- [Switch]
					local L_205_ = {}
					L_203_arg0 = tostring(L_203_arg0 or "New Switch")
					L_204_arg1 = typeof(L_204_arg1) == "function" and L_204_arg1 or function()
					end
					local L_206_ = L_83_:FindFirstChild("Switch"):Clone()
					L_206_.Parent = L_189_
					L_206_:FindFirstChild("Title").Text = L_203_arg0
					L_206_:FindFirstChild("Title").ZIndex = L_206_:FindFirstChild("Title").ZIndex + (L_92_ * 10)
					L_206_.ZIndex = L_206_.ZIndex + (L_92_ * 10)
					L_206_:GetChildren()[1].ZIndex = L_206_:GetChildren()[1].ZIndex + (L_92_ * 10)
					spawn(
                            function()
						while true do
							if L_206_ and L_206_:GetChildren()[1] then
								L_206_:GetChildren()[1].ImageColor3 = L_141_arg1.main_color
							end
							L_79_.Heartbeat:Wait()
						end
					end)
					local L_207_ = false
					L_206_.Activated:Connect(
                            function()
						L_207_ = not L_207_
						L_206_.Text = L_207_ and utf8.char(10003) or ""
						pcall(L_204_arg1, L_207_)
					end)
					function L_205_:Set(L_208_arg0)
						L_207_ = (typeof(L_208_arg0) == "boolean") and L_208_arg0 or false
						L_206_.Text = L_207_ and utf8.char(10003) or ""
						pcall(L_204_arg1, L_207_)
					end
					return L_205_, L_206_
				end
				function L_187_:AddTextBox(L_209_arg0, L_210_arg1, L_211_arg2)
					L_209_arg0 = tostring(L_209_arg0 or "New TextBox")
					L_210_arg1 = typeof(L_210_arg1) == "function" and L_210_arg1 or function()
					end
					L_211_arg2 = typeof(L_211_arg2) == "table" and L_211_arg2 or {
						["clear"] = true
					}
					L_211_arg2 = {
						["clear"] = ((L_211_arg2.clear) == true)
					}
					local L_212_ = L_83_:FindFirstChild("TextBox"):Clone()
					L_212_.Parent = L_189_
					L_212_.PlaceholderText = L_209_arg0
					L_212_.ZIndex = L_212_.ZIndex + (L_92_ * 10)
					L_212_:GetChildren()[1].ZIndex = L_212_:GetChildren()[1].ZIndex + (L_92_ * 10)
					L_212_.FocusLost:Connect(
                            function(L_213_arg0)
						if L_213_arg0 then
							if # L_212_.Text > 0 then
								pcall(L_210_arg1, L_212_.Text)
								if L_211_arg2.clear then
									L_212_.Text = ""
								end
							end
						end
					end)
					return L_212_
				end
				function L_187_:AddSlider(L_214_arg0, L_215_arg1, L_216_arg2)
					local L_217_ = {}
					L_214_arg0 = tostring(L_214_arg0 or "New Slider")
					L_215_arg1 = typeof(L_215_arg1) == "function" and L_215_arg1 or function()
					end
					L_216_arg2 = typeof(L_216_arg2) == "table" and L_216_arg2 or {}
					L_216_arg2 = {
						["min"] = L_216_arg2.min or 0,
						["max"] = L_216_arg2.max or 100,
						["readonly"] = L_216_arg2.readonly or false
					}
					local L_218_ = L_83_:FindFirstChild("Slider"):Clone()
					L_218_.Parent = L_189_
					L_218_.ZIndex = L_218_.ZIndex + (L_92_ * 10)
					local L_219_ = L_218_:FindFirstChild("Title")
					local L_220_ = L_218_:FindFirstChild("Indicator")
					local L_221_ = L_218_:FindFirstChild("Value")
					L_219_.ZIndex = L_219_.ZIndex + (L_92_ * 10)
					L_220_.ZIndex = L_220_.ZIndex + (L_92_ * 10)
					L_221_.ZIndex = L_221_.ZIndex + (L_92_ * 10)
					L_219_.Text = L_214_arg0
					do -- Slider Math
						local L_222_ = false
						L_218_.MouseEnter:Connect(
                                function()
							L_222_ = true
							L_149_:setDraggable(false)
						end)
						L_218_.MouseLeave:Connect(
                                function()
							L_222_ = false
							L_149_:setDraggable(true)
						end)
						local L_223_ = false
						L_77_.InputBegan:Connect(
                                function(L_224_arg0)
							if L_224_arg0.UserInputType == Enum.UserInputType.MouseButton1 or L_224_arg0.UserInputType == Enum.UserInputType.Touch then
								L_223_ = true
								spawn(
                                            function()
                                                -- Loop check
									if L_222_ and not L_216_arg2.readonly then
										while L_223_ and (not L_190_) do
											local L_225_ = L_90_func()
											local L_226_ = (L_218_.AbsoluteSize.X - (L_218_.AbsoluteSize.X - (L_225_.X - L_218_.AbsolutePosition.X) + 1)) / L_218_.AbsoluteSize.X
											local L_227_ = 0
											local L_228_ = 1
											local L_229_ = L_227_
											if L_226_ >= L_227_ and L_226_ <= L_228_ then
												L_229_ = L_226_
											elseif L_226_ < L_227_ then
												L_229_ = L_227_
											elseif L_226_ > L_228_ then
												L_229_ = L_228_
											end
											L_86_func(
                                                            L_220_, {
												Size = UDim2.new(L_229_ or L_227_, 0, 0, 20)
											}, L_141_arg1.tween_time)
											local L_230_ = math.floor((L_229_ or L_227_) * 100)
											local L_231_ = L_216_arg2.max
											local L_232_ = L_216_arg2.min
											local L_233_ = L_231_ - L_232_
											local L_234_ = math.floor(((L_233_ / 100) * L_230_) + L_232_)
											L_221_.Text = tostring(L_234_)
											pcall(L_215_arg1, L_234_)
											L_79_.Heartbeat:Wait()
										end
									end
								end)
							end
						end)
						L_77_.InputEnded:Connect(
                                function(L_235_arg0)
							if L_235_arg0.UserInputType == Enum.UserInputType.MouseButton1 or L_235_arg0.UserInputType == Enum.UserInputType.Touch then
								L_223_ = false
							end
						end)
						function L_217_:Set(L_236_arg0)
							L_236_arg0 = tonumber(L_236_arg0) or 0
							L_236_arg0 = (((L_236_arg0 >= 0 and L_236_arg0 <= 100) and L_236_arg0) / 100)
							L_86_func(L_220_, {
								Size = UDim2.new(L_236_arg0 or 0, 0, 0, 20)
							}, L_141_arg1.tween_time)
							local L_237_ = math.floor((L_236_arg0 or 0) * 100)
							local L_238_ = L_216_arg2.max
							local L_239_ = L_216_arg2.min
							local L_240_ = L_238_ - L_239_
							local L_241_ = math.floor(((L_240_ / 100) * L_237_) + L_239_)
							L_221_.Text = tostring(L_241_)
							pcall(L_215_arg1, L_241_)
						end
						L_217_:Set(L_216_arg2["min"])
					end
					return L_217_, L_218_
				end
				function L_187_:AddKeybind(L_242_arg0, L_243_arg1, L_244_arg2)
					local L_245_ = {}
					L_242_arg0 = tostring(L_242_arg0 or "New Keybind")
					L_243_arg1 = typeof(L_243_arg1) == "function" and L_243_arg1 or function()
					end
					L_244_arg2 = typeof(L_244_arg2) == "table" and L_244_arg2 or {}
					L_244_arg2 = {
						["standard"] = L_244_arg2.standard or Enum.KeyCode.RightShift
					}
					local L_246_ = L_83_:FindFirstChild("Keybind"):Clone()
					local L_247_ = L_246_:FindFirstChild("Input")
					local L_248_ = L_246_:FindFirstChild("Title")
					L_246_.ZIndex = L_246_.ZIndex + (L_92_ * 10)
					L_247_.ZIndex = L_247_.ZIndex + (L_92_ * 10)
					L_247_:GetChildren()[1].ZIndex = L_247_:GetChildren()[1].ZIndex + (L_92_ * 10)
					L_248_.ZIndex = L_248_.ZIndex + (L_92_ * 10)
					L_246_.Parent = L_189_
					L_248_.Text = "  " .. L_242_arg0
					L_246_.Size = UDim2.new(0, L_89_func(L_248_) + 80, 0, 20)
					local L_249_ = {
                            -- thanks to stroketon for helping me out with this
						RightControl = "RightCtrl",
						LeftControl = "LeftCtrl",
						LeftShift = "LShift",
						RightShift = "RShift",
						MouseButton1 = "Mouse1",
						MouseButton2 = "Mouse2"
					}
					local L_250_ = L_244_arg2.standard
					function L_245_:SetKeybind(L_251_arg0)
						local L_252_ = L_249_[L_251_arg0.Name] or L_251_arg0.Name
						L_247_.Text = L_252_
						L_250_ = L_251_arg0
					end
					L_77_.InputBegan:Connect(
                            function(L_253_arg0, L_254_arg1)
						if L_85_.binding then
							spawn(
                                        function()
								wait()
								L_85_.binding = false
							end)
							return
						end
						if L_253_arg0.KeyCode == L_250_ and not L_254_arg1 then
							pcall(L_243_arg1, L_250_)
						end
					end)
					L_245_:SetKeybind(L_244_arg2.standard)
					L_247_.Activated:Connect(
                            function()
						if L_85_.binding then
							return
						end
						L_247_.Text = "..."
						L_85_.binding = true
						local L_255_, L_256_ = L_77_.InputBegan:Wait()
						L_245_:SetKeybind(L_255_.KeyCode)
					end)
					return L_245_, L_250_
				end
				function L_187_:AddDropdown(L_257_arg0, L_258_arg1)
					local L_259_ = {}
					L_257_arg0 = tostring(L_257_arg0 or "New Dropdown")
					L_258_arg1 = typeof(L_258_arg1) == "function" and L_258_arg1 or function()
					end
					local L_260_ = L_83_:FindFirstChild("Dropdown"):Clone()
					local L_261_ = L_260_:FindFirstChild("Box")
					local L_262_ = L_261_:FindFirstChild("Objects")
					local L_263_ = L_260_:FindFirstChild("Indicator")
					L_260_.ZIndex = L_260_.ZIndex + (L_92_ * 10)
					L_261_.ZIndex = L_261_.ZIndex + (L_92_ * 10)
					L_262_.ZIndex = L_262_.ZIndex + (L_92_ * 10)
					L_263_.ZIndex = L_263_.ZIndex + (L_92_ * 10)
					L_260_:GetChildren()[3].ZIndex = L_260_:GetChildren()[3].ZIndex + (L_92_ * 10)
					L_260_.Parent = L_189_
					L_260_.Text = "      " .. L_257_arg0
					L_261_.Size = UDim2.new(1, 0, 0, 0)
					local L_264_ = false
					L_260_.Activated:Connect(
                            function()
						L_264_ = not L_264_
						local L_265_ = (# L_262_:GetChildren() - 1) * 20
						if # L_262_:GetChildren() - 1 >= 10 then
							L_265_ = 200
							L_262_.CanvasSize = UDim2.new(0, 0, (# L_262_:GetChildren() - 1) * 0.1, 0)
						end
						if L_264_ then -- Open
							if L_190_ then
								return
							end
							L_190_ = true
							L_86_func(L_261_, {
								Size = UDim2.new(1, 0, 0, L_265_)
							}, L_141_arg1.tween_time)
							L_86_func(L_263_, {
								Rotation = 90
							}, L_141_arg1.tween_time)
						else -- Close
							L_190_ = false
							L_86_func(L_261_, {
								Size = UDim2.new(1, 0, 0, 0)
							}, L_141_arg1.tween_time)
							L_86_func(L_263_, {
								Rotation = -90
							}, L_141_arg1.tween_time)
						end
					end)
					function L_259_:Add(L_266_arg0)
						local L_267_ = {}
						L_266_arg0 = tostring(L_266_arg0 or "New Object")
						local L_268_ = L_83_:FindFirstChild("DropdownButton"):Clone()
						L_268_.Parent = L_262_
						L_268_.Text = L_266_arg0
						L_268_.ZIndex = L_268_.ZIndex + (L_92_ * 10)
						L_268_.MouseEnter:Connect(
                                function()
							L_268_.BackgroundColor3 = L_141_arg1.main_color
						end)
						L_268_.MouseLeave:Connect(
                                function()
							L_268_.BackgroundColor3 = Color3.fromRGB(33, 34, 36)
						end)
						if L_264_ then
							local L_269_ = (# L_262_:GetChildren() - 1) * 20
							if # L_262_:GetChildren() - 1 >= 10 then
								L_269_ = 200
								L_262_.CanvasSize = UDim2.new(0, 0, (# L_262_:GetChildren() - 1) * 0.1, 0)
							end
							L_86_func(L_261_, {
								Size = UDim2.new(1, 0, 0, L_269_)
							}, L_141_arg1.tween_time)
						end
						L_268_.Activated:Connect(
                                function()
							if L_190_ then
								L_260_.Text = "      [ " .. L_266_arg0 .. " ]"
								L_190_ = false
								L_264_ = false
								L_86_func(L_261_, {
									Size = UDim2.new(1, 0, 0, 0)
								}, L_141_arg1.tween_time)
								L_86_func(L_263_, {
									Rotation = -90
								}, L_141_arg1.tween_time)
								pcall(L_258_arg1, L_266_arg0)
							end
						end)
						function L_267_:Remove()
							L_268_:Destroy()
						end
						return L_268_, L_267_
					end
					return L_259_, L_260_
				end
				function L_187_:AddColorPicker(L_270_arg0)
					local L_271_ = {}
					L_270_arg0 = typeof(L_270_arg0) == "function" and L_270_arg0 or function()
					end
					local L_272_ = L_83_:FindFirstChild("ColorPicker"):Clone()
					L_272_.Parent = L_189_
					L_272_.ZIndex = L_272_.ZIndex + (L_92_ * 10)
					local L_273_ = L_272_:FindFirstChild("Palette")
					local L_274_ = L_272_:FindFirstChild("Sample")
					local L_275_ = L_272_:FindFirstChild("Saturation")
					L_273_.ZIndex = L_273_.ZIndex + (L_92_ * 10)
					L_274_.ZIndex = L_274_.ZIndex + (L_92_ * 10)
					L_275_.ZIndex = L_275_.ZIndex + (L_92_ * 10)
					do -- Color Picker Math
						local L_276_ = 0
						local L_277_ = 1
						local L_278_ = 1
						local function L_279_func()
							local L_285_ = Color3.fromHSV(L_276_, L_277_, L_278_)
							L_274_.ImageColor3 = L_285_
							L_275_.ImageColor3 = Color3.fromHSV(L_276_, 1, 1)
							pcall(L_270_arg0, L_285_)
						end
						do
							local L_286_ = Color3.fromHSV(L_276_, L_277_, L_278_)
							L_274_.ImageColor3 = L_286_
							L_275_.ImageColor3 = Color3.fromHSV(L_276_, 1, 1)
						end
						local L_280_, L_281_ = false, false
						L_273_.MouseEnter:Connect(
                                function()
							L_149_:setDraggable(false)
							L_280_ = true
						end)
						L_273_.MouseLeave:Connect(
                                function()
							L_149_:setDraggable(true)
							L_280_ = false
						end)
						L_275_.MouseEnter:Connect(
                                function()
							L_149_:setDraggable(false)
							L_281_ = true
						end)
						L_275_.MouseLeave:Connect(
                                function()
							L_149_:setDraggable(true)
							L_281_ = false
						end)
						local L_282_ = L_273_:FindFirstChild("Indicator")
						local L_283_ = L_275_:FindFirstChild("Indicator")
						L_282_.ZIndex = L_282_.ZIndex + (L_92_ * 10)
						L_283_.ZIndex = L_283_.ZIndex + (L_92_ * 10)
						local L_284_ = false
						L_77_.InputBegan:Connect(
                                function(L_287_arg0)
							if L_287_arg0.UserInputType == Enum.UserInputType.MouseButton1 or L_287_arg0.UserInputType == Enum.UserInputType.Touch then
								L_284_ = true
								spawn(
                                            function()
                                                -- Loop check
									while L_284_ and L_280_ and (not L_190_) do -- Palette
										local L_288_ = L_90_func()
										local L_289_ = ((L_273_.AbsoluteSize.X - (L_288_.X - L_273_.AbsolutePosition.X)) + 1)
										local L_290_ = ((L_273_.AbsoluteSize.Y - (L_288_.Y - L_273_.AbsolutePosition.Y)) + 1.5)
										local L_291_ = Color3.fromHSV(L_289_ / 100, L_290_ / 100, 0)
										L_276_ = L_289_ / 100
										L_277_ = L_290_ / 100
										L_86_func(
                                                        L_282_, {
											Position = UDim2.new(0, math.abs(L_289_ - 100) - (L_282_.AbsoluteSize.X / 2), 0, math.abs(L_290_ - 100) - (L_282_.AbsoluteSize.Y / 2))
										}, L_141_arg1.tween_time)
										L_279_func()
										L_79_.Heartbeat:Wait()
									end
									while L_284_ and L_281_ and (not L_190_) do -- Saturation
										local L_292_ = L_90_func()
										local L_293_ = ((L_273_.AbsoluteSize.Y - (L_292_.Y - L_273_.AbsolutePosition.Y)) + 1.5)
										L_278_ = L_293_ / 100
										L_86_func(
                                                        L_283_, {
											Position = UDim2.new(0, 0, 0, math.abs(L_293_ - 100))
										}, L_141_arg1.tween_time)
										L_279_func()
										L_79_.Heartbeat:Wait()
									end
								end)
							end
						end)
						L_77_.InputEnded:Connect(
                                function(L_294_arg0)
							if L_294_arg0.UserInputType == Enum.UserInputType.MouseButton1 or L_294_arg0.UserInputType == Enum.UserInputType.Touch then
								L_284_ = false
							end
						end)
						function L_271_:Set(L_295_arg0)
							L_295_arg0 = typeof(L_295_arg0) == "Color3" and L_295_arg0 or Color3.new(1, 1, 1)
							local L_296_, L_297_, L_298_ = L_87_func(L_295_arg0.r * 255, L_295_arg0.g * 255, L_295_arg0.b * 255)
							L_274_.ImageColor3 = L_295_arg0
							L_275_.ImageColor3 = Color3.fromHSV(L_296_, 1, 1)
							pcall(L_270_arg0, L_295_arg0)
						end
					end
					return L_271_, L_272_
				end
				function L_187_:AddConsole(L_299_arg0)
					local L_300_ = {}
					L_299_arg0 = typeof(L_299_arg0) == "table" and L_299_arg0 or {
						["readonly"] = true,
						["full"] = false
					}
					L_299_arg0 = {
						["y"] = tonumber(L_299_arg0.y) or 200,
						["source"] = L_299_arg0.source or "Logs",
						["readonly"] = ((L_299_arg0.readonly) == true),
						["full"] = ((L_299_arg0.full) == true)
					}
					local L_301_ = L_83_:FindFirstChild("Console"):Clone()
					L_301_.Parent = L_189_
					L_301_.ZIndex = L_301_.ZIndex + (L_92_ * 10)
					L_301_.Size = UDim2.new(1, 0, L_299_arg0.full and 1 or 0, L_299_arg0.y)
					local L_302_ = L_301_:GetChildren()[1]
					local L_303_ = L_302_:FindFirstChild("Source")
					local L_304_ = L_302_:FindFirstChild("Lines")
					L_303_.ZIndex = L_303_.ZIndex + (L_92_ * 10)
					L_304_.ZIndex = L_304_.ZIndex + (L_92_ * 10)
					L_303_.TextEditable = not L_299_arg0.readonly -- Syntax Zindex
					for L_305_forvar0, L_306_forvar1 in next, L_303_:GetChildren() do
						L_306_forvar1.ZIndex = L_306_forvar1.ZIndex + (L_92_ * 10) + 1
					end
					L_303_.Comments.ZIndex = L_303_.Comments.ZIndex + 1
					do -- Highlighting (thanks to whoever made this)
						local L_307_ = {
							"and",
							"break",
							"do",
							"else",
							"elseif",
							"end",
							"false",
							"for",
							"function",
							"goto",
							"if",
							"in",
							"local",
							"nil",
							"not",
							"or",
							"repeat",
							"return",
							"then",
							"true",
							"until",
							"while"
						}
						local L_308_ = {
							"getrawmetatable",
							"newcclosure",
							"islclosure",
							"setclipboard",
							"game",
							"workspace",
							"script",
							"math",
							"string",
							"table",
							"print",
							"wait",
							"BrickColor",
							"Color3",
							"next",
							"pairs",
							"ipairs",
							"select",
							"unpack",
							"Instance",
							"Vector2",
							"Vector3",
							"CFrame",
							"Ray",
							"UDim2",
							"Enum",
							"assert",
							"error",
							"warn",
							"tick",
							"loadstring",
							"_G",
							"shared",
							"getfenv",
							"setfenv",
							"newproxy",
							"setmetatable",
							"getmetatable",
							"os",
							"debug",
							"pcall",
							"ypcall",
							"xpcall",
							"rawequal",
							"rawset",
							"rawget",
							"tonumber",
							"tostring",
							"type",
							"typeof",
							"_VERSION",
							"coroutine",
							"delay",
							"require",
							"spawn",
							"LoadLibrary",
							"settings",
							"stats",
							"time",
							"UserSettings",
							"version",
							"Axes",
							"ColorSequence",
							"Faces",
							"ColorSequenceKeypoint",
							"NumberRange",
							"NumberSequence",
							"NumberSequenceKeypoint",
							"gcinfo",
							"elapsedTime",
							"collectgarbage",
							"PhysicalProperties",
							"Rect",
							"Region3",
							"Region3int16",
							"UDim",
							"Vector2int16",
							"Vector3int16",
							"load",
							"fire",
							"Fire"
						}
						local L_309_ = function(L_316_arg0, L_317_arg1)
							local L_318_ = {}
							local L_319_ = L_316_arg0
							local L_320_ = {
								["="] = true,
								["."] = true,
								[","] = true,
								["("] = true,
								[")"] = true,
								["["] = true,
								["]"] = true,
								["{"] = true,
								["}"] = true,
								[":"] = true,
								["*"] = true,
								["/"] = true,
								["+"] = true,
								["-"] = true,
								["%"] = true,
								[";"] = true,
								["~"] = true
							}
							for L_321_forvar0, L_322_forvar1 in pairs(L_317_arg1) do
								L_318_[L_322_forvar1] = true
							end
							L_319_ = L_319_:gsub(".", function(L_323_arg0)
								if L_320_[L_323_arg0] ~= nil then
									return "\32"
								else
									return L_323_arg0
								end
							end)
							L_319_ = L_319_:gsub("%S+", function(L_324_arg0)
								if L_318_[L_324_arg0] ~= nil then
									return L_324_arg0
								else
									return (" "):rep(# L_324_arg0)
								end
							end)
							return L_319_
						end
						local L_310_ = function(L_325_arg0)
							local L_326_ = {
								["="] = true,
								["."] = true,
								[","] = true,
								["("] = true,
								[")"] = true,
								["["] = true,
								["]"] = true,
								["{"] = true,
								["}"] = true,
								[":"] = true,
								["*"] = true,
								["/"] = true,
								["+"] = true,
								["-"] = true,
								["%"] = true,
								[";"] = true,
								["~"] = true
							}
							local L_327_ = ""
							L_325_arg0:gsub(".", function(L_328_arg0)
								if L_326_[L_328_arg0] ~= nil then
									L_327_ = L_327_ .. L_328_arg0
								elseif L_328_arg0 == "\n" then
									L_327_ = L_327_ .. "\n"
								elseif L_328_arg0 == "\t" then
									L_327_ = L_327_ .. "\t"
								else
									L_327_ = L_327_ .. "\32"
								end
							end)
							return L_327_
						end
						local L_311_ = function(L_329_arg0)
							local L_330_ = ""
							local L_331_ = false
							L_329_arg0:gsub(".", function(L_332_arg0)
								if L_331_ == false and L_332_arg0 == "\34" then
									L_331_ = true
								elseif L_331_ == true and L_332_arg0 == "\34" then
									L_331_ = false
								end
								if L_331_ == false and L_332_arg0 == "\34" then
									L_330_ = L_330_ .. "\34"
								elseif L_332_arg0 == "\n" then
									L_330_ = L_330_ .. "\n"
								elseif L_332_arg0 == "\t" then
									L_330_ = L_330_ .. "\t"
								elseif L_331_ == true then
									L_330_ = L_330_ .. L_332_arg0
								elseif L_331_ == false then
									L_330_ = L_330_ .. "\32"
								end
							end)
							return L_330_
						end
						local L_312_ = function(L_333_arg0)
							local L_334_ = ""
							local L_335_ = false
							L_333_arg0:gsub(".", function(L_336_arg0)
								if L_335_ == false and L_336_arg0 == "[" then
									L_335_ = true
								elseif L_335_ == true and L_336_arg0 == "]" then
									L_335_ = false
								end
								if L_335_ == false and L_336_arg0 == "\\]" then
									L_334_ = L_334_ .. "\\]"
								elseif L_336_arg0 == "\n" then
									L_334_ = L_334_ .. "\n"
								elseif L_336_arg0 == "\t" then
									L_334_ = L_334_ .. "\t"
								elseif L_335_ == true then
									L_334_ = L_334_ .. L_336_arg0
								elseif L_335_ == false then
									L_334_ = L_334_ .. "\32"
								end
							end)
							return L_334_
						end
						local L_313_ = function(L_337_arg0)
							local L_338_ = ""
							L_337_arg0:gsub("[^\r\n]+", function(L_339_arg0)
								local L_340_ = false
								local L_341_ = 0
								L_339_arg0:gsub(".", function(L_342_arg0)
									L_341_ = L_341_ + 1
									if L_339_arg0:sub(L_341_, L_341_ + 1) == "--" then
										L_340_ = true
									end
									if L_340_ == true then
										L_338_ = L_338_ .. L_342_arg0
									else
										L_338_ = L_338_ .. "\32"
									end
								end)
								L_338_ = L_338_
							end)
							return L_338_
						end
						local L_314_ = function(L_343_arg0)
							local L_344_ = ""
							L_343_arg0:gsub(".", function(L_345_arg0)
								if tonumber(L_345_arg0) ~= nil then
									L_344_ = L_344_ .. L_345_arg0
								elseif L_345_arg0 == "\n" then
									L_344_ = L_344_ .. "\n"
								elseif L_345_arg0 == "\t" then
									L_344_ = L_344_ .. "\t"
								else
									L_344_ = L_344_ .. "\32"
								end
							end)
							return L_344_
						end
						local L_315_ = function(L_346_arg0)
							if L_346_arg0 == "Text" then
								L_303_.Text = L_303_.Text:gsub("\13", "")
								L_303_.Text = L_303_.Text:gsub("\t", "      ")
								local L_348_ = L_303_.Text
								L_303_.Keywords.Text = L_309_(L_348_, L_307_)
								L_303_.Globals.Text = L_309_(L_348_, L_308_)
								L_303_.RemoteHighlight.Text = L_309_(L_348_, {
									"FireServer",
									"fireServer",
									"InvokeServer",
									"invokeServer"
								})
								L_303_.Tokens.Text = L_310_(L_348_)
								L_303_.Numbers.Text = L_314_(L_348_)
								L_303_.Strings.Text = L_311_(L_348_)
								L_303_.Comments.Text = L_313_(L_348_)
								local L_349_ = 1
								L_348_:gsub("\n", function()
									L_349_ = L_349_ + 1
								end)
								L_304_.Text = ""
								for L_350_forvar0 = 1, L_349_ do
									L_304_.Text = L_304_.Text .. L_350_forvar0 .. "\n"
								end
								L_302_.CanvasSize = UDim2.new(0, 0, L_349_ * 0.153846154, 0)
							end
							local L_347_ = function(L_351_arg0)
							end
							if L_346_arg0 == "Text" then
								L_303_.Text = L_303_.Text:gsub("\13", "")
								L_303_.Text = L_303_.Text:gsub("\t", "      ")
								local L_352_ = L_303_.Text
								L_303_.Info.Text = L_312_(L_352_)
								local L_353_ = 1
								L_352_:gsub("\n", function()
									L_353_ = L_353_ + 1
								end)
								L_302_.CanvasSize = UDim2.new(0, 0, L_353_ * 0.153846154, 0)
							end
						end
						if L_299_arg0.source == "Lua" then
							L_315_("Text")
							L_303_.Changed:Connect(L_315_)
						elseif L_299_arg0.source == "Logs" then
							L_304_.Visible = false
							highlight_logs("Text")
							L_303_.Changed:Connect(highlight_logs)
						end
						function L_300_:Set(L_354_arg0)
							L_303_.Text = tostring(L_354_arg0)
						end
						function L_300_:Get()
							return L_303_.Text
						end
						function L_300_:Log(L_355_arg0)
							L_303_.Text = L_303_.Text .. "[*] " .. tostring(L_355_arg0) .. "\n"
						end
					end
					return L_300_, L_301_
				end
				function L_187_:AddHorizontalAlignment()
					local L_356_ = {}
					local L_357_ = L_83_:FindFirstChild("HorizontalAlignment"):Clone()
					L_357_.Parent = L_189_
					function L_356_:AddButton(...)
						local L_358_, L_359_
						local L_360_ = {
							L_187_:AddButton(...)
						}
						if typeof(L_360_[1]) == "table" then
							L_358_ = L_360_[1]
							L_359_ = L_360_[2]
							L_359_.Parent = L_357_
							return L_358_, L_359_
						else
							L_359_ = L_360_[1]
							L_359_.Parent = L_357_
							return L_359_
						end
					end
					return L_356_, L_357_
				end
				function L_187_:AddFolder(L_361_arg0) -- [Folder]
					local L_362_ = {}
					L_361_arg0 = tostring(L_361_arg0 or "New Folder")
					local L_363_ = L_83_:FindFirstChild("Folder"):Clone()
					local L_364_ = L_363_:FindFirstChild("Button")
					local L_365_ = L_363_:FindFirstChild("Objects")
					local L_366_ = L_364_:FindFirstChild("Toggle")
					L_363_.ZIndex = L_363_.ZIndex + (L_92_ * 10)
					L_364_.ZIndex = L_364_.ZIndex + (L_92_ * 10)
					L_365_.ZIndex = L_365_.ZIndex + (L_92_ * 10)
					L_366_.ZIndex = L_366_.ZIndex + (L_92_ * 10)
					L_364_:GetChildren()[1].ZIndex = L_364_:GetChildren()[1].ZIndex + (L_92_ * 10)
					L_363_.Parent = L_189_
					L_364_.Text = "        " .. L_361_arg0
					spawn(
                            function()
						while true do
							if L_364_ and L_364_:GetChildren()[1] then
								local L_369_ = _G.baseColor:lerp(Color3.new(0, 0, 0), 0.3)
								folder_color = L_369_ --HEREHEREHERE
								L_364_:GetChildren()[1].ImageColor3 = folder_color
							end
							L_79_.Heartbeat:Wait()
						end
					end)
					local function L_367_func()
						local L_370_ = 25
						for L_371_forvar0, L_372_forvar1 in next, L_365_:GetChildren() do
							if not (L_372_forvar1:IsA("UIListLayout")) then
								L_370_ = L_370_ + L_372_forvar1.AbsoluteSize.Y + 5
							end
						end
						return L_370_
					end
					local L_368_ = false
					L_364_.Activated:Connect(
                            function()
						if L_368_ then -- Close
							L_86_func(L_366_, {
								Rotation = 0
							}, L_141_arg1.tween_time)
							L_365_.Visible = false
						else -- Open
							L_86_func(L_366_, {
								Rotation = 90
							}, L_141_arg1.tween_time)
							L_365_.Visible = true
						end
						L_368_ = not L_368_
					end)
					function L_362_:Fold(L_373_arg0)
						L_86_func(L_366_, {
							Rotation = (L_368_ and 0 or 90)
						}, L_141_arg1.tween_time)
						L_368_, L_365_.Visible = L_373_arg0, L_373_arg0
					end
					spawn(
                            function()
						while true do
							L_86_func(
                                        L_363_, {
								Size = UDim2.new(1, 0, 0, (L_368_ and L_367_func() or 20))
							}, L_141_arg1.tween_time)
							wait()
						end
					end)
					for L_374_forvar0, L_375_forvar1 in next, L_187_ do
						L_362_[L_374_forvar0] = function(...)
							local L_376_, L_377_
							local L_378_ = {
								L_375_forvar1(...)
							}
							if typeof(L_378_[1]) == "table" then
								L_376_ = L_378_[1]
								L_377_ = L_378_[2]
								L_377_.Parent = L_365_
								return L_376_, L_377_
							else
								L_377_ = L_378_[1]
								L_377_.Parent = L_365_
								return L_377_
							end
						end
					end
					return L_362_, L_363_
				end
			end
			return L_187_, L_189_
		end
	end
	for L_379_forvar0, L_380_forvar1 in next, L_143_:GetDescendants() do
		if L_88_func(L_380_forvar1, "ZIndex") then
			L_380_forvar1.ZIndex = L_380_forvar1.ZIndex + (L_92_ * 10)
		end
	end
	return L_145_, L_143_
end

-- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --

-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --

-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --

-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --

-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --

-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --
-- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT ---- USELESS UI SHIT --

_G.extraantilag = false
_G.Speed = 1
_G.Autofarming = false
_G.BuildSize = 1

-- // LOCALS \\ --

localPlayer = game.Players.LocalPlayer
playerGui = localPlayer:WaitForChild("PlayerGui")
playerListFrame = playerGui:WaitForChild("PlayerListGui"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
TeamOwner = game.Players.LocalPlayer

RunService = game:GetService("RunService")
Players = game:GetService("Players")
player = Players.LocalPlayer

-- Configuration
totalGoldGained = 0
initialAmount = 0

humanoidRootPart = nil

stages = {
	"CaveStage1",
	"CaveStage2",
	"CaveStage3",
	"CaveStage4",
	"CaveStage5",
	"CaveStage6",
	"CaveStage7",
	"CaveStage8",
	"CaveStage9",
	"CaveStage10"
}

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
blocksPerBatch = _G.Speed

blockCosts = {
	WoodBlock = 5, -- 50 blocks for 250 gold, so 5 gold per block
	SmoothWoodBlock = 5, -- 50 blocks for 250 gold, so 5 gold per block
	GlassBlock = 10, -- 25 blocks for 250 gold, so 10 gold per block
	StoneBlock = 5.5, -- 50 blocks for 275 gold, so 5.5 gold per block
	FabricBlock = 6, -- 50 blocks for 300 gold, so 6 gold per block
	PlasticBlock = 6, -- 50 blocks for 300 gold, so 6 gold per block
	GrassBlock = 6, -- 50 blocks for 300 gold, so 6 gold per block
	SandBlock = 6, -- 50 blocks for 300 gold, so 6 gold per block
	RustedBlock = 6, -- 50 blocks for 300 gold, so 6 gold per block
	BouncyBlock = 6, -- 50 blocks for 300 gold, so 6 gold per block
	MetalBlock = 6.5, -- 50 blocks for 325 gold, so 6.5 gold per block
	ConcreteBlock = 7, -- 50 blocks for 350 gold, so 7 gold per block
	IceBlock = 7, -- 50 blocks for 350 gold, so 7 gold per block
	CoalBlock = 7.5, -- 50 blocks for 375 gold, so 7.5 gold per block
	BrickBlock = 7.5, -- 50 blocks for 375 gold, so 7.5 gold per block
	MarbleBlock = 7.5, -- 50 blocks for 375 gold, so 7.5 gold per block
	TitaniumBlock = 8, -- 50 blocks for 400 gold, so 8 gold per block
	ObsidianBlock = 8.5 -- 50 blocks for 425 gold, so 8.5 gold per block
}

blockNames = {
	"BalloonBlock",
	"BalloonStarBlock",
	"WoodBlock",
	"TitaniumBlock",
	"StoneBlock",
	"SandBlock",
	"RustedBlock",
	"PlasticBlock",
	"ToyBlock",
	"ObsidianBlock",
	"NeonBlock",
	"MetalBlock",
	"MarbleBlock",
	"IceBlock",
	"GrassBlock",
	"GoldBlock",
	"GlassBlock",
	"BouncyBlock",
	"ParachuteBlock",
	"FabricBlock",
	"ConcreteBlock",
	"CoalBlock",
	"CaneBlock",
	"BrickBlock",
	"SmoothWoodBlock"
}

-- \\ LOCALS // --

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
	print("Updated TeamOwner: " .. (TeamOwner or "No team owner found"))
end

-- Function to handle character added
local function L_101_func(L_413_arg0)
	humanoidRootPart = L_413_arg0:WaitForChild("HumanoidRootPart")
	if _G.Autofarming then
		L_100_func()
	end
end

function BetaInstantLoad() 
	L_96_func()
	local L_416_ = false

    -- Function to send notifications
	local function L_417_func(L_447_arg0, L_448_arg1, L_449_arg2)
		L_2_:Notify(
            {
			Title = L_447_arg0,
			Description = L_448_arg1
		}, {
			OutlineColor = Color3.fromRGB(44, 44, 200),
			Time = 5,
			Type = "image"
		}, {
			Image = "rbxassetid://111630714337304",
			ImageColor = L_449_arg2
		})
	end

    -- Retrieve necessary services and tools
	local L_418_ = game:GetService("Players")
	local L_419_ = L_418_.LocalPlayer
	local L_420_ = L_419_.Backpack
	local L_421_ = L_419_.Character or L_419_.CharacterAdded:Wait()
	local L_422_ = L_420_:FindFirstChild("BuildingTool") and (L_420_.BuildingTool:FindFirstChild("RF") or L_421_.BuildingTool:FindFirstChild("RF"))
	local L_423_ = L_420_:FindFirstChild("ScalingTool") and (L_420_.ScalingTool:FindFirstChild("RF") or L_421_.ScalingTool:FindFirstChild("RF"))
	local L_424_ = L_420_:FindFirstChild("PaintingTool") and (L_420_.PaintingTool:FindFirstChild("RF") or L_421_.PaintingTool:FindFirstChild("RF"))
	local L_425_ = L_420_:FindFirstChild("PropertiesTool") and (L_420_.PropertiesTool:FindFirstChild("SetPropertieRF"))

    -- Retrieve data and blocks
	local L_426_ = L_419_:FindFirstChild("Data")
	local L_427_ = game:GetService("Workspace")
	local L_428_ = L_427_:FindFirstChild("Blocks")
	local L_429_ = L_427_:FindFirstChild("BuildPreview")
	local L_430_ = L_419_.TeamColor.Name
	local L_431_ = L_427_:FindFirstChild(L_430_ .. "Zone")

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
		if L_429_ then
			for L_450_forvar0, L_451_forvar1 in pairs(L_429_:GetChildren()) do
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
		print("Collected parts:", # L_432_)
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
		L_422_:InvokeServer(unpack(L_461_))
	end

    -- Function to invoke the ScalingTool remote function
	local function L_437_func(L_462_arg0, L_463_arg1, L_464_arg2)
		local L_465_ = {
			[1] = L_462_arg0,
			[2] = L_463_arg1,
			[3] = L_464_arg2
		}
		L_423_:InvokeServer(unpack(L_465_))
	end

    -- Function to invoke the PaintingTool remote function
	local function L_438_func(L_466_arg0)
		L_424_:InvokeServer(L_466_arg0)
	end

    -- Function to set properties using the PropertiesTool remote function
	local function L_439_func(L_467_arg0, L_468_arg1)
		local L_469_ = {
			[1] = L_467_arg0,
			[2] = L_468_arg1
		}
		L_425_:InvokeServer(unpack(L_469_))
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
	local L_442_ = 0

-- Function to process each part after scaling
	local function L_443_func(L_478_arg0, L_479_arg1)
    -- Increment the counter each time the function is called
		L_442_ = L_442_ + 1
		local L_480_ = L_478_arg0.ParentName
		local L_481_ = L_428_:FindFirstChild(TeamOwner)
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
		while tick() - startTime < 20 do 
			L_438_func(L_433_)
		end
	end
	

-- Function to process all parts
	local function L_445_func()
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
		until # L_432_ == L_442_
		if # L_432_ == L_442_ then
			L_432_ = {}
			L_417_func("Success", "Your build has been successfully loaded. You may now save.", Color3.fromRGB(72, 72, 199))
			L_444_func()
			L_442_ = 0
		end
	end

    -- Function to start the process
	local function L_446_func()
		if L_429_ and # L_429_:GetChildren() == 0 then
			L_417_func("ERROR", "You need a preview loaded before using this", Color3.fromRGB(72, 72, 199))
			L_416_ = true
			return
		end
		L_435_func()
		if L_429_ then
			for L_489_forvar0, L_490_forvar1 in pairs(L_429_:GetChildren()) do
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
		L_417_func("Loading...", "Build will start shortly", Color3.fromRGB(72, 72, 199))
		L_445_func()
	end
end

function BetaInstantLoad3()
	local L_491_ = false

    -- Function to send notifications
	local function L_492_func(L_521_arg0, L_522_arg1, L_523_arg2)
		L_2_:Notify(
            {
			Title = L_521_arg0,
			Description = L_522_arg1
		}, {
			OutlineColor = Color3.fromRGB(50, 50, 200),
			Time = 5,
			Type = "image"
		}, {
			Image = "http://www.roblox.com/asset/?id=111630714337304",
			ImageColor = L_523_arg2
		})
	end

    -- Retrieve necessary services and tools
	local L_493_ = game:GetService("Players")
	local L_494_ = L_493_.LocalPlayer
	local L_495_ = L_494_.Backpack
	local L_496_ = L_494_.Character or L_494_.CharacterAdded:Wait()
	local L_497_ = L_495_:FindFirstChild("BuildingTool") and (L_495_.BuildingTool:FindFirstChild("RF") or L_496_.BuildingTool:FindFirstChild("RF"))
	local L_498_ = L_495_:FindFirstChild("ScalingTool") and (L_495_.ScalingTool:FindFirstChild("RF") or L_496_.ScalingTool:FindFirstChild("RF"))
	local L_499_ = L_495_:FindFirstChild("PaintingTool") and (L_495_.PaintingTool:FindFirstChild("RF") or L_496_.PaintingTool:FindFirstChild("RF"))
	local L_500_ = L_495_:FindFirstChild("PropertiesTool") and (L_495_.PropertiesTool:FindFirstChild("SetPropertieRF"))

    -- Retrieve data and blocks
	local L_501_ = L_494_:FindFirstChild("Data")
	local L_502_ = game:GetService("Workspace")
	local L_503_ = L_502_:FindFirstChild("Blocks")
	local L_504_ = L_502_:FindFirstChild("BuildPreview")
	local L_505_ = L_494_.TeamColor.Name
	local L_506_ = L_502_:FindFirstChild(L_505_ .. "Zone")

    -- Table to store collected parts
	local L_507_ = {}
	local L_508_ = {}
	local L_509_ = {}
	local function L_510_func()
		L_507_ = {}
		L_509_ = {}
		if L_491_ then
			return
		end
		if L_504_ then
			for L_524_forvar0, L_525_forvar1 in pairs(L_504_:GetChildren()) do
				if L_525_forvar1 then
					local L_526_ = L_525_forvar1.Color
					table.insert(
                        L_507_, {
						ParentName = L_525_forvar1.Name,
						CFrame = L_525_forvar1.CFrame,
						Size = L_525_forvar1.Size
					})
					table.insert(L_509_, L_526_)
				end
			end
		end
		print("Collected parts:", # L_507_)
	end

    -- Function to invoke the BuildingTool remote function
	local function L_511_func(L_527_arg0, L_528_arg1, L_529_arg2)
		local L_530_ = {
			[1] = L_527_arg0,
			[2] = L_528_arg1,
			[5] = true,
			[6] = L_529_arg2,
			[7] = false
		}
		L_497_:InvokeServer(unpack(L_530_))
	end

    -- Function to invoke the ScalingTool remote function
	local function L_512_func(L_531_arg0, L_532_arg1, L_533_arg2)
		local L_534_ = {
			[1] = L_531_arg0,
			[2] = L_532_arg1,
			[3] = L_533_arg2
		}
		L_498_:InvokeServer(unpack(L_534_))
	end

    -- Function to invoke the PaintingTool remote function
	local function L_513_func(L_535_arg0)
		L_499_:InvokeServer(L_535_arg0)
	end

    -- Function to set properties using the PropertiesTool remote function
	local function L_514_func(L_536_arg0, L_537_arg1)
		local L_538_ = {
			[1] = L_536_arg0,
			[2] = L_537_arg1
		}
		L_500_:InvokeServer(unpack(L_538_))
	end

    -- Function to rename a block instance
	local function L_515_func(L_539_arg0, L_540_arg1)
		L_539_arg0.Name = L_540_arg1
	end

    -- Function to process each part
	local function L_516_func(L_541_arg0, L_542_arg1)
		local L_543_ = L_541_arg0.ParentName
		local L_544_ = L_501_ and L_501_:FindFirstChild(L_543_) and L_501_[L_543_].Value or nil
		local L_545_ = 1000 + (L_542_arg1 * 1)
		local L_546_ = string.find(L_543_:lower(), "block") and L_506_.CFrame * CFrame.new(0, L_545_, 0) or L_541_arg0.CFrame
		L_511_func(L_543_, L_544_, L_546_)
	end
	local L_517_ = 0
	local function L_518_func(L_547_arg0, L_548_arg1)
		L_517_ = L_517_ + 1
		local L_549_ = L_547_arg0.ParentName
		local L_550_ = L_503_ and L_503_[TeamOwner]
		local L_551_ = L_550_ and L_550_:FindFirstChild(L_549_)
		if L_551_ then
			local L_552_ = L_549_ .. tostring(L_548_arg1)
			L_515_func(L_551_, L_552_)
			L_512_func(L_551_, L_547_arg0.Size, L_547_arg0.CFrame)
			if L_509_ and # L_509_ > 0 then
                -- Adjust the index if it exceeds the table length
				local L_553_ = (L_548_arg1 % # L_509_) + 1
				local L_554_ = L_509_[L_553_]
				table.insert(L_508_, {
					L_551_,
					L_554_
				})
			else
				warn("Test table is not defined or is empty")
			end
		end
	end

    -- Function to process all parts
	local function L_519_func()
		task.defer(
            function()
			for L_555_forvar0, L_556_forvar1 in ipairs(L_507_) do
				task.spawn(
                        function()
					L_516_func(L_556_forvar1, L_555_forvar0)
					task.defer(
                                function()
						L_96_func()
						task.wait(0.5)
						L_518_func(L_556_forvar1, L_555_forvar0 - 1)
					end)
				end)
			end
			repeat
				task.wait(0.5)
			until # L_507_ == L_517_
			if # L_507_ == L_517_ then
				L_507_ = {}
				L_492_func("Success", "Your build has been successfully loaded. You may now save.", Color3.fromRGB(72, 72, 199))
				task.wait(0.06)
				L_513_func(L_508_)
			end
		end)
	end

    -- Function to start the process
	local function L_520_func()
		if L_504_ and # L_504_:GetChildren() == 0 then
			L_492_func("ERROR", "You need a preview loaded before using this", Color3.fromRGB(72, 72, 199))
			L_491_ = true
			return
		end
		L_510_func()
		if L_504_ then
			for L_557_forvar0, L_558_forvar1 in pairs(L_504_:GetChildren()) do
				L_558_forvar1:Destroy()
			end
		end
	end

    -- Start the process
	L_520_func()

    -- If not stopped, proceed with processing all parts
	if not L_491_ then
		L_492_func("Loading...", "Build will start shortly", Color3.fromRGB(72, 72, 199))
		L_519_func()
	end
end

-- Variables

local L_102_ = {
	["magenta"] = workspace["MagentaZone"],
	["yellow"] = workspace["New YellerZone"],
	["black"] = workspace["BlackZone"],
	["white"] = workspace["WhiteZone"],
	["green"] = workspace["CamoZone"],
	["blue"] = workspace["Really blueZone"],
	["red"] = workspace["Really redZone"]
}

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
	Redthing.FillColor = Color3.fromRGB(77, 77, 200)
	Redthing.OutlineColor = Color3.fromRGB(0, 0, 0)
end

local function L_103_func(L_559_arg0, L_560_arg1)
	game.StarterGui:SetCore("SendNotification", {
		Title = L_559_arg0,
		Text = L_560_arg1,
		Icon = "rbxassetid://5252447904",
		Duration = 5
	})
end

-- Functions
local function L_104_func(L_561_arg0)
	local L_562_ = setmetatable({}, {
		__mode = "v"
	})
	return function(L_563_arg0)
		local L_564_ = L_562_[L_563_arg0] or L_561_arg0(L_563_arg0)
		L_562_[L_563_arg0] = L_564_
		return L_564_
	end
end

local L_105_
do
	local L_565_, L_566_, L_567_ = 16777216, 65536, 256
	L_105_ = function(L_568_arg0)
		local L_569_ = floor(L_568_arg0 / L_565_)
		local L_570_ = floor((L_568_arg0 - (L_569_ * L_565_)) / L_566_)
		local L_571_ = floor((L_568_arg0 - (L_569_ * L_565_) - (L_570_ * L_566_)) / L_567_)
		return {
			Color = Color3rgb(L_569_, L_570_, L_571_), -- Rgb
			Alpha = floor((L_568_arg0 - (L_569_ * L_565_) - (L_570_ * L_566_) - (L_571_ * L_567_)) / 1) -- Alpha
		}
	end
end

L_105_ = L_104_func(L_105_)

function AnglesString(L_572_arg0)
	local L_573_ = split(L_572_arg0, ",")
	return CFrameAng(rad(L_573_[1]), rad(L_573_[2]), rad(L_573_[3]))
end

--AnglesString = memoize(AnglesString)

function String(L_574_arg0)
	return gsub(tostring(L_574_arg0), " ", "")
end

--String = memoize(String)

function Raw(L_575_arg0)
	return unpack(split(L_575_arg0, ","))
end

--Raw = memoize(Raw)

function Floor(L_576_arg0, L_577_arg1)
	return floor((L_576_arg0 * (10 ^ L_577_arg1)) + 0.5) / (10 ^ L_577_arg1)
end

function GetStringAngles(L_578_arg0)
	local L_579_, L_580_, L_581_ = ToEulerAnglesXYZ(L_578_arg0)
	L_579_ = L_579_ * RADIANS_TO_DEGREES
	L_580_ = L_580_ * RADIANS_TO_DEGREES
	L_581_ = L_581_ * RADIANS_TO_DEGREES
	return Floor(L_579_, 5) .. "," .. Floor(L_580_, 5) .. "," .. Floor(L_581_, 5)
end

--GetStringAngles = memoize(GetStringAngles)

function GetAngles(L_582_arg0)
	local L_583_, L_584_, L_585_ = ToEulerAnglesXYZ(L_582_arg0)
	return CFrameAng(L_583_, L_584_, L_585_)
end

--GetAngles = memoize(GetAngles)

function GetTeam()
	return tostring(LocalPlayer.Team)
end

function GetPlot()
	return L_102_[tostring(LocalPlayer.Team)]
end

function GetTeamPlayers(L_586_arg0)
	local L_587_ = {}
	for L_588_forvar0, L_589_forvar1 in ipairs(Players:GetPlayers()) do
		if tostring(L_589_forvar1.Team) == L_586_arg0 then
			table.insert(L_587_, L_589_forvar1.Name)
		end
	end
	return L_587_
end

function GetBlocks(L_590_arg0)
	local L_591_ = GetTeamPlayers(L_590_arg0)
	local L_592_ = {}
	for L_593_forvar0, L_594_forvar1 in ipairs(L_591_) do
		local L_595_ = workspace.Blocks:FindFirstChild(L_594_forvar1)
		if L_595_ then
			for L_596_forvar0, L_597_forvar1 in ipairs(L_595_:GetChildren()) do
				if L_597_forvar1:FindFirstChild("Health") then
					table.insert(L_592_, L_597_forvar1)
				end
			end
		end
	end
	return L_592_
end

function GetTeamBlocks(L_598_arg0)
	return GetBlocks(L_598_arg0)
end

function GetPlayerBlocks(L_599_arg0)
	return game.workspace.Blocks:FindFirstChild(L_599_arg0):GetChildren()
end

function GetPreviewBlocks()
	local L_600_ = {}
	for L_601_forvar0, L_602_forvar1 in next, GetChildren(AutoBuildPreview) do
		insert(L_600_, L_602_forvar1)
	end
	return L_600_
end

function GetTool(L_603_arg0)
	return (FindFirstChild(LocalPlayer.Backpack, L_603_arg0) and LocalPlayer.Backpack[L_603_arg0].RF) or (FindFirstChild(LocalPlayer.Character, L_603_arg0) and LocalPlayer.Character[L_603_arg0].RF)
end

-- Encoding / Decoding / Converting
function Encode(L_604_arg0, L_605_arg1)
	local L_606_ = {}
	local L_607_ = L_605_arg1 and L_102_[L_605_arg1] or GetPlot()
	for L_608_forvar0, L_609_forvar1 in ipairs(L_604_arg0) do
		local L_610_ = L_609_forvar1.Name
		local L_611_ = L_609_forvar1:FindFirstChild("PPart")

        -- Skip if PPart is not found
		if not L_611_ then
			continue
		end
		if not L_606_[L_610_] then
			L_606_[L_610_] = {}
		end
		local L_612_ = L_607_.CFrame:ToObjectSpace(L_611_.CFrame)

        -- Insert block data into jsonTable
		table.insert(
            L_606_[L_610_], {
			Rotation = GetStringAngles(L_612_),
			Position = String(L_612_.p),
			ShowShadow = L_611_.CastShadow or true,
			CanCollide = L_611_.CanCollide or true,
			Anchored = L_611_.Anchored or true,
			Transparency = L_611_.Transparency > 0 and L_611_.Transparency or nil,
			Size = string.find(L_610_, "Block") and L_611_.Size ~= Vector3new(2, 2, 2) and String(L_611_.Size) or nil,
			Color = L_611_.Color ~= BuildingParts[L_610_].PPart.Color and String(L_611_.Color) or nil
		})
	end
	return HttpService:JSONEncode(L_606_)
end

function Encode1(L_613_arg0, L_614_arg1)
	local L_615_ = {}
	local L_616_ = L_614_arg1 and L_102_[L_614_arg1] or GetPlot()
	for L_617_forvar0, L_618_forvar1 in ipairs(L_613_arg0) do
		local L_619_ = L_618_forvar1.Name
		local L_620_ = L_618_forvar1.PPart
		if not (L_615_[L_619_]) then
			L_615_[L_619_] = {}
		end
		local L_621_ = L_616_.CFrame:ToObjectSpace(L_620_.CFrame)
		local L_622_ = tonumber(GetStringAngles(L_621_))
		local L_623_ = tonumber(L_621_.p)
		local L_624_ = string.find(L_619_, "Block") and L_620_.Size ~= Vector3.new(2, 2, 2) and L_620_.Size or nil
		table.insert(
            L_615_[L_619_], {
			Rotation = L_622_ and string.format("%.3f", L_622_),
			Position = L_623_ and string.format("%.3f", L_623_),
			ShowShadow = L_620_.CastShadow or true,
			CanCollide = L_620_.CanCollide or true,
			Anchored = L_620_.Anchored or true,
			Transparency = L_620_.Transparency > 0 and L_620_.Transparency or 0,
			Size = L_624_ and string.format("%.3f", L_624_.x) .. ", " .. string.format("%.3f", L_624_.y) .. ", " .. string.format("%.3f", L_624_.z) or nil,
			Color = L_620_.Color ~= BuildingParts[L_619_].PPart.Color and tostring(L_620_.Color) or nil
		})
	end
	return HttpService:JSONEncode(L_615_)
end

function Decode(L_625_arg0, L_626_arg1)
	local L_627_ = {}
	L_626_arg1 = L_626_arg1 or 1
	local L_628_ = xpcall(
        function()
		L_627_ = HttpService:JSONDecode(L_625_arg0)
	end, function()
		warn("Invalid JSON")
	end)
	if (not L_628_) then
		return {}
	end
	for L_629_forvar0, L_630_forvar1 in next, L_627_ do
		if (FindFirstChild(BuildingParts, L_629_forvar0)) then
			for L_631_forvar0, L_632_forvar1 in next, L_630_forvar1 do
				local L_633_ = L_627_[L_629_forvar0][L_631_forvar0]
				L_633_.Position = CFramenew(Vector3new(Raw(L_632_forvar1.Position)) * L_626_arg1)
				L_633_.Rotation = AnglesString(L_632_forvar1.Rotation)
				L_633_.Color = L_632_forvar1.Color and Color3new(Raw(L_632_forvar1.Color)) or nil
				L_633_.Size = L_632_forvar1.Size and L_632_forvar1.Size ~= "2,2,2" and Vector3new(Raw(L_632_forvar1.Size)) * L_626_arg1 or nil
				L_627_[L_629_forvar0][L_631_forvar0] = L_633_
			end
		else
			L_627_[L_629_forvar0] = nil
		end
	end
	return L_627_
end

function Convert(L_634_arg0)
	local L_635_ = game:GetService("HttpService") -- Get HttpService for JSON encoding
	local L_636_, L_637_ = readfile(L_634_arg0), {}
	if not L_636_:find("/") then
		return nil
	end
	local L_638_ = GetPlot()
	for L_639_forvar0, L_640_forvar1 in next, L_636_:split("/") do
		local L_641_ = L_640_forvar1:split(":")
		if # L_641_ == 5 and FindFirstChild(BuildingParts, L_641_[5]) then
			if not L_637_[L_641_[5]] then
				L_637_[L_641_[5]] = {}
			end
			local L_642_ = CFramenew(Raw(L_641_[1])) * AnglesString(L_641_[2])
			L_642_ = ToObjectSpace(CFramenew(0, - 17.9999924, 0), L_642_)
			local L_643_ = L_641_[7] == "true" and true or false
			local L_644_ = L_641_[8] == "true" and true or false
			table.insert(
                L_637_[L_641_[5]], {
				Color = L_641_[3] ~= "-" and L_641_[3] or nil,
				Size = L_641_[4] ~= "-" and L_641_[4] or nil,
				Position = String(L_642_.p),
				Rotation = GetStringAngles(L_642_),
				Transparency = L_641_[6] and tonumber(L_641_[6]) or nil,
				ShowShadow = L_643_,
				CanCollide = L_644_,
				Anchored = true
                    -- Add other properties as needed
			})
		end
	end
	L_637_ = L_635_:JSONEncode(L_637_)

    -- Uncomment this later (Preventing from having to Convert every time)
    -- writefile(file, jsonTable)
	return L_637_
end

function LoadFile(L_645_arg0, L_646_arg1, L_647_arg2)
	local L_648_ = nil
	if (# GetChildren(AutoBuildPreview) > 0) then
		local L_649_ = GetPreviewBlocks()
		local L_650_ = Encode(L_649_, GetTeam())
		L_648_ = Decode(L_650_, L_646_arg1)
	else
		local L_651_ = Convert(L_645_arg0) or readfile(L_645_arg0)
		L_648_ = Decode(L_651_, L_646_arg1)
	end
	LoadBlocks(L_648_, L_647_arg2)
end

function LoadBlocks(L_652_arg0, L_653_arg1)
	local L_654_ = L_653_arg1 and L_102_[L_653_arg1] or GetPlot()
	local L_655_ = GetTool("BuildingTool")
	local L_656_ = GetTool("ScalingTool")
	local L_657_ = GetTool("PaintingTool")
	local L_658_ = getsenv(L_655_.Parent.LocalScript).isPartInZone
	ProgressAmount = 0
	ProgressUsed = 0
	for L_662_forvar0, L_663_forvar1 in next, L_652_arg0 do
		ProgressAmount = ProgressAmount + # L_663_forvar1
	end

    -- Building Part
	local L_659_, L_660_, L_661_ = {}, {}, nil
	do
		local L_664_ = function(L_665_arg0)
			L_665_arg0:WaitForChild("PPart", 1)
			if (not FindFirstChild(L_665_arg0, "PPart")) then
				return
			end
			for L_666_forvar0, L_667_forvar1 in next, L_659_ do
				if ((L_665_arg0.PPart.Position - L_667_forvar1.Position).Magnitude < BLOCK_MAGNITUDE) then
					insert(L_660_, {
						Block = L_665_arg0,
						Data = L_667_forvar1.Data
					})
					remove(L_659_, L_666_forvar0)
					ProgressUsed = ProgressUsed + 1
					break
				end
			end
		end
		L_661_ = workspace.ChildAdded:Connect(L_664_)
	end
	for L_668_forvar0, L_669_forvar1 in next, L_652_arg0 do
		local L_670_ = Data[L_668_forvar0].Value
		local L_671_ = Data[L_668_forvar0].Used.Value
		for L_672_forvar0, L_673_forvar1 in next, L_669_forvar1 do
			if (L_672_forvar0 > (L_670_ - L_671_)) then
				warn("Not Enough Blocks For " .. L_668_forvar0)
				break
			end
			local L_674_ = (L_654_.CFrame * (L_673_forvar1.Position * L_673_forvar1.Rotation))
			if (L_658_(L_674_, L_654_)) then
				if (L_673_forvar1.Size or L_673_forvar1.Color or L_673_forvar1.Transparency or L_673_forvar1.Anchored or L_673_forvar1.CanCollide or L_673_forvar1.ShowShadow) then
					insert(L_659_, {
						Position = L_674_.p,
						Data = L_673_forvar1
					})
				end
				if (SafeMode and # L_659_ <= 5) then
					repeat
						wait()
					until # L_659_ <= 5
				end
				if (SpeedFunct(L_672_forvar0)) then
					taskSpawn(
                        InvokeServer, L_655_, L_668_forvar0, L_670_, nil, nil, L_673_forvar1.Anchored == nil and true, 1, L_674_)
				end
			else
				ProgressAmount = ProgressAmount - 1
			end
		end
	end
	repeat
		wait()
	until # L_659_ == 0
	L_661_:Disconnect()
	wait(1)
	ProgressUsed = 0
	for L_675_forvar0, L_676_forvar1 in next, L_660_ do
		if (L_676_forvar1.Data.Size) then
			if (SpeedFunct(L_675_forvar0) and not SafeMode) then
				taskSpawn(InvokeServer, L_656_, L_676_forvar1.Block, L_676_forvar1.Data.Size, L_676_forvar1.Block.PPart.CFrame)
			else
				InvokeServer(L_656_, L_676_forvar1.Block, L_676_forvar1.Data.Size, L_676_forvar1.Block.PPart.CFrame)
			end
			ProgressUsed = ProgressUsed + 1
		end
	end
	do -- Paint Shit
		local L_677_ = {}
		for L_678_forvar0, L_679_forvar1 in next, L_660_ do
			if (L_679_forvar1.Data.Color) then
				insert(L_677_, {
					L_679_forvar1.Block,
					L_679_forvar1.Data.Color
				})
			end
		end
		InvokeServer(L_657_, L_677_)
	end
	wait(1.5)
	L_2_:Notify(
        {
		Title = "Success",
		Description = "You may now save your build once its fully finished"
	}, {
		OutlineColor = Color3.fromRGB(44, 44, 200),
		Time = 5,
		Type = "image"
	}, {
		Image = "http://www.roblox.com/asset/?id=111630714337304",
		ImageColor = Color3.fromRGB(72, 72, 199)  
	})
end

-- Init
function SavePlot(L_680_arg0, L_681_arg1)
	if not L_680_arg0 or not L_681_arg1 then
		return
	end
	local L_682_ = GetTeamBlocks(L_681_arg1)
	local L_683_ = Encode(L_682_, L_681_arg1)

    -- Append directory path to the file name
	local L_684_ = "WeshkyBuildStorage/" .. L_680_arg0

    -- Write encoded JSON data to file
	writefile(L_684_, L_683_)
end

function SavePlotNEW(L_685_arg0, L_686_arg1)
	if not L_685_arg0 or not L_686_arg1 then
		return
	end
	local L_687_ = GetTeamBlocks(L_686_arg1)
	local L_688_ = Encode1(L_687_, L_686_arg1)

    -- Append directory path to the file name
	local L_689_ = "WeshkyBuildStorage/" .. L_685_arg0

    -- Write encoded JSON data to file
	writefile(L_689_, L_688_)
end

function SavePlot1(L_690_arg0, L_691_arg1)
	if not L_690_arg0 or not L_691_arg1 then
		return
	end
	local L_692_ = L_691_arg1.Team
	local L_693_ = GetPlayerBlocks(L_691_arg1)
	local L_694_ = Encode(L_693_, L_692_)
	local L_695_ = "WeshkyBuildStorage/" .. L_690_arg0
	writefile(L_695_, L_694_)
end

function applyTeamColorHighlights(L_696_arg0)
	local L_697_ = workspace:FindFirstChild(L_696_arg0)
	if not L_697_ then
		warn("Blocks not found in workspace")
		return
	end
	for L_701_forvar0, L_702_forvar1 in ipairs(L_697_:GetChildren()) do
		if not L_702_forvar1:IsA("Model") then
			local L_703_ = Instance.new("Model")
			L_703_.Name = L_702_forvar1.Name
			L_702_forvar1.Parent = L_703_
			L_703_.Parent = L_697_
		end
	end
	local function L_698_func(L_704_arg0)
		return {
			math.floor(L_704_arg0.R * 255 + 0.5),
			math.floor(L_704_arg0.G * 255 + 0.5),
			math.floor(L_704_arg0.B * 255 + 0.5)
		}
	end
	local function L_699_func(L_705_arg0, L_706_arg1)
		local L_707_ = Instance.new("Highlight")
		L_707_.Name = "Highlight"
		L_707_.Parent = L_705_arg0
		L_707_.FillColor = L_706_arg1
		L_707_.OutlineColor = L_706_arg1
	end
	local function L_700_func(L_708_arg0, L_709_arg1, L_710_arg2)
		return Color3.fromRGB(L_708_arg0, L_709_arg1, L_710_arg2)
	end
	for L_711_forvar0, L_712_forvar1 in ipairs(L_697_:GetChildren()) do
		if L_712_forvar1:IsA("Model") then
			local L_713_ = game:GetService("Players"):FindFirstChild(L_712_forvar1.Name)
			if L_713_ and L_713_.Team then
				local L_714_ = L_713_.Team
				local L_715_ = L_714_.TeamColor.Color
				local L_716_ = L_698_func(L_715_)
				local L_717_ = L_700_func(L_716_[1], L_716_[2], L_716_[3])
				L_699_func(L_712_forvar1, L_717_)
			end
		end
	end
end

function PreviewFile(L_718_arg0, L_719_arg1, L_720_arg2)
	if workspace:FindFirstChild("BuildPreview"):FindFirstChild("BuildPreviewHighlight") then
		Redthing.Parent = workspace.BuildPreview
	else
		Redthing = Instance.new("Highlight")
		Redthing.Name = "BuildPreviewHighlight"
		Redthing.Parent = workspace.BuildPreview or AutoBuildPreview
		Redthing.FillColor = Color3.fromRGB(54, 113, 135)
		Redthing.OutlineColor = Color3.fromRGB(16, 16, 16)
	end
	local L_721_ = Convert(L_718_arg0) or readfile(L_718_arg0)
	local L_722_ = Decode(L_721_, L_719_arg1)
	local L_723_ = L_720_arg2 and L_102_[L_720_arg2] or GetPlot()
	for L_724_forvar0, L_725_forvar1 in pairs(L_722_) do
		for L_726_forvar0, L_727_forvar1 in pairs(L_725_forvar1) do
			task.spawn(
                function()
				local L_728_ = Clone(BuildingParts[L_724_forvar0])
				local L_729_ = L_723_.CFrame * (L_727_forvar1.Position * L_727_forvar1.Rotation)
				SetPrimaryPartCFrame(L_728_, L_729_)
				L_728_.Health.Value = ""
				L_728_.Parent = AutoBuildPreview
				L_728_.PPart.Size = L_727_forvar1.Size or L_728_.PPart.Size
				L_728_.PPart.Anchored = true
				L_728_.PPart.Transparency = 0 --block.Transparency or 0
                    --clonedBlock.PPart.Transparency = 0
				L_728_.PPart.CastShadow = L_727_forvar1.ShowShadow or false
				L_728_.PPart.CanCollide = L_727_forvar1.CanCollide or true
				if L_727_forvar1.Color then
					for L_730_forvar0, L_731_forvar1 in pairs(GetDescendants(L_728_)) do
						if L_731_forvar1:IsA("BasePart") then
							L_731_forvar1.Color = L_727_forvar1.Color
						end
					end
				end
				task.wait()
			end)
		end
	end
end

local L_106_ = Instance.new("Part", AutoBuildPreview)
do
	L_106_.Transparency = 1
	L_106_.Anchored = true
	L_106_.CanCollide = false
end

function reflectVec(L_732_arg0, L_733_arg1)
	return L_732_arg0 - 2 * (L_733_arg1 * L_732_arg0:Dot(L_733_arg1))
end

function ReflectCFrame(L_734_arg0, L_735_arg1, L_736_arg2)
	local L_737_ = L_735_arg1.Position
	local L_738_ = L_735_arg1.LookVector
	local L_739_ = L_734_arg0.Position
	local L_740_, L_741_, L_742_ = L_739_.X, L_739_.Y, L_739_.Z
	local L_743_ = L_737_ + reflectVec(Vector3new(L_740_, L_741_, L_742_) - L_737_, L_738_)
	local L_744_ = L_734_arg0.XVector
	local L_745_ = L_734_arg0.YVector
	local L_746_ = L_734_arg0.ZVector
	L_744_ = - reflectVec(L_744_, L_738_)
	L_745_ = reflectVec(L_745_, L_738_)
	L_746_ = reflectVec(L_746_, L_738_)
	return CFramenew(
        L_743_.X, L_743_.Y, L_743_.Z, L_744_.X, L_745_.X, L_746_.X, L_744_.Y, L_745_.Y, L_746_.Y, L_744_.Z, L_745_.Z, L_746_.Z)
end

function MirrorBuild()
	local L_747_ = AutoBuildPreview:GetBoundingBox()
	for L_748_forvar0, L_749_forvar1 in next, GetChildren(AutoBuildPreview) do
		if (FindFirstChild(L_749_forvar1, "PPart")) then
			SetPrimaryPartCFrame(L_749_forvar1, ReflectCFrame(L_749_forvar1.PPart.CFrame, L_747_))
		end
	end
end

function UpdatePreview(L_750_arg0)
	local L_751_, L_752_ = AutoBuildPreview:GetBoundingBox()
	L_750_arg0 = L_750_arg0 or Vector3new()
	local L_753_ = (L_750_arg0 and CFramenew(L_751_.Position) or L_751_) * CFrameAng(rad(RotationX), rad(RotationY), rad(RotationZ)) + L_750_arg0
	L_106_.CFrame = L_751_
	L_106_.Parent = AutoBuildPreview
	AutoBuildPreview.PrimaryPart = L_106_
	SetPrimaryPartCFrame(AutoBuildPreview, L_753_)
	L_106_.Parent = workspace
end

-- Function to get the plot and teleport to its CFrame
function CenterBuild()
	local L_754_ = team and L_102_[team] or GetPlot()
	local L_755_, L_756_ = AutoBuildPreview:GetBoundingBox()
	local L_757_ = L_754_.CFrame
	L_106_.CFrame = L_755_
	L_106_.Parent = AutoBuildPreview
	AutoBuildPreview.PrimaryPart = L_106_
	local L_758_ = CFrame.new(0, 100, 0)
	SetPrimaryPartCFrame(AutoBuildPreview, L_757_ * L_758_)
	L_106_.Parent = workspace
end

function ClearPreview()
	AutoBuildPreview:ClearAllChildren()
end

do
	local L_759_ = L_93_:AddWindow("Vortex Auto Build", {
		main_Pos = UDim2.new(0, 600, 0, 400),
		min_size = Vector2.new(384, 550),
		can_resize = true,
		main_text_color = Color3.fromRGB(255, 255, 255)
	})
	local L_760_ = L_93_:AddWindow("Block Checker", {
		main_Pos = UDim2.new(0, 2, 0, 2),
		min_size = Vector2.new(250, 400),
		can_resize = true,
		main_text_color = Color3.fromRGB(255, 255, 255)
	})
	local L_762_ = L_759_:AddTab("Auto Build")
	local L_764_ = L_759_:AddTab("Adjusters")
	--local L_765_ = L_759_:AddTab("Image Loader")
	local L_766_ = L_759_:AddTab("Autofarm")
    local CreditsTab = L_759_:AddTab("Credits & Discord")
	local L_767_ = L_760_:AddTab("ListBlocks")
	local L_768_ = L_760_:AddTab("CheckPrice")
	function ListBuild(L_774_arg0)
		L_96_func()
		L_2_:Notify(
            {
			Title = "Wait Please",
			Description = "Big Files may take longer to load it is not broken just wait"
		}, {
			OutlineColor = Color3.fromRGB(44, 44, 200),
			Time = 5,
			Type = "image"
		}, {
			Image = "http://www.roblox.com/asset/?id=111630714337304",
			ImageColor = Color3.fromRGB(72, 72, 199)
		})
		local L_775_ = TeamOwner
		local L_776_ = game.Players[L_775_].Data
        -- Read and decode the file
		local L_777_ = Convert(L_774_arg0) or readfile(L_774_arg0)
		local L_778_ = Decode(L_777_, 1)

        -- Initialize tables to track needed and missing blocks
		local L_779_ = {}
		local L_780_ = {}

        -- Calculate needed and missing amounts
		for L_782_forvar0, L_783_forvar1 in pairs(L_778_) do
			local L_784_ = 0
			for L_786_forvar0, L_787_forvar1 in pairs(L_783_forvar1) do
				if not L_787_forvar1.Size or L_787_forvar1.Size == DEFAULT_BLOCK_SIZE then
					L_784_ = L_784_ + 1
				else
					L_784_ = L_784_ + math.ceil(L_787_forvar1.Size.X * L_787_forvar1.Size.Y * L_787_forvar1.Size.Z / 8 + 0.5)
				end
			end
			local L_785_ = L_784_ - L_776_[L_782_forvar0].Value
			L_779_[L_782_forvar0] = L_784_
			if L_785_ > 0 then
				L_780_[L_782_forvar0] = L_785_
			end
		end

        -- Destroy all previous labels
		for L_788_forvar0, L_789_forvar1 in pairs(blockamounts) do
			if L_789_forvar1 and L_789_forvar1.Destroy then
				L_789_forvar1:Destroy()
			else
				print("Warning: Could not destroy item in blockamounts")
			end
		end

        -- Clear the blockamounts table
		blockamounts = {}

        -- Add new labels for missing blocks
		for L_790_forvar0, L_791_forvar1 in pairs(L_780_) do
			local L_792_ = L_767_:AddLabel(string.format("%s: Missing %d", L_790_forvar0, L_791_forvar1))
			table.insert(blockamounts, L_792_)
		end

        -- Check if all blocks are available
		local L_781_ = true
		for L_793_forvar0, L_794_forvar1 in pairs(L_780_) do
			if L_794_forvar1 > 0 then
				L_781_ = false
				break
			end
		end

        -- Add a label if no blocks are missing
		if L_781_ then
			local L_795_ = math.random(1, 10)
			local L_796_ = L_767_:AddLabel(string.format("You are missing nothing. %d", L_795_))
			table.insert(blockamounts, L_796_)
		end
	end
	function checkprice(L_797_arg0)
		L_2_:Notify(
            {
			Title = "Wait Please",
			Description = "Big Files may take longer to load it is not broken just wait"
		}, {
			OutlineColor = Color3.fromRGB(44, 44, 200),
			Time = 5,
			Type = "image"
		}, {
			Image = "http://www.roblox.com/asset/?id=111630714337304",
			ImageColor = Color3.fromRGB(72, 72, 199)
		})
		local L_798_ = TeamOwner
		local L_799_ = game.Players[L_798_].Data

        -- Read and decode the file
		local L_800_ = Convert(L_797_arg0) or readfile(L_797_arg0)
		local L_801_ = Decode(L_800_, 1)

        -- Initialize table to track missing blocks
		local L_802_ = {}

        -- Calculate missing amounts
		for L_803_forvar0, L_804_forvar1 in pairs(L_801_) do
			local L_805_ = 0
			for L_807_forvar0, L_808_forvar1 in pairs(L_804_forvar1) do
				if not L_808_forvar1.Size or L_808_forvar1.Size == DEFAULT_BLOCK_SIZE then
					L_805_ = L_805_ + 1
				else
					L_805_ = L_805_ + math.ceil(L_808_forvar1.Size.X * L_808_forvar1.Size.Y * L_808_forvar1.Size.Z / 8 + 0.5)
				end
			end
			local L_806_ = L_805_ - L_799_[L_803_forvar0].Value
			if L_806_ > 0 then
				L_802_[L_803_forvar0] = L_806_
			end
		end
		for L_809_forvar0, L_810_forvar1 in pairs(prices) do
			if L_810_forvar1 and L_810_forvar1.Destroy then
				L_810_forvar1:Destroy()
			else
				print("Warning: Could not destroy item in prices")
			end
		end
		prices = {}

        -- Print costs for missing blocks if total cost is greater than 0
		for L_811_forvar0, L_812_forvar1 in pairs(L_802_) do
			local L_813_ = blockCosts[L_811_forvar0] or 0
			local L_814_ = L_813_ * L_812_forvar1
			if L_814_ > 0 then
				local L_815_ = L_768_:AddLabel(string.format("%s costs %d gold", L_811_forvar0, L_814_))
				table.insert(prices, L_815_)
			else
				local L_816_ = L_768_:AddLabel("You Got Every Blocks")
				table.insert(prices, L_816_)
			end
		end
	end
	function renameFile(L_817_arg0, L_818_arg1)
		local L_819_ = "WeshkyBuildStorage/" .. L_817_arg0 .. ".Build"
		local L_820_ = "WeshkyBuildStorage/" .. L_818_arg1 .. ".Build"
		local L_821_, L_822_ = pcall(readfile, L_819_)
		if L_821_ then
			pcall(writefile, L_820_, L_822_)
			pcall(delfile, L_819_)
		else
			warn("Failed to read the file: " .. L_819_)
		end
	end
	local L_773_ = nil
	do -- Elements
		local L_823_ = L_762_:AddLabel("")
		local L_824_ = L_762_:AddLabel("How to use: \n #1 Download a .Build file from my discord \n #2 Place the .Build file into workspace \n #3 Select the file, press preview, then load")
		local L_825_ = L_762_:AddLabel("")
		CreditsTab:AddButton("Copy Vortex Discord Invite", function()
			setclipboard("https://discord.gg/cTRZBY8zjY")
		end)
		local CrdFolder = CreditsTab:AddFolder("Vortrex Credits")
		CrdFolder:Fold(true)
		local CreditsTab = CrdFolder:AddLabel("\n \nThanks for Using Vortex Auto Build.\nIf you need Help or need build files join our Discord\nCredits: Main Developer Sxirbes")
		--local CreditsTab = CrdFolder:AddLabel("")
		--local CreditsTab = CrdFolder:AddLabel("\nCredits: Main Developer Sxirbes")

		local L_827_ = L_762_:AddFolder("New Builder")
		local L_828_ = L_827_:AddDropdown("Build Files", function(L_873_arg0)
			local L_874_ = string.match(L_873_arg0, "^(.-)%s*%-%s*")
			L_773_ = L_874_
			print(L_773_)
		end)
		local L_829_ = {}
		local L_830_ = false -- Default sorting order: alphabetical
		local function L_831_func(L_875_arg0)
			return L_875_arg0:match("^[%w%s]+$") ~= nil
		end
		local function L_832_func(L_876_arg0)
			if L_876_arg0 < 1024 then
				return string.format("%d bytes", L_876_arg0)
			elseif L_876_arg0 < 1024 * 1024 then
				return string.format("%.1f KB", L_876_arg0 / 1024)
			elseif L_876_arg0 < 1024 * 1024 * 1024 then
				return string.format("%.1f MB", L_876_arg0 / (1024 * 1024))
			else
				return string.format("%.1f GB", L_876_arg0 / (1024 * 1024 * 1024))
			end
		end
		local function L_833_func(L_877_arg0)
			local L_878_ = 0
			local L_879_, L_880_ = pcall(readfile, L_877_arg0)
			if L_879_ and L_880_ then
				L_878_ = # L_880_
			end
			return L_878_
		end
		local function L_834_func(L_881_arg0)
			local L_882_ = string.match(L_881_arg0, "([^/\\]+)%.Build$")
			if L_882_ then
				local L_883_ = L_833_func(L_881_arg0)
				local L_884_ = (L_883_ > 0) and L_832_func(L_883_) or "corrupt"
				return {
					name = L_882_,
					size = L_883_,
					formattedSize = L_884_
				}
			end
			return nil
		end

        -- Create the percentage UI
		local L_835_ = Instance.new("ScreenGui")
		L_835_.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
		L_835_.IgnoreGuiInset = true
		local L_836_ = Instance.new("Frame")
		L_836_.Size = UDim2.new(0, 0, 0, 0)
		L_836_.Position = UDim2.new(0, 10, 1, -50)
		L_836_.BackgroundColor3 = Color3.new(0, 0, 0)
		L_836_.BackgroundTransparency = 1
		L_836_.BorderSizePixel = 0
		L_836_.Parent = L_835_
		local L_837_ = Instance.new("UICorner")
		L_837_.CornerRadius = UDim.new(0, 10)
		L_837_.Parent = L_836_
		local L_838_ = Instance.new("TextLabel")
		L_838_.Size = UDim2.new(0, 0, 0, 0)
		L_838_.Position = UDim2.new(0.5, -100, 0.5, -10)
		L_838_.BackgroundTransparency = 1
		L_838_.TextColor3 = Color3.new(1, 1, 1)
		L_838_.TextScaled = true
		L_838_.TextTransparency = 1
		L_838_.Text = "loading files 0%"
		L_838_.Parent = L_836_

        -- Create the toggle button
		local L_839_ = Instance.new("TextButton")
		L_839_.Size = UDim2.new(0, 0, 0, 0)
		L_839_.Position = UDim2.new(0, 9000, 0, 10) -- Adjusted position to the right
		L_839_.Text = ""
		L_839_.BackgroundTransparency = 1
		L_839_.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
		L_839_.TextColor3 = Color3.new(1, 1, 1)
		L_839_.Parent = L_835_
		L_839_.MouseButton1Click:Connect(
            function()
			L_830_ = not L_830_
			if L_830_ then
				L_839_.Text = "Sort: Size"
			else
				L_839_.Text = "Sort: Alphabetical"
			end
			refreshDropdown() -- Refresh the dropdown to apply new sorting
		end)
		local function L_840_func()
			L_836_.Visible = true
			for L_894_forvar0, L_895_forvar1 in ipairs(L_829_) do
				L_895_forvar1:Remove()
			end
			L_829_ = {}
			local L_885_ = listfiles("WeshkyBuildStorage/") or {}
			for L_896_forvar0, L_897_forvar1 in ipairs(listfiles("")) do
				table.insert(L_885_, L_897_forvar1)
			end
			local L_886_ = {}
			local L_887_ = # L_885_
			local L_888_ = 5
			local L_889_ = 0
			local function L_890_func(L_898_arg0)
				local L_899_ = math.min(L_898_arg0 + L_888_ - 1, L_887_)
				for L_900_forvar0 = L_898_arg0, L_899_ do
					local L_901_ = L_885_[L_900_forvar0]
					if string.sub(L_901_, -6) == ".Build" then
						local L_903_ = L_834_func(L_901_)
						if L_903_ then
							table.insert(L_886_, L_903_)
						end
					end
					L_889_ = L_889_ + 1
					local L_902_ = math.floor((L_889_ / L_887_) * 100)
					L_838_.Text = "loading files " .. L_902_ .. "%"
				end
			end
			local function L_891_func()
				if L_830_ then
                    -- Sort by file size (largest to smallest)
					table.sort(
                        L_886_, function(L_904_arg0, L_905_arg1)
						return L_904_arg0.size > L_905_arg1.size
					end)
				else
                    -- Sort alphabetically
					table.sort(
                        L_886_, function(L_906_arg0, L_907_arg1)
						local L_908_ = L_831_func(L_906_arg0.name)
						local L_909_ = L_831_func(L_907_arg1.name)
						if L_908_ ~= L_909_ then
							return L_908_ -- Regular names come before non-regular names
						end
						return L_906_arg0.name:lower() < L_907_arg1.name:lower() -- Alphabetical order
					end)
				end
				for L_910_forvar0, L_911_forvar1 in ipairs(L_829_) do
					L_911_forvar1:Remove()
				end
				L_829_ = {}
				for L_912_forvar0, L_913_forvar1 in ipairs(L_886_) do
					local L_914_ = string.format("%s - %s", L_913_forvar1.name, L_913_forvar1.formattedSize)
					local L_915_ = L_828_:Add(L_914_)
					table.insert(L_829_, L_915_)
				end

                -- Hide the percentage UI after completion
				L_836_.Visible = false
			end

            -- Process files in batches
			local L_892_ = 1
			local function L_893_func()
				if L_892_ <= L_887_ then
					task.spawn(
                        function()
						L_890_func(L_892_)
						L_892_ = L_892_ + L_888_
						RunService.Heartbeat:Wait()
						L_893_func()
					end)
				else
					L_891_func()
				end
			end
			L_893_func()
		end
		task.defer(
            function()
			L_840_func()
		end)

        --]]
		L_827_:AddButton("Refresh Files", function()
			L_840_func()
			print("Dropdown refreshed")
		end)
		local L_841_, L_842_ = nil, nil
		L_827_:AddButton("Preview", function()
			local L_916_ = "WeshkyBuildStorage/" .. L_773_ .. ".Build"
			local L_917_ = isfile(L_916_)
			if L_917_ then
				ClearPreview()
				print(L_916_, _G.BuildSize)
				PreviewFile(L_916_, _G.BuildSize)
			elseif isfile(L_773_ .. ".Build") then
				ClearPreview()
				print(L_773_ .. ".Build", _G.BuildSize)
				PreviewFile(L_773_ .. ".Build", _G.BuildSize)
			else
                    --PreviewFile(SelectFile .. ".Build", _G.BuildSize)
				L_2_:Notify(
                        {
					Title = "Error",
					Description = "File not found."
				}, {
					OutlineColor = Color3.fromRGB(44, 44, 200),
					Time = 5,
					Type = "image"
				}, {
					Image = "http://www.roblox.com/asset/?id=111630714337304",
					ImageColor = Color3.fromRGB(72, 72, 199)
				})
			end
		end)
		L_827_:AddButton("Clear Preview", function()
			if # AutoBuildPreview:GetChildren() > 0 then
				ClearPreview()
			end
		end)
		L_827_:AddButton("Build Preview", function()
			BetaInstantLoad()
		end)
		L_767_:AddButton("Check Blocks", function()
			if isfile("WeshkyBuildStorage/" .. L_773_ .. ".Build") then
				print("debug")
				ListBuild("WeshkyBuildStorage/" .. L_773_ .. ".Build")
			elseif isfile(L_773_) then
				ListBuild(L_773_)
			else
				L_2_:Notify(
                        {
					Title = "Error",
					Description = "Didnt Work"
				}, {
					OutlineColor = Color3.fromRGB(44, 44, 200),
					Time = 5,
					Type = "image"
				}, {
					Image = "http://www.roblox.com/asset/?id=111630714337304",
					ImageColor = Color3.fromRGB(72, 72, 199)
				})
			end
		end)
		L_768_:AddButton("Missing Blocks Cost", function()
			if isfile("WeshkyBuildStorage/" .. L_773_ .. ".Build") then
				print("debug")
				checkprice("WeshkyBuildStorage/" .. L_773_ .. ".Build")
			elseif isfile(L_773_) then
				checkprice(L_773_)
			else
				L_2_:Notify(
                        {
					Title = "Error",
					Description = "Failed Did you have a build selected.."
				}, {
					OutlineColor = Color3.fromRGB(44, 44, 200),
					Time = 5,
					Type = "image"
				}, {
					Image = "http://www.roblox.com/asset/?id=111630714337304",
					ImageColor = Color3.fromRGB(72, 72, 199)
				})
			end
		end)
		local L_843_ = L_827_:AddSwitch("Client Remove Block After Placed (Used For Fps)", function(L_918_arg0)
			_G.extraantilag = L_918_arg0
		end)
		L_843_:Set(false)
		local L_844_ = L_762_:AddFolder("Save Builds")
        --local Blank = folder:AddLabel("")
		L_844_:AddTextBox("File Name", function(L_919_arg0)
			L_841_ = L_919_arg0 .. ".Build"
		end, {
			["clear"] = false
		})

        -- Add a dropdown for team selection
		local L_846_ = L_844_:AddDropdown("Teams", function(L_920_arg0)
			if L_920_arg0 == "My Team" then
				L_920_arg0 = game.Players.LocalPlayer.Team.Name
			end
			L_842_ = L_920_arg0
		end)
		L_846_:Add("My Team")
		L_846_:Add("white")
		L_846_:Add("blue")
		L_846_:Add("green")
		L_846_:Add("red")
		L_846_:Add("black")
		L_846_:Add("yellow")
		L_846_:Add("magenta")

        -- Add a button to save the file
		L_844_:AddButton("Save To File", function()
			SavePlot(L_841_, L_842_)
			UpdateList()
		end)
		L_844_:AddButton("Smaller Save (broke)", function()
			SavePlotNEW(L_841_, L_842_)
			UpdateList()
		end)
		local L_847_
		local L_848_ = L_844_:AddDropdown("Players", function(L_921_arg0)
			L_847_ = L_921_arg0
		end)
		local L_849_ = {}
		function refreshplayers()
			for L_922_forvar0, L_923_forvar1 in ipairs(L_849_) do
				L_923_forvar1:Remove()
			end
			for L_924_forvar0, L_925_forvar1 in pairs(game.Players:GetPlayers()) do
				local L_926_ = L_848_:Add(L_925_forvar1.Name)
				table.insert(L_849_, L_926_)
			end
		end
		refreshplayers()
		L_844_:AddButton("Update Player List", function()
			refreshplayers()
		end)
		L_844_:AddButton("Save Player Build", function()
			SavePlot1(L_841_, L_847_)
			UpdateList()
		end)
		local L_852_ = 1
		L_764_:AddButton("Center On Plot (Buggy)", function()
			CenterBuild()
		end)
		local L_853_ = L_764_:AddFolder("Position Offset")
		do
			L_853_:AddTextBox("Move Multiplier", function(L_934_arg0)
				L_852_ = L_934_arg0
			end, {
				["clear"] = false
			})
			L_853_:AddButton("Move Up", function()
				UpdatePreview(Vector3new(0, L_852_, 0))
			end)
			L_853_:AddButton("Move Down", function()
				UpdatePreview(Vector3new(0, - L_852_, 0))
			end)
			L_853_:AddButton("Move Left", function()
				UpdatePreview(Vector3new(L_852_, 0, 0))
			end)
			L_853_:AddButton("Move Right", function()
				UpdatePreview(Vector3new(- L_852_, 0, 0))
			end)
			L_853_:AddButton("Move Forwards", function()
				UpdatePreview(Vector3new(0, 0, L_852_))
			end)
			L_853_:AddButton("Move Backwards", function()
				UpdatePreview(Vector3new(0, 0, - L_852_))
			end)
			L_853_:Fold(true)
		end
		local L_854_ = L_764_:AddFolder("Rotation Offset")
		do
			L_854_:AddSlider("X", function(L_935_arg0)
				RotationX = L_935_arg0
				UpdatePreview()
			end, {
				min = 0,
				max = 360
			})
			L_854_:AddSlider("Y", function(L_936_arg0)
				RotationY = L_936_arg0
				UpdatePreview()
			end, {
				min = 0,
				max = 360
			})
			L_854_:AddSlider("Z", function(L_937_arg0)
				RotationZ = L_937_arg0
				UpdatePreview()
			end, {
				min = 0,
				max = 360
			})
			L_854_:AddTextBox("AutoBuild Size", function(L_938_arg0)
				local L_939_ = tonumber(L_938_arg0)
				if L_939_ then
					_G.BuildSize = L_939_ / 100
				else
					L_2_:Notify(
                            {
						Title = "ERROR",
						Description = "This is not a valid number..."
					}, {
						OutlineColor = Color3.fromRGB(44, 44, 200),
						Time = 5,
						Type = "image"
					}, {
						Image = "http://www.roblox.com/asset/?id=111630714337304",
						ImageColor = Color3.fromRGB(72, 72, 199)
					})
				end
			end, {
				["clear"] = false
			})
			L_854_:Fold(true)
		end

		local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger

		local L_855_ = L_766_:AddSwitch("Normal Autofarm", function(L_940_arg0)
			getgenv().TreasureAutoFarm.Enabled = L_940_arg0
			print("Autofarm toggled: " .. tostring(L_940_arg0))
		end)
		
		getgenv().TreasureAutoFarm = {
			Enabled = true,
			Teleport = 2.3,
			TimeBetweenRuns = 1 
		}
		
		local Players = game:GetService("Players")
		local Workspace = game:GetService("Workspace")
		local Lighting = game:GetService("Lighting")
		
		local LocalPlayer = Players.LocalPlayer
		
		local autoFarm = function(currentRun)
			local Character = LocalPlayer.Character
			local NormalStages = Workspace.BoatStages.NormalStages
			local teleportCount = 0
		
			for i = 1, 10 do
				if not getgenv().TreasureAutoFarm.Enabled then return end
				
				local Stage = NormalStages["CaveStage" .. i]
				local DarknessPart = Stage:FindFirstChild("DarknessPart")
		
				if (DarknessPart) then
					teleportCount = teleportCount + 1
					print("Teleporting to next stage: Stage " .. i)
					TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
					TriggerChest.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
					if teleportCount ~= 5 then
						workspace.ClaimRiverResultsGold:FireServer()
					else
						firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, 0)
						print("Test Farm Oven")
					end
					TriggerChest.CFrame = CFrame.new(-521.271667, -9.89999485, 172.898331, 0.855194747, -6.33011084e-08, 0.518306851, 1.27484903e-08, 1, 1.01095843e-07, -0.518306851, -7.98490021e-08, 0.855194747)
					Character.HumanoidRootPart.CFrame = DarknessPart.CFrame
		
					local Part = Instance.new("Part", LocalPlayer.Character)
					Part.Anchored = true
					Part.Transparency = 0.5
					Part.Size = Vector3.new(13, 1, 13)
					Part.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 6, 0)

					local Decal = Instance.new("Decal")
					Decal.Texture = "rbxassetid://137665433481652"
					Decal.Face = Enum.NormalId.Top
					Decal.Parent = Part

					wait(getgenv().TreasureAutoFarm.Teleport)
					Part:Destroy()
				end
			end
		
			--print("Teleporting to the end")
			--repeat wait()
			--	Character.HumanoidRootPart.CFrame = NormalStages.TheEnd.GoldenChest.Trigger.CFrame
			--until Lighting.ClockTime ~= 35

			local Respawned = false
			local Connection
			Connection = LocalPlayer.CharacterAdded:Connect(function()
				Respawned = true
				Connection:Disconnect()
			end)
		
			repeat wait() until Respawned
			wait(getgenv().TreasureAutoFarm.TimeBetweenRuns)
			print("Auto Farm: Run " .. currentRun .. " finished")
		end
		
		local autoFarmRun = 1
		spawn(function()
			while wait() do
				if (getgenv().TreasureAutoFarm.Enabled) then
					print("Initializing Auto Farm: Run " .. autoFarmRun)
					autoFarm(autoFarmRun)
					autoFarmRun = autoFarmRun + 1
				end
			end
		end)
		
		
		L_855_:Set(false)
		local L_856_ = game:GetService("HttpService")
		local L_857_ = game:GetService("RunService")
		local L_858_ = Vector2.new(30, 30)
		local L_859_ = game.Players.LocalPlayer

		--[[
		local L_860_ = L_765_:AddFolder("Image Loader")
		L_860_:Fold(true)
		_G.ImageBlock = "PlasticBlock"
		_G.ImageSize = Vector3.new(2, 2, 2)
		local L_861_
		local L_862_ = _G.ImageBlock
		L_860_:AddTextBox("Image Link", function(L_941_arg0)
			local L_942_ = game:GetService("Workspace")
			local L_943_ = game:GetService("HttpService")
			local L_944_ = game:GetService("RunService")
			if L_941_arg0 then
				local L_945_ = L_859_.TeamColor.Name
				local L_946_ = L_942_[L_945_ .. "Zone"]
				local L_947_ = "https://novakool.pythonanywhere.com/?URL=" .. L_941_arg0 .. "&SizeX=" .. L_858_.X .. "&SizeY=" .. L_858_.Y
				local L_948_, L_949_ = pcall(
                        function()
					local L_950_ = L_943_:JSONDecode(game:HttpGet(L_947_))
					local L_951_ = L_950_.Data
					local L_952_ = Vector2.new(L_950_.Size[1], L_950_.Size[2])

                            -- Calculate aspect ratio
					local L_953_ = L_952_.X / L_952_.Y

                            -- Determine the size of the parts based on image resolution
					local L_954_ = math.max(L_858_.X, L_858_.Y)
					local L_955_ = _G.ImageSize

                            -- Calculate the number of pixels along each dimension
					local L_956_ = math.ceil(L_952_.X / L_954_ * L_858_.X)
					local L_957_ = math.ceil(L_952_.Y / L_954_ * L_858_.Y)
					local L_958_ = Vector2.new(L_956_, L_957_)
					local L_959_ = L_958_ / 2
					local L_960_ = L_959_.Y + 10
					local L_961_ = 1

                            -- Clean up old parts
					for L_962_forvar0, L_963_forvar1 in pairs(game.workspace.BuildPreview:GetChildren()) do
						if L_963_forvar1:IsA("Highlight") == false then
							L_963_forvar1:Destroy()
						end
					end

                            -- Create the new parts
					for L_964_forvar0 = - L_959_.Y + 1, L_959_.Y do
						for L_965_forvar0 = - L_959_.X + 1, L_959_.X do
							local L_966_ = L_946_.CFrame + Vector3.new(L_965_forvar0 * L_955_.X, - L_964_forvar0 * L_955_.Y + L_960_, 0)
							local L_967_ = Instance.new("Part")
							local L_968_ = L_951_[L_961_]
							if L_968_ then
								local L_969_ = Color3.fromRGB(L_968_[1], L_968_[2], L_968_[3])
								L_861_ = L_862_
								L_967_.Parent = game.workspace.BuildPreview
								L_967_.Name = L_861_
								L_967_.CFrame = L_966_
								L_967_.Size = L_955_
								L_967_.Anchored = true
								L_967_.Color = L_969_
							end
							if L_961_ % 100 == 0 then
								L_944_.Heartbeat:Wait()
							end
							L_961_ = L_961_ + 1
						end
					end
				end)
				if L_948_ then
					L_2_:Notify(
                            {
						Title = "NovaImageLoader",
						Description = "Image had loaded/Is loading"
					}, {
						OutlineColor = Color3.fromRGB(44, 44, 200),
						Time = 5,
						Type = "image"
					}, {
						Image = "http://www.roblox.com/asset/?id=111630714337304",
						ImageColor = Color3.fromRGB(255, 84, 84)
					})
				else
					L_2_:Notify(
                            {
						Title = "ERROR",
						Description = "Did you make sure a image is loaded?"
					}, {
						OutlineColor = Color3.fromRGB(44, 44, 200),
						Time = 5,
						Type = "image"
					}, {
						Image = "http://www.roblox.com/asset/?id=111630714337304",
						ImageColor = Color3.fromRGB(255, 84, 84)
					})
				end
			end
		end, {
			["clear"] = false
		})
		L_765_:AddLabel("Image resolution is limited to 520x520")

        -- Minimum distance threshold for matching
		local L_863_ = 3 -- Adjust this value as needed

        -- Function to find the closest match to the input
		local function L_864_func(L_970_arg0)
			local L_971_ = nil
			local L_972_ = math.huge
			for L_973_forvar0, L_974_forvar1 in ipairs(blockNames) do
                -- Compute similarity (can be adjusted for more accuracy)
				local L_975_ = math.abs(# L_974_forvar1 - # L_970_arg0) -- Use absolute difference

                -- Check if the input is a substring of the block name and meets distance threshold
				if L_975_ < L_972_ and L_974_forvar1:lower():find(L_970_arg0:lower(), 1, true) then
					L_972_ = L_975_
					L_971_ = L_974_forvar1
				end
			end

            -- Only return the closest match if it meets the minimum distance threshold
			if L_972_ <= L_863_ then
				return L_971_
			else
				return nil
			end
		end
		L_860_:AddTextBox("Image resolution", function(L_976_arg0)
			local L_977_ = L_976_arg0:gsub(" ", "")
			local L_978_ = L_977_:split("x")
			local L_979_ = tonumber(L_978_[1])
			local L_980_ = tonumber(L_978_[2])
			if L_979_ and L_980_ then
				L_979_ = math.clamp(L_979_, 10, 320)
				L_980_ = math.clamp(L_980_, 10, 320)
				L_858_ = Vector2.new(L_979_, L_980_)
				L_2_:Notify(
                        {
					Title = "NovaImageLoader",
					Description = "The ImageResolution has been set to " .. L_979_ .. "x" .. L_979_
				}, {
					OutlineColor = Color3.fromRGB(44, 44, 200),
					Time = 5,
					Type = "image"
				}, {
					Image = "http://www.roblox.com/asset/?id=111630714337304",
					ImageColor = Color3.fromRGB(255, 84, 84)
				})
			else
				L_2_:Notify(
                        {
					Title = "ERROR",
					Description = "This is not a valid image resolution the limit is 320x320"
				}, {
					OutlineColor = Color3.fromRGB(44, 44, 200),
					Time = 5,
					Type = "image"
				}, {
					Image = "http://www.roblox.com/asset/?id=111630714337304",
					ImageColor = Color3.fromRGB(255, 84, 84)
				})
			end
		end, {
			["clear"] = false
		})
		L_860_:AddTextBox("Image Size", function(L_981_arg0)
			local function L_982_func(L_983_arg0)
				return L_983_arg0:match("^%d+%.?%d* %d+%.?%d* %d+%.?%d*$") ~= nil
			end
			if L_982_func(L_981_arg0) then
				local L_984_, L_985_, L_986_ = L_981_arg0:match("(%d+%.?%d*) (%d+%.?%d*) (%d+%.?%d*)")
				_G.ImageSize = Vector3.new(tonumber(L_984_), tonumber(L_985_), tonumber(L_986_))
			else
				L_2_:Notify(
                        {
					Title = "ERROR",
					Description = "That is not a valid number. Please enter numbers in the format (0 0 0) or (0.2 0.2 0.2)."
				}, {
					OutlineColor = Color3.fromRGB(200, 44, 44),
					Time = 5,
					Type = "image"
				}, {
					Image = "http://www.roblox.com/asset/?id=111630714337304",
					ImageColor = Color3.fromRGB(255, 84, 84)
				})
			end
		end, {
			["clear"] = false
		})
		L_860_:AddButton("LoadImage", function()
			BetaInstantLoad3()
		end)
		]]
		ClearPreview()
		L_2_:Notify(
            {
			Title = "Ui Loaded Succsesfully",
			Description = "Have Fun Using Vortex Auto Build."
		}, {
			OutlineColor = Color3.fromRGB(44, 44, 200),
			Time = 5,
			Type = "default"
		})
	end
	L_762_:Show()
	L_767_:Show()
	L_93_:FormatWindows()
    --BETAUI:Hide()
end

