local hud
local scoreboard

-- Server Sent Events
function SetScoreBoardData(servername, players) 
	ExecuteWebJS(scoreboard, "ServerVersion('"..servername.."')")
	ExecuteWebJS(scoreboard, "RemovePlayers()")

	for k, v in pairs(players) do
		ExecuteWebJS(scoreboard, "AddPlayer('"..v[1].."', "..v[2]..", "..v[3]..", "..v[4]..")")
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

function PlayerChangeLevel(newLevel)
	AddPlayerChat(newLevel)
	ExecuteWebJS(hud, "ChangePlayerLevel('"..newLevel.."')")
end
AddRemoteEvent("PlayerChangeLevel", PlayerChangeLevel)

AddRemoteEvent("WarnDesynchro", function()
	ExecuteWebJS(hud, "Warn('<span style=\"color:orange\">[LEVEL UP]</span>  ARME : <ICI ARME>')")
end)

AddRemoteEvent("GameRestarting", function()
	ExecuteWebJS(hud, "Warn('<span style=\"color:orange\">[ATTENTION]</span> LA PARTIE COMMENCE')")
end)

AddRemoteEvent("WelcomeToServer", function()
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
end)

AddRemoteEvent("NotifyPlayerWin", function(winner)
	OpenScoreboard()
	ExecuteWebJS(scoreboard, "PlayerWonGame('"..winner.."')")
	Delay(8000, function()
		SetWebVisibility(scoreboard, WEB_HIDDEN)
	end)
end)

function OpenScoreboard()
	CallRemoteEvent("GetScoreBoardData")
	SetWebVisibility(scoreboard, WEB_VISIBLE)
end

-- Client Sent Events
function OnKeyPress(key)
	if key == "Tab" then
		OpenScoreboard()
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

function refresh_health()
	local ply_health = GetPlayerHealth()
	local weapon, ammo, inmag = GetPlayerWeapon()
	ExecuteWebJS(hud, "RefreshPlayerBar("..ply_health..","..inmag..")")
end

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
	ShowWeaponHUD(false)
end
AddEvent("OnPackageStart", OnPackageStart)
