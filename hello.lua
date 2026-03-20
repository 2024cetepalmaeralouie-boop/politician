-- Save this to your GitHub as 'button_spy.lua'
print("--- BUTTON SNIFFER ACTIVE ---")

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Function to handle the click log
local function connectButton(button)
    button.MouseButton1Click:Connect(function()
        print("-------------------------------")
        print("BUTTON CLICKED: " .. button.Name)
        print("PATH: " .. button:GetFullName())
        
        -- Check if the button has 'Attributes' (Common way to store data in 2026)
        local attributes = button:GetAttributes()
        if next(attributes) ~= nil then
            print("ATTRIBUTES FOUND:")
            for name, value in pairs(attributes) do
                print("   -> " .. name .. ": " .. tostring(value))
            end
        else
            print("No extra data attributes found on this button.")
        end
    end)
end

-- Scan for all existing buttons (TextButtons and ImageButtons)
for _, v in pairs(PlayerGui:GetDescendants()) do
    if v:IsA("TextButton") or v:IsA("ImageButton") then
        connectButton(v)
    end
end

-- Also watch for NEW buttons that might be added later (like in menus)
PlayerGui.DescendantAdded:Connect(function(v)
    if v:IsA("TextButton") or v:IsA("ImageButton") then
        connectButton(v)
    end
end)

print("Monitoring all UI buttons... Click something to see data!")
