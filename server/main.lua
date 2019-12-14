-- steam_id: number KEY
-- kills: Number
-- deaths: Number
-- level : number
-- weapon : String 
-- ex: players[1] = {}
 
players = {}
weapons = {2, 6, 8}

positions = {}


AddCommand("next", function(playerid)
    next = players[playerid].weapon + 1  
    players[playerid].weapon = next

    SetPlayerWeapon(playerid, weapons[next], 200, true, 1, true)
    AddPlayerChat(playerid, "You kill someone, next weapons !")
end)

-- COMMAND TEST ANIMATION
AddCommand("die", function(playerid, animation) -- animation id
    SetPlayerHealth(playerid, 0)
end)



function OnPlayerJoin(ply)
    AddPlayerChatAll("Coucou! " .. ply)
    
    -- initation du joueur de base
    p = {}
    p["level"] = 0
    p["kills"] = 0
    p["deaths"] = 0
    p["weapon"] = nil
    p["steam_id"] = ply

    players[ply] = p

    SetPlayerSpawnLocation( ply, -76573.953125, -164022.0625, 3319.1821289063, 0 )
end
AddEvent("OnPlayerJoin", OnPlayerJoin)
    
function OnPlayerSpawn(playerid)

    if(players[playerid].weapon == nil or players[playerid].weapon == 0) then
        SetPlayerWeapon(playerid, weapons[1], 200, true, 1, true) -- set l'arme du joueur 
        players[playerid].weapon = 1
    else
        weapon = players[playerid].weapon - 1
        
        players[playerid].weapon = weapon

        SetPlayerWeapon(playerid, weapons[weapon] , 200, true, 1, true) -- set l'arme du joueur 
        AddPlayerChat(playerid, "You die, downgrade of your weapons ! " ..  weapon)
    end


    CallRemoteEvent(playerid, "setClothe", playerid) -- set la tenue du joueur
    AddPlayerChat( playerid, "You are level " .. players[playerid].level) -- Affiche le niveau du joueur
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)