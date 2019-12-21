local weapons = {
    {
        id = 9,
        name = "MAC10",
        ammo = 300
    },
    {
        id = 8,
        name = "MP5",
        ammo = 300
    },
    {
        id = 10,
        name = "UMP-45",
        ammo = 300
    },
    {
        id = 16,
        name = "Ak-U",
        ammo = 200
    },
    {
        id = 12,
        name = "Ak-47",
        ammo = 200
    },
    {
        id = 11,
        name = "M4A1",
        ammo = 200
    },
    {
        id = 14,
        name = "Rifle",
        ammo = 200
    },
    {
        id = 15,
        name = "Rifle 2",
        ammo = 200
    },
    {
        id = 19,
        name = "SCAR-H",
        ammo = 200
    },
    {
        id = 20,
        name = "Scout",
        ammo = 30
    },
    {
        id = 6,
        name = "Shotgun",
        ammo = 20
    },
    {
        -- Faire en sorte que le joueur soit downgrade quand son chargeur est vide
        id = 4,
        name = "#1 Gun",
        ammo = 8 
    }
}

Ladder = {}

function Ladder.getWeaponName(level) 
    return weapons[level].name
end

function Ladder.getWeaponId(level) 
    return weapons[level].id
end

function Ladder.getWeaponStartAmmo(level)
    return weapons[level].ammo
end

function Ladder.getLevelMax()
    return #weapons
end