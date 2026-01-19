local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- ==========================================================
-- 1. CONFIGURATION: THE "GOD CODE"
-- ==========================================================
-- Replace this with the LONG code you saw on the loading screen.
-- Keep the quotes "" around it!
local FAKE_UUID = "bab13f04-64c5-4ab3-a5b8-cfee12ccec8e" 

-- ==========================================================
-- 2. THE SILENT INTERCEPTOR
-- ==========================================================
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

print("😈 GIFT SWAPPER READY. Go Hold E on your friend!")

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- We listen for the specific Gifting Signal you found earlier
    -- "RF/Trade.SendGift" is the name you saw in the Spy
    if (method == "InvokeServer" or method == "FireServer") and 
       (self.Name == "RF/Trade.SendGift" or self.Name == "SendGift") then

        -- Print what we found so you know it worked
        print("🛑 STOP! Intercepting Gift Request...")
        print("   > Target Player: " .. tostring(args[1]))
        print("   > Original Item Data: " .. tostring(args[2]))

        -- THE SWAP:
        -- We force the UUID into the second slot (where 'nil' used to be)
        args[2] = FAKE_UUID

        print("✅ SWAPPED! Sending fake UUID: " .. FAKE_UUID)

        -- Send the modified lie to the server
        return oldNamecall(self, unpack(args))
    end

    return oldNamecall(self, ...)
end)

-- Visual Confirmation
local msg = Instance.new("Message", workspace)
msg.Text = "HOOK ENABLED: Gift any Common Item to test!"
task.wait(3)
msg:Destroy()