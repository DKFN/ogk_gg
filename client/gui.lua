local scoreboard

-- Server Sent Events
function SetScoreBoardData(servername, players) 
	ExecuteWebJS(scoreboard, "ServerVersion('"..servername.."')")
	ExecuteWebJS(scoreboard, "RemovePlayers()")

	-- table.sort(players, function(ply1, ply2)
	-- 	return ply1.kills > ply2.kills
	-- end)

	for k, v in pairs(players) do
		ExecuteWebJS(scoreboard, "AddPlayer('"..v[1].."', "..v[2]..", "..v[3]..", "..v[4].."," .. v[5] .. ")")
	end
end
AddRemoteEvent("SetScoreBoardData", SetScoreBoardData)

function UpdatePlayerInfo(level) 
	AddPlayerChat(level)
	local weapon = GetPlayerWeapon()
end
AddRemoteEvent("UpdatePlayerInfo", UpdatePlayerInfo) 

AddRemoteEvent("WelcomeToServer", function()
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
end)

AddRemoteEvent("NotifyPlayerWin", function(winner, x, y, z)
	ThrowFirework(x, y, z)
	OpenScoreboard()
	HUD.setVisibility(WEB_HIDDEN)
	ExecuteWebJS(scoreboard, "PlayerWonGame('"..winner.."')")
	Delay(8000, function()
		SetWebVisibility(scoreboard, WEB_HIDDEN) 
	end)
end)

function ThrowFirework(x, y, z)
	for i=1,12 do 
		CreateFireworks(i, x, y, z + 600, 60.0 + i * 5.0, 0.0, 0.0)
	end
end

function OpenScoreboard()
	CallRemoteEvent("GetScoreBoardData")
	SetWebVisibility(scoreboard, WEB_VISIBLE)
end

-- Client Sent Events
function OnKeyPress(key)
	if key == "Tab" then
		OpenScoreboard()
		HUD.setVisibility(WEB_HIDDEN)
	end

	if key == "O" then
		HUD.setVisibility(WEB_HIDDEN)
	end
end
AddEvent("OnKeyPress", OnKeyPress)

function OnKeyRelease(key)
	if key == "Tab" then
		HUD.setVisibility(WEB_VISIBLE)
		SetWebVisibility(scoreboard, WEB_HIDDEN)
	end
end
AddEvent("OnKeyRelease", OnKeyRelease)

function OnPlayerSpawn(playerid)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)

function OnPackageStart()
	HUD.init()

	scoreboard = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 10)
	LoadWebFile(scoreboard, "http://asset/ogk_gg/gui/scoreboard.html")
	SetWebAlignment(scoreboard, 0.0, 0.0)
	SetWebAnchors(scoreboard, 0.0, 0.0, 1.0, 1.0)
	SetWebVisibility(scoreboard, WEB_HIDDEN)
	ShowHealthHUD(false)
	ShowWeaponHUD(false)

	-- Someone found fix, ask discord
	-- here is the fix
	EnableFirstPersonCamera(true)
	SetNearClipPlane(15)
	
end
AddEvent("OnPackageStart", OnPackageStart)


