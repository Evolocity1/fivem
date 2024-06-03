local weaponsByName = {}
local weaponsByHash = {}
local AllPlayerBucket = {}

function MP.GetAllPlayer()
    return MP.Player
end

function MP.MooveAllItemInProtected(src)
    local inventory = exports["k9-inventory"]:GetInventory(src, "inventory")
    exports["k9-inventory"]:ClearInventory(src, "inventory")
    for i = 1, #inventory do
        local name, count = inventory[i].name, inventory[i].count
        exports["k9-inventory"]:AddItem(src, "protected", name, count, "Moove All Items Protected Arena")
    end
end

function MP.GetPlayerFromPed(ped)
    for k, v in pairs(MP.Player) do
        if tostring(GetPlayerPed(v.source)) == tostring(ped) then
            return MP.Player[k]
        end
    end
    return false
end

function MP.RandomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end

local function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end

	local t={} ; i=1
    if input ~= nil then
        for str in string.gmatch(input, '([^'..seperator..']+)') do
            t[i] = str
            i = i + 1
        end
        return t
    end
end

local function GetIDFromSource(Type, CurrentID)
	local ID = stringsplit(CurrentID, ':')
	if (ID[1]:lower() == string.lower(Type)) then
		return ID[2]:lower()
	end
	return nil
end



function MP.GetPPSteam(identifier)
    local avatar = "https://avatars.cloudflare.steamstatic.com/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg"
    local callback = promise:new()
    PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', identifier), 16) .. '/?xml=1', function(Error, Content, Head)
        local SteamProfileSplitted = stringsplit(Content, '\n')
        if SteamProfileSplitted ~= nil and next(SteamProfileSplitted) ~= nil then
            for i, Line in ipairs(SteamProfileSplitted) do
                if Line:find('<avatarFull>') then
                    avatar = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
                    break
                end
            end
        end
        callback:resolve(avatar)
    end)
    return Citizen.Await(callback)
end


function MP.IsInSafezone(coordss)
    for i = 1, #Config.Safezone do
		if #(coordss-vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z)) < Config.Safezone[i].dist then
		    return true
		 end
	end 
	return false
end

local y = 0
function MP.GetClosestSafezone(coordss)
    y = 0
    for i = 1, #Config.Safezone do
		local diste = #(coordss-vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z))
		local distes = 1000000.0
		if y ~= 0 then
			distes = #(coordss-vector3(Config.Safezone[y].coords.x, Config.Safezone[y].coords.y, Config.Safezone[y].coords.z))
		end
		if diste < distes then
			y = i
			coords = vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z)
		end
	end 
	return coords
end

function MP.ChangeModeDeJeu(src, name)
	local xPlayer = MP.Player[src]
    if xPlayer.cheatermonde and name ~= "entrainement" then 
        xPlayer.ModeDeJeu = "pvp"
        MP.SetPlayerRoutingBucket(xPlayer.source, 8)
        TriggerClientEvent("MP:ChangeModeDeJeu", xPlayer.source, "pvp")
        return 
    end
	local bool, lemode = MP.GetModeDeJeu(name)
    if bool then
        xPlayer.ModeDeJeu = lemode.mode
        local add = lemode.id
        if lemode.mode == "entrainement" then
            add = xPlayer.idunique + 10
        end
        MP.SetPlayerRoutingBucket(xPlayer.source, add)
        TriggerClientEvent("MP:ChangeModeDeJeu", xPlayer.source, lemode.mode)
        if lemode.mode ~= "pvp" then
        	MP.SendWebhook("Changement de mode de jeu", GetPlayerName(xPlayer.source) .. " vient de rentré dans le mode " ..lemode.mode, "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1182683326566371349/eXQqum7hxDUiryU8OJcsWvZ-xygiR4dgbjHBGO167bGc-R6GNWkZz2anCB-MEcNJbVLu")
        end    
    end
end

function MP.GetModeDeJeu(name)
	for i = 1, #Config.ModeDeJeu do
		if Config.ModeDeJeu[i].mode == name then
			return true, Config.ModeDeJeu[i]
		end
	end
	return false
end

local function searchPlayerInRoutingBucket(src)
	for i = 1, #AllPlayerBucket do
		if AllPlayerBucket[i].src == src then
			return AllPlayerBucket[i].id, i
		end
	end
	return 0
end

function MP.RefreshClientRoutingBucket(src)
	if src then
		TriggerClientEvent("MP:RefreshPlayerBucket", src, AllPlayerBucket)
	else
		TriggerClientEvent("MP:RefreshPlayerBucket", -1, AllPlayerBucket)
	end
end

function MP.DeletePlayerRoutingBucket(src)
	local id, i = searchPlayerInRoutingBucket(src)
	table.remove(AllPlayerBucket, i)
	MP.RefreshClientRoutingBucket()
end

function MP.GetPlayerRoutingBucket(src)
	return searchPlayerInRoutingBucket(src)
end

function MP.SetPlayerRoutingBucket(src, id)
	local _, i = MP.GetPlayerRoutingBucket(src)
	if i ~= nil then
		AllPlayerBucket[i].id = id
	else
		table.insert(AllPlayerBucket, {src = src, id = id})
	end
	SetPlayerRoutingBucket(src, id)
	MP.RefreshClientRoutingBucket()
end

function MP.GetAllPlayerInRoutingBucket(id)
	local p = {}
	for i = 1, #AllPlayerBucket do
		if AllPlayerBucket[i].id == id then
			table.insert(p, AllPlayerBucket[i].src)
		end
	end
	return p
end

	

CreateThread(function()
	for index, weapon in pairs(Config.Weapons) do
		weaponsByName[weapon.name] = index
		weaponsByHash[GetHashKey(weapon.name)] = weapon
	end
end)


local function foundgroup(name)
	for i = 1, #MP.Group do
		if MP.Group[i] == name then
			return i
		end
	end
end

local function foundgroupmini(name)
	for i = 1, #MP.Group do
		if MP.Group[i] == name then
			return i 
		end
	end
end

function getDate()
	local hour = tonumber(os.date('%H')) + 2
	if hour >= 24 then
		hour = (tonumber(os.date('%H')) == 22) and 1 or 2
	end
	return os.date('%d/%m/%Y'), hour.. ":" ..os.date('%M'), hour.. ":" ..os.date('%M:%S'), hour .. ":" ..os.date('%M')
end

function IsPerm(maperm, laperm)
	local bool = foundgroup(maperm) >= foundgroupmini(laperm)
	return bool
end

function MP.GetWeaponLabel(weaponName)
	weaponName = string.upper(weaponName)

	local index = weaponsByName[weaponName]
	return Config.Weapons[index].label or ""
end

function MP.GetIdentifier(src)
    local identifier = ""
    local license = ""
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(v, 'steam:') then
          identifier = v
        end
        if string.match(v, 'license:') then
            license = v 
        end
    end
    return identifier, license
end

function MP.DropPlayer(src, raison, isconsole, id)
	if not isconsole then
		--MP.SendWebhook("Nouveau Kick", "[" ..src.. "] " ..GetPlayerName(src) .. " vient de se faire kick par [" ..id.. "] " ..GetPlayerName(id).. " pour la raison suivante : \n**" ..raison.. "**", "Kick by " ..MP.Player[id].identifier, "https://discord.com/api/webhooks/1142978684194672771/ERubn5OhHUk2D8L-5gRratPxam9minMxVhRo-p-qtYqnnW4GVNEQGHFyK24P0JyPoV3W")
	else
		--MP.SendWebhook("Nouveau Kick", "[" ..src.. "] " ..GetPlayerName(src) .. " vient de se faire kick par la console ou le serveur pour la raison suivante : \n**" ..raison.. "**", "", "https://discord.com/api/webhooks/1142978684194672771/ERubn5OhHUk2D8L-5gRratPxam9minMxVhRo-p-qtYqnnW4GVNEQGHFyK24P0JyPoV3W")
	end
    DropPlayer(src, raison)
    
end

function MP.GetPlayerFromId(src)
    return MP.Player[src]
end

function MP.GetPlayerFromIdUnique(id)
	for k, v in pairs(MP.Player) do
		if tonumber(v.idunique) == tonumber(id) then
			return MP.Player[tonumber(v.source)]
		end
	end
	return false
end

function MP.GetPlayerFromIdentifier(identifier)
	for k, v in pairs(MP.Player) do
		if v.identifier == identifier then
			return MP.Player[v.source]
		end
	end
	return false
end

function MP.GetPlayers()
	return MP.Player
end

function MP.SavePlayer(src)
	local xPlayer = MP.Player[src]
	updateUser(xPlayer.identifier, {account = xPlayer.getAccount(), group = xPlayer.group, coin = xPlayer.coin, position = {x = GetEntityCoords(GetPlayerPed(xPlayer.source)).x, y = GetEntityCoords(GetPlayerPed(xPlayer.source)).y, z = GetEntityCoords(GetPlayerPed(xPlayer.source)).z, h = GetEntityHeading(GetPlayerPed(xPlayer.source))}})
       MySQL.Async.execute('UPDATE MP_user SET account = @account, groupe = @groupe, job = @job, job_grade = @job_grade, job2 = @job2, job2_grade = @job2_grade, position = @position, coin = @coin WHERE identifier = @identifier', {
                    ['@account'] = json.encode(xPlayer.getAccount()),
                    ['@groupe'] = xPlayer.group,
                    ['@position'] = json.encode({x = GetEntityCoords(GetPlayerPed(xPlayer.source)).x, y = GetEntityCoords(GetPlayerPed(xPlayer.source)).y, z = GetEntityCoords(GetPlayerPed(xPlayer.source)).z, h = GetEntityHeading(GetPlayerPed(xPlayer.source))}),
                    ['@coin'] = xPlayer.coin,
                    ['@identifier'] = xPlayer.identifier
                
        })
end

function MP.DumpTable(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for _ = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k, v in pairs(table) do
			if type(k) ~= 'number' then k = '"' .. k .. '"' end
			for _ = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '[' .. k .. '] = ' .. MP.DumpTable(v, nb + 1) .. ',\n'
		end

		for _ = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(table)
	end
end

function MP.RandomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end

function MP.Random(low, gre)
	return math.random(low, gre)
end

function MP.SendWebhook(name, msg, footer, webhook, color)
	local lacolor = tonumber(color) ~= nil and tonumber(color) or 16753920
	local embed = {
		{
			["color"] = lacolor,
			["title"] = "**".. name .."**",
			["description"] = msg,
			["footer"] = {
                ["text"] = footer,
            },
		}
	}

  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function MP.Round(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10 ^ numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

-- credit http://richard.warburton.it
function MP.GroupDigits(value)
	local left, num, right = string.match(value, '^([^%d]*%d)(%d*)(.-)$')

	return left .. (num:reverse():gsub('(%d%d%d)', '%1' .. " "):reverse()) .. right
end

function MP.Trim(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end