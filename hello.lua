-- DELTA STABLE DRAGGABLE SPY
local UIS = game:GetService("UserInputService")
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
f.BorderSizePixel = 2

-- 2. CUSTOM DRAG LOGIC (The "Delta Fix")
local dragging, dragInput, dragStart, startPos
f.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = f.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        f.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- 3. SCROLLING AREA (Horizontal + Vertical)
local s = Instance.new("ScrollingFrame", f)
s.Size = UDim2.new(1, 0, 1, 0)
s.CanvasSize = UDim2.new(4, 0, 0, 0)
s.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
s.ScrollBarThickness = 8
s.AutomaticCanvasSize = Enum.AutomaticSize.Y

local l = Instance.new("UIListLayout", s)

local function log(t)
    local txt = Instance.new("TextLabel", s)
    txt.Size = UDim2.new(1, 0, 0, 25)
    txt.Text = t
    txt.TextColor3 = Color3.fromRGB(0, 255, 150)
    txt.BackgroundTransparency = 1
    txt.TextSize = 12
    txt.TextXAlignment = "Left"
    txt.Font = Enum.Font.Code
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
            for i, v in pairs(args) do argStr = argStr .. "[" .. i .. "]: " .. tostring(v) .. " | " end
            log("📡 " .. tostring(self.Name) .. " -> " .. argStr)
            return self[k](self, ...)
        end
    end
    return old(t, k)
end)