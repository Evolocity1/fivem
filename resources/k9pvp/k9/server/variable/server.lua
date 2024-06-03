MP = {}
MP.Player = {}
MP.Command = {}
MP.NbPlayer = 0
MP.Group = {
    "user",
    "modo",
    "admin",
    "superadmin",
    "owner",
}
MP.Cache = {
    ["bags"] = {
        
    }
}

MP.AttenteBattleRoyale = {
    
}

MP.GameBattleRoyaleLancer = false

MP.InGameBattleRoyale = {
    
}
MP.LabelItem = {}
MP.Bags = {}
MP.StuffParTerre = {}
MP.DvAllTime = 600
Config = {}

arenablip = {
    ["1"] = {
        coords = vector3(384.37280273438, -344.56195068359, 46.815280914307),
        radius = 50.0
    },
    
    ["2"] = {
        coords = vector3(15.17710018158, -1865.5754394531, 23.603677749634),
        radius = 200.0
    },
    
    ["3"] = {
        coords = vector3(56.651557922363, 3675.8012695313, 39.753532409668),
        radius = 200.0
    },
}

AllKillsInArena = {
    ["gungame"] = {},
    ["deathmatch"] = {},
}

function AddKillInArena(arena, src)
    if AllKillsInArena[arena][tostring(src)] == nil then AllKillsInArena[arena][tostring(src)] = 0 end
    AllKillsInArena[arena][tostring(src)] = AllKillsInArena[arena][tostring(src)] + 1
    return AllKillsInArena[arena][tostring(src)] + 1
end

function GetKillInArena(arena, src)
    if AllKillsInArena[arena][tostring(src)] == nil then AllKillsInArena[arena][tostring(src)] = 0 end
    return AllKillsInArena[arena][tostring(src)] + 1
end

arenaactuel = {
    ["deathmatch"] = "1",
    ["gungame"] = "1"
}
arenablipactuel = {
    ["deathmatch"] = "1",
    ["gungame"] = "1",
}

arenarespawn = {
    ["1"] = {
        vector3(417.41857910156, -349.39190673828, 47.293525695801),
        vector3(389.29144287109, -331.48236083984, 46.875026702881),
        vector3(362.59094238281, -326.90420532227, 46.734050750732),
        vector3(354.37448120117, -352.22961425781, 46.437438964844),
        vector3(368.15216064453, -371.3330078125, 46.744537353516),
        vector3(384.40335083008, -371.57843017578, 46.893215179443),
        vector3(389.60830688477, -356.54739379883, 48.024158477783),
        vector3(423.69882202148, -333.51885986328, 47.210033416748)
    },
    
    ["2"] = {
        vector3(42.29419708252, -1854.5687255859, 22.831567764282),
        vector3(59.688911437988, -1859.0263671875, 22.850950241089),
        vector3(67.327789306641, -1872.1484375, 22.420789718628),
        vector3(29.393686294556, -1841.2396240234, 24.23118019104),
        vector3(-4.5438585281372, -1892.5620117188, 23.42723274231),
        vector3(20.289312362671, -1907.3356933594, 22.477445602417),
        vector3(24.005844116211, -1895.6348876953, 22.609781265259),
        vector3(-1.8434027433395, -1879.9337158203, 23.701877593994)
    },
    
    ["3"] = {
        vector3(69.265380859375, 3789.20703125, 33.309066772461),
        vector3(152.81317138672, 3670.6179199219, 31.96488571167),
        vector3(25.087156295776, 3631.6147460938, 40.113548278809),
        vector3(33.83345413208, 3671.515625, 40.440574645996),
        vector3(-16.502534866333, 3721.4331054688, 39.50528717041),
        vector3(1.2507255077362, 3664.4189453125, 40.112342834473),
        vector3(99.276000976563, 3607.3974609375, 39.707275390625),
    },
    
}

listweapon = {
    ["deathmatch"] = {
        "weapon_assaultrifle",
        "weapon_assaultrifle_mk2",
        "weapon_carbinerifle",
        "weapon_carbinerifle_mk2",
        "weapon_advancedrifle",
        "weapon_specialcarbine",
        "weapon_specialcarbine_mk2",
        "weapon_bullpuprifle",
        "weapon_bullpuprifle_mk2",
        "weapon_compactrifle",
        "weapon_militaryrifle",
        "weapon_heavyrifle",
        "weapon_tacticalrifle",
        "weapon_mg",
        "weapon_combatmg",
        "weapon_combatmg_mk2",
        "weapon_gusenberg",
    },
    ["deluxotricks"] = {
        string.upper("weapon_marksmanrifle"),
        string.upper("weapon_marksmanrifle_mk2"),
        string.upper("weapon_heavysniper"),
        string.upper("weapon_heavysniper_mk2"),
        "deluxo",
        "oppressor"
    },
    ["gungame"] = {
        "weapon_snspistol",
        "weapon_pistol",
        "weapon_pistol50",
        "weapon_compactrifle",
        "weapon_bullpuprifle",
        "weapon_combatpdw",
        "weapon_assaultrifle",
        "weapon_carbinerifle",
        "weapon_carbinerifle_mk2",
        "weapon_specialcarbine",
        "weapon_specialcarbine_mk2",
        "weapon_tacticalrifle",
        "weapon_combatmg",
        "weapon_combatmg_mk2",
        "weapon_heavysniper",
        "weapon_marksmanrifle",
        "weapon_marksmanrifle_mk2",
        "weapon_advancedrifle",
        "weapon_bullpuprifle_mk2",
        "weapon_knife",
    },
    ["battleroyale"] = {}
}