-- DIRECT REMOTE LISTENER (No UI, Console Only)
print("--- STARTING DIRECT SCAN ---")

local function connectRemote(remote)
    if remote:IsA("RemoteEvent") then
        remote.OnClientEvent:Connect(function(...)
            print("📩 RECEIVED FROM SERVER [" .. remote.Name .. "]:", ...)
        end)
        
        -- This part attempts to spy on what YOU send
        local oldFire = remote.FireServer
        remote.FireServer = function(self, ...)
            print("🔥 YOU SENT TO SERVER [" .. remote.Name .. "]:")
            local args = {...}
            for i, v in pairs(args) do
                print("   Arg " .. i .. ": " .. tostring(v))
            end
            return oldFire(self, ...)
        end
    end
end

-- Scan everything currently in the game
for _, item in pairs(game:GetDescendants()) do
    if item:IsA("RemoteEvent") or item:IsA("RemoteFunction") then
        connectRemote(item)
    end
end

-- Watch for new Remotes being added (like when a shop opens)
game.DescendantAdded:Connect(function(item)
    connectRemote(item)
end)

print("--- SCAN COMPLETE: CLICK BUY NOW ---")
