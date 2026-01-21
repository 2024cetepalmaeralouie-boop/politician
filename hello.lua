-- MOBILE SECURITY SCANNER + UI
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- 1. THE UI SETUP
local screen = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screen.ResetOnSpawn = false

local toggleBtn = Instance.new("TextButton", screen)
toggleBtn.Size = UDim2.new(0, 150, 0, 50)
toggleBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
toggleBtn.Text = "SCANNER: OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Draggable = true -- Essential for mobile!

-- 2. THE SCANNER LOGIC
local active = false
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if active and (method == "FireServer" or method == "InvokeServer") then
        local name = tostring(self.Name)
        -- Ignore common movement/physics signals
        if not name:find("Move") and not name:find("Ping") then
            warn("📡 DETECTED: " .. name)
            for i, v in pairs(args) do
                print("   [" .. i .. "]: " .. tostring(v))
            end
        end
    end
    return oldNamecall(self, ...)
end)

-- 3. TOGGLE BUTTON FUNCTION
toggleBtn.MouseButton1Click:Connect(function()
    active = not active
    if active then
        toggleBtn.Text = "SCANNER: ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        print("🛡️ Audit Started - Perform actions now!")
    else
        toggleBtn.Text = "SCANNER: OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
end)