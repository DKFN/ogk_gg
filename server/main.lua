-- steam_id: number KEY
-- kills: Number
-- deaths: Number
-- level : number
-- last_weapon : String 
-- ex: players[1] = {}
 
players = {}

positions = {}

-- COMMAND TEST ANIMATION
AddCommand("animation", function(playerid, animation) -- animation id
    SetPlayerAnimation(playerid, animation)
    AddPlayerChat(playerid, "Test" .. playerid)
end)

function OnPlayerJoin(ply)
    AddPlayerChatAll("Coucou! " .. ply)
    
    -- initation du joueur de base
    p = {}
    p["level"] = 0
    p["kills"] = 0
    p["deaths"] = 0
    p["last_weapon"] = nil
    p["steam_id"] = ply

    players[ply] = p

    SetPlayerSpawnLocation( ply, -76573.953125, -164022.0625, 3319.1821289063, 0 )
end
AddEvent("OnPlayerJoin", OnPlayerJoin)
    
function OnPlayerSpawn(playerid)
    SetPlayerWeapon(playerid, 2, 200, true, 1, true) -- set l'arme du joueur 
    CallRemoteEvent(playerid, "setClothe", playerid) -- set la tenue du joueur
    AddPlayerChat( playerid, "You are level " .. players[playerid].level) -- Affiche le niveau du joueur
    
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)