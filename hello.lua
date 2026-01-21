-- MOBILE SECURITY SCANNER (FORCE UI FIX)
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- 1. CLEAN UP OLD UI (In case you ran it twice)
if PlayerGui:FindFirstChild("MobileScannerGui") then
    PlayerGui.MobileScannerGui:Destroy()
end

-- 2. THE UI SETUP
local screen = Instance.new("ScreenGui", PlayerGui)
screen.Name = "MobileScannerGui"
screen.ResetOnSpawn = false
screen.DisplayOrder = 999 -- Keeps it above game buttons
screen.IgnoreGuiInset = true -- Uses the whole screen space

local toggleBtn = Instance.new("TextButton", screen)
toggleBtn.Size = UDim2.new(0, 180, 0, 70) -- Bigger for thumbs
toggleBtn.Position = UDim2.new(0.5, -90, 0.2, 0) -- Top middle
toggleBtn.Text = "SCANNER: OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.Code
toggleBtn.TextSize = 18
toggleBtn.ZIndex = 10 -- Force to front

-- 3. THE SCANNER LOGIC
local active = false
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if active and (method == "FireServer" or method == "InvokeServer") then
        local name = tostring(self.Name)
        if not name:find("Move") and not name:find("Ping") then
            warn("📡 DETECTED: " .. name)
            for i, v in pairs(args) do
                print("   [" .. i .. "]: " .. tostring(v))
            end
        end
    end
    return oldNamecall(self, ...)
end)

-- 4. TOGGLE BUTTON FUNCTION
toggleBtn.MouseButton1Click:Connect(function()
    active = not active
    if active then
        toggleBtn.Text = "SCANNER: ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    else
        toggleBtn.Text = "SCANNER: OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
end)

print("🛡️ MOBILE UI LOADED - Check Top of Screen")