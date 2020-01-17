-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz
local OMG = ImportPackage("omg")

OGK_GG_DEBUG = true

players = {}
player_count = 0

-- current_map = "armory"
-- current_map = "western"
-- current_map = "port"
-- current_map = "spawn_zone"
-- current_map = "gg2"
-- current_map = "trucks_center"
current_map = "tropico"
-- current_map = "alien_attack"
-- current_map = "hangar"

avaible_map = {"western", "armory", "port", "port_small", "trucks_center", "tropico", "alien_attack"} -- "paradise_ville", "chemistry"}
avaible_map_count = 7
last_map = 6
gmid = 0

function assign_spawn(player)
    local spawn_location = spawns[current_map]
    local spawn_idx = Random(1, spawns_max[current_map])
    local assigned_spawn = spawn_location[spawn_idx]
    
    if spawn_idx == p["last_spawn_index"] then
        print("Reassigning spawn ....")
        assign_spawn(player)
        return
    end
    p["last_spawn_index"] = spawn_idx
    if OGK_GG_DEBUG then
        AddPlayerChat(player, "You are assigned spawn #".. spawn_idx.. "")
    end
    -- local assigned_spawn = spawn_location[Random(1, 1]
    
    SetPlayerSpawnLocation(player, assigned_spawn[1], assigned_spawn[2], assigned_spawn[3] + (player * 10), assigned_spawn[4])
end

function OnPackageStart()
	LoadMapFromIni("packages/ogk_gg/maps/armory.ini")
	LoadMapFromIni("packages/ogk_gg/maps/gg2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock1.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock3.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock4.ini")
	LoadMapFromIni("packages/ogk_gg/maps/ports1.ini")
	LoadMapFromIni("packages/ogk_gg/maps/ports2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/ports_murs.ini")
	LoadMapFromIni("packages/ogk_gg/maps/port_objects.ini")
	LoadMapFromIni("packages/ogk_gg/maps/port_small.ini")
	LoadMapFromIni("packages/ogk_gg/maps/spawn_zone.ini")
	LoadMapFromIni("packages/ogk_gg/maps/trucks.ini")
	LoadMapFromIni("packages/ogk_gg/maps/trucks2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/trucks3.ini")
	LoadMapFromIni("packages/ogk_gg/maps/tropico_walls.ini")
	LoadMapFromIni("packages/ogk_gg/maps/tropico_objects.ini")
	LoadMapFromIni("packages/ogk_gg/maps/tropicofixblocks.ini")
	LoadMapFromIni("packages/ogk_gg/maps/tropicofix2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/hangar.ini")
	LoadMapFromIni("packages/ogk_gg/maps/hangarwalls.ini")
    LoadMapFromIni("packages/ogk_gg/maps/hangar_spawns.ini")
    
    if not OMG then
        print("OMG IS NOT SETUP CORRECTLY")
        print("GAMEMODE WILL NOT WORK")
    end
    gmId = OMG.Register("GG", { author = "OGK", fullName = "GunGame DeathMatch!" })
end
AddEvent("OnPackageStart", OnPackageStart)

-- This function is responsible to check synchronisation state between client and server
AddRemoteEvent("OMG:GG:PlayerCheckWeaponSynchro", function(player, weapon, equipped_slot)
    local weaponid = players[player].weapon
    if weaponid ~= 0 and Ladder.getWeaponId(weaponid) ~= weapon then
        RefreshWeapons(player)
    end
end)

-- Reassigns player weapon to current level weapon
function RefreshWeapons(killer)
    SetPlayerAnimation(killer, 0)
    local wpn = players[killer].weapon

    SetPlayerWeapon(killer, 1, 200, false, 1, false) -- Fixes the need to reload the weapon
    SetPlayerAnimation(killer, 0)

    EquipPlayerWeaponSlot(killer, 2)
    SetPlayerWeapon(killer, Ladder.getWeaponId(wpn), Ladder.getWeaponStartAmmo(wpn), true, 1, true)
    SetPlayerAnimation(killer, 0)

end
AddRemoteEvent("OMG:GG:OnPlayerPressReload", RefreshWeapons)

function level_up(killer)
    if(players[killer].weapon ~= Ladder.getLevelMax()) then
        if (GetPlayerWeapon(killer, 1) ~= Ladder.getWeaponId(players[killer].weapon)) then
            return
        end
        
        local tmp =  players[killer].weapon + 1 -- upgrade the killer weapon
        players[killer].weapon = tmp
        CallRemoteEvent(killer, "PlayLevelUp")
        CallRemoteEvent(killer, "PlayerChangeLevel", tostring(players[killer].weapon))
    else
        CallEvent("PlayerWin", killer)
    end
end

-- This function waits until the plays does not AIM and will then change the level of the player
function OnPlayerDeath(player, instigator)
    local OMG = ImportPackage("omg")
    print("ON PLAYER DEATH")
    _.print(OMG.GetAllPlayers_U(gmId))
    _.print(OMG.GetAllPlayers(gmId))
    for k, v in ipairs(OMG.GetAllPlayers_U(gmId)) do
        print(" Sending kill for "..v)
    end
    SetPlayerSpectate(player, true)
    local player_data = players[player]
    if player_data and player_data.ingame == true then
        assign_spawn(player)
        for v in OMG.GetAllPlayers(gmId) do
            print("PlayerDeath Assign"..v)
            local ply_weapon = players[instigator].weapon
            if player == instigator then
                ply_weapon = 0
            end
            CallRemoteEvent(v, "AddFrag", GetPlayerName(instigator), ply_weapon, GetPlayerName(player))
        end
        
        players[player].deaths = players[player].deaths + 1
        -- Prevents suicide
        if player == instigator then
            return 
        end

        players[instigator].kills = players[instigator].kills + 1
        level_up(instigator)
    end
end

AddEvent("OMG:GG:OnPlayerDeath", OnPlayerDeath)

function OnPlayerJoin(ply)
    print("Joined"..ply)
    AddPlayerChatAll("Hey ! " .. GetPlayerName(ply))
    
    -- initation du joueur de base
    p = {}
    p["level"] = 0
    p["kills"] = 0
    p["deaths"] = 0
    p["weapon"] = 0
    p["id"] = ply
    p["victory"] = 0
    p["ingame"] = false
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
        
    SetPlayerRespawnTime(ply, 5000)
    local plyrs = OMG.GetAllPlayers_U(gmId)
    local plyrsSafe = OMG.GetAllPlayers(gmId)
    _.print(plyrs)
    _.print(plyrsSafe)
    for k, v in ipairs(plyrs) do
        print(v)
    end

    -- Initial spawn
    -- assign_spawn(ply)
    local initial_player_spawn = spawns["spawn_zone"][1]
    SetPlayerLocation(ply, initial_player_spawn[1], initial_player_spawn[2], initial_player_spawn[3] + (ply * 10), initial_player_spawn[4])
end
AddEvent("OMG:GG:OnPlayerJoin", OnPlayerJoin)

AddEvent("OMG:GG:OnPlayerQuit", function(player)
    players[player] = nil
    for _,v in ipairs(OMG.GetAllPlayers(gmId)) do
        CallRemoteEvent(v, "PlayerQuit", player)
    end
end)

CreateTimer(function()
    local allPlayers = OMG.GetAllPlayers(gmId)
    print("GG Players : ")
    _.print(allPlayers)
end, 2000)

function OnPlayerSpawn(playerid)
    print("Player joined")
    -- TODO: This is not the best event to specify that
    local defaultCloth = 1
    local allPlayers = OMG.GetAllPlayers(gmId)
    local allPlayersU = OMG.GetAllPlayers_U(gmId)
    print(allPlayers)
    print(allPlayersU)
    -- Avoids nude players
    for _, v in ipairs(allPlayers) do
        local assigned_cloth -- Production bug found during playtest
        if (players[v]) then
            assigned_cloth = players[v].cloth
        else
            assigned_cloth = defaultCloth
        end
        print("Assigning da clothes ..."..v)
        CallRemoteEvent(playerid, "setClothe", v, assigned_cloth) -- set la tenu des joueurs pour le joueur
        CallRemoteEvent(v, "setClothe", playerid, players[playerid].cloth) -- set la tenue du joueur pour les autres joueurs
    end

    -- Anti spawn kill enable
    SetPlayerSpectate(playerid, false)
    SetPlayerHealth(playerid, 9999)
    -- AddPlayerChat(playerid, "Anti Spawn Kill: actif")

    -- After spawn operations
    if players[playerid]["ingame"] == true then
        Delay(50, function()
            -- Changin weapons for player
            local level = players[playerid].weapon
            CallRemoteEvent(playerid, "PlayerChangeLevel", players[playerid].weapon) -- Affiche le niveau du joueur
            SetPlayerWeapon(playerid, Ladder.getWeaponId(level), Ladder.getWeaponStartAmmo(level), true, 1, true)

            -- Exploit prevention (Thanks Jan)
            SetPlayerWeapon(playerid, 1, 0, false, 2, false)
            SetPlayerWeapon(playerid, 1, 0, false, 3, false)
        end)

        -- Anti spawn kill disable
        Delay(4000, function()            
            SetPlayerHealth(playerid, 100)
        end)
    end
end
AddEvent("OMG:GG:OnPlayerSpawn", OnPlayerSpawn) -- spawn and respawn handle the player die and downgrade 

-- Player avatars Leaderboard
AddEvent("OMG:GG:OnPlayerSteamAuth", function(playerid)
    CallEvent("GetPlayerSummaryInfo", playerid)
    Delay(10000, function()
        CallEvent("PushPlayerAvatars")
    end)
end)

AddRemoteEvent("OMG:GG:PlayerReady", function(player)
    if not players[player].ingame then
        AddPlayerChat(player, "Received ready message")
        SetPlayerHealth(player, 0)
        SetPlayerSpectate(player, true)
        assign_spawn(player)
        players[player]["fist_spawn"] = 0;
        players[player]["ingame"] = true;
        players[player]["weapon"] = 1;
        SetPlayerPropertyValue(player, "weapons_name", 1, true)
        CallRemoteEvent(player, "PlayerChangeLevel", 1)
    end
end)

AddEvent("OMG:GG:PlayerWin", function(winner)  
    -- Notify player win 
    local winner_name = GetPlayerName(winner)

    players[winner].victory = players[winner].victory + 1 -- add 1 to player victory count

    local x, y, z = GetPlayerLocation(winner)

    CallRemoteEvent(winner, "PlayerIsWinner")

    spawnPickupsItems()

    Delay(10000, function()
        CallEvent("StartVoteMap")
    end)

    for _, v in ipairs(OMG.GetAllPlayers(gmId)) do
        SetPlayerSpectate(v, true)
        CallRemoteEvent(v, "NotifyPlayerWin", winner_name, x, y, z)

        if v ~= winner then
            CallRemoteEvent(v, "PlayerIsLooser")
        end

        Delay(10000, function()
            if players[v] then
                players[v].kills = 0
                players[v].deaths = 0
                players[v].weapon = 1
            end
        end)
    end
end)
