function UpdatePlayerInfo(level)
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
	Scoreboard.showWinner(winner)
end)

function ThrowFirework(x, y, z)
	for i=1,12 do 
		CreateFireworks(i, x, y, z + 600, 60.0 + i * 5.0, 0.0, 0.0)
	end
end

function OpenScoreboard()
	CallRemoteEvent("GetScoreBoardData")
	Scoreboard.setVisibility(WEB_VISIBLE)
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
		Scoreboard.setVisibility(WEB_HIDDEN)
	end
end
AddEvent("OnKeyRelease", OnKeyRelease)

function OnPlayerSpawn(playerid)
		Scoreboard.setVisibility(WEB_HIDDEN)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)

function OnPackageStart()
	ShowHealthHUD(false)
	ShowWeaponHUD(false)
	
	HUD.init()
	Scoreboard.init()
	

	-- Someone found fix, ask discord
	-- here is the fix
	EnableFirstPersonCamera(true)
	SetNearClipPlane(15)
	
end
AddEvent("OnPackageStart", OnPackageStart)


