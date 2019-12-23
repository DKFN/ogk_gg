-- 800 = basic health kit
-- 807 = pills for armor like (maybe find another model)

local items = {

    -- port
    {
        model = 800, -- model id refer https://dev.playonset.com/wiki/Objects
        type = "health", -- type can be "armor" or "health"
        map = "port", -- the map where items are loaded 
        respawn = 5000, -- miniscds (miniscds)
        amount = 20, -- amount of life or armor given  
        x = 37001, -- x pos
        y = 206149, -- y pos
        z = 556 -- z pos
    },

    {
        model = 800,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "health", -- type can be "armor" or "health"
        respawn = 5000, -- respawn time (miniscds)
        map = "port", -- the map where items are loaded
        amount = 20, -- amount of life or armor given 
        x = 40994, -- x pos
        y = 199173, -- y pos
        z = 551 -- z pos
    },

    {
        model = 807,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "armor", -- type can be "armor" or "health"
        respawn = 10000, -- respawn time (miniscds)
        map = "port", -- the map where items are loaded
        amount = 10, -- amount of life or armor given 
        x = 41587, -- x pos
        y = 205541, -- y pos
        z = 572 -- z pos
    },

    {
        model = 807,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "armor", -- type can be "armor" or "health"
        respawn = 10000, -- respawn time (miniscds)
        map = "port", -- the map where items are loaded
        amount = 10, -- amount of life or armor given 
        x = 41256, -- x pos
        y = 205541, -- y pos
        z = 565 -- z pos
    },
  
    {
        model = 807,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "armor", -- type can be "armor" or "health"
        respawn = 10000, -- respawn time (miniscds)
        map = "port", -- the map where items are loaded
        amount = 10, -- amount of life or armor given 
        x = 38992, -- x pos
        y = 207019, -- y pos
        z = 551 -- z pos
    },


    -- port_small
    {
        model = 800,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "health", -- type can be "armor" or "health"
        map = "port_small", -- the map where items are loaded
        respawn = 10000, -- respawn time (miniscds)
        amount = 20, -- amount of life or armor given 
        x = 44164, -- x pos
        y = 202148, -- y pos
        z = 551 -- z pos
    },

    {
        model = 800,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "health", -- type can be "armor" or "health"
        map = "port_small", -- the map where items are loaded
        respawn = 10000, -- respawn time (miniscds)
        amount = 20, -- amount of life or armor given 
        x = 41987, -- x pos
        y = 206561, -- y pos
        z = 572 -- z pos
    },

    {
        model = 807,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "armor", -- type can be "armor" or "health"
        map = "port_small", -- the map where items are loaded
        respawn = 30000, -- respawn time (miniscds)
        amount = 40, -- amount of life or armor given 
        x = 44046, -- x pos
        y = 204322, -- y pos
        z = 808 -- z pos
    },

    {
        model = 807,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "armor", -- type can be "armor" or "health"
        map = "port_small", -- the map where items are loaded
        respawn = 15000, -- respawn time (miniscds)
        amount = 15, -- amount of life or armor given 
        x = 44142, -- x pos
        y = 203237, -- y pos
        z = 563 -- z pos
    },

    -- armory

    {
        model = 807,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "armor", -- type can be "armor" or "health"
        map = "armory", -- the map where items are loaded
        respawn = 30000, -- respawn time (miniscds)
        amount = 20, -- amount of life or armor given 
        x = -14806, -- x pos
        y = 133018, -- y pos
        z = 1562 -- z pos
    },

    {
        model = 807,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "armor", -- type can be "armor" or "health"
        map = "armory", -- the map where items are loaded
        respawn = 30000, -- respawn time (miniscds)
        amount = 20, -- amount of life or armor given 
        x = -15769, -- x pos
        y = 133754, -- y pos
        z = 1562 -- z pos
    },
    
    {
        model = 800,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "health", -- type can be "armor" or "health"
        map = "armory", -- the map where items are loaded
        respawn = 15000, -- respawn time (miniscds)
        amount = 40, -- amount of life or armor given 
        x = -13619, -- x pos
        y = 133632, -- y pos
        z = 1562 -- z pos
    },

    {
        model = 800,  -- model id refer https://dev.playonset.com/wiki/Objects
        type = "health", -- type can be "armor" or "health"
        map = "armory", -- the map where items are loaded
        respawn = 15000, -- respawn time (miniscds)
        amount = 40, -- amount of life or armor given 
        x = -14829, -- x pos
        y = 134801, -- y pos
        z = 1562 -- z pos
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
            -- delete old pickups
            if (pickupsItems[k] ~= nil) then
                for k, v in ipairs(pickupsItems) do
                    DestroyPickup(k)
                    print("[OGK][GG] SpawnPickupItems OldMapDestroyer -- " .. k)
                    pickupsItems[k] = nil
                end
            end

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
            CallRemoteEvent(player, "PlayPickupSound")

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
            CallRemoteEvent(player, "PlayPickupSound")
        else 
            AddPlayerChat(player, "You can pickup that because you already have max armor !")
        end
    end
end
AddRemoteEvent("playerUsePickupItems", playerUsePickupItems)

