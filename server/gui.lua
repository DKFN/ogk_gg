function UpdateScoreboardData(playerid)
	local PlayerTable = { }
	
	for _, v in ipairs(GetAllPlayers()) do
		PlayerTable[v] = {
			GetPlayerName(v),
			GetPlayerIP(v),
			GetPlayerPing(v)
		}
	end
	
	CallRemoteEvent(playerid, "OnGetScoreboardData", GetServerName(), GetPlayerCount(), GetMaxPlayers(), PlayerTable)
end
AddRemoteEvent("UpdateScoreboardData", UpdateScoreboardData)