-- DELTA SPY: NO AUTO-SCROLL + NO BLANK ROWS
local player = game.Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

if pGui:FindFirstChild("SpyX") then pGui.SpyX:Destroy() end
local sg = Instance.new("ScreenGui", pGui)
sg.Name = "SpyX"

-- 1. THE MAIN CONTAINER
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 300, 0, 200)
f.Position = UDim2.new(0.5, -150, 0.2, 0)
f.BackgroundColor3 = Color3.new(0, 0, 0)
f.Active = true
f.Draggable = true

-- 2. SCROLLING AREA (Horizontal + Manual Scroll only)
local s = Instance.new("ScrollingFrame", f)
s.Size = UDim2.new(1, 0, 1, 0)
s.CanvasSize = UDim2.new(4, 0, 0, 0) -- Starts with 0 vertical height
s.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
s.ScrollBarThickness = 8
s.AutomaticCanvasSize = Enum.AutomaticSize.Y -- Only grows when a row is added

local l = Instance.new("UIListLayout", s)
l.SortOrder = Enum.SortOrder.LayoutOrder

-- 3. LOGGING FUNCTION
local function log(t)
    local txt = Instance.new("TextLabel", s)
    txt.Size = UDim2.new(1, 0, 0, 25) -- Fixed height per row
    txt.Text = t
    txt.TextColor3 = Color3.fromRGB(0, 255, 150)
    txt.BackgroundTransparency = 1
    txt.TextSize = 12
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Font = Enum.Font.Code
    -- We REMOVED the line that forces CanvasPosition to the bottom
end

-- 4. THE ENGINE
local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(t, k)
    if k == "FireServer" or k == "InvokeServer" then
        return function(self, ...)
            local args = {...}
            local argStr = ""
            for i, v in pairs(args) do
                argStr = argStr .. "[" .. i .. "]: " .. tostring(v) .. " | "
            end
            log("📡 " .. tostring(self.Name) .. " -> " .. argStr)
            return self[k](self, ...)
        end
    end
    return old(t, k)
end)

-- No "Ready" message to keep it clean