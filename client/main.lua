-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz

OGK_GG_DEBUG = true

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
local shift_delay_id
function weapon_refresher()
	CreateTimer(function()
		-- Sprint fixture, put into own function
		-- Fixes the unabillity to sprint + avoids player from chaging weapon to fists
		local equipped_slot = GetPlayerEquippedWeaponSlot()
		if IsShiftPressed() then
			if equipped_slot == 1 then
				CallRemoteEvent("Sprint")
				CallEvent("WarnShiftToRun")
			end
		else 
			if equipped_slot ~= 1 then
				-- Delays allows usr enough time to rpess twice
				Delay(300, function()
					if not IsShiftPressed() then
						CallRemoteEvent("SprintStopped")
					end
				end)
			end
		end
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


AddRemoteEvent("OMG:GG:OnPackageStart", function()
	weapon_refresher()
	ui_refresher()
	MOTDInit()
	-- EnableSnowParticles(true)	
	-- SetLandscapeSnowAlpha(1)
end)
