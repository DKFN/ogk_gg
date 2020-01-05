-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz
function ScoreboardInit() 
    scoreboard = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 24)
	LoadWebFile(scoreboard, "http://asset/ogk_gg/gui/scoreboard.html")
	SetWebAlignment(scoreboard, 0.0, 0.0)
	SetWebAnchors(scoreboard, 0.0, 0.0, 1.0, 1.0)
	SetWebVisibility(scoreboard, WEB_HIDDEN)
end

-- Server Sent Events
AddRemoteEvent("SetScoreBoardData", function(servername, players, map_name) 
	ExecuteWebJS(scoreboard, "ServerVersion('"..servername.."')")
	ExecuteWebJS(scoreboard, "RemovePlayers()")

	table.sort(players, function(ply1, ply2)
		return ply1[3] > ply2[3]
	end)

	for k, v in pairs(players) do
		ExecuteWebJS(scoreboard, "AddPlayer('"..v[1].."', "..v[2]..", "..v[3]..", "..v[4].."," .. v[5] .. ")")
	end
	AddPlayerChat("Setting client data ....")
	
end)
