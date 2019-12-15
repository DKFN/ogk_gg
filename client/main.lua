--[[

This script contains the initial weapon configuration for the client.
Addtional configuration on the server is necessary.

]]--
function setClothe(player)
	SetPlayerClothingPreset(player, math.abs(5))
end
AddRemoteEvent("setClothe", setClothe) 

function notifyServerOfCurrentWeapon()
	local equipped_slot = GetPlayerEquippedWeaponSlot()
	local weapon, ammo = GetPlayerWeapon()
	CallRemoteEvent("PlayerCheckWeaponSynchro", weapon, equipped_slot)	
end

function refresh_watcher()
	Delay(30, function()
		notifyServerOfCurrentWeapon()
        refresh_watcher()
    end)
end

AddEvent("OnPackageStart", function()
	refresh_watcher()
end)

