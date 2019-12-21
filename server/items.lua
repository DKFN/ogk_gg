local items = {
    {
        model = 800, -- model id refer https://dev.playonset.com/wiki/Objects
        type = "health", -- type can be "armor" or "health"
        map = "port", -- the map where items are loaded 
        respawn = 5000, -- miniscds (miniscds)
        amount = 10, -- amount of life or armor given  
        x = 37581.5625, -- x pos
        y = 203059.046875, -- y pos
        z = 550.94915711484 -- z pos
    },
    {
        model = 807,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "armor", -- type can be "armor" or "health"
        respawn = 5000, -- respawn time (miniscds)
        map = "port", -- the map where items are loaded
        amount = 5, -- amount of life or armor given 
        x = 37553.515625, -- x pos
        y = 203883.671875, -- y pos
        z = 550.94915771484 -- z pos
    }
}

pickupsItems = {}

function spawnPickupsItems(pickup_id)
    if(pickup_id ~= nil) then
        local v = pickupsItems[pickup_id]
        DestroyPickup(pickup_id)
        
        Delay(v.respawn, function()
            local id = CreatePickup(v.model, v.x, v.y, v.z)
            print("[OGK][GG] SpawnPickupItems ReSpawner -- " .. " Type:" .. v.type .. " Id: " .. id)
            pickupsItems[id] = v
        end)
    else
        for k, v in ipairs(items) do
            if (v.map == current_map) then
                local id = CreatePickup(v.model, v.x, v.y, v.z)
                print("[OGK][GG] SpawnPickupItems Loader -- " .. " Type:" .. v.type .. " Id: " .. id)
                pickupsItems[id] = v
            end
        end
    end
end
AddEvent("OnPackageStart", spawnPickupsItems)

function playerUsePickupItems(player, pickup_id)
    local object = pickupsItems[pickup_id]
    
    if(object.type == "health") then
        local health = GetPlayerHealth(player)
        local next_health = health + object.amount
        if(next_health < 100) then
            SetPlayerHealth(player, next_health)
            spawnPickupsItems(pickup_id)
        else
            AddPlayerChat(player, "You can pickup that because you already have max health !")
        end
    end

    if(object.type == "armor") then
        local armor = GetPlayerArmor(player)
        local next_armor = armor + object.amount
        if(armor <= 50) then
            SetPlayerArmor(player, armor + next_armor)
            spawnPickupsItems(pickup_id)
        else 
            AddPlayerChat(player, "You can pickup that because you already have max armor !")
        end
    end
end
AddRemoteEvent("playerUsePickupItems", playerUsePickupItems)
