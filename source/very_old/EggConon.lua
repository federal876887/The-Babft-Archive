local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local PlaceID = 1930863474
local player = Players.LocalPlayer

print("Attempting to teleport...")

-- Teleportationscode für den Subplace
local teleportScript = [[
    wait(25)

    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    -- Setze den CFrame des Spielers vor der Interaktion
    local preClickCFrame = CFrame.new(151.633881, 26.4910316, -585.128662, -0.132995218, -1.5907526e-08, -0.991116703, 1.22512063e-08, 1, -1.76940596e-08, 0.991116703, -1.44956003e-08, -0.132995218)
    rootPart.CFrame = preClickCFrame

    wait(2)

    -- Klicke den Button, wenn der ClickDetector vorhanden ist
    local button = workspace:WaitForChild("ButtonStand"):WaitForChild("Button"):WaitForChild("ButtonPart")
    local clickDetector = button:FindFirstChild("ClickDetector")

    if clickDetector then
        fireclickdetector(clickDetector)
        print("ClickDetector Got Pressed!!")
    else
        print("ClickDetector Already Got Pressed!!!")
    end

    -- Setze den CFrame für das Ziel
    local targetCFrame = CFrame.new(170.553009, 136.338943, -591.240723, 
        -0.199367583, 0.000256254803, 0.979924738, 
        -8.58971116e-09, 0.99999994, -0.000261506328, 
        -0.979924798, -5.21442998e-05, -0.199367568
    )

    -- Erstelle einen Part
    local Part = Instance.new("Part")
    Part.Name = "WeshkyOnTop"
    Part.Size = Vector3.new(50, 2, 50)
    Part.Transparency = 0.6
    Part.Anchored = true
    Part.CFrame = targetCFrame
    Part.Color = Color3.fromRGB(255, 52, 52)
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.Parent = workspace
    
    -- Erstelle ein Decal auf dem Part
    local Decal = Instance.new("Decal")
    Decal.Texture = "rbxassetid://138258387077137"
    Decal.Transparency = 0.6
    Decal.Name = "Weshky Is Better Then Lexus!!"
    Decal.Face = Enum.NormalId.Top
    Decal.Parent = Part

    wait(1)
    rootPart.CFrame = targetCFrame + Vector3.new(0, 3, 0)

    print("Player got teleported and script executed on subplace! ")
]]

-- Teleportiere den Spieler zum Subplace und führe das Skript dort aus
queue_on_teleport(teleportScript)

-- Versuche die Teleportation
print("Teleporting to subplace...")
TeleportService:Teleport(PlaceID, player)
