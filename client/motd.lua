function MOTDInit()
    scoreboard = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 10)
    LoadWebFile(scoreboard, "http://asset/ogk_gg/gui/motd.html")
    SetWebAlignment(scoreboard, 0.0, 0.0)
    SetWebAnchors(scoreboard, 0.0, 0.0, 1.0, 1.0)
    SetWebVisibility(scoreboard, WEB_VISIBLE)
end
