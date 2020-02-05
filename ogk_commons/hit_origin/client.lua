-- OGK Common Utils - Hit Origin FeedBack

-- Author: DeadlyKungFu.Ninja

AddRemoteEvent("OGK:HIT_LOCATION:NotifyHitLocation", function(hitLocation)
    CallEvent("OGK:HIT_LOCATION:HitLocation", hitLocation)
end)
