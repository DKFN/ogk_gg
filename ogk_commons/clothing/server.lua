-- OGK Common Utils - Clothing

-- Author: DeadlyKungFu.Ninja

-- Is Called on Player stream in

local function SendPlayerSkin(requesterId, playerId)
    print("Cloth request by "..requesterId.." for "..playerId)
    if players[playerId] and players[playerId].skin then
        print("Delayed skin sending")
        CallRemoteEvent(requesterId, "OGK:CLOTHING:ReceivePlayerClothes", playerId, players[playerId].skin)
    else
        print("Delayed skin sending")
        Delay(2000, function() 
            SendPlayerSkin(requesterId, playerId)
        end)
    end
end
AddRemoteEvent("OGK:CLOTHING:AskPlayerClothes", SendPlayerSkin)


-- Is called on player spawn so evryone that would have missed it gets the clothing of the person
AddEvent("OnPlayerSpawn", function(playerid)
    local defaultCloth = 1
    -- Avoids nude players
    for _, v in ipairs(GetAllPlayers()) do
        local assigned_cloth -- Production bug found during playtest
        if (players[v]) then
            assigned_cloth = players[v].skin
        else
            assigned_cloth = defaultCloth
        end

        CallRemoteEvent(playerid, "OGK:CLOTHING:ReceivePlayerClothes", v, assigned_cloth) -- set la tenu des joueurs pour le joueur
        CallRemoteEvent(v, "OGK:CLOTHING:ReceivePlayerClothes", playerid, players[playerid].skin) -- set la tenue du joueur pour les autres joueurs
    end
end)

