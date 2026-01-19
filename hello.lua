local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- ==========================================
-- 1. CONFIGURATION (EDIT THIS!)
-- ==========================================

-- Put your friend's username here
local FRIEND_NAME = "LouieG18" 

-- Put the WEIRD CODE you saw on the screen here. 
-- (Type it exactly as you see it on your loading screen)
local UUID_CODE = "bab13f04-64c5-4ab3-a5b8-cfee12ccec8e" -- <--- REPLACE THIS WITH THE FULL CODE

-- ==========================================
-- 2. THE SCRIPT
-- ==========================================

local giftRemote = nil

-- Find the remote automatically (using the name you found earlier)
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v.Name == "SendGift" or v.Name == "RF/Trade.SendGift" then
        giftRemote = v
        print("✅ FOUND REMOTE: " .. v:GetFullName())
        break
    end
end

if giftRemote then
    -- Notify
    local msg = Instance.new("Message", workspace)
    msg.Text = "SENDING UUID GIFT..."
    task.wait(2)
    msg:Destroy()

    print("------------------------------------------------")
    print("🚀 LAUNCHING PAYLOAD")
    print("📦 TARGET: " .. FRIEND_NAME)
    print("🔑 UUID: " .. UUID_CODE)
    print("------------------------------------------------")

    -- Try to FIRE the remote with the UUID
    -- We try both Invoke and Fire to be safe
    local success, err = pcall(function()
        if giftRemote:IsA("RemoteFunction") then
            giftRemote:InvokeServer(FRIEND_NAME, UUID_CODE)
        elseif giftRemote:IsA("RemoteEvent") then
            giftRemote:FireServer(FRIEND_NAME, UUID_CODE)
        end
    end)

    if success then
        print("✅ SIGNAL SENT SUCCESSFULLY!")
        local hint = Instance.new("Hint", workspace)
        hint.Text = "SIGNAL SENT! Check if friend got the item."
        task.wait(5)
        hint:Destroy()
    else
        warn("❌ FAILED TO SEND: " .. tostring(err))
        local hint = Instance.new("Hint", workspace)
        hint.Text = "ERROR: " .. tostring(err)
        task.wait(5)
        hint:Destroy()
    end

else
    local err = Instance.new("Message", workspace)
    err.Text = "ERROR: Could not find 'RF/Trade.SendGift'"
    task.wait(3)
    err:Destroy()
end