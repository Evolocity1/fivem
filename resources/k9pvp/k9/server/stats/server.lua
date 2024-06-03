local allstats = {}

Citizen.CreateThread(function()
        MySQL.Async.fetchAll('SELECT * FROM MP_stats', {}, function(result)
                for i = 1, #result do
                    allstats[result[i].identifier] = json.decode(result[i].stats)
                end
                print(#result .." stats load")
        end)
end)

function AddPlayerInStats(identifier)
    local default = {
        ["pvp"] = {
            ["kill"] = 0,
            ["death"] = 0,
            ["zombiekill"] = 0,
        },
        ["darkzone"] = {
            ["kill"] = 0,
            ["death"] = 0,
            ["zombiekill"] = 0,
        },
        ["redzone"] = {
            ["kill"] = 0,
            ["death"] = 0,
            ["zombiekill"] = 0,
        },
        ["airdrop"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
        ["deluxoarena"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
        ["battleroyale"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
        ["account"] = {
            ["accountcreated"] = os.date('%Y-%m-%d'),
            ["timeplay"] = 0,
        },
        ["gungame"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
        ["deathmatch"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
    }
    allstats[identifier] = default
    MySQL.Async.execute("INSERT INTO MP_stats (identifier, stats) VALUES (@identifier, @stats)", {
            ['@identifier'] = identifier,
            ['@stats'] = json.encode(default),
   	})
end

function ResetStatsPlayer(identifier)
    local default = {
        ["pvp"] = {
            ["kill"] = 0,
            ["death"] = 0,
            ["zombiekill"] = 0,
        },
        ["darkzone"] = {
            ["kill"] = 0,
            ["death"] = 0,
            ["zombiekill"] = 0,
        },
        ["redzone"] = {
            ["kill"] = 0,
            ["death"] = 0,
            ["zombiekill"] = 0,
        },
        ["airdrop"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
        ["deluxoarena"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
        ["battleroyale"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
        ["account"] = {
            ["accountcreated"] = allstats[identifier]["account"]["accountcreated"],
            ["timeplay"] = 0,
        },
        ["gungame"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
        ["deathmatch"] = {
            ["kill"] = 0,
            ["death"] = 0,
        },
    }
    allstats[identifier] = default
    MySQL.Async.execute('UPDATE MP_stats SET stats = @stats WHERE identifier = @identifier', {
            ['@stats'] = json.encode(allstats[identifier]),
            ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE MP_user SET stats = @stats WHERE identifier = @identifier', {
            ['@stats'] = json.encode(allstats[identifier]),
            ['@identifier'] = identifier,
    })
    local xPlayer = MP.GetPlayerFromIdentifier(identifier)
    xPlayer.stats = allstats[identifier]
    xPlayer.refreshMyClient()
end
function GetStatsPlayer(identifier)
    if allstats[identifier] == nil then
        AddPlayerInStats(identifier)
    end
    return allstats[identifier]
end

function AddStatsPlayer(identifier, mdj, lastats)
    if allstats[identifier] == nil then
        AddPlayerInStats(identifier)
    end
    allstats[identifier][mdj][lastats] = allstats[identifier][mdj][lastats] + 1
    MySQL.Async.execute('UPDATE MP_stats SET stats = @stats WHERE identifier = @identifier', {
            ['@stats'] = json.encode(allstats[identifier]),
            ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE MP_user SET stats = @stats WHERE identifier = @identifier', {
            ['@stats'] = json.encode(allstats[identifier]),
            ['@identifier'] = identifier,
    })
    return allstats[identifier]
end

RegisterCommand("resetstats", function(source, args)
        local id = source == 0 and tonumber(args[1]) or source
        if id == nil then return end
        local xPlayer = MP.Player[id]
        if xPlayer then
            if xPlayer.isvip then
                ResetStatsPlayer(xPlayer.identifier)
                xPlayer.showNotification("~g~Reset Success")
            else
				xPlayer.showNotification("~r~You have not the vip")
            end
        end
end)