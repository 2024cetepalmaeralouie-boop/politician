local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- ========================================================
-- 1. CONFIGURATION: THE MAGIC NUMBER
-- ========================================================
-- Try -10000 first (Negative). This attempts to refund money.
-- If this makes you walk backwards, change it to 99999 (Positive) to get super speed.
local AMOUNT_TO_HACK = -10000

-- ========================================================
-- 2. THE EXPLOIT
-- ========================================================
local targetRemote = nil

-- Find the remote automatically
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v.Name == "UpgradeSpeed" then
        targetRemote = v
        print("✅ FOUND REMOTE: " .. v:GetFullName())
        break
    end
end

if targetRemote then
    local msg = Instance.new("Message", workspace)
    msg.Text = "SENDING HACK: " .. AMOUNT_TO_HACK
    task.wait(2)
    msg:Destroy()

    print("------------------------------------------------")
    print("🚀 INJECTING VALUE: " .. AMOUNT_TO_HACK)
    print("------------------------------------------------")

    -- Fire the signal 5 times to make sure it hits hard
    for i = 1, 5 do
        if targetRemote:IsA("RemoteFunction") then
            targetRemote:InvokeServer(AMOUNT_TO_HACK)
        elseif targetRemote:IsA("RemoteEvent") then
            targetRemote:FireServer(AMOUNT_TO_HACK)
        end
        task.wait(0.1)
    end
    
    local hint = Instance.new("Hint", workspace)
    hint.Text = "PAYLOAD SENT! Check your Cash & Speed."
    task.wait(5)
    hint:Destroy()
else
    local err = Instance.new("Message", workspace)
    err.Text = "ERROR: Could not find 'UpgradeSpeed' remote."
    task.wait(3)
    err:Destroy()
end