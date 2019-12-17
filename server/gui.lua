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
