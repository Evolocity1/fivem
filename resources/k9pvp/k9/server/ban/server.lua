local allban = {}
Citizen.CreateThread(function()
        MySQL.Async.fetchAll('SELECT * FROM MP_ban', {}, function(result)
                allban = result
        end)
end)

local function checkBanToken(alltoken, mytoken)
    for i = 1, #alltoken.token do
        for d = 1, #mytoken do
            if alltoken.token[i] == mytoken[d] then
                return true
            end
        end
    end
    return false
end

local function checkBan(ide)
        for i = 1, #allban do
            if allban[i].identifier == ide or allban[i].license == ide or allban[i].xblid == ide or allban[i].discord == ide or allban[i].liveid == ide then
                return true, allban[i]
            end
        end
    return false
end

function isBan(src, token)
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        local bool, baninfo = checkBan(v)
        if bool then
            return true, baninfo
        end
    end
    for i = 1, #allban do
        local bool, baninfo = checkBanToken(allban[i], token)
    	if bool then
            return true, allban[i]
        end
    end
    return false
end

local function getBanById(id)
    for i = 1, #allban do
        if allban[i].id == id then
            return true, allban[i], i
        end
    end
    return false
end

local lestoken = {}

function MP.BanPlayer(src, author, reason)
    local id = 0
    if #allban >= 1 then
    	id = tonumber(allban[#allban].id + 1)
    else
        id = 1
    end
    local xPlayer = MP.Player[src]
    local name = xPlayer and "["..xPlayer.idunique.."] " ..xPlayer.name or GetPlayerName(src)
    local identifiertarget = xPlayer and xPlayer.identifier or "BAN ANTICHEAT"
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
    lestoken[src] = {}
	for i = 0, GetNumPlayerTokens(src) - 1 do 
			table.insert(lestoken[src], GetPlayerToken(src, i))
	end
    table.insert(allban, {
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
   
   MySQL.Async.execute("INSERT INTO MP_ban (identifier, license, liveid, xblid, discord, playerip, token, sourceplayername, targetplayername, reason, id, identifiertarget) VALUES (@identifier, @license, @liveid, @xblid, @discord, @playerip, @token, @sourceplayername, @targetplayername, @reason, @id, @identifiertarget)", {
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
   DropPlayer(src, "Banned for reason : Suspicious Behavior")
end

function MP.UnbanPlayer(idban)
    local bool, baninfo, i = getBanById(idban)
    if bool then
        MySQL.Async.execute('DELETE FROM MP_ban WHERE identifier = @identifier', {  
            ['@identifier'] = baninfo.identifier,
        })
        table.remove(allban, i)
    end
end

RegisterCommand("unbl", function(source, args)
        local id = tonumber(args[1])
        if id == nil then return end
        if source ~= 0 then
        	local xPlayer = MP.Player[source]
            if not IsPerm(xPlayer.group, "admin") then return end
            local bool, baninfo = getBanById(id)
            if not bool then xPlayer.showNotification("~r~The ban doesn't exist") return end
            if IsPerm(xPlayer.group, "admin") then
                MP.SendWebhook("Unban Player ["..baninfo.id.."]", "Staff : **["..xPlayer.idunique.."]** " ..xPlayer.name.."** \nPlayer Unban : **"..baninfo.sourceplayername.."** ", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206998770022228048/IazyNy4RPdHH9f4cJTBLzZKiB9ylIZ5s9vr2epNxk3U9gy8l7r0RIubdl5xW-c7Zz-1N")
                MP.UnbanPlayer(id)
                
                xPlayer.showNotification("~g~Unban success")
            else
                if xPlayer.identifier == baninfo.identifiertarget then
                    MP.SendWebhook("Unban Player ["..baninfo.id.."]", "Staff : **["..xPlayer.idunique.."]** " ..xPlayer.name.."** \nPlayer Unban : **"..baninfo.sourceplayername.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206998770022228048/IazyNy4RPdHH9f4cJTBLzZKiB9ylIZ5s9vr2epNxk3U9gy8l7r0RIubdl5xW-c7Zz-1N")
                    MP.UnbanPlayer(id)
                    xPlayer.showNotification("~g~Unban success")
                    
                else
                    xPlayer.showNotification("~r~You have not the permission for the execute command")
                end
           	end
        else
        	MP.UnbanPlayer(id)
            MP.SendWebhook("Unban Player TXADMIN ["..baninfo.id.."]", "Player Unban : **"..baninfo.name.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206998770022228048/IazyNy4RPdHH9f4cJTBLzZKiB9ylIZ5s9vr2epNxk3U9gy8l7r0RIubdl5xW-c7Zz-1N")
        end
end)
    

RegisterCommand("bl", function(source, args)
        local name, identifier
        if source ~= 0 then
        	xPlayer = MP.Player[source]
            if not IsPerm(xPlayer.group, "admin") then return end
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
            MP.SendWebhook("Ban Player **[" ..xTarget.idunique.."] " ..xTarget.name.. "**", "Staff : **"..name.."** \nPlayer Ban : **[" ..xTarget.idunique.."] " ..xTarget.name.. "**", "Identifier : " ..identifier, "https://discord.com/api/webhooks/1207000301681385553/o4y9yno8FvfpVzvbJyoqkWdpBiWOD7hjQzlZYxP-iJcwcHp1Vasl2v8xSnFwNL2_yUDY")
            MP.BanPlayer(xTarget.source, name, arga)
        end
end)


--

