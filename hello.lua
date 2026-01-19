local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ========================================================
-- 1. CONFIGURATION: THE TIMING
-- ========================================================
-- How long to wait after Gifting before crashing?
-- 0.05 = Very Fast (Might crash before gift sends)
-- 0.50 = Medium (Good starting point)
-- 1.00 = Slow (Might save data too fast)
local CRASH_DELAY = 0.05 

-- ========================================================
-- 2. THE TRAP (Silent Listener)
-- ========================================================
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

local isArmed = true

print("------------------------------------------------")
print("💣 DUPE TRAP ARMED")
print("   > Waiting for you to gift...")
print("   > Will kick you in " .. CRASH_DELAY .. " seconds after gifting.")
print("------------------------------------------------")

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- We listen for the Gift Signal (Same name we found earlier)
    if isArmed and (method == "FireServer" or method == "InvokeServer") and 
       (self.Name == "SendGift" or self.Name == "RF/Trade.SendGift") then
        
        -- 1. DETECT THE GIFT
        print("🚨 GIFT SIGNAL DETECTED! INITIATING CRASH...")
        
        -- 2. START THE COUNTDOWN (In a separate thread so we don't block the gift)
        task.spawn(function()
            local startTime = tick()
            
            -- Wait the specific amount of time
            while tick() - startTime < CRASH_DELAY do
                task.wait()
            end
            
            -- 3. THE CRASH
            player:Kick("🔌 DUPE LAG SWITCH: DISCONNECTED! Check Alt.")
        end)
        
        -- 4. LET THE GIFT GO THROUGH (Crucial!)
        -- We return the original function so the server receives the gift request
        return oldNamecall(self, ...)
    end

    return oldNamecall(self, ...)
end)

-- Visual Confirmation
local msg = Instance.new("Message", workspace)
msg.Text = "DUPE READY! Gift your alt to trigger the crash."
task.wait(3)
msg:Destroy()