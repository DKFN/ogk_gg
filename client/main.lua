--[[

This script contains the initial weapon configuration for the client.
Addtional configuration on the server is necessary.

]]--
function setClothe(player, clothId)
	SetPlayerClothingPreset(player, clothId)
end
AddRemoteEvent("setClothe", setClothe) 

function notifyServerOfCurrentWeapon()
	local equipped_slot = GetPlayerEquippedWeaponSlot()
	local weapon, ammo = GetPlayerWeapon() -- Do not put equipped slot as we swap users slot as hack
	CallRemoteEvent("PlayerCheckWeaponSynchro", weapon, equipped_slot)	
end

-- Watchers
function weapon_refresher()
	Delay(30, function()
		notifyServerOfCurrentWeapon()
        weapon_refresher()
    end)
end

function ui_refresher()
	Delay(5, function()
        refresh_health()
		ui_refresher()
	end)
end

AddEvent("OnPackageStart", function()
	weapon_refresher()
	ui_refresher()
end)

