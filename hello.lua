local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ========================================================
-- CONFIGURATION
-- ========================================================
local TARGET_PLAYER = "LouieG18" -- <--- PUT YOUR MAIN NAME HERE
local GIFT_DELAY = 1.5                     -- <--- Seconds to wait between gifts

-- ========================================================
-- THE SCRIPT
-- ========================================================
local giftRemote = nil

-- Find remote automatically
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v.Name == "SendGift" or v.Name == "RF/Trade.SendGift" then
        giftRemote = v
        break
    end
end

if not giftRemote then return end

-- GUI Toggle
local screen = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local btn = Instance.new("TextButton", screen)
btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0.5, -100, 0.2, 0)
btn.Text = "AUTO-GIFT: OFF"
btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

local active = false

btn.MouseButton1Click:Connect(function()
    active = not active
    if active then
        btn.Text = "GIFTING HELD ITEM..."
        btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        
        task.spawn(function()
            while active do
                local char = player.Character
                if char then
                    -- 1. Check if holding an item
                    local tool = char:FindFirstChildWhichIsA("Tool")
                    
                    if tool then
                        -- 2. Gift it
                        if giftRemote:IsA("RemoteFunction") then
                            giftRemote:InvokeServer(TARGET_PLAYER, tool.Name)
                        else
                            giftRemote:FireServer(TARGET_PLAYER, tool.Name)
                        end
                        
                        -- 3. Wait cooldown
                        task.wait(GIFT_DELAY)
                    end
                end
                task.wait(0.2) -- Check hand every 0.2 seconds
            end
        end)
    else
        btn.Text = "AUTO-GIFT: OFF"
        btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)