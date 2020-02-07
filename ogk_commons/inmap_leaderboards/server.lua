-- OGK Common Utils - InMap Leaderboard
-- Author: DeadlyKungFu.Ninja

local leaderboards_main 
local BIG_TEXT_SIZE = 24
local SMALL_TEXT_SIZE = 12

local leaderboard_rows = {}
leaderboard_rows[1] = {}
leaderboard_rows[2] = {}
leaderboard_rows[3] = {}
leaderboard_rows[4] = {}
leaderboard_rows[5] = {}

AddEvent("OnPackageStart", function()

    _.forEach(INMAP_LEADERBOARDS, function(lbPos)

		CreateText3D("LEADER BOARD", BIG_TEXT_SIZE, lbPos[1], lbPos[2], lbPos[3], 0,0,0)
        
        _.push(leaderboard_rows[1],
            CreateText3D("WAITING API ....", BIG_TEXT_SIZE - 4, lbPos[1], lbPos[2], lbPos[3] - 100, 0,0,0))
        _.push(leaderboard_rows[2],
            CreateText3D("WAITING API ....", BIG_TEXT_SIZE - 8, lbPos[1], lbPos[2], lbPos[3] - 150, 0,0,0))
        _.push(leaderboard_rows[3],
            CreateText3D("WAITING API ....", SMALL_TEXT_SIZE, lbPos[1], lbPos[2], lbPos[3] - 200, 0,0,0))
        _.push(leaderboard_rows[4],
            CreateText3D("WAITING API ....", SMALL_TEXT_SIZE, lbPos[1], lbPos[2], lbPos[3] - 250, 0,0,0))
        _.push(leaderboard_rows[5],
            CreateText3D("WAITING API ....", SMALL_TEXT_SIZE, lbPos[1], lbPos[2], lbPos[3] - 300, 0,0,0))
    end)

    _.print(leaderboard_rows)
end)

AddEvent("OGK:INMAP_LEADERBOARD:ReceiveData", function(data)
    local leaders = json.parse(data)
    _.map(_.range(1, 5), function(n)
        local leader = leaders[n]
        _.forEach(leaderboard_rows[n], function(row)
            if leader then
                SetText3DText(row, leader.login.." - "..leader.count.." victories")
            else
                SetText3DText(row, "-")
            end
        end)
    end)
end)
