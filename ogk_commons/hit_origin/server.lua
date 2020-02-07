-- OGK Common Utils - Hit Origin FeedBack

-- Author: DeadlyKungFu.Ninja
local HITORIGIN_DEBUG = true
local function _print(message)
    if HITORIGIN_DEBUG then
        _.print(message)
    end
end

AddEvent("OnPlayerWeaponShot", function(player, weapon, hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ)
    if hittype == 2 then
        local victimRotation = GetPlayerHeading(hitid)
        local instigatorRotation = GetPlayerHeading(player)
        local oppositor = 180
        if instigatorRotation >= 0 then
            oppositor = -180
        end

        _print("Victim rotation ?  "..victimRotation.."")
        _print("Instigator rotation ?  "..instigatorRotation.."")
        local oppositeHitRotation = instigatorRotation + oppositor

        local oppositorvictimHeading = victimRotation
        local oppositeHitRotation = oppositeHitRotation - oppositorvictimHeading
        _print("Relative to rotation ?  "..oppositeHitRotation)
        if oppositeHitRotation <= 0 then
            oppositeHitRotation = 360 + oppositeHitRotation
        end
        _print("Corrected to rotation ?  "..oppositeHitRotation)

        -- Find relative rotation based on hit values
        local hitRelativePosition = "undef"
        if oppositeHitRotation >= 330 or oppositeHitRotation <= 45 then
            hitRelativePosition = "front"
        end
        if oppositeHitRotation >= 45 and oppositeHitRotation <= 135 then
            hitRelativePosition = 'right'
        elseif oppositeHitRotation >= 135 and oppositeHitRotation <= 225 then
            hitRelativePosition = "back"
        elseif oppositeHitRotation >= 225 and oppositeHitRotation <= 335 then
            hitRelativePosition = "left"
        end
        _print("HIT REL POS  "..hitRelativePosition.."")

        CallRemoteEvent(hitid, "OGK:HIT_LOCATION:NotifyHitLocation", hitRelativePosition)
    end
end)
