-- DELTA EXECUTOR OPTIMIZED REMOTE SPY
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- 1. DELETE OLD VERSION
if PlayerGui:FindFirstChild("DeltaSpy") then PlayerGui.DeltaSpy:Destroy() end

-- 2. UI SETUP
local sg = Instance.new("ScreenGui", PlayerGui)
sg.Name = "DeltaSpy"
sg.ResetOnSpawn = false

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 220, 0, 180)
frame.Position = UDim2.new(0.5, -110, 0.05, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, 0, 1, -25)
scroll.Position = UDim2.new(0, 0, 0, 25)
scroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
scroll.CanvasSize = UDim2.new(0, 0, 50, 0)

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "DELTA REMOTE SNIFFER"
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14

-- 3. LOGGING
local function addLog(txt)
    local l = Instance.new("TextLabel", scroll)
    l.Size = UDim2.new(1, 0, 0, 25)
    l.Text = txt
    l.TextColor3 = Color3.fromRGB(0, 255, 150)
    l.BackgroundTransparency = 1
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    scroll.CanvasPosition = Vector2.new(0, scroll.AbsoluteCanvasSize.Y)
end

-- 4. THE ENGINE (Delta Compatible)
local mt = getrawmetatable(game)
local old = mt.__namecall
if setreadonly then setreadonly(mt, false) else make_writeable(mt) end

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" or method == "InvokeServer" then
        local remoteName = tostring(self.Name)
        -- Filter out the "noise" so Delta doesn't lag
        if not remoteName:find("Move") and not remoteName:find("Ping") and not remoteName:find("Physics") then
            local argString = ""
            for i, v in pairs(args) do
                argString = argString .. tostring(v) .. " "
            end
            addLog("> " .. remoteName .. ": " .. argString)
        end
    end
    return old(self, ...)
end)

addLog("System: Delta Spy Loaded!")