local lesdefi = {}
local function searchtamere(src, k, id)
    for i = 1, #lesdefi[src][k] do
        if lesdefi[src][k][i].id == id then
            return true
        end
    end
    return false
end
local function GenerateAll(src)
    lesdefi[src] = {}
    for k, v in pairs(MP.AllDefi) do
        if lesdefi[src][k] == nil then lesdefi[src][k] = {} end
        while #lesdefi[src][k] ~= 7 do
            Citizen.Wait(1)
            local stonelerandom = v[math.random(1, #v)]
            if not searchtamere(src, k, stonelerandom.id) then
                local randoms = tostring(math.random(stonelerandom.mini, stonelerandom.maxe))
                local abc = randoms
                local nb = 0
                if tonumber(randoms) >= 50 then
                    if (tonumber(string.sub(tostring(randoms), -1)) >= 2.5 and tonumber(string.sub(tostring(randoms), -1)) <= 7.5) then
                        nb = 5
                    else
                        if tonumber(string.sub(tostring(randoms), -1)) >= 7.5 then
                            randoms = tostring(tonumber(randoms) + 5)
                        end
                    end
                    local subs = string.sub(tostring(randoms), -1)
                    randoms = string.reverse(randoms)
                    randoms = string.gsub(randoms, subs, nb, 1)
                    randoms = string.reverse(randoms)
                end
                table.insert(lesdefi[src][k], {id = stonelerandom.id, label = stonelerandom.label, value = 0, maxvalue = tonumber(randoms), bool = false})
            end
        end
    end
    return lesdefi[src]
end

local function GenerateOne(src, name)
    lesdefi[src] = {}
    lesdefi[src][name] = {}
    while #lesdefi[src][name] ~= 7 do
        local stonelerandom = MP.AllDefi[name][math.random(1, #MP.AllDefi[name])]
        if not searchtamere(src, name, stonelerandom.id) then
            table.insert(lesdefi[src][k], {id = stonelerandom.id, label = stonelerandom.label, value = 0, maxvalue = math.random(stonelerandom.mini, stonelerandom.maxe), bool = true})
        end
    end
    return lesdefi[src][name]
end

function GenerateDefi(identifier, name)
    local _identifier = identifier
    local _name = name
    if name == nil then
        Citizen.CreateThread(function()
            ChangeAllDefi(_identifier, GenerateAll(_identifier))
        end)
    else
        Citizen.CreateThread(function()
            ChangeDefi(_identifier, _name, GenerateOne(_identifier, _name))
        end)
    end
end

RegisterCommand("free", function(source, args)
    local xPlayer = MP.Player[source]
    if xPlayer.HasDefi(13) then
        xPlayer.CompleteDefi(13, 1)
    end
end)