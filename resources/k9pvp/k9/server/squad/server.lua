local idsquad = 0
local allsquad = {}
local allmemberinsquad = {}
local invitesquad = {}

local function searchInviteSquad(id)
    for i = 1, #invitesquad do
        if invitesquad[i].id == id then
            return true, invitesquad[i], i
        end
    end
    return false
end

local function searchSquad(id)
    for i = 1, #allsquad do
        if allsquad[i].idsquad == id then
            return true, allsquad[i], i 
        end
    end
    return false
end

local function searchMemberInSquad(id)
    for k, v in pairs(allmemberinsquad) do
        for i = 1, #allmemberinsquad[k] do
            if allmemberinsquad[k][i].id == id then
                return true, allmemberinsquad[k][i], i 
            end
        end
    end
    return false
end

local function updateAllMemberSquadHud(id, ta)
    for i = 1, #allmemberinsquad[id] do
        TriggerClientEvent("MP:UpdateHudSquad", tonumber(allmemberinsquad[id][i].id), ta)
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            for k, v in pairs(allmemberinsquad) do
        		for i = 1, #allmemberinsquad[k] do
                    local ped = GetPlayerPed(allmemberinsquad[k][i].id) 
                    if DoesEntityExist(ped) then
                        local found = false
                        if tonumber(allmemberinsquad[k][i].health) ~= tonumber(GetEntityHealth(ped) - 100) then
                            allmemberinsquad[k][i].health = tonumber(GetEntityHealth(ped) - 100)
                            found = true
                        end
                        if tonumber(allmemberinsquad[k][i].armor) ~= tonumber(GetPedArmour(ped)) then
                            allmemberinsquad[k][i].armor = tonumber(GetPedArmour(ped))
                            found = true
                        end
                        if found then
                            updateAllMemberSquadHud(k, {id = allmemberinsquad[k][i].id, health = allmemberinsquad[k][i].health, armor = allmemberinsquad[k][i].armor})
                        end
                    end
                end
            end
        end
end)

function CreateSquad(src)
    local xPlayer = MP.Player[source]
    idsquad = idsquad + 1
    table.insert(allsquad, {
        owner = xPlayer.source,
        pp = xPlayer.ppsteam,
        name = xPlayer.name,
        idsquad = idsquad,
        nbmembre = 1,
        private = false,
    })
    allmemberinsquad[idsquad] = {}
    table.insert(allmemberinsquad[idsquad], {
        id = src,
        idsquad = idsquad,
        name = xPlayer.name,
        pp = xPlayer.ppsteam,
        health = 100,
        armor = 100,
    })
    RefreshSquad()
    RefreshAllMemberSquad(idsquad)
end

function JoinSquad(src, id)
    local xPlayer = MP.Player[source]
    if xPlayer.ModeDeJeu ~= "pvp" then xPlayer.showNotification("You are not in pvp") return end
    local bool = searchMemberInSquad(xPlayer.source)
    if bool then xPlayer.showNotification("~r~You are already in a squad") return end
    local boole, lasquad = searchSquad(id)
    if not boole then xPlayer.showNotification("~r~Squad does not exist") return end
    if lasquad.nbmembre >= 4 then xPlayer.showNotification("~r~The squad is full") return end
    local booleee, invite, dd = searchInviteSquad(src)
    if (lasquad.private and not booleee) then return end
    if booleee then
        table.remove(invitesquad, dd)
    end
    lasquad.nbmembre = lasquad.nbmembre + 1
    for i = 1, #allmemberinsquad[id] do
        TriggerClientEvent("MP:AddMemberInSquad", allmemberinsquad[id][i].id, {
            id = src,
            idsquad = id,
            name = xPlayer.name,
            pp = xPlayer.ppsteam,
            health = 100,
        	armor = 100,
        })
    end
    table.insert(allmemberinsquad[id], {
        id = src,
        idsquad = id,
        name = xPlayer.name,
        pp = xPlayer.ppsteam,
        health = 100,
        armor = 100,
    })
    RefreshSquad()
    RefreshAllMemberSquad(id)
end

function QuitSquad(src)
    local boole, lemember, i = searchMemberInSquad(src)
    if not boole then return end
    local id = lemember.idsquad
    local bool, lasquad, d = searchSquad(lemember.idsquad)
    
    table.remove(allmemberinsquad[id], i)
    if bool then
    	lasquad.nbmembre = lasquad.nbmembre - 1
    end
    if lasquad.nbmembre <= 0 then
        table.remove(allsquad, d)
    else
        if lasquad.owner == src then
        	lasquad.owner = allmemberinsquad[lemember.idsquad][math.random(1, #allmemberinsquad[lemember.idsquad])].id
        end
        for i = 1, #allmemberinsquad[id] do
            TriggerClientEvent("MP:RemoveMemberInSquad", allmemberinsquad[id][i].id, src)
        end
    end
    RefreshSquad()
    RefreshAllMemberSquad(id)
    TriggerClientEvent("MP:LeaveSquad", src)
end

function DeleteSquad(id, i)
    for i = 1, #allmemberinsquad[id] do
        TriggerClientEvent("MP:LeaveSquad", allmemberinsquad[id][i].id)
    end
    allmemberinsquad[id] = nil
    table.remove(allsquad, i)
    RefreshSquad()
end

function RefreshSquad(id)
    if id then
        TriggerClientEvent("MP:RefreshSquad", id, allsquad)
    else
        TriggerClientEvent("MP:RefreshSquad", -1, allsquad)
    end
end

function RefreshAllMemberSquad(idsquad)
    for i = 1, #allmemberinsquad[idsquad] do
        TriggerClientEvent("MP:RefreshMemberSquad", allmemberinsquad[idsquad][i].id, allmemberinsquad[idsquad])
    end
end

RegisterServerEvent("MP:CreateSquad")
AddEventHandler("MP:CreateSquad", function()
    local xPlayer = MP.Player[source]
    local bool = searchMemberInSquad(xPlayer.source)
    if bool then return end
    if xPlayer.ModeDeJeu == "pvp" then
        CreateSquad(xPlayer.source)
        xPlayer.showNotification("~g~Squad Create")
    else
        xPlayer.showNotification("You are not in pvp")
    end
end)

RegisterServerEvent("MP:JoinSquad")
AddEventHandler("MP:JoinSquad", function(id)
    JoinSquad(source, tonumber(id))
end)

RegisterServerEvent("MP:LeaveSquad")
AddEventHandler("MP:LeaveSquad", function()
        QuitSquad(source)  
end)

RegisterServerEvent("MP:KickSquad")
AddEventHandler("MP:KickSquad", function(id)
        local xPlayer = MP.Player[source]
        local bool, leplayer = searchMemberInSquad(xPlayer.source)
        if not bool then return end
        local boole, lasquad = searchSquad(leplayer.idsquad)
        if not boole then return end
        if not (xPlayer.source == lasquad.owner) then return end
        QuitSquad(id)
end)

RegisterServerEvent("MP:DeleteSquad")
AddEventHandler("MP:DeleteSquad", function()
        local xPlayer = MP.Player[source]
        local bool, leplayer = searchMemberInSquad(xPlayer.source)
        if not bool then return end
        local boole, lasquad, i = searchSquad(leplayer.idsquad)
        if not boole then return end
        if not (xPlayer.source == lasquad.owner) then return end
        DeleteSquad(lasquad.idsquad, i)
end)

RegisterServerEvent("MP:ChangePrivateSquad")
AddEventHandler("MP:ChangePrivateSquad", function(check)
        local xPlayer = MP.Player[source]
        local bool, leplayer = searchMemberInSquad(xPlayer.source)
        if not bool then return end
        local boole, lasquad, i = searchSquad(leplayer.idsquad)
        if not boole then return end
        if not (xPlayer.source == lasquad.owner) then return end
        lasquad.private = check
        RefreshSquad()
end)