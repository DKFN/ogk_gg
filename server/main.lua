-- steam_id: number KEY
-- kills: Number
-- deaths: Number
-- level : number
-- weapon : String 
-- ex: players[1] = {}
 
players = {}
local weapons = { 2, 6, 8, 4, 9, 10, 11}
local current_map = "western"

positions = {}

spawns = {}
spawns["western"] = {}
spawns["western"][1] = {-76573.953125, -164022.0625, 3319.1821289063, 0}

function OnPackageStart()
    LoadMap()
end
AddEvent("OnPackageStart", OnPackageStart)

function RefreshWeapons(killer) 
    -- SetPlayerWeapon(killer, 1, 200, true, 1, true)
    local wpn = weapons[players[killer].weapon]
    AddPlayerChat(killer, "Assigning .... " .. wpn)
    SetPlayerAnimation(killer, "STOP")
    EquipPlayerWeaponSlot(killer, 2)
    SetPlayerWeapon(killer, wpn, 200, true, 1, true)
    Delay(1000, function()
        EquipPlayerWeaponSlot(killer, 1)
    end)
end
AddRemoteEvent("OnPlayerPressReload", RefreshWeapons)

function level_up(killer)
    if(players[killer].weapon ~= 4) then
        local tmp =  players[killer].weapon + 1 -- upgrade the killer weapon
        players[killer].weapon = tmp
        players[killer].kills = players[killer].kills + 1
        AddPlayerChat(killer, "LEVEL UP Weapon level: " .. players[killer].weapon)
    end
end

-- This function waits until the plays does not AIM and will then change the level of the player
function try_autoPass(instigator)
    Delay(20, function()
        if IsPlayerAiming(instigator) then
            CallRemoteEvent(instigator, "WarnNextLevel")
            try_autoPass(instigator)
        else
            RefreshWeapons(instigator)
        end
    end)
end

function OnPlayerDeath(player, instigator)
    -- TODO: Before level up check that player has changed weapon and not on previous one
    level_up(instigator)

    players[instigator].kills = players[instigator].kills + 1
    players[player].deaths = players[player].deaths + 1

    for _, plyr in pairs(GetAllPlayers()) do
        CallRemoteEvent(plyr, "AddFrag", instigator, "test", player)
    end

    try_autoPass(instigator)
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

    if command == "up" then
        AddPlayerChat(player, "Simulating kill")
        OnPlayerDeath(1, player)
    end

    if command == "warn" then
        CallRemoteEvent(player, "WarnNextLevel")
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

    players[ply] = p

    local spawn_location = spawns[current_map]
    SetPlayerSpawnLocation( ply, spawn_location[1][1], spawn_location[1][2], spawn_location[1][3], 0 )
end
AddEvent("OnPlayerJoin", OnPlayerJoin)
    
function OnPlayerSpawn(playerid)
    SetPlayerWeapon(playerid, weapons[players[playerid].weapon], 200, true, 1, true)
    CallRemoteEvent(playerid, "setClothe", playerid) -- set la tenue du joueur
    AddPlayerChat( playerid, "You are level " .. players[playerid].weapon) -- Affiche le niveau du joueur
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn) -- spawn and respawn handle the player die and downgrade 
