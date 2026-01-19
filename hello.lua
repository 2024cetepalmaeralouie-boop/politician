local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

-- 1. The Target Name (Must match the Index EXACTLY)
local FAKE_NAME = "Esok Sekolah"

local function overwriteTool(tool)
    if tool:IsA("Tool") then
        -- Wait for the game to finish giving you the original item
        task.wait(0.1)
        
        -- 2. Rename the Item
        -- If the developer is lazy, he just checks this Name when you sell.
        print("😈 SWAPPING ITEM: " .. tool.Name .. " -> " .. FAKE_NAME)
        tool.Name = FAKE_NAME
        
        -- 3. Extra Trick: Rename the 'Handle' just in case
        local handle = tool:FindFirstChild("Handle")
        if handle then
            handle.Name = "Handle" -- Keep this standard, or change if needed
        end
        
        -- 4. Value Spoofing (If the item has a price tag inside)
        -- We look for any "NumberValue" inside the tool and set it to 1 million
        for _, child in pairs(tool:GetChildren()) do
            if child:IsA("NumberValue") or child:IsA("IntValue") then
                child.Value = 999999999
            end
        end
    end
end

-- Listen for new items entering your inventory
backpack.ChildAdded:Connect(overwriteTool)
player.Character.ChildAdded:Connect(overwriteTool)

-- Notify you
local msg = Instance.new("Message", workspace)
msg.Text = "TARGET SET: " .. FAKE_NAME
task.wait(3)
msg:Destroy()