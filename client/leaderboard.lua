-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz

-- Ingame Leaderboard
function GameLeaderboardInit() 
    leaderboard = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 10)
	LoadWebFile(leaderboard, "http://asset/ogk_gg/gui/hud_leaderboard.html")
	SetWebAlignment(leaderboard, 0.0, 0.0)
	SetWebAnchors(leaderboard, 0.0, 0.0, 1.0, 1.0)
    SetWebVisibility(leaderboard, WEB_VISIBLE)
end

AddRemoteEvent("LeaderboardReceivePlayerStats", function(playerid, data)
    local plydata = json.parse(data)
    _.print(plydata)
    ExecuteWebJS(leaderboard, "LeaderBoardReceiveData("..playerid..", '"..data.."')");
end)


AddRemoteEvent("LeaderboardReceivePlayerAvatar", function(playerid, image)
    ExecuteWebJS(leaderboard, "LeaderBoardReceiveAvatar("..playerid..", '"..image.."')");
end)
