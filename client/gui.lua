-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz 

-- Hard coded player state, next step create a user object which have a state and a GUI
local Player = {state = "game"}

function UpdatePlayerInfo(level)
	local weapon = GetPlayerWeapon()
end
AddRemoteEvent("UpdatePlayerInfo", UpdatePlayerInfo) 

AddRemoteEvent("WelcomeToServer", function()
	AddPlayerChat('TELEPORTATION DANS LA PARTIE')
end)

AddRemoteEvent("NotifyPlayerWin", function(winner, x, y, z)
	ThrowFirework(x, y, z)
	OpenScoreboard()
	SetWebVisibility(hud, WEB_HIDDEN)
    SetWebVisibility(leaderboard, WEB_VISIBLE)
	SetWebVisibility(scoreboard, WEB_VISIBLE)
    ExecuteWebJS(scoreboard, "PlayerWonGame('"..winner.."')")
end)

function ThrowFirework(x, y, z)
	for i=1,12 do 
		CreateFireworks(i, x, y, z + 600, 60.0 + i * 5.0, 0.0, 0.0)
	end
end

function OpenScoreboard()
	CallRemoteEvent("GetScoreBoardData")
	SetWebVisibility(scoreboard, WEB_HITINVISIBLE)
end

-- Client Sent Events
function OnKeyPress(key)
	if key == "Tab" then
		OpenScoreboard()
		SetWebVisibility(hud, WEB_HIDDEN)
		SetWebVisibility(leaderboard, WEB_HIDDEN)
	end

	if OGK_GG_DEBUG then
		-- Map editor toogle down HUD
		if key == "O" then
			SetWebVisibility(hud, WEB_HIDDEN)
			SetWebVisibility(leaderboard, WEB_HIDDEN)
		end
	end
end
AddEvent("OnKeyPress", OnKeyPress)

function OnKeyRelease(key)
	if key == "Tab" then
		SetWebVisibility(hud, WEB_VISIBLE)
		SetWebVisibility(leaderboard, WEB_VISIBLE)
		SetWebVisibility(scoreboard, WEB_HIDDEN)
	end
end
AddEvent("OnKeyRelease", OnKeyRelease)

function OnPlayerSpawn(playerid)
	SetWebVisibility(scoreboard, WEB_HIDDEN)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)

function OnPackageStart()
	ScoreboardInit()
	ShowHealthHUD(false)
	ShowWeaponHUD(false)
	
	GameLeaderboardInit()
	HUDInit()
	
	-- Someone found fix, ask discord
	-- here is the fix thx Logic
	-- EnableFirstPersonCamera(true)
	-- SetNearClipPlane(15)
	
end
AddEvent("OnPackageStart", OnPackageStart)

AddEvent("OGK:HIT_LOCATION:HitLocation", function(hitLocation)
	ExecuteWebJS(hud, "DisplayHit('"..hitLocation.."')")
end)
