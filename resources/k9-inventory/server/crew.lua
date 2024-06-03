-- allcrew
-- allmembercrew

-- 0 member 1 admin 2 owner

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
        ["accountcreated"] = "01/01/2000",
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


local allinvite = {}

Citizen.CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM MP_crew", {}, function(result)
        for i = 1, #result do
            result[i].stats = json.decode(result[i].stats)
            allmembercrew[result[i].name] = {}
            allcrew[result[i].name] = result[i]
        end
        print(#result .. " CREW LOAD")
        MySQL.Async.fetchAll("SELECT * FROM MP_membrecrew", {}, function(resulte)
            for i = 1, #resulte do
                if allmembercrew[resulte[i].namecrew] then
                    table.insert(allmembercrew[resulte[i].namecrew], resulte[i])
                end
            end
            for i = 1, #resulte do
                if allmembercrew[resulte[i].namecrew] then
                    for j = 1, #allmembercrew[resulte[i].namecrew] do
                        local boole, user = exports["k9pvp"]:GetUserFromIdUnique(allmembercrew[resulte[i].namecrew][j].idunique)
                        allmembercrew[resulte[i].namecrew][j].name = boole and user.name or ""
                        allmembercrew[resulte[i].namecrew][j].money = boole and user.account["bank"] or 0
                        allmembercrew[resulte[i].namecrew][j].id = 0
                    end
                end
            end
            print(#resulte.. " MEMBER CREW LOAD")
        end)
    end)
end)

local function foundCrew(name)
    for k, v in pairs(allcrew) do
        if k == name then
            return true, v
        end
    end
    return false
end

exports("foundCrew", foundCrew)

local function foundPlayerInCrew(identifier)
    for k, v in pairs(allmembercrew) do
        for i = 1, #v do
            if v[i].identifier == identifier then
                return true, v[i], k, i
            end
        end
    end
    return false
end

local function RefreshClientAllCrew(name)
    for i = 1, #allmembercrew[name] do
        local xPlayer = MP.GetPlayerFromIdUnique(tonumber(allmembercrew[name][i].idunique))
        if xPlayer then
            RefreshClient(xPlayer.source, xPlayer.identifier)
        end
    end
end

local function AddPlayerInCrew(namecrew, identifier, image, idunique, name, permission, money, src)
    if allmembercrew[namecrew] == nil then allmembercrew[namecrew] = {} end
    table.insert(allmembercrew[namecrew], {id = src, identifier = identifier, image = image, idunique = idunique, namecrew = namecrew, permission = permission, kills = 0, deaths = 0, name = name, statut = "ONLINE", money = money})
    MySQL.Async.execute("INSERT INTO MP_membrecrew (identifier, image, idunique, namecrew, permission) VALUES (@identifier, @image, @idunique, @namecrew, @permission)", {
        ['@identifier'] = identifier,
        ['@image'] = image,
        ['@idunique'] = idunique,
        ['@namecrew'] = namecrew,
        ['@permission'] = permission,
    })
    RefreshClientAllCrew(namecrew)
end

local function ChangePermission(identifier, newperm)
    local bool, leplayer = foundPlayerInCrew(identifier)
    if bool then
        leplayer.permission = newperm
        MySQL.Async.execute('UPDATE MP_membrecrew SET permission = @permission WHERE identifier = @identifier', {
            ['@permission'] = newperm,
            ['@identifier'] = identifier
        })
        RefreshClientAllCrew(leplayer.namecrew)
    end
end

local function KickPlayerCrew(identifier)
    local bool, leplayer, k, i = foundPlayerInCrew(identifier)
    if bool then
        table.remove(allmembercrew[k], i)
        MySQL.Async.execute('DELETE FROM MP_membrecrew WHERE identifier = @identifier AND namecrew = @namecrew', {  
            ['@identifier'] = identifier,
            ['@namecrew'] = leplayer.namecrew
        })
        RefreshClientAllCrew(leplayer.namecrew)
        local xTarget = MP.GetPlayerFromIdentifier(identifier)
        if xTarget then
            TriggerClientEvent("MP:KickCrew", xTarget.source)
        end
    end
end

exports("AddPlayerInCrew", AddPlayerInCrew)

local function CreateCrew(identifier, name, tag, image, idunique, nameplayer, images, money, src)
    allcrew[name] = {owner = identifier, name = name, tag = tag, image = image, stats = default}
    allmembercrew[name] = {}
     MySQL.Async.execute("INSERT INTO MP_crew (owner, name, tag, image) VALUES (@owner, @name, @tag, @image)", {
        ['@owner'] = identifier,
        ['@name'] = name,
        ['@tag'] = tag,
        ['@image'] = image,
    })
    AddPlayerInCrew(name, identifier, images, idunique, nameplayer, 2, money, src)
end

local function DeleteCrew(name)
    MySQL.Async.execute('DELETE FROM MP_crew WHERE name = @name', {  
        ['@name'] = name
    })
    allcrew[name] = nil
    allmembercrew[name] = nil
end

function RefreshClient(src, identifier)
    local bool, leplayer = foundPlayerInCrew(identifier)
    if bool then
        local boole, lecrew = foundCrew(leplayer.namecrew)
        if boole then
            TriggerClientEvent("MP:UpdateMyCrew", src, allmembercrew[leplayer.namecrew], lecrew, leplayer)
            print("crew " ..leplayer.namecrew.. " found avec " ..#allmembercrew[leplayer.namecrew].. " membre dedans")
        end
    end
end

exports("RefreshClientCrew", RefreshClient)

local function RefreshClientCrewConnect(identifier, id)
    print(identifier, 'refresh client')
    local bool, leplayer = foundPlayerInCrew(identifier)
    if bool then
        leplayer.statut = "ONLINE"
        leplayer.id = id
        RefreshClientAllCrew(leplayer.namecrew)
    end
end
exports("RefreshClientCrewConnect", RefreshClientCrewConnect)

local function AddStats(identifier, mdj, statss)
    local bool, leplayer = foundPlayerInCrew(identifier)
    if bool then
        if statss == "kill" then
            leplayer.kills = leplayer.kills + 1
            MySQL.Async.execute('UPDATE MP_membrecrew SET kills = @kills WHERE identifier = @identifier', {
                ['@kills'] = leplayer.kills,
                ['@identifier'] = identifier
            })
        end
        if statss == "death" then
            leplayer.deaths = leplayer.deaths + 1
            MySQL.Async.execute('UPDATE MP_membrecrew SET deaths = @deaths WHERE identifier = @identifier', {
                ['@deaths'] = leplayer.deaths,
                ['@identifier'] = identifier
            })
        end
        local boolcrew, lecrew = foundCrew(leplayer.namecrew)
        if boolcrew then
            lecrew.stats[mdj][statss] = lecrew.stats[mdj][statss] + 1
            MySQL.Async.execute('UPDATE MP_crew SET stats = @stats WHERE name = @name', {
                ['@stats'] = json.encode(lecrew.stats),
                ['@name'] = leplayer.namecrew 
            })
        end
        RefreshClientAllCrew(leplayer.namecrew)
    end
end

exports("AddStats", AddStats)

RegisterServerEvent("MP:CreateCrew")
AddEventHandler("MP:CreateCrew", function(data)
    local xPlayer = MP.GetPlayerFromId(source)
    local boolplayerincrew = foundPlayerInCrew(xPlayer.identifier)
    if not boolplayerincrew then
        local bool = foundCrew(data.crewname)
        if not bool then
            CreateCrew(xPlayer.identifier, data.crewname, data.crewtag, data.crewimage, xPlayer.idunique, xPlayer.name, xPlayer.ppsteamcache, xPlayer.getAccount("bank"), xPlayer.source)
        else
            xPlayer.showNotification("~r~There is already an existing crew")
        end
    else
        xPlayer.showNotification("~r~You are already in a crew")
    end
end)

RegisterServerEvent("MP:ActionPlayer")
AddEventHandler("MP:ActionPlayer", function(data) -- data.idunique = identifier  
    local xPlayer = MP.GetPlayerFromId(source)
    local boolplayerincrew, leplayer = foundPlayerInCrew(xPlayer.identifier)
    if not boolplayerincrew then return end
    local boolrandomplayerincrew, leplayeraction = foundPlayerInCrew(data.idunique)
    if not boolrandomplayerincrew then return end
    local bool, lecrew = foundCrew(leplayer.namecrew)
    if not bool then return end
    if boolplayerincrew and boolrandomplayerincrew and leplayer.namecrew == leplayeraction.namecrew and bool then
        if leplayer.permission >= 1 then
            if data.action == "promote" then
                if leplayer.permission > leplayeraction.permission and leplayeraction.permission <= 2 or (lecrew.owner == leplayer.identifier and leplayer.identifier ~= leplayeraction.identifier) then
                    ChangePermission(data.idunique, leplayeraction.permission + 1)
                end
            elseif data.action == "demote" then
                if leplayer.permission > leplayeraction.permission and leplayeraction.permission >= 0 or (lecrew.owner == leplayer.identifier and leplayer.identifier ~= leplayeraction.identifier)  then
                    ChangePermission(data.idunique, leplayeraction.permission - 1)
                end
            elseif data.action == "kick" then
                if leplayer.permission > leplayeraction.permission or (lecrew.owner == leplayer.identifier and leplayer.identifier ~= leplayeraction.identifier)  then
                    KickPlayerCrew(data.idunique)
                end
            end
        end
    end
end)

RegisterServerEvent("MP:LeaveCrew")
AddEventHandler("MP:LeaveCrew", function()
    local xPlayer = MP.GetPlayerFromId(source)
    local boolplayerincrew, leplayer = foundPlayerInCrew(xPlayer.identifier)
    local bool, lecrew = foundCrew(leplayer.namecrew)
    if boolplayerincrew and bool then
        if lecrew.owner ~= leplayer.identifier or #allmembercrew[lecrew.name] <= 1 then
            KickPlayerCrew(xPlayer.identifier)
            if lecrew.owner == leplayer.identifier then
                DeleteCrew(lecrew.name)
            end
        end
    end
end)

RegisterCommand("invite", function(source, args)
    if tonumber(args[1]) == nil then return end
    local xPlayer = MP.GetPlayerFromId(source)
    if xPlayer.idunique == tonumber(args[1]) then return end
    local bool, leplayer = foundPlayerInCrew(xPlayer.identifier)
    if bool then
        if leplayer.permission >= 1 then
            local lereturn = exports["k9pvp"]:InvitePlayerInCrew(tonumber(args[1]), leplayer.namecrew)
            xPlayer.showNotification(lereturn)
        end
    end
end)


 AddEventHandler('onResourceStart', function(resourceName)
     if resourceName == "k9-inventory" then
         Citizen.Wait(1000)
        for k, v in pairs(MP.Player) do
             local bool, leplayer = foundPlayerInCrew(v.identifier)
             if bool then
                leplayer.statut = "ONLINE"
             end
             RefreshClient(v.source, v.identifier)
             TriggerClientEvent("MP:UpdateInviteCrew", v.source, v.invitecrew)
         end
     end
 end)