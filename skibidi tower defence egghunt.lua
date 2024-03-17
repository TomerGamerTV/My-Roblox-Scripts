-- Define the ManFace function
function ManFace()
    local message = "man face man"
    local recipient = "All"
    for i = 1, 3 do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, recipient)
        wait(1)
    end
end

-- Check if HiddenEggs exists in the Workspace
local eggHuntEggs = game.Workspace:FindFirstChild("HiddenEggs")

if not eggHuntEggs then
    -- If HiddenEggs doesn't exist, check if Lobby or TradingPlaza exists in Workspace > Worlds
    local worlds = game.Workspace.Worlds
    local eggHuntLocation = worlds:FindFirstChild("Lobby") or worlds:FindFirstChild("TradingPlaza")

    if not eggHuntLocation then
        error("Neither Lobby nor TradingPlaza was found in Workspace > Worlds.")
    end

    -- If TradingPlaza is found, send a message in the chat
    if eggHuntLocation.Name == "TradingPlaza" then
        ManFace()
    end

    -- Get the EggHuntEggs folder
    eggHuntEggs = eggHuntLocation.EggHuntEggs
end

-- Function to fire all ClickDetectors of an object
local function fireClickDetectors(object)
    for _, child in ipairs(object:GetChildren()) do
        if child:IsA("ClickDetector") then
            fireclickdetector(child)
        end
        -- Recursively fire ClickDetectors for children of the object
        fireClickDetectors(child)
    end
end

-- Function to iterate over all items and fire their ClickDetectors
local function fireAllClickDetectors()
    for _, item in ipairs(eggHuntEggs:GetChildren()) do
        fireClickDetectors(item)
    end
end

-- Continuously fire all ClickDetectors every 10 seconds
while true do
    fireAllClickDetectors()
    wait(10) -- Wait for 10 seconds
end

-- Send the appropriate notification
if eggHuntEggs.Name == "HiddenEggs" then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Egg Hunt";
        Text = "The Glacier Egg is located above the npc spawner, others will spawn while you play";
    })
elseif eggHuntEggs.Parent.Name == "TradingPlaza" then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Egg Hunt";
        Text = "Finished collecting all the eggs, now you only need to complete a trade to get the golden egg!";
    })
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Egg Hunt";
        Text = "Finished grabbing all the eggs!";
    })
end
