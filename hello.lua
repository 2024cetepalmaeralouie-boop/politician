-- REMOTE CAPTURER (GIFT EDITION)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" or method == "InvokeServer" then
        -- This will print the Remote name and the data to your console
        -- so you can match it with the "INCOMING_GIFT" log you saw.
        warn("FIRE ATTEMPT: " .. self.Name)
        for i, v in pairs(args) do
            print("Argument [" .. i .. "]: " .. tostring(v))
        end
    end

    return oldNamecall(self, ...)
end)