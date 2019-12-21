-- Hard coded player state, next step create a user object which have a state and a GUI
local Player = {state = "game"}

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
	WebUIManager.setVisibility("hud", Player.state, WEB_HIDDEN)
	WebUIManager.getGUI("scoreboard").showWinner(winner)
end)

function ThrowFirework(x, y, z)
	for i=1,12 do 
		CreateFireworks(i, x, y, z + 600, 60.0 + i * 5.0, 0.0, 0.0)
	end
end

function OpenScoreboard()
	CallRemoteEvent("GetScoreBoardData")
	WebUIManager.setVisibility("scoreboard", Player.state, WEB_VISIBLE)
end

-- Client Sent Events
function OnKeyPress(key)
	if key == "Tab" then
		OpenScoreboard()
		WebUIManager.setVisibility("hud", Player.state, WEB_HIDDEN)
	end

	if OGK_GG_DEBUG then
		-- Map editor toogle down HUD
		if key == "O" then
			WebUIManager.setVisibility("hud", Player.state, WEB_HIDDEN)
		end
	end
end
AddEvent("OnKeyPress", OnKeyPress)

function OnKeyRelease(key)
	if key == "Tab" then
		WebUIManager.setVisibility("hud", Player.state, WEB_VISIBLE)
		WebUIManager.setVisibility("scoreboard", Player.state, WEB_HIDDEN)
	end
end
AddEvent("OnKeyRelease", OnKeyRelease)

function OnPlayerSpawn(playerid)
	WebUIManager.setVisibility("scoreboard", Player.state, WEB_HIDDEN)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)

function OnPackageStart()
	ShowHealthHUD(false)
	ShowWeaponHUD(false)
	
	WebUIManager.init()
	
	-- Someone found fix, ask discord
	-- here is the fix
	EnableFirstPersonCamera(true)
	SetNearClipPlane(15)
	
end
AddEvent("OnPackageStart", OnPackageStart)
