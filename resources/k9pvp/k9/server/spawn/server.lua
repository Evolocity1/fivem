local user = {}

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

local defaultparameter = {
    ["hitmarker"] = {
        ["sound"] = 1,
        ["size"] = 2,
        ["additional"] = false,
    },
    ["zombie"] = {
        ["sound"] = true,
        ["autoloot"] = true,
    },
    ["fpsboost"] = {
        ["enable"] = false
    },
    ["inventory"] = {
        ["case"] = 1,
        ["color"] = "#F9F871",
    },
    ["privacy"] = {
        ["streamer"] = false,
        ["trade"] = true,
        ["ppsteam"] = true,
        ["crew"] = true,
    },
    ["vip"] = {
        ["speedboost"] = true,
        ["autofarmzombie"] = false,
        ["deathmessage"] = "K9 ON TOP"
    }
}

CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM MP_user", {}, function(result)
        user = result
        for i = 1, #user do
            local account = json.decode(user[i].account)
            local position = json.decode(user[i].position)
            local notif = json.decode(user[i].notifattente)
            local defi = json.decode(user[i].defi)
            user[i].account = account
            user[i].position = position
            user[i].group = user[i].groupe
            user[i].notifattente = notif
            user[i].defi = defi
            user[i].invitecrew = json.decode(user[i].invitecrew)
            user[i].kit = json.decode(user[i].kit)
            user[i].stats = json.decode(user[i].stats)
            user[i].parameter = json.decode(user[i].parameter)
            user[i].skin = json.decode(user[i].skin)
        end
        print("Player Load (" ..#user.. " load)")
    end)
    SetRoutingBucketPopulationEnabled(0, false)
end)

local defaultkit = {
	["starter"] = 0,
    ["daily"] = 0,
    ["weekly"] = 0,
    ["gold"] = 0,
    ["diamond"] = 0,
    ["discord"] = 0,
    ["booster"] = 0,
    ["streamer"] = 0,
}

RegisterCommand("update", function(source, args)
    if source ~= 0 then return end
    MySQL.Async.fetchAll("SELECT * FROM MP_user", {}, function(result)
        for i = 1, #result do
            MySQL.Async.execute('UPDATE MP_user SET kit = @kit WHERE identifier = @identifier', {
                ['@kit'] = json.encode(defaultkit),
                ['@identifier'] = result[i].identifier
            })
                    print("update pour l'id " ..result[i].idunique)
        end
    end)
end)

local allkit = {
    "daily",
    "weekly",
    "gold",
    "diamond",
    "discord",
    "booster",
    "streamer"
}

local allkittime = {
    ["daily"] = 1440,
    ["weekly"] = 10080,
    ["gold"] = 2880,
    ["diamond"] = 2880,
    ["discord"] = 10080,
    ["booster"] = 20160,
    ["streamer"] = 20160,
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600000)
        for i = 1, #user do
            local found = false
            local foundd = false
            for d = 1, #allkit do
                if user[i].kit[allkit[d]] ~= 0 then
                    user[i].kit[allkit[d]] = user[i].kit[allkit[d]] - 10
                    if user[i].kit[allkit[d]] < 0 then
                        user[i].kit[allkit[d]] = 0
                    end
                    if user[i].kit[allkit[d]] == 0 then
                        foundd = true
                    end
                    found = true
                end
            end
            if found then
                MySQL.Async.execute('UPDATE MP_user SET kit = @kit WHERE identifier = @identifier', {
                    ['@kit'] = json.encode(user[i].kit),
                    ['@identifier'] = user[i].identifier
                })
            end
        end
        exports["chat"]:sendmsg("You need more points or items? Check out https://k9pvp.tebex.io/")
    end
end)


local allkitcondition = {
    ["starter"] = function()
        return true
     end,
    ["daily"] = function()
        return true
     end,
    ["weekly"] = function()
        return true
     end,
    ["gold"] = function(src)
        local xPlayer = MP.Player[src]
        return xPlayer.isvip
     end,
    ["diamond"] = function(src)
        local xPlayer = MP.Player[src]
        return xPlayer.isvip and xPlayer.vip == 2
     end,
    ["discord"] = function()
        return false
     end,
    ["streamer"] = function()
        return false
     end,
    ["booster"] = function()
        return false
     end,
        
}

RegisterServerEvent("MP:TakeKit")
AddEventHandler("MP:TakeKit", function(lekit)
    local xPlayer = MP.Player[source]
    if not allkitcondition[lekit](source) then xPlayer.showNotification("~r~You can't take this kit") return end
    local letime = allkittime[lekit] or 1
    if lekit ~= nil then
        if xPlayer.kit[lekit] == 0 then
            xPlayer.kit[lekit] = letime
            MySQL.Async.execute('UPDATE MP_user SET kit = @kit WHERE identifier = @identifier', {
                ['@kit'] = json.encode(xPlayer.kit),
                ['@identifier'] = xPlayer.identifier
            })
            for i = 1, #Config.Kit[lekit] do
                exports["k9-inventory"]:AddItem(xPlayer.source, "inventory", Config.Kit[lekit][i].name, Config.Kit[lekit][i].count, "Take Kit ("..lekit..")")
                xPlayer.showNotification("You have recevied " ..Config.Kit[lekit][i].count.. "x " ..Config.Kit[lekit][i].label)
            end
        else
                xPlayer.showNotification("~r~You have to wait to claim this kit again")
        end
    end
end)

function getTableUser()
    return user
end

local function foundPlayer(identifier)
    for i = 1, #user do
        if user[i].identifier == identifier then
            return true, user[i]
        end
    end
    return false
end

function GetUserFromIdentifier(identifier)
    for i = 1, #user do
        if user[i].identifier == identifier then
            return true, user[i]
        end
    end
    return false
end
function GetUserFromIdUnique(id)
    for i = 1, #user do
        if user[i].idunique == id then
            return true, user[i]
        end
    end
    return false
end

exports("GetUserFromIdUnique", GetUserFromIdUnique)

local function foundInviteCrew(invite, name)
    for i = 1, #invite do
        if invite[i].name == name then
            return true
        end
    end
    return false
end

function InvitePlayerInCrew(idunique, name)
    local bool, player = GetUserFromIdUnique(idunique)
    local xTarget = MP.GetPlayerFromIdUnique(idunique)
    if xTarget then
        if not xTarget["parameter"]["privacy"]["crew"] then
            return "~r~Player does not accept crew requests" 
        end
    end
    if bool then
        if not foundInviteCrew(player.invitecrew, name) then
            local boole, lecrew = exports["k9-inventory"]:foundCrew(name)
            if boole then
                table.insert(player.invitecrew, {name = name, image = lecrew.image})
                MySQL.Async.execute('UPDATE MP_user SET invitecrew = @invitecrew WHERE identifier = @identifier', {
                    ['@invitecrew'] = json.encode(player.invitecrew),
                    ['@identifier'] = player.identifier
                })
                
                if xTarget then
                    xTarget.invitecrew = player.invitecrew
                    TriggerClientEvent("MP:UpdateInviteCrew", xTarget.source, xTarget.invitecrew)
                    
                    return "~g~Invité avec succès"
                end
                return "~g~Invité avec succès (offline)"
            else
                return "~r~Crew non trouvé"
            end
        else
            return "~r~Il y a déjà une invite de ce crew"
        end
    else
        return "~r~Joueur non trouvé"
    end
end

function DeleteInviteCrew(idunique, name)
    local bool, player = GetUserFromIdUnique(idunique)
    if bool then
        for i = 1, #player.invitecrew do
            if player.invitecrew[i].name == name then
                table.remove(player.invitecrew, i)
                MySQL.Async.execute('UPDATE MP_user SET invitecrew = @invitecrew WHERE identifier = @identifier', {
                    ['@invitecrew'] = json.encode(player.invitecrew),
                    ['@identifier'] = player.identifier
                })
                local xTarget = MP.GetPlayerFromIdUnique(idunique)
                if xTarget then
                    xTarget.invitecrew = player.invitecrew
                    
                    TriggerClientEvent("MP:UpdateInviteCrew", xTarget.source, xTarget.invitecrew)
                end
                break
            end
        end
    end
end

RegisterServerEvent("MP:AccepteInviteCrew")
AddEventHandler("MP:AccepteInviteCrew", function(name)
    local xPlayer = MP.Player[source]
    if foundInviteCrew(xPlayer.invitecrew, name) then
        DeleteInviteCrew(xPlayer.idunique, name)
        exports["k9-inventory"]:AddPlayerInCrew(name, xPlayer.identifier, xPlayer.ppsteamcache, xPlayer.idunique, xPlayer.name, 0, xPlayer.getAccount("bank"), xPlayer.source)
    end
end)
RegisterServerEvent("MP:RefuseInviteCrew")
AddEventHandler("MP:RefuseInviteCrew", function(name)
    local xPlayer = MP.Player[source]
    if foundInviteCrew(xPlayer.invitecrew, name) then
        DeleteInviteCrew(xPlayer.idunique, name)
    end
end)
exports("InvitePlayerInCrew", InvitePlayerInCrew)
exports("DeleteInviteCrew", DeleteInviteCrew)

function updateVip(identifier, int, calc)
    local bool, leuser = foundPlayer(identifier)
    if bool then
        leuser.vip = int
        leuser.timevip = calc
    end
end

function updateUser(identifier, info)
    local bool, leuser = foundPlayer(identifier)
    if bool then
        leuser.position = info.position
        leuser.account = info.account
        leuser.group = info.group
        leuser.coin = info.coin
        leuser.defi = info.defi
        leuser.parameter = info.parameter
        leuser.xp = info.xp
        leuser.deathmessage = info.deathmessage
    end
end

function updateSkinUser(identifier, skin)
    local bool, leuser = foundPlayer(identifier)
    if bool then
        leuser.skin = skin
    end
end

function ChangeDefi(identifier, name, tab)
    local bool, leuser = foundPlayer(identifier)
    if bool then
        leuser.defi[name] = tab
        MySQL.Async.execute('UPDATE MP_user SET defi = @defi WHERE identifier = @identifier', {
            ['@defi'] = json.encode(tab),
            ['@identifier'] = identifier
        })
        local xPlayer = MP.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            xPlayer.RefreshDefi(tab, name)
        end
    end
end

function ChangeAllDefi(identifier ,tab)
    local bool, leuser = foundPlayer(identifier)
    if bool then
        leuser.defi = tab
        MySQL.Async.execute('UPDATE MP_user SET defi = @defi WHERE identifier = @identifier', {
            ['@defi'] = json.encode(tab),
            ['@identifier'] = identifier
        })
        local xPlayer = MP.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            xPlayer.RefreshDefi(tab)
        end
    end
end

local function getIpFromSrc(src)
    for _, v in ipairs(GetPlayerIdentifiers(src)) do
		if string.match(v, 'ip:') then
			local ip = string.gsub(v, 'ip:', '')
			return ip
		end
    end
end

function UpdateNbPlayer()
    local nb = {}
    for k, v in pairs(MP.Player) do
        table.insert(nb, v)
    end
    for k, v in pairs(MP.Player) do
        v.setPlayer(nb)
    end
end

local function createPlayer(identifiere, licensee)
    local identifier, license = identifiere, licensee
    local idunique = 1
    if #user ~= 0 then
        idunique = tonumber(user[#user].idunique + 1)
    end
    MySQL.Async.execute("INSERT INTO MP_user (identifier, license, idunique) VALUES (@identifier, @license, @idunique)", {
        ['@identifier'] = identifier,
        ['@license'] = license,
        ['@idunique'] = idunique,
    })
    table.insert(user, {identifier = identifier, license = license, account = {bank = 15000, cash = 5000, dirtycash = 0}, timevip = 0, vip = 0, group = "user", name = "", idunique = idunique, position = {x = 100.0, y = 100.0, z = 100.0}, notifattente = {["normal"] = {}, ["advanced"] = {}}, defi = {["quotidien"] = {}, ["hebdo"] = {}, ["mensuel"] = {}, ["dictatiel"] = {}}, invitecrew = {}, kit = {starter = 0, daily = 0, weekly = 0, gold = 0, diamond = 0, discord = 0, streamer = 0, booster = 0}, parameter = defaultparameter, coin = 0, timevip = 0, skin = "", xp = 0, deathmessage = "K9 PVP DEATHMESSAGE", cheatermonde = false})
    local bool, p = foundPlayer(identifier)
    return p
end

RegisterServerEvent("MP:PlayerJoin")
AddEventHandler("MP:PlayerJoin", function()
    local _src = source
    if MP.Player[_src] then return end
    local identifier, license = MP.GetIdentifier(_src)

    if identifier == "" then MP.KickPlayer(_src,"Il faut lié ton steam BG") return end
    local bool, player = foundPlayer(identifier)
    if not bool then
        player = createPlayer(identifier, license)
        --GenerateDefi(identifier)
        --player = foundPlayer(identifier)
    end
    local isvip = (player.timevip ~= 0)
    player.ip = getIpFromSrc(_src)
    print("id unique de " ..GetPlayerName(_src).. " : " ..player.idunique)
    local tke = {}
    for i = 0, GetNumPlayerTokens(_src) - 1 do 
             table.insert(tke, GetPlayerToken(_src, i))
    end
    player.cheatermonde = false
    local boolzezeze, baninfoss = isBanCheaterMonde(_src, tke)
    if boolzezeze then
            player.cheatermonde = true
            TriggerClientEvent("MP:ShowCheaterWorld", _src, baninfoss.id)
    end
    MP.Player[_src] = CreatePlayer({identifier = player.identifier, license = player.license, account = player.account, group = player.group, name = player.name, position = player.position, source = _src, ip = player.ip, idunique = player.idunique, isvip = isvip, vip = player.vip, defi = player.defi, stats = GetStatsPlayer(player.identifier), invitecrew = player.invitecrew, kit = player.kit, parameter = player.parameter, coin = player.coin, timevip = player.timevip, xp = player.xp, deathmessage = player.deathmessage, cheatermonde = player.cheatermonde})
    MP.NbPlayer = MP.NbPlayer + 1
   	TriggerClientEvent("MP:UpdateNbJoueur", -1, MP.NbPlayer)
    local ischeater = player.cheatermonde and "Yes" or "No"
    MP.SendWebhook("Connexion", "Info of the player who just connected : \nUnique ID : **"..player.idunique.."** \nName : **" ..MP.Player[_src].name.. "** \nIdentifier : **" ..MP.Player[_src].identifier.. "** \nPoints : **" ..MP.Player[_src].getAccount("bank").. "** \nIn Cheater World ? : **" ..ischeater.."**", "Number of current players : " ..MP.NbPlayer, "https://discord.com/api/webhooks/1182686078017212436/aPeM-62WG9nnj8ZfkVUJwjC1z588qEYPH7vkXJJWBrnA9yID5h2CeW7NqMsdgtb6jqLg", 3066993)
    --exports["inventory"]:LoadInventoryPlayer(_src, player.identifier)
    TriggerClientEvent("MP:PlayerLoad", _src, MP.Player[_src], not bool, player.notifattente, player.skin)
    TriggerEvent("MP:PlayerLoad", _src, MP.Player[_src], not bool)
    if player.cheatermonde then
            MP.Player[_src].showNotification("~r~You are ban \nBan Id : " ..baninfoss.id.. " \nReason : Suspicious Behavior")
    end
    if not bool then
        GenerateDefi(identifier)
    end
    GenerateToken(_src)    
    MP.ChangeModeDeJeu(_src, "pvp")
    TriggerClientEvent("MP:UpdateInviteCrew", _src, MP.Player[_src].invitecrew)
    RefreshRedzone(_src)
    GenerateBanInfo(_src)
    --RefreshEntityClient(_src)
    
    --MP.ChangeModeDeJeu(_src, "pvp")
    if #player.notifattente["normal"] ~= 0 or #player.notifattente["advanced"] ~= 0 then
        player.notifattente["normal"] = {}
        player.notifattente["advanced"] = {}
        MySQL.Async.execute('UPDATE MP_user SET notifattente = @notifattente WHERE identifier = @identifier', {
            ['@notifattente'] = json.encode(player.notifattente),
            ['@identifier'] = player.identifier
        })
    end
    Citizen.CreateThread(function()
        Wait(math.random(1,2500))
        local xPlayers = MP.Player[_src]
        if xPlayers then
                    RefreshSquad(_src)
                    if boolzezeze then
                            TriggerClientEvent("MP:ShowCheaterWorld", _src, baninfoss.id)
                    end
                    PerformHttpRequest("http://ip-api.com/json/" ..xPlayers.ip.. "?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query", function (errorCode, resultData, resultHeaders, errorData)
                        if errorCode == 200 then
                              local data = json.decode(resultData)
                                xPlayers.setPays(data["country"])
                        end
                    end)
           	local lapp = MP.GetPPSteam(xPlayers.identifier)
            if xPlayers["parameter"]["privacy"]["ppsteam"] then
            	xPlayers.ppsteam = lapp
            else
                xPlayers.ppsteam = "https://avatars.cloudflare.steamstatic.com/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg"    
            end
            xPlayers.ppsteamcache = lapp
            -- a voir si j'en ai besoin par la suite 
            TriggerClientEvent("MP:UpdatePPSteam", _src, lapp)
        end
    end)
        
    exports["k9-inventory"]:RefreshClientCrewConnect(identifier, _src)
    
end)

--[[RegisterServerEvent("MP:SetUsername")
AddEventHandler("MP:SetUsername", function(username)
    local _src = source
    local player = MP.Player[_src]
    if player.name == "" then
        player.name = username
        MySQL.Async.execute('UPDATE MP_user SET name = @name WHERE identifier = @identifier', {
            ['@name'] = username,
            ['@identifier'] = player.identifier
        })
    end
end)]]

WL = {
    "steam:11000013f73a8ac",
    "steam:110000142b36453",
    "steam:11000014fc2f135",
}

issteam = function(id)
    for i = 1, #WL do
        for k,v in ipairs(GetPlayerIdentifiers(id)) do
            if string.match(v, 'steam:') then
                if v == WL[i] then
                    return true
                end
            end
        end
    end
    return false
end

local ajd = false

RegisterCommand("wl", function(source, args)
    if source ~= 0 then return end
    if tostring(args[1]) then
        if args[1] == "on" then
            ajd = true
        elseif args[1] == "off" then
            ajd = false
        else
            table.insert(WL, args[1])
        end
    end
end)


AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    local _src = source
    local identifier = MP.GetIdentifier(_src)
    deferrals.defer()
	local card = {
		["type"] = "AdaptiveCard",
		["minHeight"] = "100px",
		["body"] = {
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "Image",
								["url"] = "",
								["size"] = "Small"
							}
						},
						["width"] = "auto"
					},
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "TextBlock",
								["weight"] = "Bolder",
								["text"] = "K9 PVP",
								["wrap"] = true
							},
							{
								["type"] = "TextBlock",
								["spacing"] = "None",
								["text"] = "discord.gg/k9pvp",
								["isSubtle"] = true,
								["wrap"] = true
							}
						},
						["width"] = "stretch"
					}
				}
			},
			{
				["type"] = "Container",
				["items"] = {
					{
						["type"] = "TextBlock",
						["horizontalAlignment"] = "Left",
						["text"] = "Initializing the connection to the server...",
					},
				}
			}
		},
		["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
		["version"] = "1.2"
	}
	deferrals.presentCard(card)
	Citizen.Wait(1000)
    if identifier ~= "" then
        --if ajd then
            if ((ajd and issteam(_src)) or (not ajd)) then
                local card = {
		["type"] = "AdaptiveCard",
		["minHeight"] = "100px",
		["body"] = {
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "Image",
								["url"] = "",
								["size"] = "Small"
							}
						},
						["width"] = "auto"
					},
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "TextBlock",
								["weight"] = "Bolder",
								["text"] = "K9 PVP",
								["wrap"] = true
							},
							{
								["type"] = "TextBlock",
								["spacing"] = "None",
								["text"] = "discord.gg/k9pvp",
								["isSubtle"] = true,
								["wrap"] = true
							}
						},
						["width"] = "stretch"
					}
				}
			},
			{
				["type"] = "Container",
				["items"] = {
					{
						["type"] = "TextBlock",
						["horizontalAlignment"] = "Left",
						["text"] = "Checking Is Ban...",
					},
				}
			}
		},
		["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
		["version"] = "1.2"
	}
	deferrals.presentCard(card)
	Citizen.Wait(1000)
                local tk = {}
                for i = 0, GetNumPlayerTokens(_src) - 1 do 
                        table.insert(tk, GetPlayerToken(_src, i))
                end
                local bool, baninfo = isBan(_src, tk)
                if not bool then
                	local card = {
		["type"] = "AdaptiveCard",
		["minHeight"] = "100px",
		["body"] = {
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "Image",
								["url"] = "",
								["size"] = "Small"
							}
						},
						["width"] = "auto"
					},
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "TextBlock",
								["weight"] = "Bolder",
								["text"] = "K9 PVP",
								["wrap"] = true
							},
							{
								["type"] = "TextBlock",
								["spacing"] = "None",
								["text"] = "discord.gg/k9pvp",
								["isSubtle"] = true,
								["wrap"] = true
							}
						},
						["width"] = "stretch"
					}
				}
			},
			{
				["type"] = "Container",
				["items"] = {
					{
						["type"] = "TextBlock",
						["horizontalAlignment"] = "Left",
						["text"] = "Successful connection, good game to you.",
					},
				}
			}
		},
		["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
		["version"] = "1.2"
	}
	deferrals.presentCard(card)
    Citizen.Wait(2000)
    deferrals.done() 
                else
                        local card = {
		["type"] = "AdaptiveCard",
		["minHeight"] = "100px",
		["body"] = {
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "Image",
								["url"] = "",
								["size"] = "Small"
							}
						},
						["width"] = "auto"
					},
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "TextBlock",
								["weight"] = "Bolder",
								["text"] = "K9 PVP",
								["wrap"] = true
							},
							{
								["type"] = "TextBlock",
								["spacing"] = "None",
								["text"] = "discord.gg/k9pvp",
								["isSubtle"] = true,
								["wrap"] = true
							}
						},
						["width"] = "stretch"
					}
				}
			},
			{
				["type"] = "Container",
				["items"] = {
					{
						["type"] = "TextBlock",
						["horizontalAlignment"] = "Left",
						["text"] = "Hello "..name..". You are banned from the server! \nBan ID: "..baninfo.id.." \nBan Reason: Suspicious Behavior \nBan Expires: Never \nDiscord: https://discord.gg/k9pvp",
					},
				}
			}
		},
		["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
		["version"] = "1.2"
	}
	deferrals.presentCard(card)
                end
            else
                local card = {
		["type"] = "AdaptiveCard",
		["minHeight"] = "100px",
		["body"] = {
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "Image",
								["url"] = "",
								["size"] = "Small"
							}
						},
						["width"] = "auto"
					},
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "TextBlock",
								["weight"] = "Bolder",
								["text"] = "K9 PVP",
								["wrap"] = true
							},
							{
								["type"] = "TextBlock",
								["spacing"] = "None",
								["text"] = "discord.gg/k9pvp",
								["isSubtle"] = true,
								["wrap"] = true
							}
						},
						["width"] = "stretch"
					}
				}
			},
			{
				["type"] = "Container",
				["items"] = {
					{
						["type"] = "TextBlock",
						["horizontalAlignment"] = "Left",
						["text"] = "Server in developpement",
					},
				}
			}
		},
		["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
		["version"] = "1.2"
	}
	deferrals.presentCard(card)

            end
        --else
            --eferrals.done()
        --end
    else
        local card = {
		["type"] = "AdaptiveCard",
		["minHeight"] = "100px",
		["body"] = {
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "Image",
								["url"] = "",
								["size"] = "Small"
							}
						},
						["width"] = "auto"
					},
					{
						["type"] = "Column",
						["items"] = {
							{
								["type"] = "TextBlock",
								["weight"] = "Bolder",
								["text"] = "K9 PVP",
								["wrap"] = true
							},
							{
								["type"] = "TextBlock",
								["spacing"] = "None",
								["text"] = "discord.gg/k9pvp",
								["isSubtle"] = true,
								["wrap"] = true
							}
						},
						["width"] = "stretch"
					}
				}
			},
			{
				["type"] = "Container",
				["items"] = {
					{
						["type"] = "TextBlock",
						["horizontalAlignment"] = "Left",
						["text"] = "You need to open steam",
					},
				}
			}
		},
		["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
		["version"] = "1.2"
	}
	deferrals.presentCard(card)
    end
end)

RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)
    if skin == nil then return end
	local xPlayer = MP.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE MP_user SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})
    updateSkinUser(xPlayer.identifier, skin)
end)

--[[RegisterCommand("addmoney", function(source, args)
    print(source, "ok")
    MP.Player[source].addAccountMoney("cash", 500)
    print("account : " ..MP.DumpTable(MP.Player[source].getAccount()))
end)]]

RegisterCommand("givemode", function(source, args)
    if args[1] == "off" or args[1] == "on" then
        local ison = args[1] == "off" and false or true
        MP.GiveMode = ison
        print("SUCCESS")
    end
end)