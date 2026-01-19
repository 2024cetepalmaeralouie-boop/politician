-- 1. Show a message immediately so we know the script loaded
local msg = Instance.new("Message")
msg.Parent = workspace
msg.Text = "Script Loaded! Searching for floor..."
task.wait(2)

-- 2. Try to find the floor (Case insensitive search)
local floor = workspace:FindFirstChild("Baseplate") or workspace:FindFirstChild("BasePlate") or workspace:FindFirstChild("Floor")

if floor then
    floor:Destroy()
    msg.Text = "BOOM! Floor deleted."
else
    msg.Text = "Script worked, but I couldn't find a part named 'Baseplate'."
end

-- 3. Cleanup
task.wait(3)
msg:Destroy()