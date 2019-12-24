
AddRemoteEvent("PlayLevelUp", function()
    local sound = CreateSound("sounds/smb/smb_powerup.wav")
    SetSoundVolume(sound, 0.3)
    if sound == false then
        AddPlayerChat("Error playing sound")
    end    
end)

AddRemoteEvent("PlayPickupSound", function()
    local sound = CreateSound("sounds/smb/smb_1-up.wav")
    SetSoundVolume(sound, 0.3)
    if sound == false then
        AddPlayerChat("Error playing sound")
    end    
end)

AddRemoteEvent("PlayerIsWinner", function()
    local sound = CreateSound("sounds/smb/smb_stage_clear.wav")
    SetSoundVolume(sound, 0.3)
end)

AddRemoteEvent("PlayerIsLooser", function()
    local sound = CreateSound("sounds/smb/smb_gameover.wav")
    SetSoundVolume(sound, 0.3)
end)

AddRemoteEvent("GameRestarting", function()
    local sound = CreateSound("sounds/quake/prepare.wav")
    SetSoundVolume(sound, 0.3)
end)

local hsInstance
AddRemoteEvent("TrueDmgHeadShot", function()
    if hsInstance then
        DestroySound(hsInstance)
    end 
    hsInstance = CreateSound("sounds/quake/headshot.wav")
    SetSoundVolume(hsInstance, 0.3)
end)
