-- http_set_user_agent("OGK_GG/0.2")

-- Synchronously send a get request to http://www.httpbin.org/get and print the body
function getPlayerSummary(playerId)
    local steam64id = GetPlayerSteamId(playerId)
    print(steam64id .. " Getting player summary for  " .. playerId)
    local _res = http_get("http://node03.ogk.infra.tetel.in:3000/steam/profile/"..steam64id)
    if (_res.body) then
        local userProfile = json.parse(_res.body)
        _.print(userProfile["image"])
        players[playerId].image = userProfile["image"]
        players[playerId].country = userProfile["country"]
    end
end 
AddEvent("GetPlayerSummaryInfo", getPlayerSummary)
