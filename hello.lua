-- ULTIMATE MOBILE REMOTE SPY
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- 1. UI SETUP (Mobile Optimized)
local screen = Instance.new("ScreenGui", PlayerGui)
screen.Name = "MobileSpyGui"
screen.ResetOnSpawn = false
screen.DisplayOrder = 999

-- Main Window
local main = Instance.new("Frame", screen)
main.Size = UDim2.new(0, 250, 0, 300)
main.Position = UDim2.new(0.5, -125, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Active = true
main.Draggable = true -- Move it with your thumb

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "📡 REMOTE SPY LOGS"
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextColor3 = Color3.new(1, 1, 1)

-- Scrollable Area for Logs
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -10, 1, -40)
scroll.Position = UDim2.new(0, 5, 0, 35)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 10, 0) -- Long enough for many logs
local layout = Instance.new("UIListLayout", scroll)
layout.Padding =指导 = UDim.new(0, 5)

-- 2. LOGGING FUNCTION
local function addLog(text)
    local log = Instance.new("TextLabel", scroll)
    log.Size = UDim2.new(1, 0, 0, 40)
    log.Text = text
    log.TextColor3 = Color3.new(0, 1, 0) -- Green text
    log.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    log.TextWrapped = true
    log.TextSize = 12
    scroll.CanvasPosition = Vector2.new(0, scroll.AbsoluteCanvasSize.Y) -- Auto scroll
end

-- 3. THE SNIFFER ENGINE
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" or method == "InvokeServer" then
        local name = tostring(self.Name)
        -- Filter out the noise
        if not name:find("Move") and not name:find("Ping") then
            local data = name .. " | Args: "
            for i, v in pairs(args) do
                data = data .. "[" .. i .. "]:" .. tostring(v) .. " "
            end
            addLog(data)
        end
    end
    return oldNamecall(self, ...)
end)

addLog("System: Spy Active. Perform an action!")