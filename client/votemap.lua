-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz

function InitVotemap()
    votemap = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 24)
	LoadWebFile(votemap, "http://asset/ogk_gg/gui/votemap.html")
	SetWebAlignment(votemap, 0.0, 0.0)
	SetWebAnchors(votemap, 0.0, 0.0, 1.0, 1.0)
    SetWebVisibility(votemap, WEB_VISIBLE)
end

AddRemoteEvent("InitVotemap", function()
    SetWebVisibility(scoreboard, WEB_HIDDEN)
    InitVotemap()
    CallRemoteEvent("GetVotemapChoices")
    SetInputMode(INPUT_UI)
end)

AddRemoteEvent("SendVotemapChoices", function(data)
    AddPlayerChat("VotemapData "..data)
    Delay(1000, function()
        ExecuteWebJS(votemap, "ReceiveVotemapData('"..data.."')")
    end)
end)

AddRemoteEvent("VotemapVotesStatus", function(status)
    AddPlayerChat("Status of vote : "..status)
    if votemap then
        ExecuteWebJS(votemap, "ReceiveVotesData('"..status.."')")
    end
end)

AddEvent("VoteForMap", function(mapChoice)
    AddPlayerChat(mapChoice)
    CallRemoteEvent("VotemapRegisterVote", mapChoice)
end)

AddRemoteEvent("VotemapStopVoteMap", function()
    SetWebVisibility(votemap, WEB_HIDDEN)
    DestroyWebUI(votemap)
    votemap = nil
end)
