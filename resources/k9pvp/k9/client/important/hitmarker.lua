local pInfo = {
    health = 0,
    armour = 0
}

-----------------------
------ Settings -------
-----------------------
hitsize=0.5
hitshow = true
hittext = true 
hitsound = true
inhit = {}
hitvalue = {}
zhit = {}
-----------------------
-----------------------
CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        pInfo.health = GetEntityHealth(player) - 100
        pInfo.armour = GetPedArmour(player)
    end
end)

AddEventHandler('gameEventTriggered', function(name, data)
    if name == "CEventNetworkEntityDamage" then
        victim = tonumber(data[1])
        attacker = tonumber(data[2])
        victimDied = tonumber(data[6]) == 1 and true or false 
        weaponHash = tonumber(data[7])
        isMeleeDamage = tonumber(data[10]) ~= 0 and true or false 
        vehicleDamageTypeFlag = tonumber(data[11]) 
        local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(victim)
        local bonehash = -1 
        if FoundLastDamagedBone then
            bonehash = tonumber(LastDamagedBone)
        end
        local PPed = PlayerPedId()
        local distance = IsEntityAPed(attacker) and #(GetEntityCoords(attacker) - GetEntityCoords(victim)) or -1
        local isplayer = IsPedAPlayer(attacker)
        local attackerid = isplayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)) or tostring(attacker==-1 and " " or attacker)
        local deadid = isplayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)) or tostring(victim==-1 and " " or victim)
        local victimName = GetPlayerName(PlayerId())

        if victim == attacker or victim ~= PPed or not IsPedAPlayer(victim) or not IsPedAPlayer(attacker) then return end

        local hit = {
            health = 0,
            armour = 0,
        }

        if pInfo.armour > GetPedArmour(PPed) then
            hit.armour = pInfo.armour - GetPedArmour(PPed)
        else
            hit["armour"] = nil
        end
        local aenlever = 0
        if GetEntityHealth(PPed) > 0 then
                aenlever = 100
        end
        if pInfo.health > (GetEntityHealth(PPed) - aenlever) then
            hit.health = pInfo.health - (GetEntityHealth(PPed) - aenlever)
        else
            hit["health"] = nil
        end
        
        
        --print(GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)))
        TriggerServerEvent('wais:s:writehit', attackerid, GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)), hit, victimDied, bonehash)
    end
end)

RegisterNetEvent('wais:c:writehit', function(victim, victimInfo, victimDied, Bone)
    local lasize = MP.GetPlayerData()["parameter"]["hitmarker"]["size"]
    if lasize == 1 then
                hitsize=0.2
    elseif lasize == 2 then
                hitsize=0.5
    else 
                hitsize=0.8
    end
    function PlayDeathSound()
        if hitsound then
            SendNUIMessage({
                    action = "PlaySound",
                    files = "kill_effect",
                    volume = 0.2
            })
        end
    end
    if victimDied then
        PlayDeathSound()
    end

    if victimInfo.armour then
        OnEntityHealthChange(victim, victimInfo.armour, Bone, {r = 48, g = 152, b = 196}, victimDied , true)
        if hitsound then
            SendNUIMessage({
                    action = "PlaySound",
                    files = "hitmarker" ..MP.GetPlayerData()["parameter"]["hitmarker"]["sound"],
                    volume = 0.25
                })
        end
    end

    if victimInfo.health then
        if hittext then
            OnEntityHealthChange(victim, victimInfo.health, Bone, {r = 212, g = 84, b = 84}, victimDied , false)
            if hitsound then
                SendNUIMessage({
                    action = "PlaySound",
                    files = "hitmarker" ..MP.GetPlayerData()["parameter"]["hitmarker"]["sound"],
                    volume = 0.25
                })
            end
        else
            OnEntityHealthChange(victim, victimInfo.health, Bone, {r = 212, g = 84, b = 84}, victimDied , false)
        end
    end
end)

-- THX FOR WRITE SCREEN FUNCTİONS -> NBK_DAMAGE --

local DrawText2Dhit = function(text, scale, x, y, a, color)
	SetTextScale(0.5, hitsize)
	SetTextFont(6)
	SetTextColour(color and tonumber(color.r or 0) or 0, color and tonumber(color.g or 0) or 0, color and tonumber(color.b or 0) or 0, 255)
	SetTextCentre(true)
    SetTextDropShadow()
    SetTextOutline(1)
    SetTextProportional(1)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
	ClearDrawOrigin()
end

function DrawText3Dhit(text, x, y, z, color)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    --print(onScreen, _x, _y)
	if onScreen then
		DrawText2Dhit(text, 11, _x, _y, nil, color)
	end
end

local DrawText2DTweenUp = function(text, scale, x, y, moveheight, speed, color)
    Citizen.CreateThread(function()
        local height = y
        local total_ = height - (y - moveheight) 
        local total = height - (y - moveheight)
        while height > (y - moveheight) do 
            DrawText2Dhit(text, scale, x, height, math.floor(255* (total/total_)), color)
            height = height - 0.01 * speed
            total = total - 0.01 * speed
            Citizen.Wait(1)
        end
    end)
end

local lastHit =  vector3(0, 0, 0)
local yhit = {}
local xhit = {}
local heights = {}
local colors = {}
local DrawText3DTweenUpAdditional = function(victim, text, scale, x, y, z, moveheight, speed, color)
    if zhit[victim] == nil then zhit[victim] = z end
    if xhit[victim] == nil then xhit[victim] = x end
    if yhit[victim] == nil then yhit[victim] = y end
    if inhit[victim] == nil then inhit[victim] = false end
    if hitvalue[victim] == nil then hitvalue[victim] = tonumber(text) end
    if heights[victim] == nil then heights[victim] = z end
    if colors[victim] == nil then colors[victim] = color end
    zhit[victim] = z
    yhit[victim] = y
    xhit[victim] = x
    heights[victim] = zhit[victim]
    colors[victim] = color
    --print(x,y,z)
    if not inhit[victim] then
        if #(lastHit - vector3(x, y, z)) < 0.3 then 
            zhit[victim] = z + 0.2
        end
        Citizen.CreateThread(function()
            inhit[victim] = true
            hitvalue[victim] = tonumber(text)
            while heights[victim] < (zhit[victim] + moveheight) do 
                DrawText3Dhit(tostring(hitvalue[victim]), xhit[victim], yhit[victim], heights[victim], colors[victim])
                heights[victim] = heights[victim] + 0.01 * speed
                Citizen.Wait(1)
            end
            inhit[victim] = false
        end)
    else
        hitvalue[victim] = hitvalue[victim] + tonumber(text)
    end
end


local DrawText3DTweenUpNormal = function(victim, text, scale, x, y, z, moveheight, speed, color)
    if #(lastHit - vector3(x, y, z)) < 0.3 then 
            z = z + 0.2
        end
    --print(x,y,z)

        Citizen.CreateThread(function()
            local height = z
            local total_ = height - (z - moveheight) 
            local total = height - (z - moveheight)
            while height < (z + moveheight) do 
                DrawText3Dhit(text, x, y, height, color)
                height = height + 0.01 * speed
                total = total + 0.01 * speed
                Citizen.Wait(1)
            end
        end)
end

OnEntityHealthChange = function(victim, value, bonehash, color, dead)
    --print(victim, value, bonehash, color, dead)
    local pcord = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(victim)))
    local health = GetEntityHealth(GetPlayerPed(GetPlayerFromServerId(victim))) - 100
    local armour = GetPedArmour(GetPlayerPed(GetPlayerFromServerId(victim)))
    --print(victim, pcord)

    local lifeRemaining = health + armour

    local coords =  bonehash and GetPedBoneCoords(victim, bonehash, 0.0, 0.0, 0.0) or pcord
    local camCoords = GetGameplayCamCoords()
    local distance = #(coords - camCoords)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    if scale < 0.2 then scale = 0.2 end 
    if bonehash == 31086 then
        color = {r = 255, g = 222, b = 0}
    end
    if hitshow == true then
        if hittext then
            if MP.GetPlayerData()["parameter"]["hitmarker"]["additional"] then
            	DrawText3DTweenUpAdditional(victim, tostring(value), 11, pcord.x + math.random(-500, 500)/1000, pcord.y, pcord.z + 0.650, 0.3, 0.35, color)
            else
                DrawText3DTweenUpNormal(victim, tostring(value), 11, pcord.x + math.random(-500, 500)/1000, pcord.y, pcord.z + 0.650, 0.3, 0.35, color)
            end
        else
            DrawText3DTweenUp(victim, tostring(lifeRemaining), 11, pcord.x + math.random(-500, 500)/1000, pcord.y, pcord.z + 0.650, 0.3, 0.35, color)
        end
    end
    --DrawText2DTweenUp(tostring(value), 11, 0.50, 0.453, 0.2, 0.35, color)
end