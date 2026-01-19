local player = game.Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- 1. Create the Spy Screen
local screen = Instance.new("ScreenGui")
screen.Name = "GiftSpy"
screen.Parent = pGui

local frame = Instance.new("ScrollingFrame")
frame.Size = UDim2.new(0.8, 0, 0.4, 0) -- Big box
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.CanvasSize = UDim2.new(0, 0, 10, 0)
frame.Parent = screen

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "GIFT SPY: Send a gift to someone!"
title.TextColor3 = Color3.new(1, 1, 0)
title.Parent = frame

-- 2. The Trap
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

local logCount = 0

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- We look for ANY signal that sends a "String" (Text)
    -- This helps us catch the Item Name or Player Name
    if method == "FireServer" or method == "InvokeServer" then
        
        -- Filter: Only show remotes that might be Gifting
        -- We look for common words like "Gift", "Send", "Trade", or the Item Name
        local remoteName = string.lower(self.Name)
        local argsString = tostring(args[1]) .. ", " .. tostring(args[2])
        
        -- (If you don't know the exact remote name, we print almost everything relevant)
        if string.find(remoteName, "gift") or string.find(remoteName, "send") or string.find(remoteName, "event") then
             logCount = logCount + 1
            
            local log = Instance.new("TextLabel")
            log.Size = UDim2.new(1, 0, 0, 60)
            log.Position = UDim2.new(0, 0, 0, 30 + (logCount * 60))
            log.TextColor3 = Color3.new(1, 1, 1)
            log.TextWrapped = true
            log.Text = logCount..". " .. self.Name .. "\nARGS: " .. argsString
            log.Parent = frame
            
            print("CAPTURED: " .. self.Name .. " | " .. argsString)
        end
    end

    return oldNamecall(self, ...)
end)