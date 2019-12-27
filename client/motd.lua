local motd

local function closeMotd()
    SetInputMode(INPUT_GAME)
    DestroyWebUI(motd)
    CallRemoteEvent("PlayerReady")
    
end
AddEvent("CloseMotd",  closeMotd)

function MOTDInit()
    motd = CreateWebUI(0.0, 0.0, 0.0, 0.0, 99, 60)
    LoadWebFile(motd, "http://asset/ogk_gg/gui/motd.html")
    SetWebAlignment(motd, 0.0, 0.0)
    SetWebAnchors(motd, 0.0, 0.0, 1.0, 1.0)
    
    Delay(1500, function()
        SetWebVisibility(motd, WEB_VISIBLE)
    end)

    SetInputMode(motd, INPUT_GAMEANDUI)

    Delay(20000, closeMotd)
end

