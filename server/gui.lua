function GetScoreBoardData(player) 
	local serverName = GetServerName()
	CallRemoteEvent(player, "SetScoreBoardData", serverName)
	AddPlayerChatAll("Received the message !" .. serverName)
end
AddRemoteEvent("GetScoreBoardData", GetScoreBoardData)
