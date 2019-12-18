function GetScoreBoardData(player) 
	local serverName = GetServerName()
	local PlayerTable = { }

	for k, v in ipairs(GetAllPlayers()) do
		if (players[v]~= nil) then
			PlayerTable[k] = {
				GetPlayerName(v),
				players[v].weapon,
				players[v].kills,
				players[v].deaths
			}
		end
	end
	CallRemoteEvent(player, "SetScoreBoardData", serverName, PlayerTable)
end
AddRemoteEvent("GetScoreBoardData", GetScoreBoardData)

function GetWeaponName(player) 
	-- current weapon id
	local tmp = players[player].weapon
	local tmp_weapon = ""
	local tmp_next = ""

	if(tmp ~= MAX_WEAPONS) then
		
		-- current weapon name
		tmp_weapon = weapons_name[tmp]
		
		-- next weapon name
		tmp_next = weapons_name[tmp + 1]

	else
		tmp_weapon = "1 SHOT GUN"

		tmp_next = "WIN"
	end

	CallRemoteEvent(player, "SetUIData", tmp_weapon, tmp_next)


end
AddRemoteEvent("GetWeaponName", GetWeaponName)
