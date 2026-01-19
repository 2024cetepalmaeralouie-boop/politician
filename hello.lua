local player = game.Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- 1. Create the Black Spy Screen
local screen = Instance.new("ScreenGui")
screen.Name = "SpyScreen_V2"
screen.Parent = pGui

local frame = Instance.new("ScrollingFrame")
frame.Size = UDim2.new(0.6, 0, 0.3, 0) -- Bigger box
frame.Position = UDim2.new(0.2, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.3
frame.CanvasSize = UDim2.new(0, 0, 10, 0)
frame.Parent = screen

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "DEEP SCAN SPY (Click the UI!)"
title.TextColor3 = Color3.new(1, 0, 0)
title.Parent = frame

-- 2. The Hook (The hacking part)
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

local logCount = 0

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- We now check for BOTH types of signals
    if method == "FireServer" or method == "InvokeServer" then
        logCount = logCount + 1
        
        local log = Instance.new("TextLabel")
        log.Size = UDim2.new(1, 0, 0, 40)
        log.Position = UDim2.new(0, 0, 0, 30 + (logCount * 40))
        log.TextColor3 = Color3.new(0, 1, 0) -- Green Text
        log.BackgroundTransparency = 1
        log.TextXAlignment = Enum.TextXAlignment.Left
        log.TextSize = 12
        
        -- Print the Remote Name and the Arguments
        log.Text = logCount..". " .. self.Name .. " (" .. method .. ") | Args: " .. tostring(args[1])
        log.Parent = frame
    end

    return oldNamecall(self, ...)
end)