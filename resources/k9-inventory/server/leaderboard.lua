Citizen.CreateThread(function()
    while true do
        MySQL.Async.fetchAll("SELECT * FROM MP_user", {}, function(result)
            leaderboard = {}
            for i = 1, #result do
                local account = json.decode(result[i].account)
                local allstats = json.decode(result[i].stats)
                table.insert(leaderboard, {identifier = result[i].identifier, kills = allstats["pvp"].kill, deaths = allstats["pvp"].death, name = result[i].name, img = "", points = account.bank})
            end
            print(#leaderboard)
            sort_on_valueseeeeee(leaderboard, "kills")
            for i = 1, #leaderboard do
                Citizen.CreateThread(function()
                    local lapp = GetSteamPP(leaderboard[i].identifier)
                    leaderboard[i].img = lapp
                end)
                if i >= 4 then break end
            end
            Wait(5000)
            RefreshClientLeaderboard()
            print("refresh send")
        end)
        MySQL.Async.fetchAll("SELECT * FROM MP_crew", {}, function(resulte)
            leaderboardcrew = {}
		
            for i = 1, #resulte do
local aa = json.decode(resulte[i].stats)
                table.insert(leaderboardcrew, {name = resulte[i].name, stats = json.decode(resulte[i].stats), img = resulte[i].image, kills = aa["pvp"].kill })
            end
	
            sort_on_valueseeeeee(leaderboardcrew, "kills")
            
            RefreshClientLeaderboardCrew()
            print("refresh crew send")
        end)
        Citizen.Wait(1000 * 60 * 30)
    end
end)


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



function GetSteamPP(identifier)
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


function sort_on_valueseeeeee(t,a)
    table.sort(t, function (u,v)
        return
             tonumber(u[a])>tonumber(v[a])
    
    end)
end



function RefreshClientLeaderboard(src)
    if src then
        TriggerClientEvent("MP:RefreshLeaderbord", src, leaderboard)
    else
        TriggerClientEvent("MP:RefreshLeaderbord", -1, leaderboard)
    end
end

function RefreshClientLeaderboardCrew(src)
    print(leaderboardcrew)
    if src then
        TriggerClientEvent("MP:RefreshLeaderbordCrew", src, leaderboardcrew)
    else
        TriggerClientEvent("MP:RefreshLeaderbordCrew", -1, leaderboardcrew)
    end
end