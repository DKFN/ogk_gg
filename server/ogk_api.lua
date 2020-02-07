-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz

-- http_set_user_agent("OGK_GG/0.2")

-- Synchronously send a get request to http://www.httpbin.org/get and print the body
function getPlayerSummary(playerId)
    local steam64id = GetPlayerSteamId(playerId)
    CallEvent("OGK:API:GetPlayerProfile", playerId, tostring(steam64id))
end 
AddEvent("GetPlayerSummaryInfo", getPlayerSummary)

AddEvent("OGK:API:ReceivePlayerProfile", function(id, data)
    if not players[id] then
        print("Delayed ...")
        Delay(200, function()
            CallEvent("OGK:API:ReceivePlayerProfile", id, data)
        end)
    else
        print("ACKed ...")
        local data = json.parse(data)
        players[id]["image"] = data["imageb64"]
        players[id]["country"] = data["country"]
    end
end)