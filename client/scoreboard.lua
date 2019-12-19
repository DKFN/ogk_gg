local scoreboard

-- Scoreboard Wrapper
Scoreboard = {}

-- Pseudo constructor for a pseudo object
function initScoreboard() 
    scoreboard = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 10)
	LoadWebFile(scoreboard, "http://asset/ogk_gg/gui/scoreboard.html")
	SetWebAlignment(scoreboard, 0.0, 0.0)
	SetWebAnchors(scoreboard, 0.0, 0.0, 1.0, 1.0)
	SetWebVisibility(scoreboard, WEB_HIDDEN)
end

-- Wrapper function to change item visibility
function Scoreboard.setVisibility(visibility)
    SetWebVisibility(scoreboard, visibility)
end

function Scoreboard.showWinner(winner)
    ExecuteWebJS(scoreboard, "PlayerWonGame('"..winner.."')")
end

-- Server Sent Events
AddRemoteEvent("SetScoreBoardData", function(servername, players) 
	ExecuteWebJS(scoreboard, "ServerVersion('"..servername.."')")
	ExecuteWebJS(scoreboard, "RemovePlayers()")

	-- table.sort(players, function(ply1, ply2)
	-- 	return ply1.kills > ply2.kills
	-- end)

	for k, v in pairs(players) do
		ExecuteWebJS(scoreboard, "AddPlayer('"..v[1].."', "..v[2]..", "..v[3]..", "..v[4].."," .. v[5] .. ")")
	end
end)