-- 1. Create a Screen GUI so you can see logs on your phone
local player = game.Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

local screen = Instance.new("ScreenGui")
screen.Name = "SpyScreen"
screen.Parent = pGui

-- The background box
local frame = Instance.new("ScrollingFrame")
frame.Size = UDim2.new(0.5, 0, 0.4, 0) -- Takes up half width, 40% height
frame.Position = UDim2.new(0.25, 0, 0.1, 0) -- Top center
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.CanvasSize = UDim2.new(0, 0, 10, 0) -- Scrollable area
frame.Parent = screen

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "REMOTE SPY (Click the Sell Button!)"
title.TextColor3 = Color3.new(1, 0, 0) -- Red text
title.BackgroundColor3 = Color3.new(0, 0, 0)
title.Parent = frame

-- 2. The Spy Logic
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

local logCount = 0

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" then
        -- Add a text line to your mobile screen
        logCount = logCount + 1
        local log = Instance.new("TextLabel")
        log.Size = UDim2.new(1, 0, 0, 50)
        log.Position = UDim2.new(0, 0, 0, 30 + (logCount * 50))
        log.TextColor3 = Color3.new(1, 1, 1) -- White text
        log.BackgroundTransparency = 1
        log.TextWrapped = true
        
        -- FORMAT: Name of Remote -> Arguments
        log.Text = logCount..". " .. self.Name .. " | Args: " .. tostring(args[1])
        log.Parent = frame
    end

    return oldNamecall(self, ...)
end)