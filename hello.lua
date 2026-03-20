-- MOBILE REMOTE SPY UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Title = Instance.new("TextLabel")

-- Setup UI
ScreenGui.Parent = game.CoreGui -- Places it over everything
ScreenGui.Name = "SpyUI"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true -- So you can move it on your phone!

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Text = "📡 REMOTE SPY (MOBILE)"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -30)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
ScrollingFrame.ScrollBarThickness = 5

UIListLayout.Parent = ScrollingFrame
UIListLayout.Padding = UDim.new(0, 5)

-- Function to add a log to the screen
local function logToUI(text)
    local Label = Instance.new("TextLabel")
    Label.Parent = ScrollingFrame
    Label.Size = UDim2.new(1, -10, 0, 20)
    Label.BackgroundTransparency = 0.8
    Label.TextColor3 = Color3.new(0.8, 1, 0.8)
    Label.Text = text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextScaled = true
end

-- THE SPY LOGIC
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" then
        logToUI("🔥 " .. self.Name)
        for i, v in pairs(args) do
            logToUI("   └ Arg " .. i .. ": " .. tostring(v))
        end
    end
    
    return old(self, ...)
end)

logToUI("System Started. Click a button!")
