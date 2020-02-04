-- OGK Common Utils - Spawn Protection

-- Author: DeadlyKungFu.Ninja
local SPAWN_PROTECTION_DEBUG = true
local OGK_SPAWN_PROTECTION_TIMEOUT = 4000
local function _print(message)
    if SPAWN_PROTECTION_DEBUG then
        print(message)
    end
end

function OGK_spwn_SetPlayerActive(playerid)
    if GetPlayerHealth(playerid) > 100 then
        CallRemoteEvent(playerid, "OGK:SPAWNPROTECTION:ChangeProtectionValue", false)
        SetPlayerHealth(playerid, 100)
    end
end

function OGK_spwn_SetPlayerProtected(playerid)
    CallRemoteEvent(playerid, "OGK:SPAWNPROTECTION:ChangeProtectionValue", true)
    SetPlayerHealth(playerid, 9999)
    -- Anti spawn kill force-disable
    Delay(OGK_SPAWN_PROTECTION_TIMEOUT, function()
        OGK_spwn_SetPlayerActive(playerid)
    end)
end

AddRemoteEvent("OGK:SPAWNPROTECTION:NotifyPlayerActive", OGK_spwn_SetPlayerActive)
AddEvent("OGK:SPAWNPROTECTION:SetPlayerActive", OGK_spwn_SetPlayerActive)
AddEvent("OGK:SPAWNPROTECTION:SetPlayerProtected", OGK_spwn_SetPlayerProtected)
