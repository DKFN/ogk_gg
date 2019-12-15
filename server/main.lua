-- steam_id: number KEY
-- kills: Number
-- deaths: Number
-- level : number
-- weapon : String 
-- ex: players[1] = {}
 
players = {}
local weapons = { 2, 6, 8, 12, 14, 15, 19, 20, 4 }
local MAX_WEAPONS = 9
local current_map = "western"

positions = {}

spawns = {}
spawns["western"] = {}
-- spawns["western"][1] = {-76523.953125, -164042.0625, 3340.1821289063, 0}
spawns["western"][1] = {-78409.382812, -165535.0625, 3218.9055175781, 0}
spawns["western"][2] = {-73164.578125, -163825.953425, 3341.1821289063, 0}
spawns["western"][3] = {-76183.953125, -159598.921875, 3350.1821289063, 0}
spawns["western"][4] = {-81129.953125, -159041.265625, 3220.026367, 0}
spawns["western"][5] = {-82072.0546875, -161787.203125, 3223.7658691406, 0}

function assign_spawn(player)
    local spawn_location = spawns[current_map]
    local assigned_spawn = spawn_location[Random(3, 3)]
    SetPlayerSpawnLocation( player, assigned_spawn[1], assigned_spawn[2], assigned_spawn[3], 0 )
end

function OnPackageStart()
    LoadMap()
end
AddEvent("OnPackageStart", OnPackageStart)

-- This function is responsible to check synchronisation state between client and server because Talos broke something T_T
AddRemoteEvent("PlayerCheckWeaponSynchro", function(player, weapon, equipped_slot)
    if weapons[players[player].weapon] ~= weapon then
        AddPlayerChat(player, "[DESYNCHRO WEAPON] PLY : "..player.." Weapon : ".. weapon .. "Supposed" .. players[player].weapon)
        AddPlayerChat(player, "[DESYNCHRO WEAPON] Reloading ...")
        CallRemoteEvent(player, "WarnDesynchro")
        RefreshWeapons(player)
    end
end)


function RefreshWeapons(killer)
    SetPlayerAnimation(killer, "STOP")
    local wpn = weapons[players[killer].weapon]
    AddPlayerChat(killer, "Assigning .... " .. wpn)
    SetPlayerAnimation(killer, "STOP")
    EquipPlayerWeaponSlot(killer, 2)
    SetPlayerWeapon(killer, wpn, 200, true, 1, true)
    SetPlayerAnimation(killer, "STOP")
    Delay(1000, function()
        EquipPlayerWeaponSlot(killer, 1)
    end)
end
AddRemoteEvent("OnPlayerPressReload", RefreshWeapons)

function level_up(killer)
    if(players[killer].weapon ~= MAX_WEAPONS) then
        local tmp =  players[killer].weapon + 1 -- upgrade the killer weapon
        players[killer].weapon = tmp
        players[killer].kills = players[killer].kills + 1
        CallRemoteEvent(killer, "PlayerChangeLevel", tostring(players[killer].weapon))
        -- AddPlayerChat(killer, "LEVEL UP Weapon level: " .. players[killer].weapon)
    end
end

-- This function waits until the plays does not AIM and will then change the level of the player
function OnPlayerDeath(player, instigator)
    assign_spawn(player)
    for _, plyr in pairs(GetAllPlayers()) do
        CallRemoteEvent(plyr, "AddFrag", GetPlayerName(instigator), "test", GetPlayerName(player))
    end
    -- Prevents suicide
    if player == instigator then
        return 
    end
    -- TODO: Before level up check that player has changed weapon and not on previous one
    level_up(instigator)

    players[instigator].kills = players[instigator].kills + 1
    players[player].deaths = players[player].deaths + 1

    RefreshWeapons(instigator)
end

AddEvent("OnPlayerDeath", OnPlayerDeath)

function OnPlayerChat(player, command, exists)
    -- Debug Commands
    if command == "nxt" then
        AddPlayerChat(player, "CMD getting to next ...")
        level_up(player)
    end
    if command == "refresh" then
        AddPlayerChat(player, "Refreshing weapons ...")
        RefreshWeapons(player)
    end

    if command == "warn" then
        CallRemoteEvent(player, "WarnNextLevel")
    end
    if command == "up" then
        OnPlayerDeath(player, player)
        level_up(player)
    end
end
AddEvent("OnPlayerChat", OnPlayerChat)


function OnPlayerJoin(ply)
    AddPlayerChatAll("Coucou! " .. GetPlayerName(ply))
    
    -- initation du joueur de base
    p = {}
    p["level"] = 0
    p["kills"] = 0
    p["deaths"] = 0
    p["weapon"] = 1
    p["id"] = ply
    p["fist_spawn"] = 1;

    players[ply] = p

    SetPlayerHealth(ply, 99999) -- Avoids spawn kill
    AddPlayerChat( ply, '////DEBUG TOOLS/////')
    AddPlayerChat( ply, "up : To auto up 1 lvl")
    AddPlayerChat( ply, "warn : Displays aim warn message")
    AddPlayerChat( ply, "refresh : Refresh weapons assignements")
    players[ply]["fist_spawn"] = 1;
        
    -- Initial spawn
    assign_spawn(ply)
    
    -- True spawn in the game, fixes jump in the ocean on slow connections
    Delay(1500, function()
        SetPlayerHealth(ply, 0)
    end)
    
end
AddEvent("OnPlayerJoin", OnPlayerJoin)
    
function OnPlayerSpawn(playerid)
    if players[playerid]["fist_spawn"] == 1 then
        players[playerid]["fist_spawn"] = 0;
        Delay(700, function()
            SetPlayerSpectate(playerid, true)
            CallRemoteEvent(playerid, "PlayerChangeLevel", 1)
        end)
    end

    SetPlayerSpectate(playerid, false)
    SetPlayerHealth(playerid, 9999)
    AddPlayerChat(playerid, "Anti Spawn Kill: actif")
    Delay(50, function()
        CallRemoteEvent(playerid, "JoiningParty")
        local wpn = weapons[players[playerid].weapon]
        SetPlayerWeapon(playerid, wpn, 200, true, 1, true)
        CallRemoteEvent(playerid, "setClothe", playerid) -- set la tenue du joueur
        AddPlayerChat( playerid, "You are level " .. players[playerid].weapon) -- Affiche le niveau du joueur
    end)
    Delay(1000, function()
        AddPlayerChat(playerid, "Anti Spawn Kill: inactif")
        SetPlayerHealth(playerid, 100)
    end)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn) -- spawn and respawn handle the player die and downgrade 
