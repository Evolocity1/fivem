IdUnique = 0
MP = {}
MP.Loaded = false
MP.IsDead = false
MP.InModeStaff = false
MP.Antizin = false
MP.Ragdoll = false
MP.Minimap = true
MP.Visible = true
MP.ZombieEnable = false
MP.IhaveSquad = false
MP.MySquad = {}
MP.Report = {}
MP.Property = {}
MP.AllPlayerBucket = {}
MP.Chat = {
}

MP.Crew = {
    bool = false,
    member = {}
}

MP.GamerTags = {}

MP.NbPlayer = 0

MP.ProgressBar = {
    bool = false,
    color = {0,0,0},
    text = "",
    times = 0.0,
    pourcent = 0.0, 
}

MP.DrawDefi = {
    bool = false,
    id = 0,
    text = "",
    value = 0,
    maxvalue = 0,
    times = 0,
}
MP.Bags = {}

MP.FPS = 0

MP.InSpec = {
    bool = false,
    source = 0,
}
MP.Redzone = {
    blips = nil,
    zone = nil,
    pos = {
        coords = vector3(0,0,0),
        radius = 0.0,
    },
    top = {
        name = "",
        kill = 0
    }
}
--
MP.NbConstruction = 0
MP.Construction = {
    
}
MP.InBuild = {
    active = false,
    build = ""
}

MP.StuffParTerre = {}

MP.InGameBattleRoyale = false

MP.MyKill = {
    ["battleroyale"] = 0,
    ["pvp"] = 0,
    ["lobby"] = 0,
}

MP.LaZone = {
    coords = vector3(61.672771453857, -1679.6567382813, 29.298700332642),
    radius = 300.0,
    degat = 1,
}

MP.InZone = false
--

MP.ModeDeJeu = "pvp"

MP.DeathMessage = {
    message = "",
    nameplayer = "",
}

--
MP.InSafezone = false
MP.ElectriciteActive = true
MP.Group = {
    "user",
    "modo",
    "admin",
    "superadmin",
    "owner",
}
MP.Cache = {
    ["bags"] = {
        
    },
    ["stuff"] = {
        
    },
}
Config = {}