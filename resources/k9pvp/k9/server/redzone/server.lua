local redzone = {
    pos = {
        coords = vector3(0,0,0),
        radius = 0.0,
    },
    top = {
        name = "Monsieur Propre",
        kill = 0
    }
}

function MP.InRedzone(coords)
    return (#(coords-redzone.pos.coords) <= redzone.pos.radius)
end

local leaderboard = {
    
}

local function searchPlayerLeaderboard(id)
    for i = 1, #leaderboard do
        if leaderboard[i].id == id then
            return true, leaderboard[i], i
        end
    end
    return false
end

local function addPlayerLeaderboard(info)
    table.insert(leaderboard, info)
end

local function ResetScore()
    leaderboard = {}
    TriggerClientEvent("MP:RefreshMyKillRedzone", -1, 0)
end

function RefreshRedzone(src)
    if src then
        TriggerClientEvent("MP:RefreshRedzone", src, redzone)
    else
        TriggerClientEvent("MP:RefreshRedzone", -1, redzone)
    end
end

Citizen.CreateThread(function()
    while true do
        GenerateRedzone()
        Citizen.Wait(1000 * 60 * 30)
    end
end)

function GenerateRedzone()
    local nbrandom = math.random(1,#Config.Redzone)
    redzone = {
        pos = {
            coords = Config.Redzone[nbrandom].coords,
            radius = Config.Redzone[nbrandom].radius,
        },
        top = {
            name = "No kill leader",
            kill = 0
        }
    }
    ResetScore()
    RefreshRedzone()
    TriggerClientEvent("MP:showNotification", -1, "~r~The redzone has just changed location")
end

RegisterServerEvent("MP:kill")
AddEventHandler("MP:kill", function(id)
    local xPlayer = MP.Player[source]
    if xPlayer.source ~= tonumber(id) and tonumber(id) ~= 0 and tonumber(id) ~= nil then
        if MP.InRedzone(GetEntityCoords(GetPlayerPed(id))) then
            local xTarget = MP.Player[id]
            local bool, player = searchPlayerLeaderboard(id)
            if bool then
                player.kill = player.kill + 1
                if redzone.top.kill < player.kill then
                    redzone.top.kill = player.kill
                    redzone.top.name = player.name
                    RefreshRedzone()
                end
                TriggerClientEvent("MP:RefreshMyKillRedzone", tonumber(id), player.kill)
            else
                addPlayerLeaderboard({id = id, name = GetPlayerName(id), kill = 1})
                if redzone.top.kill == 0 then
                    redzone.top.kill = 1
                    redzone.top.name = GetPlayerName(id)
                    RefreshRedzone()
                end
                TriggerClientEvent("MP:RefreshMyKillRedzone", tonumber(id), 1)
            end
            xTarget.AddStats("redzone", "kill")
            exports["k9-inventory"]:AddStats(xTarget.identifier, "redzone", "kill")
            if xTarget.HasDefi(6) then
                xTarget.CompleteDefi(6, 1)
            end
        end
    end
end)