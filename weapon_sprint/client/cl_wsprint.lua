-- By Voltaism#1399
function changeweap(weapidd,val)
    CallRemoteEvent("ChangeWeapSprint",weapidd,val)
end

local retrychangetimer = nil

function retrychange(weapidd,val)
    if (not IsPlayerAiming(GetPlayerId()) and not IsPlayerReloading(GetPlayerId()) and GetPlayerMovementMode(GetPlayerId())~=5) then
        changeweap(weapidd,val)
        DestroyTimer(retrychangetimer)
        retrychangetimer=nil
    end
end

AddEvent("OnKeyPress",function(key)
    if key == "Left Shift" then
        if GetPlayerWeapon(GetPlayerEquippedWeaponSlot(GetPlayerId())) ~= 1 then
            local weapidd = GetPlayerWeapon(GetPlayerEquippedWeaponSlot(GetPlayerId()))
            if (weapidd>21 and weapidd <= 41) then
                weapidd=weapidd-20
            elseif weapidd > 41 then
                weapidd=weapidd-40
            end
            if (IsPlayerAiming(GetPlayerId()) or IsPlayerReloading(GetPlayerId()) or GetPlayerMovementMode(GetPlayerId())==5) then
                if not retrychangetimer then
                   retrychangetimer = CreateTimer(retrychange, 10 ,weapidd,2)
                else
                    DestroyTimer(retrychangetimer)
                    retrychangetimer = CreateTimer(retrychange, 10 ,weapidd,2)
                end
            else
                changeweap(weapidd,2)
           end
        end
    end
end)

AddEvent("OnKeyRelease",function(key)
    if key == "Left Shift" then
        if GetPlayerWeapon(GetPlayerEquippedWeaponSlot(GetPlayerId())) ~= 1 then
            local weapidd = GetPlayerWeapon(GetPlayerEquippedWeaponSlot(GetPlayerId()))
            if (weapidd>21 and weapidd <= 41) then
                weapidd=weapidd-20
            elseif weapidd > 41 then
                weapidd=weapidd-40
            end
            if (IsPlayerAiming(GetPlayerId()) or IsPlayerReloading(GetPlayerId()) or GetPlayerMovementMode(GetPlayerId())==5) then
                if not retrychangetimer then
                    retrychangetimer = CreateTimer(retrychange, 10 ,weapidd,1)
                 else
                     DestroyTimer(retrychangetimer)
                     retrychangetimer = CreateTimer(retrychange, 10 ,weapidd,1)
                 end
            else
                changeweap(weapidd,1)
           end
        end
    end
end)

