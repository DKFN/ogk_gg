
local hud
local scoreboard

function OnKeyPress(key)
	if key == "Tab" then

		ExecuteWebJS(scoreboard, "Testing()")
		
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
