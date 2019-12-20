function OnPlayerChat(player, command, exists)
    -- Debug Commands
    if OGK_GG_DEBUG then
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

        if command == "win" then
            CallEvent("PlayerWin", player)
        end

        if command == "pos" then
            local x, y, z = GetPlayerLocation(player)
            AddPlayerChat(player, "<strong style='color:red;'>X:</strong>" .. x .. " <strong style='color:red;'>Y:</strong>" .. y .. " <strong style='color:red;'>Z:</strong>" .. z)
        end

        if command == "tptest" then
            local spawn_location = spawns["shoots"]
            local assigned_spawn = spawn_location[1]
            SetPlayerLocation(player, assigned_spawn[1], assigned_spawn[2], assigned_spawn[3])
        end
    end
    
    if command == "kill" then
        SetPlayerHealth(player, 0)
    end

    local playerName = GetPlayerName(player)
    local message = command
    AddPlayerChatAll(""..playerName.." : "..message)   
end
AddEvent("OnPlayerChat", OnPlayerChat)
