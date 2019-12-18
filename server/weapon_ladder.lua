local weapons = {
    {id = 9, name = "MAC10"},
    {id = 8, name = "SMG"},
    {id = 12, name = "Ak-47"},
    {id = 14, name = "Rifle"},
    {id = 15, name = "Rifle 2"},
    {id = 19, name = "Rifle 3"},
    {id = 20, name = "Sniper"},
    {id = 6, name = "Shotgun"},
    {id = 4, name = "#1 Gun"}
}

Ladder = {}

function Ladder.getWeaponName(level) 
    return weapons[level].name
end

function Ladder.getWeaponId(level) 
    return weapons[level].id
end

function Ladder.getLevelMax()
    return #weapons
end