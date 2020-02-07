-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz

OGK_GG_DEBUG = true

function notifyServerOfCurrentWeapon()
	local equipped_slot = GetPlayerEquippedWeaponSlot()
	local weapon, ammo = GetPlayerWeapon() -- Do not put equipped slot as we swap users slot as hack
	CallRemoteEvent("PlayerCheckWeaponSynchro", weapon, equipped_slot)	
end

-- Watchers
local shift_delay_id
function weapon_refresher()
	CreateTimer(function()
	notifyServerOfCurrentWeapon()
    end, 70)
end

function sprint_watchter()
end

function ui_refresher()
	CreateTimer(function()
		CallRemoteEvent("GetWeaponName")
	end, 1000) -- 15ms is a bit too much
end


AddEvent("OnPackageStart", function()
	weapon_refresher()
	ui_refresher()
	MOTDInit()
	-- EnableSnowParticles(true)	
	-- SetLandscapeSnowAlpha(1)
end)
