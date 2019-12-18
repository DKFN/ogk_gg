function GetScoreBoardData(player) 
	local serverName = GetServerName()
	local PlayerTable = { }

	for k, v in ipairs(GetAllPlayers()) do
		PlayerTable[k] = {
			GetPlayerName(v),
			players[v].weapon,
			players[v].kills,
			players[v].deaths
		}
	end
	CallRemoteEvent(player, "SetScoreBoardData", serverName, PlayerTable)
end
AddRemoteEvent("GetScoreBoardData", GetScoreBoardData)

function GetWeaponName(player) 
	-- current weapon id
	local tmp = players[player].weapon
	local tmp_weapon = ""
	local tmp_next = ""

	tmp_weapon = Ladder.getWeaponName(tmp) 
	if(tmp ~= Ladder.getLevelMax()) then
		tmp_next = Ladder.getWeaponName(tmp + 1)
	else
		tmp_next = "WIN"
	end

	CallRemoteEvent(player, "SetUIData", tmp_weapon, tmp_next)


end
AddRemoteEvent("GetWeaponName", GetWeaponName)
