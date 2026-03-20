-- MOBILE REMOTE SPY & UI (2026 EDITION)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Title = Instance.new("TextLabel")

-- Setup UI
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "📡 REMOTE SPY: ACTIVE"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -30)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 10, 0)
ScrollingFrame.ScrollBarThickness = 6

UIListLayout.Parent = ScrollingFrame
UIListLayout.Padding = UDim.new(0, 2)

local function logToUI(text, color)
    local Label = Instance.new("TextLabel")
    Label.Parent = ScrollingFrame
    Label.Size = UDim2.new(1, -10, 0, 22)
    Label.BackgroundTransparency = 0.9
    Label.TextColor3 = color or Color3.new(1, 1, 1)
    Label.Text = text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextScaled = true
end

-- THE SNIFFER LOGIC
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" or method == "InvokeServer" then
        logToUI("🔥 NAME: " .. self.Name, Color3.new(1, 0.4, 0.4))
        for i, v in pairs(args) do
            logToUI("   └ Arg " .. i .. ": " .. tostring(v), Color3.new(0.8, 0.8, 1))
        end
    end
    
    return old(self, ...)
end)

logToUI("System Loaded. Click the 'Buy' button again!", Color3.new(0.4, 1, 0.4))
