-- OGK Common Utils - HealthRegen

-- Author: DeadlyKungFu.Ninja
local REGEN_DEBUG = false
local awaitRegen = {} -- id, entry
AddCommand("ouch", function(playerid)
    SetPlayerHealth(playerid, 20)
end)

local function _print(message)
    if REGEN_DEBUG then
        print(message)
    end
end
-- 
CreateTimer(function()
    for k, v in ipairs(GetAllPlayers()) do
        local playerHealth = GetPlayerHealth(v)
        if playerHealth < 100 and _.find(awaitRegen, function(p) return p.id == v end) == nil then
            _print("Player needs regen"..v)
            awaitRegen[#awaitRegen + 1] = {
                entry = os.time(os.date("!*t")),
                id = v
            }
            _print("Awaiting regen ".._.str(awaitRegen[v]))
        end
    end
    -- print("Regen".._.str(awaitRegen))
end, 1000)

CreateTimer(function()
    local now = os.time(os.date("!*t"))
    for k, v in ipairs(awaitRegen) do
        local playerHealth = GetPlayerHealth(v.id)
        if playerHealth < 100 then
            -- print("Entry: ".. tonumber(v.entry))
            -- print("Post: ".. tonumber(now) - 5)awaitRegen[v]
            _print("Regenerating ... ".._.str(v))
            if tonumber(v.entry) < tonumber(now) - 5 then
                SetPlayerHealth(v.id, playerHealth + 1)
            end
        else
            awaitRegen = _.filter(awaitRegen, function(p)
                _print("Stopr egen for "..p.id.." Comparing with "..v.id)
                return p.id ~= v.id 
            end)
            _print("After stop".._.str(awaitRegen))
        end
    end
end, 200)

AddEvent("OnPlayerWeaponShot", function(player, wpn, hittype, hitid, hitX, hitY, hitZ, startX, startY, startY, normalX, normalY, normalZ)
    print("HIT ID "..hitid.." HIT TYPE : "..hittype)
    if hittype == 2 then
        _print("Have to cancel health regen"..hitid)
        awaitRegen = _.filter(awaitRegen, function(p)
            return p.id ~= hitid 
        end)
        _print("After cancel".._.str(awaitRegen))
    end
end)

AddEvent("OnPlayerQuit", function(player)
    awaitRegen = _.filter(awaitRegen, function(p)
        return p.id ~= player 
    end)
end)

