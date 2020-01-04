-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz

local votes = {}
AddRemoteEvent("GetVotemapChoices", function(player)
    print("Began Votemap for "..player)
    local playerCount = GetPlayerCount()    
    local allMaps = _.map(avaible_map, function(mapName)
        local mapMax = spawns_max[mapName]
        local mapMin = map_min_players[mapName]
        return {
            available = mapMax >= playerCount and mapMin <= playerCount,
            name = mapName,
        }
    end)
    local mapsString = json.stringify(allMaps)
    CallRemoteEvent(player, "SendVotemapChoices", mapsString)
    print(mapsString)
end)

AddRemoteEvent("VotemapRegisterVote", function(playerId, mapChoice)
    votes[playerId] = mapChoice
end)

local refreshTimer
AddEvent("StartVoteMap", function()
    for _, v in ipairs(GetAllPlayers()) do
        CallRemoteEvent(v, "InitVotemap")
    end

    refreshTimer = CreateTimer(function()
        local status = json.stringify(votes)
        for _, v in ipairs(GetAllPlayers()) do
           CallRemoteEvent(v, "VotemapVotesStatus", status)
        end
    end, 500)

    Delay(10000, function()
        CallEvent("StopVoteMap")
    end)
end)

AddEvent("StopVoteMap", function()
    print("Votemap stopped electing ...")

    if #votes ~= 0 then
        local voteCounts = {}
        _.forEach(votes, function(mapName)
            if voteCounts[mapName] then
                voteCounts[mapName] = voteCounts[mapName] + 1
            else
                voteCounts[mapName] = 1
            end
        end)
        _.print(voteCounts)
        local winnerMapMax = 0
        local winnerMap = current_map -- Assign to random elected one
        _.forEach(voteCounts, function(v, k)
            if v > winnerMapMax then
                winnerMapMax = v
                winnerMap = k
            end
        end)

        -- TODO: Rework: Is bad there
        -- local electedNewMap = _.first)
        current_map = winnerMap
        print("Votemap after vote results "..winnerMap)

        votes = {}
    end
    
    print("Restting")
    votes = {}
    DestroyTimer(refreshTimer)
    refreshTimer = nil
    for _, v in ipairs(GetAllPlayers()) do
        SetPlayerHealth(v, 0)
        CallRemoteEvent(v, "VotemapStopVoteMap")
        CallRemoteEvent(v, "GameRestarting")
     end
end)
