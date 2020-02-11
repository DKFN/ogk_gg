-- OGK Common Utils - API Common interface

-- Author: DeadlyKungFu.Ninja

local TIMER_REFRESH_RATE = 120000

local function OnWinRequestComplete(winRequest)
    local status = http_result_status(winRequest)
    local data = http_result_body(winRequest)
    if status == 200 then
        local playerStats = json.parse(data);
        print("[OGK][API] Player already won "..playerStats.count.." times")
        print("[OGK][API] Win corretly send to Global Stats")
        CallEvent("OGK:API:GetGamemodeStats")
    elseif status == 202 then
        print("[OGK][API] Win will not be saved in global leaderboard")
    else
        print("[OGK][API] Unexpected error ["..status.."]")
    end
    http_destroy(winRequest)
end

AddEvent("OGK:API:AddPlayerWin", function(playerId)
    local winRequest = makeApiRequest()
    local winnerSteamId = GetPlayerSteamId(playerId)	
    
    http_set_target(winRequest, "/victory/"..winnerSteamId.."?gamemode="..OGK_GAMEMODE)
    http_set_verb(winRequest, "post")

    if http_send(winRequest, OnWinRequestComplete, winRequest) == false then
        http_destroy(winRequest)
		error("[OGK][API] ERROR : Login request failed due to gameserver problem (things will break)")
	end
end)

local function OnLeaderBoardGetComplete(leaderBoardRequest)
    local status = http_result_status(leaderBoardRequest)
    local data = http_result_body(leaderBoardRequest)
    local leaders = json.parse(data);
    print("Leaders : ")
    _.print(leaders)
    if status == 200 then
        print("[OGK][API] Stats: OK")
    else
        print("[OGK][API] Unexpected error ["..status.."]")
    end
    CallEvent("OGK:INMAP_LEADERBOARD:ReceiveData", json.stringify(leaders))
end

-- LeaderBoard stats watcher
AddEvent("OGK:API:GetGamemodeStats", function()
    local leaderBoardRequest = makeApiRequest()
    
    http_set_target(leaderBoardRequest, "/victory/?gamemode="..OGK_GAMEMODE)
    http_set_verb(leaderBoardRequest, "get")

    print("[OGK][API] Refreshing Global Stats")
    if http_send(leaderBoardRequest, OnLeaderBoardGetComplete, leaderBoardRequest) == false then
        http_destroy(winRequest)
		error("[OGK][API] ERROR : Login request failed due to gameserver problem (things will break)")
	end
end)

CreateTimer(function()
   CallEvent("OGK:API:GetGamemodeStats")
end, TIMER_REFRESH_RATE)
