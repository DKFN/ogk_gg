function GetScoreBoardData(player) 
	local serverName = GetServerName()
	local PlayerTable = { }

	for t, v in ipairs(GetAllPlayers()) do
		PlayerTable[v] = {
			players[v].weapon,
			players[v].deaths,
			players[v].kills
		}
	end
	CallRemoteEvent(player, "SetScoreBoardData", serverName, PlayerTable)
end
AddRemoteEvent("GetScoreBoardData", GetScoreBoardData)
