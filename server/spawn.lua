-- Onset Gaming Kommunity -- Gungame
-- Authors : DeadlyKungFu.ninja / Mr Jack / Alcayezz

spawns = {}
spawns_max = {}
map_min_players = {}
busy_spawns = {}

-- Approved maps
spawns["western"] = {}
-- spawns["western"][1] = {-76523.953125, -164042.0625, 3340.1821289063, 0}
spawns["western"][1] = {-78409.382812, -165535.0625, 3218.9055175781, 0}
spawns["western"][2] = {-73164.578125, -163825.953425, 3341.1821289063, 0}
spawns["western"][3] = {-76183.953125, -159598.921875, 3350.1821289063, 0}
spawns["western"][4] = {-81129.953125, -159041.265625, 3220.026367, 0}
spawns["western"][5] = {-82072.0546875, -161787.203125, 3223.7658691406, 0}
spawns["western"][6] = {-77854.0390625, -162242.171875, 3275.2133789063, 0}
spawns["western"][7] = {-79157.9296875, -159667.328125, 3311.9304199219, 0}
spawns["western"][8] = {-79294.234375, -165837.1875, 3313.8293457031, 0}
spawns["western"][9] = {-74902.171875, -165330.984375, 3319.1813964844, 0}
spawns["western"][10] = {-76897.6171875, -162373.875, 3776.4736328125, 0}
spawns["western"][11] = {-76217.65625, -160574.078125, 3429.8293457031, 0}
spawns["western"][12] = {-80027.7890625, -165668.4375, 3222.1259765625, 0}
spawns_max["western"] = 12
map_min_players["western"] = 4


-- Mapped maps
spawns["armory"] = {}
spawns["armory"][1] = { -13398.2929, 132876.7812, 1561.6047, 140 }
spawns["armory"][2] = { -15648.6054, 133113.5625, 1561.6047, 90 }
spawns["armory"][3] = { -14610.5712, 132762.9218, 1561.6047, 145 }
spawns["armory"][4] = { -15727.7382, 134334.6718, 1561.6047, 90 }
spawns_max["armory"] = 4
map_min_players["armory"] = 1

spawns["port"] = {}
spawns["port"][1] = { 37885.355468, 200909.421875, 1548.2750, 0 }
spawns["port"][2] = { 40412.3320, 199853.921875, 1062.7739, 0 }
spawns["port"][3] = { 41172.6210, 205495.1875, 564.5087, 0 }
spawns["port"][4] = { 41597.21093, 202835.0625, 571.7512, 0}
spawns["port"][5] = { 39558.332, 206936.53125, 550.9492, 0}
spawns["port"][6] = { 36878.0156, 207499.110, 567.75964, 0}
spawns["port"][7] = { 39178.8359, 204733.203, 551.0, 0 }
spawns["port"][8] = { 38024.62110, 205067.906, 551.0, 0 }
spawns["port"][9] = { 37044.48, 202884.93, 550.94, 0 }
spawns["port"][10] = { 37357.04, 201498.10, 550.94, 0 }
spawns["port"][11] = { 36947.87, 199390.76, 550.94, 0 }
spawns["port"][12] = { 38455.64, 200087.15, 550.94, 0 }
spawns["port"][13] = { 38916.32, 199426.35, 550.94, 0 }
spawns["port"][14] = { 40670.05, 199346.79, 550.94, 0 }
spawns["port"][15] = { 37043.66, 206222.75, 565.97, 0 }
spawns_max["port"] = 15
map_min_players["port"] = 6

spawns["port_small"] = {}
spawns["port_small"][1] = { 44147.490, 204403.5500, 562.700, 0 }
spawns["port_small"][2] = { 43790.27770, 206686.0, 550.701843, 0 }
spawns["port_small"][3] = { 42180.0, 201287.0, 551.0, 0 }
spawns["port_small"][4] = { 43917.778, 200340.3125, 509.200, 0 }
spawns_max["port_small"] = 4
map_min_players["port_small"] = 1

spawns["trucks_center"] = {}
spawns["trucks_center"][1] = { 17655.6113, 132438.515625, 1555.963867, 0 }
spawns["trucks_center"][2] = { 15831.0, 137311.9, 1556.963867, 0 }
spawns["trucks_center"][3] = { 15856.0, 134755.0, 1556.963867, 0 }
spawns["trucks_center"][4] = { 19876.0, 132388.0, 1556.963867, 0 }
spawns["trucks_center"][5] = { 15697.0, 133555.0, 1574.963867, 0 }
spawns["trucks_center"][6] = { 17737.0, 136405.0, 1556.963867, 0 }
spawns_max["trucks_center"] = 6
map_min_players["trucks_center"] = 3

spawns["tropico"] = {}
spawns["tropico"][1] = { -110019.0, 225094.0, 327.0, 90 }

spawns["tropico"][2] = { 
    -109550.0,
    223632.0,
    179.0,
    180
 }

spawns["tropico"][3] = { 
    -106712.0,
    226676.0,
    179.0,
    180
 }

spawns["tropico"][4] = { 
    -106946.0,
    224033.0,
    190.0,
    180
 }

spawns_max["tropico"] = 4
map_min_players["tropico"] = 1

spawns["hangar"] = {}
spawns["hangar"][1] = { 
    -20424.0,
    -30459.0,
    2201.0,
    0
 }

 spawns["hangar"][2] = { 
    -16378.0,
    -28885.0,
    2201.0,
    0
 }

spawns["hangar"][3] = { 
    -15271.0,
    -32003.0,
    2201.0,
    0
}

spawns["hangar"][4] = { 
    -19692.0,
    -33597.0,
    2201.0,
    0
}

 spawns_max["hangar"] = 4
 map_min_players["hangar"] = 1


-- Player Wait zone outside of game
spawns["spawn_zone"] = {}
spawns["spawn_zone"][1] = { 18483.21875, 140415.296875, 1556.962, 160 }
spawns_max["spawn_zone"] = 1
map_min_players["spawn_zone"] = 1
-- End of player wait time

-- Mapped maps
spawns["gg2"] = {}
spawns["gg2"][1] = { 164173.703125, -163128.578125, 1914.5045166016, 0 }
spawns_max["gg2"] = 1
map_min_players["gg2"] = 1

-- Proposal maps
spawns["paradise_ville"] = {}
spawns["paradise_ville"][1] = { 42824.6914, 134416.125, 1567.509277, 0 }
spawns_max["paradise_ville"] = 1
map_min_players["paradise_ville"] = 1

spawns["prison_yard"] = {}
spawns["prison_yard"][1] = { 178002.09375, 67944.6944, 1528.15002441, 0 }
spawns_max["prison_yard"] = 1
map_min_players["prison_yard"] = 1
