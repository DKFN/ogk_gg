-- OGK Common Utils - Clothing

-- Author: DeadlyKungFu.Ninja

function setClothe(player, clothId)
	SetPlayerClothingPreset(player, clothId)
end
AddRemoteEvent("OGK:CLOTHING:ReceivePlayerClothes", setClothe)

AddEvent("OnPlayerStreamIn", function(player, otherplayer)
    CallRemoteEvent("OGK:CLOTHING:AskPlayerClothes", player, otherplayer)
end)

