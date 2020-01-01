-- Ingame Leaderboard
function GameLeaderboardInit() 
    leaderboard = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 10)
	LoadWebFile(leaderboard, "http://asset/ogk_gg/gui/hud_leaderboard.html")
	SetWebAlignment(leaderboard, 0.0, 0.0)
	SetWebAnchors(leaderboard, 0.0, 0.0, 1.0, 1.0)
    SetWebVisibility(leaderboard, WEB_VISIBLE)

    CreateTimer(function()
        CallRemoteEvent("PollPlayerStats")
    end, 3000)

    CreateTimer(function()
        CallRemoteEvent("PollPlayerAvatars")
    end, 7000)
end

AddRemoteEvent("LeaderboardReceivePlayerStats", function(playerid, data)
    AddPlayerChat("" .. data)
    local plydata = json.parse(data)
    _.print(plydata)
    ExecuteWebJS(leaderboard, "LeaderBoardReceiveData("..playerid..", '"..data.."')");
    AddPlayerChat("OK")
end)


AddRemoteEvent("LeaderboardReceivePlayerAvatar", function(playerid, image)
    AddPlayerChat("" .. image)
    ExecuteWebJS(leaderboard, "LeaderBoardReceiveAvatar("..playerid..", '"..image.."')");
end)
