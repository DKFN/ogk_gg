-- steam_id: number KEY
-- kills: Number
-- deaths: Number
-- level : number
-- weapon : String 
-- ex: players[1] = {}
 
players = {}
weapons = {2, 6, 8, 4}

positions = {}

spawns = {}
spawns["western"] = {}
spawns["western"][1] = {-76573.953125, -164022.0625, 3319.1821289063, 0}

function OnPackageStart()
    LoadMap()
end
AddEvent("OnPackageStart", OnPackageStart)

AddRemoteEvent("ChangeWeapon", function(playerid, killer)
    if(players[killer].weapon ~= 4) then
        next = players[killer].weapon + 1  -- upgrade the killer weapon
        players[killer].weapon = next
        SetPlayerWeapon(killer, 1, 200, true, 1, true)
        SetPlayerWeapon(killer, weapons[players[killer].weapon], 200, true, 1, true)
        
        AddPlayerChat(killer, "Reloading Weapons")
        AddPlayerChat(killer, "You kill someone, next weapons !" .. weapons[next])
        AddPlayerChat(killer, "Weapon level: " .. players[killer].weapon)
    end
end) 

function OnPlayerDeath(playerid, killer)
	CallEvent("ChangeWeapon", killer)
end
AddEvent("OnPlayerDeath", OnPlayerDeath)

function OnPlayerChatCommand(player, command, exists)
end
AddEvent("OnPlayerChatCommand", OnPlayerChatCommand);


function OnPlayerJoin(ply)
    AddPlayerChatAll("Coucou! " .. ply)
    
    -- initation du joueur de base
    p = {}
    p["level"] = 0
    p["kills"] = 0
    p["deaths"] = 0
    p["weapon"] = weapons[1]
    p["steam_id"] = ply

    players[ply] = p

    local spawn_location = spawns["western"]

    SetPlayerSpawnLocation( ply, spawn_location[1][1], spawn_location[1][2], spawn_location[1][3], 0 )
end
AddEvent("OnPlayerJoin", OnPlayerJoin)
    
function OnPlayerSpawn(playerid)
    SetPlayerWeapon(playerid, players[playerid].weapon, 200, true, 1, true)
    CallRemoteEvent(playerid, "setClothe", playerid) -- set la tenue du joueur
    AddPlayerChat( playerid, "You are level " .. players[playerid].level) -- Affiche le niveau du joueur
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn) -- spawn and respawn handle the player die and downgrade 
