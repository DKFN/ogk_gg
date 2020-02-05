-- OGK Common Utils - Clothing

-- Author: DeadlyKungFu.Ninja

-- Is Called on Player stream in
AddRemoteEvent("OGK:CLOTHING:AskPlayerClothes", function(requesterId, playerId)
    if Players[playerId] and Players[playerId].skin then
        CallRemoteEvent(requesterId, "OGK:CLOTHING:ReceivePlayerClothes", Players[playerId].skin)
    end
end)

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

