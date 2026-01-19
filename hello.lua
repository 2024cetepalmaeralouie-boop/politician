local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 1. Setup the Spy
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

local isScanning = true

-- 2. GUI Notification
local msg = Instance.new("Message", workspace)
msg.Text = "GO TOUCH THE FINISH LINE NOW!"

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if isScanning and (method == "FireServer" or method == "InvokeServer") then
        -- We ignore common movement signals to reduce spam
        if self.Name ~= "UpdateCharacter" and self.Name ~= "TouchInterest" then
            
            -- 3. Print the "Secret Code"
            print("🚨 CAUGHT SIGNAL: " .. self.Name)
            print("   TYPE: " .. method)
            print("   ARGS: " .. tostring(args[1]) .. ", " .. tostring(args[2]))
            
            -- Create a visual alert on screen
            local alert = Instance.new("Hint", workspace)
            alert.Text = "CAPTURED: " .. self.Name .. " | Args: " .. tostring(args[1])
            task.wait(5)
            alert:Destroy()
        end
    end

    return oldNamecall(self, ...)
end)