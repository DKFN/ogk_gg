function GetScoreBoardData(player) {
	CallRemoteEvent(player, "SendScoreBoardData", serverName)
	local serverName = GetServerName()
	AddPlayerChatAll("Received the message !" .. serverName)
}
AddRemoteEvent("GetScoreBoardData", GetScoreBoardData)
