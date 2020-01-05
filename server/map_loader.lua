--[[
Forked by OGK for server loading map from ini purposes

Copyright (C) 2019 Blue Mountains GmbH
This program is free software: you can redistribute it and/or modify it under the terms of the Onset
Open Source License as published by Blue Mountains GmbH.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the Onset Open Source License for more details.
You should have received a copy of the Onset Open Source License along with this program. If not,
see https://bluemountains.io/Onset_OpenSourceSoftware_License.txt
]]--

local EditorObjects = { }
EditorObjects[1] = { }

local _print = function (message)
    print('[OGK][GG] Map Loader -- ' .. message .. '')
end

local function CreateMapEditorObject(player, modelid, x, y, z, rx, ry, rz, sx, sy, sz)
    local object = CreateObject(modelid, x, y, z, rx, ry, rz, sx, sy, sz)

    SetObjectStreamDistance(object, 100000)

	if object ~= false then
		EditorObjects[1][object] = true
	end

	return object
end

function LoadMapFromIni(FileName)
	if _G["ini_open"] == nil then
		return print("Can't load map from ini as ini-plugin is missing")
	end

	if not file_exists(FileName) then
		return print("Map ini file does not exist "..FileName)
	end

	local ini = ini_open(FileName)
	local numobjects = math.tointeger(ini_read(ini, "info", "numobjects"))
	local createdbySteamId = ini_read(ini, "info", "createdbySteamId")
	local createdbyName = ini_read(ini, "info", "createdbyName")

	local ObjectsLoaded = 0
	for i=1, numobjects do
		local modelid = math.tointeger(ini_read(ini, "objects", "model_"..i))
		local x = tonumber(ini_read(ini, "objects", "x_"..i))
		local y = tonumber(ini_read(ini, "objects", "y_"..i))
		local z = tonumber(ini_read(ini, "objects", "z_"..i))
		local rx = tonumber(ini_read(ini, "objects", "rx_"..i))
		local ry = tonumber(ini_read(ini, "objects", "ry_"..i))
		local rz = tonumber(ini_read(ini, "objects", "rz_"..i))
		local sx = tonumber(ini_read(ini, "objects", "sx_"..i))
		local sy = tonumber(ini_read(ini, "objects", "sy_"..i))
		local sz = tonumber(ini_read(ini, "objects", "sz_"..i))

		if CreateMapEditorObject(1, modelid, x, y, z, rx, ry, rz, sx, sy, sz) ~= false then
			ObjectsLoaded = ObjectsLoaded + 1
		end
	end
	ini_close(ini)
	_print(''..createdbyName.. ' Map : ' ..FileName..'')
end

function file_exists(filename)
    local file = io.open(filename, "r")
    if file then
        file:close()
        return true
    end
    return false
end
