local player = game.Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- 1. VISUAL LOGGER (So you can see it on screen)
local screen = Instance.new("ScreenGui")
screen.Name = "ShopSpy"
screen.Parent = pGui

local frame = Instance.new("ScrollingFrame")
frame.Size = UDim2.new(0.6, 0, 0.4, 0)
frame.Position = UDim2.new(0.2, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.3
frame.CanvasSize = UDim2.new(0, 0, 10, 0)
frame.Parent = screen

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "SHOP SPY: Go buy an upgrade!"
title.TextColor3 = Color3.new(0, 1, 0)
title.Parent = frame

-- 2. THE SPY
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

local logCount = 0

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- Watch for any Remote Signal
    if method == "FireServer" or method == "InvokeServer" then
        
        -- Filter out movement spam
        if self.Name ~= "UpdateCharacter" and self.Name ~= "TouchInterest" and self.Name ~= "CharacterSoundEvent" then
            
            logCount = logCount + 1
            local argsText = ""
            for i, v in pairs(args) do
                argsText = argsText .. tostring(v) .. ", "
            end
            
            -- Create log on screen
            local log = Instance.new("TextLabel")
            log.Size = UDim2.new(1, 0, 0, 50)
            log.Position = UDim2.new(0, 0, 0, 30 + (logCount * 50))
            log.TextColor3 = Color3.new(1, 1, 1)
            log.TextWrapped = true
            log.Text = logCount..". " .. self.Name .. " | ARGS: " .. argsText
            log.Parent = frame
            
            print("CAPTURED: " .. self.Name .. " | " .. argsText)
        end
    end

    return oldNamecall(self, ...)
end)