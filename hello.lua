local player = game.Players.LocalPlayer
local character = player.Character
local rootPart = character:WaitForChild("HumanoidRootPart")

-- 1. Create a floating red box above your head
local box = Instance.new("Part")
box.Size = Vector3.new(4, 4, 4)
box.Position = rootPart.Position + Vector3.new(0, 10, 0) -- 10 studs up
box.BrickColor = BrickColor.new("Really red")
box.Material = Enum.Material.Neon
box.Anchored = true
box.Parent = game.Workspace

-- 2. Tell you it worked
local msg = Instance.new("Message")
msg.Parent = game.Workspace
msg.Text = "LOOK UP! I created a block."
task.wait(3)
msg:Destroy()