
AddRemoteEvent("PlayLevelUp", function()
    local sound = CreateSound("sounds/smb/smb_powerup.wav")
    if sound == false then
        AddPlayerChat("Error playing sound")
    end    
end)

AddRemoteEvent("PlayPickupSound", function()
    local sound = CreateSound("sounds/smb/smb_1-up.wav")
    if sound == false then
        AddPlayerChat("Error playing sound")
    end    
end)

AddRemoteEvent("PlayerIsWinner", function()
    CreateSound("sounds/smb/smb_stage_clear.wav")
end)

AddRemoteEvent("PlayerIsLooser", function()
    CreateSound("sounds/smb/smb_gameover.wav")
end)

AddRemoteEvent("GameRestarting", function()
    CreateSound("sounds/quake/prepare.wav")
end)

local hsInstance
AddRemoteEvent("TrueDmgHeadShot", function()
    if hsInstance then
        DestroySound(hsInstance)
    end 
    hsInstance = CreateSound("sounds/quake/headshot.wav")
end)
