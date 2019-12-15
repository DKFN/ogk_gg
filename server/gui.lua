function GetScoreBoardData(player) 
	local serverName = GetServerName()
	local PlayerTable = { }

	for t, v in ipairs(GetAllPlayers()) do
		PlayerTable[v] = {
			players[t].weapon,
			players[t].deaths,
			players[t].kills
		}
	end
	CallRemoteEvent(player, "SetScoreBoardData", serverName, PlayerTable)
end
AddRemoteEvent("GetScoreBoardData", GetScoreBoardData)
