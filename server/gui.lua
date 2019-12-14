function GetScoreBoardData(player) 
	local serverName = GetServerName()
	CallRemoteEvent(player, "SetScoreBoardData", serverName, GetPlayerName(player), players[player].weapon, players[player].deaths, players[player].kills)
	AddPlayerChatAll("Received the message !" .. serverName)
end
AddRemoteEvent("GetScoreBoardData", GetScoreBoardData)
