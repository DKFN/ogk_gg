-- By Voltaism#1399
AddEvent("OnPackageStart",function()
    local file = io.open("weapons.json", 'r') 
            if (file) then 
                local contents = file:read("*a")
                local weaptable = json_decode(contents);
                io.close(file)
                if not weaptable.weapons[61] then
                    if not weaptable.weapons[22] then
                    local tbls1 = {}
                    local tbls2 = {}
                   for i,v in ipairs(weaptable.weapons) do
                    if i ~= 1 then
                       local tbltoinsert = v
                       tbltoinsert.Name = tbltoinsert.Name.."2"
                       print(tbltoinsert.Name)
                       table.insert(tbls1,tbltoinsert)
                    end
                   end
                   for i,v in ipairs(weaptable.weapons) do
                    if i ~= 1  then
                       local tbltoinsert = v
                       tbltoinsert.Name = tbltoinsert.Name.."3"
                       print(tbltoinsert.Name)
                       table.insert(tbls2,tbltoinsert)
                    end
                   end
                   for i,v in ipairs(tbls1) do
                       table.insert(weaptable.weapons,v)
                   end
                   for i,v in ipairs(tbls2) do
                    table.insert(weaptable.weapons,v)
                   end
                   local wfile = io.open("weapons.json", 'w') 
                     if wfile then
                      local contents = json_encode(weaptable)
                      wfile:write(contents)
                      io.close(wfile)
                    end
                else
                    print("Remove Custom Weapons")
                end
            end
            end
end)

AddRemoteEvent("ChangeWeapSprint",function(ply,weapid,val)
    SetPlayerWeapon(ply, weapid+20*val, 1000, true, GetPlayerEquippedWeaponSlot(ply),true)
end)