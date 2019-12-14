
local hud
local scoreboard

function OnKeyPress(key)
	if key == "Tab" then

		-- fix visible bug
		if IsValidTimer(sb_timer) then
			DestroyTimer(sb_timer)
		end
		sb_timer = CreateTimer(UpdateScoreboardData, 1500)
		UpdateScoreboardData()
		SetWebVisibility(scoreboard, WEB_VISIBLE)
	end
end
AddEvent("OnKeyPress", OnKeyPress)

function OnKeyRelease(key)
	if key == "Tab" then
		SetWebVisibility(scoreboard, WEB_HIDDEN)
	end
end
AddEvent("OnKeyRelease", OnKeyRelease)

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
end
AddEvent("OnPackageStart", OnPackageStart)

--- SCOREBOARD
function UpdateScoreboardData()
	CallRemoteEvent("UpdateScoreboardData")
end

function OnGetScoreboardData(servername, count, maxplayers, players)
	--print(servername, count, maxplayers)
	ExecuteWebJS(scoreboard, "testing()")
	--print("OnGetScoreboardData "..#players)
	--for k, v in ipairs(players) do
	--	ExecuteWebJS(scoreboard, "AddPlayer("..k..", '"..v[1].."', '"..v[2].."', '"..v[3].."')")
	--end
end
AddRemoteEvent("OnGetScoreboardData", OnGetScoreboardData)