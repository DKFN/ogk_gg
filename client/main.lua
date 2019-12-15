--[[

This script contains the initial weapon configuration for the client.
Addtional configuration on the server is necessary.

]]--
function setClothe(player)
	SetPlayerClothingPreset(player, math.abs(5))
end
AddRemoteEvent("setClothe", setClothe) 