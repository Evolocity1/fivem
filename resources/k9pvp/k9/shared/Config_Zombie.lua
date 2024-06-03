Config.Zombie = {
    Framework = "esx", -- esx or qbcore
    BloodTypes = {
        "BigRunOverByVehicle",
        "BigHitByVehicle",
        "SCR_Dumpster",
        "SCR_Torture",
        "TD_SHOTGUN_FRONT_KILL",
        "Burnt_Ped_Head_Torso",
    },
    Darkzone = {
        {coords = vector3(4471.0263671875, -4472.63671875, 12.551622390747), radius = 100.0},
        {coords = vector3(5162.9555664063, -4964.4995117188, 13.962225914001), radius = 100.0},
        {coords = vector3(5313.5419921875, -5598.0009765625, 64.87353515625), radius = 100.0},
    },
    Classes = {
        ["normal"] = {
            models = {
                "a_m_y_downtown_01",
                "a_m_y_acult_02",
                "a_m_m_skidrow_01",
                "a_m_y_genstreet_01",
            },
            randomComponents = true,
            randomProps = true,
            clipset = "move_m@drunk@verydrunk",
            headshot = true,
            health = 200,
            armor = 0,
        },
        ["armored"] = {
            models = {
                "s_m_y_cop_01",
                "s_m_y_swat_01",
                "s_m_m_armoured_01",
            },
            randomComponents = true,
            randomProps = true,
            headshot = false,
            clipset = "move_m@drunk@verydrunk",
            health = 200,
            armor = 0,
        },
        ["infected"] = {
            models = {
                "a_m_m_hillbilly_02",
                "a_m_o_acult_02",
            },
            randomComponents = true,
            randomProps = true,
            headshot = true,
            clipset = "move_characters@orleans@core@",
            health = 100,
            armor = 0,
            fast = true,
            object = {
                model = "p_gasmask_s",
                bone = 31086,
                offset = vector3(0, 0, 0),
                rotation = vector3(0, -90, 180)
            },
        },
        ["grenadier"] = {
            models = {
                "s_m_m_doctor_01",
                "s_m_m_scientist_01",
            },
            randomComponents = true,
            randomProps = true,
            headshot = true,
            clipset = "move_m@drunk@verydrunk",
            health = 200,
            armor = 0,
            object = {
                model = "prop_gascyl_01a",
                bone = 24816,
                offset = vector3(0.15, -0.220, 0),
                rotation = vector3(0, 88, 6)
            },
        },
    },
    SpawnSettings = {
        spawnRates = { -- > total 2.0  < --
            ["normal"] = 1.40,
            ["armored"] = 0.35,
            ["infected"] = 0.15,
            ["grenadier"] = 0.10,
        },
        minDst = 5,
        maxDst = 7,
        spawnWait = 2000,
        maxZombie = 25,
        zombieDamage = 8,
        vehicleAttack = true
    },
    ZombieSound = true,
    ZombieSounds = {
        "zombie_sound_1",
        "zombie_sound_2",
    },
    ite25 = {
        "revolter",
        "zr380",
        "deathbike",
        "bmx",
        "vigilante",
    "scarab",
    "thruster",
    "oppressor",
    "deluxo",
    "weapon_hominglauncher",
    "weapon_heavysniper_mk2",
    "weapon_marksmanrifle_mk2",
    "weapon_marksmanrifle",
    "weapon_rpg",
    },
    MinMoney = {
        ["normal"] = 5,
    },
    MaxMoney = {
        ["normal"] = 30
    }

}

Strings = {
    ["zombie_loot_text"] = "Press [~b~E~b~]~w~ loot zombie",
    ["cant-loot-zombie-dead"] = "You cannot loot zombies because you died",
    ["cant-loot-zombie-vehicle"] = "You cannot loot zombies because you are in the vehicle.",
    ["you-found-item"] = "You found ~b~%s"
}