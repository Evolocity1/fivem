local allbancheater = {}
Citizen.CreateThread(function()
        MySQL.Async.fetchAll('SELECT * FROM MP_cheater', {}, function(result)
                allbancheater = result
        end)
end)

local function checkBanTokencheater(alltoken, mytoken)
    for i = 1, #alltoken.token do
        for d = 1, #mytoken do
            if alltoken.token[i] == mytoken[d] then
                return true
            end
        end
    end
    return false
end

local function checkBancheater(ide)
        for i = 1, #allbancheater do
            if allbancheater[i].identifier == ide or allbancheater[i].license == ide or allbancheater[i].xblid == ide or allbancheater[i].discord == ide or allbancheater[i].liveid == ide then
                return true, allbancheater[i]
            end
        end
    return false
end

function isBanCheaterMonde(src, token)
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        local bool, baninfo = checkBancheater(v)
        if bool then
            return true, baninfo
        end
    end
    for i = 1, #allbancheater do
        local bool, baninfo = checkBanTokencheater(allbancheater[i], token)
    	if bool then
            return true, allbancheater[i]
        end
    end
    return false
end

local function getBanByIdcheater(id)
    for i = 1, #allbancheater do
        if allbancheater[i].id == id then
            return true, allbancheater[i], i
        end
    end
    return false
end


local function getBanByIdFromIdentifiercheater(identifier)
    for i = 1, #allbancheater do
        if allbancheater[i].identifier == identifier then
            return true, allbancheater[i], i
        end
    end
    return false
end
local lestoken = {}

function MP.BanPlayerCheaterMonde(src, author, reason, identifier)
    local xPlayer = MP.Player[tonumber(src)]
    local id = xPlayer.idunique
    local boole = getBanByIdcheater(id)
    if boole then return end
    local name = xPlayer and "["..xPlayer.idunique.."] " ..xPlayer.name or GetPlayerName(src)
    local identifiertarget = identifier and identifier or "BAN ANTICHEAT"
    if reason == nil then reason = "Unknow" end
    if author == nil then author = "Unknow" end
    local license,identifier,liveid,xblid,discord,playerip,target
    for k,v in ipairs(GetPlayerIdentifiers(src))do
						if string.sub(v, 1, string.len("license:")) == "license:" then
							license = v
						elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
							identifier = v
						elseif string.sub(v, 1, string.len("live:")) == "live:" then
							liveid = v
						elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
							xblid  = v
						elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
							discord = v
						elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
							playerip = v
						end
	end
    local bool = getBanByIdFromIdentifiercheater(identifier)
    if bool then return end
    lestoken[src] = {}
	for i = 0, GetNumPlayerTokens(src) - 1 do 
			table.insert(lestoken[src], GetPlayerToken(src, i))
	end
    table.insert(allbancheater, {
            license = license,
            identifier = identifier,
            liveid = liveid,
            xblid = xblid,
            discord = discord,
            playerip = playerip,
            token = lestoken[src],
            sourceplayername = name,
            targetplayername = author,
            reason = reason,
            id = id,
            identifiertarget = identifiertarget,
   })
   
   MySQL.Async.execute("INSERT INTO MP_cheater (identifier, license, liveid, xblid, discord, playerip, token, sourceplayername, targetplayername, reason, id, identifiertarget) VALUES (@identifier, @license, @liveid, @xblid, @discord, @playerip, @token, @sourceplayername, @targetplayername, @reason, @id, @identifiertarget)", {
            ['@identifier'] = identifier,
            ['@license'] = license,
            ['@liveid'] = liveid,
            ['@xblid'] = xblid,
            ['@discord'] = discord,
            ['@playerip'] = playerip,
            ['@token'] = json.encode(lestoken[src]),
            ['@sourceplayername'] = name,
            ['@targetplayername'] = author,
            ['@reason'] = reason,
            ['@id'] = id,
            ['@identifiertarget'] = identifiertarget
   })
    xPlayer.cheatermonde = true
   	local coords = MP.GetClosestSafezone(GetEntityCoords(GetPlayerPed(xPlayer.source)))
   	SetEntityCoords(GetPlayerPed(xPlayer.source), coords)
    MP.ChangeModeDeJeu(xPlayer.source, "pvp")
    xPlayer.showNotification("~r~You are ban \nBan Id : " ..id.. " \nReason : Suspicious Behavior")
    TriggerClientEvent("MP:ShowCheaterWorld", xPlayer.source, id)
end

function MP.UnbanPlayerCheaterMonde(idban)
    local bool, baninfo, i = getBanByIdcheater(idban)
    if bool then
        local xPlayer = MP.GetPlayerFromIdentifier(baninfo.identifier)
        if xPlayer then
            xPlayer.cheatermonde = false
            local coords = MP.GetClosestSafezone(GetEntityCoords(GetPlayerPed(xPlayer.source)))
            SetEntityCoords(GetPlayerPed(xPlayer.source), coords)
            MP.ChangeModeDeJeu(xPlayer.source, "pvp")
            MP.SetPlayerRoutingBucket(xPlayer.source, 1)
            xPlayer.showNotification("You are unbanned")
            TriggerClientEvent("MP:HideCheaterWorld", xPlayer.source)
        end
        MySQL.Async.execute('DELETE FROM MP_cheater WHERE identifier = @identifier', {  
            ['@identifier'] = baninfo.identifier,
        })
        table.remove(allbancheater, i)
    end
end

RegisterCommand("unban", function(source, args)
        local id = tonumber(args[1])
        if id == nil then return end
        if source ~= 0 then
        	local xPlayer = MP.Player[source]
            if xPlayer.group == "user" then return end
            local bool, baninfo = getBanByIdcheater(id)
            if not bool then xPlayer.showNotification("~r~The ban doesn't exist") return end
            if IsPerm(xPlayer.group, "admin") then
                MP.SendWebhook("Unban Player ["..baninfo.id.."]", "Staff : **["..xPlayer.idunique.."]** " ..xPlayer.name.."** \nPlayer Unban : **"..baninfo.sourceplayername.."** ", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206998770022228048/IazyNy4RPdHH9f4cJTBLzZKiB9ylIZ5s9vr2epNxk3U9gy8l7r0RIubdl5xW-c7Zz-1N")
                MP.UnbanPlayerCheaterMonde(id)
                
                xPlayer.showNotification("~g~Unban success")
            else
                if xPlayer.identifier == baninfo.identifiertarget then
                    MP.SendWebhook("Unban Player ["..baninfo.id.."]", "Staff : **["..xPlayer.idunique.."]** " ..xPlayer.name.."** \nPlayer Unban : **"..baninfo.sourceplayername.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206998770022228048/IazyNy4RPdHH9f4cJTBLzZKiB9ylIZ5s9vr2epNxk3U9gy8l7r0RIubdl5xW-c7Zz-1N")
                    MP.UnbanPlayerCheaterMonde(id)
                    xPlayer.showNotification("~g~Unban success")
                    
                else
                    xPlayer.showNotification("~r~You have not the permission for the execute command")
                end
           	end
        else
        	MP.UnbanPlayerCheaterMonde(id)
            MP.SendWebhook("Unban Player TXADMIN ["..baninfo.id.."]", "Player Unban : **"..baninfo.sourceplayername.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206998770022228048/IazyNy4RPdHH9f4cJTBLzZKiB9ylIZ5s9vr2epNxk3U9gy8l7r0RIubdl5xW-c7Zz-1N")
        end
end)
    

RegisterCommand("ban", function(source, args)
        local name, identifier
        if source ~= 0 then
        	xPlayer = MP.Player[source]
            if xPlayer.group == "user" then return end
            name = "["..xPlayer.idunique.."] " ..xPlayer.name
            identifier = xPlayer.identifier
        else
            name = "CONSOLE"
            identifier = "CONSOLE"
        end
        
        local xTarget = MP.GetPlayerFromIdUnique(tonumber(args[1]))
        local arga = ""
        for k,v in pairs(args) do
            if k ~= 1 then
        		arga = arga..v.. " " 
            end
    	end
        if arga == "" then return end
        if xTarget then
            MP.SendWebhook("Ban Player **[" ..xTarget.idunique.."] " ..xTarget.name.. "**", "Staff : **"..name.."** \nPlayer Ban : **[" ..xTarget.idunique.."] " ..xTarget.name.. "**", "Identifier : " ..identifier, "https://discord.com/api/webhooks/1208720264007786517/On1e_QcVKpYjGtu52c375HTxaQvG4fbLXUu9PK7xk2P3HwMWHtRpd9bfScjNXGkilbur")
            MP.BanPlayerCheaterMonde(xTarget.source, name, arga, xPlayer.identifier)
            if xPlayer then
            	xPlayer.showNotification("You have banned ["..xTarget.idunique.."] " ..xTarget.name)
            end
        end
end)

RegisterCommand("banid", function(source, args)
        if source == 0 then return end
        local xPlayer = MP.Player[source]
        if not xPlayer.cheatermonde then return end
        local bool, baninfos = getBanByIdFromIdentifiercheater(xPlayer.identifier)
        if not bool then xPlayer.showNotification("~r~Error") return end
        xPlayer.showNotification("Ban ID : " ..baninfos.id)
end)


--

local allbaninfo = {}

Citizen.CreateThread(function()
        MySQL.Async.fetchAll('SELECT * FROM MP_baninfo', {}, function(result)
                allbaninfo = result
                for i = 1, #allbaninfo do
                    allbaninfo[i].token = json.decode(allbaninfo[i].token)
                end
        end)
end)

local function IsAlreadyBanInfo(steam)
    for i = 1, #allbaninfo do
        if allbaninfo[i].identifier == steam then
            return true, allbaninfo[i]
        end
    end
    return false
end

function GenerateBanInfo(src)
	local license,identifier,liveid,xblid,discord,playerip,target
    for k,v in ipairs(GetPlayerIdentifiers(src))do
						if string.sub(v, 1, string.len("license:")) == "license:" then
							license = v
						elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
							identifier = v
						elseif string.sub(v, 1, string.len("live:")) == "live:" then
							liveid = v
						elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
							xblid  = v
						elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
							discord = v
						elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
							playerip = v
						end
	end
    lestoken[src] = {}
	for i = 0, GetNumPlayerTokens(src) - 1 do 
			table.insert(lestoken[src], GetPlayerToken(src, i))
	end
    if not IsAlreadyBanInfo(identifier) then
        table.insert(allbaninfo, {
                license = license,
                identifier = identifier,
                liveid = liveid,
                xblid = xblid,
                discord = discord,
                playerip = playerip,
                token = lestoken[src],
                sourceplayername = GetPlayerName(src),
       })

       MySQL.Async.execute("INSERT INTO MP_baninfo (identifier, license, liveid, xblid, discord, playerip, token, sourceplayername) VALUES (@identifier, @license, @liveid, @xblid, @discord, @playerip, @token, @sourceplayername)", {
                ['@identifier'] = identifier,
                ['@license'] = license,
                ['@liveid'] = liveid,
                ['@xblid'] = xblid,
                ['@discord'] = discord,
                ['@playerip'] = playerip,
                ['@token'] = json.encode(lestoken[src]),
                ['@sourceplayername'] = GetPlayerName(src),
       })
    end
end

local function BanPlayerOffline(steam, author, reason, identifiertarget, id)
    local bool, leban = IsAlreadyBanInfo(steam)
    if not bool then return "~r~Error with table baninfo" end
    local boole = getBanByIdcheater(id)
    if boole then return "~r~The player is already banned" end
    if reason == "" then reason = "Unknow" end
    table.insert(allbancheater, {
            license = leban.license,
            identifier = leban.identifier,
            liveid = leban.liveid,
            xblid = leban.xblid,
            discord = leban.discord,
            playerip = leban.playerip,
            token = leban.token,
            sourceplayername = leban.sourceplayername,
            targetplayername = author,
            reason = reason,
            id = id,
            identifiertarget = identifiertarget,
   })
   
   MySQL.Async.execute("INSERT INTO MP_cheater (identifier, license, liveid, xblid, discord, playerip, token, sourceplayername, targetplayername, reason, id, identifiertarget) VALUES (@identifier, @license, @liveid, @xblid, @discord, @playerip, @token, @sourceplayername, @targetplayername, @reason, @id, @identifiertarget)", {
            ['@identifier'] = leban.identifier,
            ['@license'] = leban.license,
            ['@liveid'] = leban.liveid,
            ['@xblid'] = leban.xblid,
            ['@discord'] = leban.discord,
            ['@playerip'] = leban.playerip,
            ['@token'] = json.encode(leban.token),
            ['@sourceplayername'] = leban.sourceplayername,
            ['@targetplayername'] = author,
            ['@reason'] = reason,
            ['@id'] = id,
            ['@identifiertarget'] = identifiertarget
   })
    return "~g~Ban " ..leban.sourceplayername.. " success"
end

RegisterCommand("banoffline", function(source, args)
        local id = tonumber(args[1])
        local arga = ""
        for k,v in pairs(args) do
            if k ~= 1 then
        		arga = arga..v.. " " 
            end
    	end
        if id == nil then return end
        local xPlayer = MP.Player[source]
        if xPlayer then
                if xPlayer.group == "user" then return end
                local bool, leuser = GetUserFromIdUnique(id)
                if bool then
                	local lereturn = BanPlayerOffline(leuser.identifier, xPlayer.name, arga, xPlayer.identifier, leuser.idunique)
               		xPlayer.showNotification(lereturn)
                else
                	xPlayer.showNotification("~r~Player doesn't exist")
                end
        end
end)