local function GetViewPoint(maxdistance)
    local width, height = GetScreenSize()
    local sc1, cX, cY, cZ = ScreenToWorld(width / 2, height / 2)
    if not sc1 then
        return false
    end
    local vX, vY, vZ = GetCameraForwardVector()
    local hitType, hitId, hitX, hitY, hitZ = LineTrace(cX, cY, cZ, cX + (vX * maxdistance), cY + (vY * maxdistance), cZ + (vZ * maxdistance))
    if hitType ~= 5 and hitType ~= 6 then
        return false
    end
    return hitX, hitY, hitZ
end

local function GetClosestPickup(x, y, z, maxdistance)
    local pickups = GetStreamedPickups()
    local pickup = 0
    local distance = maxdistance
    for i=1,#pickups do
        local px, py, pz = GetPickupLocation(pickups[i])
        local d = GetDistance3D(x, y, z, px, py, pz)
        if d < distance then
            distance = d
            pickup = pickups[i]
        end
    end
    return pickup
end

local function GetPickupLookingAt()
    local vx, vy, vz = GetViewPoint(600)
    if vx == false then
        return 0
    end
    return GetClosestPickup(vx, vy, vz, 300)
end

function OnKeyPress(key)
    if key == "E" then
        local item = GetPickupLookingAt()

        if(item ~= 0) then
            CallRemoteEvent(GetPlayerId(), "PlayLevelUp")
            CallRemoteEvent("playerUsePickupItems", item)
        end
    end
    print("test")
end
AddEvent("OnKeyPress", OnKeyPress)