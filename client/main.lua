OGK_GG_DEBUG = true

function setClothe(player, clothId)
	SetPlayerClothingPreset(player, clothId)
end
AddRemoteEvent("setClothe", setClothe) 


-- TODO : Put in anorther package to avoid wide crashing
function notifyServerOfCurrentWeapon()
	local equipped_slot = GetPlayerEquippedWeaponSlot()
	local weapon, ammo = GetPlayerWeapon() -- Do not put equipped slot as we swap users slot as hack
	CallRemoteEvent("PlayerCheckWeaponSynchro", weapon, equipped_slot)	
end

-- Watchers
function weapon_refresher()
	CreateTimer(function()
		notifyServerOfCurrentWeapon()
    end, 70)
end

function ui_refresher()
	CreateTimer(function()
		CallRemoteEvent("GetWeaponName")
	end, 15)
end


AddEvent("OnPackageStart", function()
	weapon_refresher()
	ui_refresher()
end)
