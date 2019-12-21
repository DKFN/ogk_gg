
AddRemoteEvent("PlayLevelUp", function()
    local sound = CreateSound("sounds/smb/smb_powerup.wav")
    if sound == false then
        AddPlayerChat("Error playing sound")
    end    
end)
