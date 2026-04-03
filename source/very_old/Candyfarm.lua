getgenv().Farm = true -- farms doors for candy
getgenv().AntiStuck = true -- kills you if the door makes u stuck

print("RedBlue")

while getgenv().Farm and task.wait() do
    for i,v in pairs(workspace.Houses:GetChildren()) do
    pcall(function()
        if v:FindFirstChild("Door") and v:FindFirstChild("Door"):FindFirstChild("DoorInnerTouch") then
            v:FindFirstChild("Door"):FindFirstChild("DoorInnerTouch").CanTouch = true
            v:FindFirstChild("Door"):FindFirstChild("DoorInnerTouch").CanCollide = false
            v:FindFirstChild("Door"):FindFirstChild("DoorInnerTouch").CFrame = game.Players.LocalPlayer.Character.PrimaryPart.CFrame * (CFrame.Angles(math.rad(math.random(1,360)), math.rad(math.random(1,360)), math.rad(math.random(1,360))) * CFrame.new(0, 0, 0))
        end
    end)
end

if getgenv().AntiStuck then
    pcall(function()
        if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed == 0 then
                task.wait(5.5) -- to be somewhat safe im too lazy
                game.Players.LocalPlayer.Character.Humanoid.Health = 0
                game.Players.LocalPlayer.Character:BreakJoints()
            end
        end)
    end
end
print("RedBlue")