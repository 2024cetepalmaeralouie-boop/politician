local floor = workspace:FindFirstChild("Baseplate") or workspace:FindFirstChild("BasePlate")

if floor then
    floor:Destroy()
    
    local msg = Instance.new("Message")
    msg.Parent = workspace
    msg.Text = "I DELETED THE FLOOR!"
    task.wait(3)
    msg:Destroy()
else
    print("Could not find floor to delete.")
end