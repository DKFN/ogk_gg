
local hud
local scoreboard

function SetScoreBoardData(servername, players) 
	ExecuteWebJS(scoreboard, "Testing('" .. servername ..  "')")
	ExecuteWebJS(scoreboard, "RemovePlayers()")

	for k, v in ipairs(players) do
		ExecuteWebJS(scoreboard, "AddPlayer('"..GetPlayerName(k).."', "..v[1]..", "..v[2]..", "..v[3]..")")
	end
end
AddRemoteEvent("SetScoreBoardData", SetScoreBoardData)

function AddFrag(killer, weapon, victim) 
	AddPlayerChat(killer .. weapon .. victim)
	ExecuteWebJS(hud, "killfeed.registerKill('test', 'test', 'test')")
end
AddRemoteEvent("AddFrag", AddFrag) 

function OnKeyPress(key)
	if key == "Tab" then
		CallRemoteEvent("GetScoreBoardData")
		SetWebVisibility(scoreboard, WEB_VISIBLE)
	end
	
	if key == 'E' then
		CallRemoteEvent("OnPlayerPressReload")
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
	ShowHealthHUD(false) 
end
AddEvent("OnPackageStart", OnPackageStart)
