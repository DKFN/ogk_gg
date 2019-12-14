-- steam_id: number KEY
-- kills: Number
-- deaths: Number
-- level : number
-- weapon : String 
-- ex: players[1] = {}
 
players = {}
weapons = {2, 6, 8, 4}

positions = {}


function nextWeapons(playerid, instigator)

    if(players[instigator].weapon ~= 3) then
        next = players[instigator].weapon + 1  -- upgrade the killer weapon
        players[instigator].weapon = next
        
        SetPlayerWeapon(instigator, weapons[next], 200, true, 1, true)
        AddPlayerChat(instigator, "You kill someone, next weapons !" .. weapons[next])
    end
end
AddEvent("OnPlayerDeath", nextWeapons) -- handle the next weapon for the instigator


function OnPlayerJoin(ply)
    AddPlayerChatAll("Coucou! " .. ply)
    
    -- initation du joueur de base
    p = {}
    p["level"] = 0
    p["kills"] = 0
    p["deaths"] = 0
    p["weapon"] = 1
    p["steam_id"] = ply

    players[ply] = p

    SetPlayerSpawnLocation( ply, -76573.953125, -164022.0625, 3319.1821289063, 0 )
end
AddEvent("OnPlayerJoin", OnPlayerJoin)
    
function OnPlayerSpawn(playerid)

    if(players[playerid].weapon == 1) then
        SetPlayerWeapon(playerid, weapons[1], 200, true, 1, true) -- set l'arme du joueur 
    else
        last = players[playerid].weapon - 1

        SetPlayerWeapon(playerid, weapons[last] , 200, true, 1, true) -- set l'arme du joueur 
        AddPlayerChat(playerid, "You die, downgrade of your weapons ! " ..  weapon)
    end


    CallRemoteEvent(playerid, "setClothe", playerid) -- set la tenue du joueur
    AddPlayerChat( playerid, "You are level " .. players[playerid].level) -- Affiche le niveau du joueur
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn) -- spawn and respawn handle the player die and downgrade 