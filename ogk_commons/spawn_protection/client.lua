-- OGK Common Utils - Spawn Protection

-- Author: DeadlyKungFu.Ninja

local playerInSpawnProtection = false


AddRemoteEvent("OGK:SPAWNPROTECTION:ChangeProtectionValue", function(newValue)
    playerInSpawnProtection = newValue
end)

AddEvent("OnKeyPress", function(key)
    if playerInSpawnProtection then
        CallRemoteEvent("OGK:SPAWNPROTECTION:NotifyPlayerActive")
        playerInSpawnProtection = false
    end
end)

