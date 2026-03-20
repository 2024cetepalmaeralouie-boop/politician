-- JUNKYARD SECURITY AUDIT: ATTRIBUTE SPOOFER
print("--- ATTRIBUTE SPOOFER ACTIVE ---")

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local function hijackButton(button)
    button.MouseButton1Down:Connect(function()
        print("MODIFING ATTRIBUTES FOR: " .. button.Name)
        
        -- Try to find and change common price/value attributes
        if button:GetAttribute("Price") then
            button:SetAttribute("Price", 0)
            print("Set Price to 0!")
        end
        
        if button:GetAttribute("Cost") then
            button:SetAttribute("Cost", 0)
            print("Set Cost to 0!")
        end

        if button:GetAttribute("Value") then
            button:SetAttribute("Value", 999999)
            print("Set Sell Value to 999,999!")
        end
    end)
end

-- Scan UI for buttons
for _, v in pairs(PlayerGui:GetDescendants()) do
    if v:IsA("TextButton") or v:IsA("ImageButton") then
        hijackButton(v)
    end
end

print("Done. Try buying or selling a car now!")
