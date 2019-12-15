local hud
local scoreboard

-- Server Sent Events
function SetScoreBoardData(servername, players) 
	ExecuteWebJS(scoreboard, "ServerVersion('"..servername.."')")
	ExecuteWebJS(scoreboard, "RemovePlayers()")

	for k, v in pairs(players) do
		ExecuteWebJS(scoreboard, "AddPlayer('"..GetPlayerName(k).."', "..v[1]..", "..v[2]..", "..v[3]..")")
	end
end
AddRemoteEvent("SetScoreBoardData", SetScoreBoardData)

function AddFrag(killer, weapon, victim)
	ExecuteWebJS(hud, "killfeed.registerKill('"..killer.."', '"..victim.."', 'TEST')")
end
AddRemoteEvent("AddFrag", AddFrag) 

function UpdatePlayerInfo(level) 
	AddPlayerChat(level)
	local weapon = GetPlayerWeapon()
end

AddRemoteEvent("UpdatePlayerInfo", UpdatePlayerInfo) 

AddRemoteEvent("WarnDesynchro", function()
	ExecuteWebJS(hud, "Warn('[LEVEL UP] NE VISEZ PLUS - NE RECHARGEZ PLUS')")
end)

AddRemoteEvent("WelcomeToServer", function()
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
end)

AddRemoteEvent("JoiningParty", function()
	ExecuteWebJS(hud, "Warn('Noubliez pas de recharger votre arme')")
end)

-- Client Sent Events
function OnKeyPress(key)
	if key == "Tab" then
		CallRemoteEvent("GetScoreBoardData")
		SetWebVisibility(scoreboard, WEB_VISIBLE)
	end

	if key == "O" then
		SetWebVisibility(hud, WEB_HIDDEN)
	end
end
AddEvent("OnKeyPress", OnKeyPress)

function OnKeyRelease(key)
	if key == "Tab" then
		SetWebVisibility(scoreboard, WEB_HIDDEN)
	end
end
AddEvent("OnKeyRelease", OnKeyRelease)

function OnPlayerSpawn(playerid)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)

function OnPackageStart()
	hud = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 10)
	LoadWebFile(hud, "http://asset/ogk_gg/gui/ui.html")
	SetWebAlignment(hud, 0.0, 0.0)
	SetWebAnchors(hud, 0.0, 0.0, 1.0, 1.0)
	SetWebVisibility(hud, WEB_VISIBLE)

	scoreboard = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 10)
	LoadWebFile(scoreboard, "http://asset/ogk_gg/gui/scoreboard.html")
	SetWebAlignment(scoreboard, 0.0, 0.0)
	SetWebAnchors(scoreboard, 0.0, 0.0, 1.0, 1.0)
	SetWebVisibility(scoreboard, WEB_HIDDEN)
	ShowHealthHUD(false)
end
AddEvent("OnPackageStart", OnPackageStart)
