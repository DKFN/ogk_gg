OGK_GG_DEBUG = true

players = {}
player_count = 0

-- current_map = "armory"
current_map = "armory"

avaible_map = {"western", "armory"} -- "paradise_ville", "chemistry"}
avaible_map_count = 2
last_map = 2

function assign_spawn(player)
    local spawn_location = spawns[current_map]
    local spawn_idx = Random(1, spawns_max[current_map])
    local assigned_spawn = spawn_location[spawn_idx]
    
    if spawn_idx == p["last_spawn_index"] then
        assign_spawn(player)
        return
    end
    p["last_spawn_index"] = assigned_spawn
    -- local assigned_spawn = spawn_location[Random(4, 4)]
    
    SetPlayerSpawnLocation( player, assigned_spawn[1], assigned_spawn[2], assigned_spawn[3] + (player * 10), 0 )
end

function OnPackageStart()
    LoadMap()
end
AddEvent("OnPackageStart", OnPackageStart)

-- This function is responsible to check synchronisation state between client and server because Talos broke something T_T
AddRemoteEvent("PlayerCheckWeaponSynchro", function(player, weapon, equipped_slot)
    local weaponid = players[player].weapon
    if Ladder.getWeaponId(weaponid) ~= weapon then
        RefreshWeapons(player)
        -- print("Refreshing weapons for player " .. player .. " Supposed weapon : " .. weapon .. " Current : " .. weaponid)
    end
end)

-- Reassigns player weapon to current level weapon
function RefreshWeapons(killer)
    SetPlayerAnimation(killer, "STOP")
    local wpn = players[killer].weapon

    SetPlayerWeapon(killer, 1, 200, false, 1, false) -- Fixes the need to reload the weapon

    EquipPlayerWeaponSlot(killer, 2)
    SetPlayerWeapon(killer, Ladder.getWeaponId(wpn), Ladder.getWeaponStartAmmo(wpn), true, 1, true)

end
AddRemoteEvent("OnPlayerPressReload", RefreshWeapons)

function level_up(killer)
    if(players[killer].weapon ~= Ladder.getLevelMax()) then
        if (GetPlayerWeapon(killer, 1) ~= Ladder.getWeaponId(players[killer].weapon)) then
            return
        end
        
        local tmp =  players[killer].weapon + 1 -- upgrade the killer weapon
        players[killer].weapon = tmp
        CallRemoteEvent(killer, "PlayerChangeLevel", tostring(players[killer].weapon))
    else
        CallEvent("PlayerWin", killer)
    end
end

-- This function waits until the plays does not AIM and will then change the level of the player
function OnPlayerDeath(player, instigator)
    assign_spawn(player)
    for _, plyr in pairs(GetAllPlayers()) do
        CallRemoteEvent(plyr, "AddFrag", GetPlayerName(instigator), "test", GetPlayerName(player))
    end
    
    players[player].deaths = players[player].deaths + 1
    -- Prevents suicide
    if player == instigator then
        return 
    end

    players[instigator].kills = players[instigator].kills + 1

    -- Do not call 
    level_up(instigator)
end

AddEvent("OnPlayerDeath", OnPlayerDeath)

function OnPlayerJoin(ply)
    player_count = player_count + 1
    AddPlayerChatAll("Coucou! " .. GetPlayerName(ply).. " Total: " .. player_count)
    
    -- initation du joueur de base
    p = {}
    p["level"] = 0
    p["kills"] = 0
    p["deaths"] = 0
    p["weapon"] = 1
    p["id"] = ply
    p["victory"] = 0
    p["fist_spawn"] = 1
    p["last_spawn_index"] = 0
    p["cloth"] = Random(2, 9)

    players[ply] = p

    SetPlayerHealth(ply, 99999) -- Avoids spawn kill
    if OGK_GG_DEBUG then
        AddPlayerChat( ply, '////DEBUG TOOLS/////')
        AddPlayerChat( ply, "up : To auto up 1 lvl")
        AddPlayerChat( ply, "warn : Displays aim warn message")
        AddPlayerChat( ply, "refresh : Refresh weapons assignements")
        AddPlayerChat( ply, "noclip : nonoclip to disable")
        AddPlayerChat( ply, "win : pay me a beer and insta win ze game")
    end

    AddPlayerChat( ply, "kill : suicide")
    players[ply]["fist_spawn"] = 1;
        
    -- Initial spawn
    assign_spawn(ply)
    
    -- True spawn in the game, fixes jump in the ocean on slow connections
    Delay(1500, function()
        SetPlayerHealth(ply, 0)
    end)
end
AddEvent("OnPlayerJoin", OnPlayerJoin)

AddEvent("OnPlayerQuit", function(player)
    player_count = player_count - 1
end)

    
function OnPlayerSpawn(playerid)
    -- First spawn setup
    if players[playerid]["fist_spawn"] == 1 then
        SetPlayerPropertyValue(playerid, "weapons_name", 1, true)

        players[playerid]["fist_spawn"] = 0;
        Delay(700, function()
            SetPlayerSpectate(playerid, true)
            CallRemoteEvent(playerid, "PlayerChangeLevel", 1)
        end)
    end

    local defaultCloth = 1
    -- Avoids nude players
    for _, v in ipairs(GetAllPlayers()) do
        local assigned_cloth -- Production bug found during playtest
        if (players[v]) then
            assigned_cloth = players[v].cloth
        else
            assigned_cloth = defaultCloth
        end

        CallRemoteEvent(playerid, "setClothe", playerid, assigned_cloth) -- set la tenu des joueurs pour le joueur
        CallRemoteEvent(v, "setClothe", playerid, players[playerid].cloth) -- set la tenue du joueur pour les autres joueurs
    end

    -- Anti spawn kill enable
    SetPlayerSpectate(playerid, false)
    SetPlayerHealth(playerid, 9999)
    -- AddPlayerChat(playerid, "Anti Spawn Kill: actif")

    -- After spawn operations
    Delay(50, function()
        -- Changin weapons for player
        local level = players[playerid].weapon
        CallRemoteEvent(playerid, "PlayerChangeLevel", players[playerid].weapon) -- Affiche le niveau du joueur
        SetPlayerWeapon(playerid, Ladder.getWeaponId(level), Ladder.getWeaponStartAmmo(level), true, 1, true)
    end)

    -- Anti spawn kill disable
    Delay(2000, function()
        SetPlayerHealth(playerid, 100)
    end)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn) -- spawn and respawn handle the player die and downgrade 

AddEvent("PlayerWin", function(winner)

    local next_map = Random(1, avaible_map_count)

    -- TODO: Refactor with a while
    if(next_map ~= last_map) then
        current_map = avaible_map[next_map]
        last_map = next_map
        
        local max_players_next = spawns_max[current_map]

        if(max_players_next < GetPlayerCount()) then
           CallEvent('PlayerWin', winner)
           return
        end
        
    else
        CallEvent('PlayerWin', winner)
        return
    end
    
    local winner_name = GetPlayerName(winner)

    players[winner].victory = players[winner].victory + 1 -- add 1 to player victory count

    local x, y, z = GetPlayerLocation(winner)

    for _, v in ipairs(GetAllPlayers()) do
        CallRemoteEvent(v, "NotifyPlayerWin", winner_name, x, y, z)

        Delay(8000, function()
            SetPlayerHealth(v, 0)
            players[v].kills = 0
            players[v].deaths = 0
            players[v].weapon = 1
            CallRemoteEvent(v, "GameRestarting")
        end)
    end

end)
