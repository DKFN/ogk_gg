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
	ExecuteWebJS(hud, "killfeed.registerKill('"..killer.."', '"..victim.."', '===>')")
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
	ExecuteWebJS(hud, "Warn('<span style=\"color:orange\">[LEVEL UP]</span>')")
end)

AddRemoteEvent("GameRestarting", function()
	ExecuteWebJS(hud, "Warn('<span style=\"color:orange\">[WARNING]</span> GAME STARTING')")
	SetWebVisibility(hud, WEB_VISIBLE)
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
	SetWebVisibility(hud, WEB_HIDDEN)
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
		SetWebVisibility(hud, WEB_HIDDEN)
	end

	if key == "O" then
		SetWebVisibility(hud, WEB_HIDDEN)
	end
end
AddEvent("OnKeyPress", OnKeyPress)

function OnKeyRelease(key)
	if key == "Tab" then
		SetWebVisibility(hud, WEB_VISIBLE)
		SetWebVisibility(scoreboard, WEB_HIDDEN)
	end
end
AddEvent("OnKeyRelease", OnKeyRelease)

function OnPlayerSpawn(playerid)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)

function SetUIData(weapon_name, weapon_next) 
	local ply_health = GetPlayerHealth()
	local weapon, ammo, inmag = GetPlayerWeapon()

	ExecuteWebJS(hud, "RefreshPlayerBar("..ply_health..","..inmag.. ",'" .. weapon_name .. "','" .. weapon_next .. "')")
end
AddRemoteEvent("SetUIData", SetUIData)

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
	-- Someone found fix, ask discord
	-- EnableFirstPersonCamera(true)
	
end
AddEvent("OnPackageStart", OnPackageStart)
