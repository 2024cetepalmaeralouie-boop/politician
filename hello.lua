local msg = Instance.new("Message")
msg.Parent = game.Workspace
msg.Text = "SUCCESS! The Executor loaded this from GitHub!"

task.wait(3)
msg:Destroy()