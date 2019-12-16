function OnPlayerChat(player, command, exists)
    -- Debug Commands
    if command == "nxt" then
        AddPlayerChat(player, "CMD getting to next ...")
        level_up(player)
    end
    if command == "refresh" then
        AddPlayerChat(player, "Refreshing weapons ...")
        RefreshWeapons(player)
    end

    if command == "warn" then
        CallRemoteEvent(player, "WarnNextLevel")
    end
    if command == "up" then
        OnPlayerDeath(player, player)
        level_up(player)
    end

    if command == "noclip" then
        SetPlayerSpectate(player, true)
    end
    if command == "nonoclip" then
        SetPlayerSpectate(player, false)
    end
    if command == "kill" then
        SetPlayerHealth(player, 0)
    end
end
AddEvent("OnPlayerChat", OnPlayerChat)
