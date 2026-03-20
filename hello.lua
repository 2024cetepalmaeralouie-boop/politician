-- REMOTE SPY: Run this to see the HIDDEN data
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    -- We are looking for "FireServer" (the client talking to the server)
    if method == "FireServer" or method == "InvokeServer" then
        print("-------------------------------")
        print("📡 REMOTE DETECTED: " .. self.Name)
        print("FROM PATH: " .. self:GetFullName())
        for i, v in pairs(args) do
            print("   Arg " .. i .. ": " .. tostring(v) .. " (" .. type(v) .. ")")
        end
    end
    
    return old(self, ...)
end)

print("--- REMOTE SPY ACTIVE: Click 'Buy' now! ---")
