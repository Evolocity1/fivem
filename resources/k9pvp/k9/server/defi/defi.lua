local desdefi = {
    {label = "Kill enemies", id = 1, mini = 15, maxe = 25}, -- éliminer des adversaires -- fait
    {label = "Kill zombies", id = 2, mini = 10, maxe = 20}, -- éliminer des zombies -- fait
    {label = "Spend points", id = 3, mini = 200, maxe = 300}, -- dépenser des points
    {label = "Earn points", id = 4, mini = 300, maxe = 400}, -- gagner des points
    {label = "Play 2 hours", id = 5, mini = 2, maxe = 2}, -- jouer 2 heures
    {label = "Kill enemies in redzones", id = 6, mini = 10, maxe = 15}, -- éliminer des adversaires en redzone
    {label = "Spawn a vehicle", id = 7, mini = 10, maxe = 15}, -- Faire spawn des véhicules -- fait
    {label = "Inflicting damage on opponents", id = 8, mini = 3000, maxe = 5000}, -- infligé des dégats a des adversaires
    {label = "Starting and ending a game in battle royale mode", id = 9, mini = 1, maxe = 1}, -- Lance et termine une partie de battle royale
    {label = "Travel a distance", id = 10, mini = 3000, maxe = 5000}, -- Parcourir une distance
    {label = "Inflicting damage on opponents heads", id = 11, mini = 750, maxe = 1500},  -- infligé des dégats a des adversaires dans la tête
    {label = "Write messages in chat", id = 12, mini = 15, maxe = 20}, -- écrire des messages dans le chat
    {label = 'Write "/free" in chat', id = 13, mini = 1, maxe = 1}, -- écrire /free dans le chat -- fait
    {label = "Inflicting damage on zombies", id = 14, mini = 1000, maxe = 1500}, -- infligé des dégats a des zombies
    {label = "Loot items in bags", id = 15, mini = 50, maxe = 100}, -- récupéré des items dans des bags
    {label = "Recover a drop", id = 16, mini = 1, maxe = 1}, -- récupéré un drop
}

MP.AllDefi = {
    ["quotidien"] = desdefi,
    ["hebdo"] = desdefi,
    ["mensuel"] = desdefi,
    ["dictaciel"] = desdefi,
    --[[["dictaciel"] = {
        {label = "Play 10 hours", id = 1},
    }]]
}