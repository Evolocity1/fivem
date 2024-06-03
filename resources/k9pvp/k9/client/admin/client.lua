local mainMenuAdmin = RageUI.CreateMenu("", "K9 PVP")
local ActionPerso = RageUI.CreateSubMenu(mainMenuAdmin, "Menu Administration", "K9 PVP")
local GestionBags = RageUI.CreateSubMenu(mainMenuAdmin, "Menu Administration", "K9 PVP")
local GestionVehicle = RageUI.CreateSubMenu(mainMenuAdmin, "Menu Administration", "K9 PVP")
local GestionJoueur = RageUI.CreateSubMenu(mainMenuAdmin, "Menu Administration", "K9 PVP")
local GestionWorld = RageUI.CreateSubMenu(mainMenuAdmin, "Menu Administration", "K9 PVP")
local OwnerOption = RageUI.CreateSubMenu(mainMenuAdmin, "Menu Administration", "K9 PVP")
local ActionPlayer = RageUI.CreateSubMenu(GestionJoueur, "Menu Administration", "K9 PVP")
local ActionBags = RageUI.CreateSubMenu(GestionBags, "Menu Administration", "K9 PVP")
local ContenuBags = RageUI.CreateSubMenu(ActionBags, "Menu Administration", "K9 PVP")
local InformationJoueur = RageUI.CreateSubMenu(mainMenuAdmin, "Menu Administration", "K9 PVP")
local InformationJoueurContenu = RageUI.CreateSubMenu(mainMenuAdmin, "Menu Administration", "K9 PVP")
local InformationPlayer =  RageUI.CreateSubMenu(ActionPlayer, "Menu Administration", "K9 PVP")
local InventoryPlayer = RageUI.CreateSubMenu(ActionPlayer, "Menu Administration", "K9 PVP")

local open = false
local lolok = 1
local filtre = 1
local filtree = 1
local joueurselect = {
    idunique = 0,
    name = "",
    infoip = {}
}
local joueurselectactionjoueur = {}
local id = 0
local idd = 0
local lebags = {}
local spec = false
local mycoords = vector3(0,0,0)
local esp = false
local allplayer = {}
local godmod = false
local name = ""
local inventoryplayer = {inventory = {}, protected = {}}

RegisterNetEvent("MP:UpdatePlayerAdmin")
AddEventHandler("MP:UpdatePlayerAdmin", function(players)
        allplayer = players
end)

local function TeleportWaypoint()
    Citizen.CreateThread(function()
        local entity = PlayerPedId()
        if IsPedInAnyVehicle(entity, false) then
            entity = GetVehiclePedIsUsing(entity)
        end
        local success = false
        local blipFound = false
        local blipIterator = GetBlipInfoIdIterator()
        local blip = GetFirstBlipInfoId(8)

        while DoesBlipExist(blip) do
            if GetBlipInfoIdType(blip) == 4 then
                cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
                blipFound = true
                break
            end
            blip = GetNextBlipInfoId(blipIterator)
        end

        if blipFound then
            DoScreenFadeOut(250)
            while IsScreenFadedOut() do
                Citizen.Wait(250)
                
            end
            local groundFound = false
            local yaw = GetEntityHeading(entity)
            
            for i = 0, 1000, 1 do
                SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
                SetEntityRotation(entity, 0, 0, 0, 0 ,0)
                SetEntityHeading(entity, yaw)
                SetGameplayCamRelativeHeading(0)
                Citizen.Wait(0)
                --groundFound = true
                if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then --GetGroundZFor3dCoord(cx, cy, i, 0, 0) GetGroundZFor_3dCoord(cx, cy, i)
                    cz = ToFloat(i)
                    groundFound = true
                    break
                end
            end
            if not groundFound then
                cz = -300.0
            end
            success = true
        end

        if success then
            SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
            SetGameplayCamRelativeHeading(0)
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
                    SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
                end
            end
            DoScreenFadeIn(250)
        end
    end)
end
function openMenuAdmin()
    if MP.GetPlayerData().group == "user" then return end
    if open then return end
    open = true
    RageUI.Visible(mainMenuAdmin, true)
    Citizen.CreateThread(function()
        while open do
            Citizen.Wait(1)
            local xPlayer = MP.GetPlayerData()
            RageUI.IsVisible(mainMenuAdmin, function()
                RageUI.Checkbox(not MP.InModeStaff and "~g~Start staff mode" or "~r~Stop staff mode", nil, MP.InModeStaff, {}, {
                      onChecked = function()
                          gostaff()
                          MP.Visible = false
                          godmod = true
                      end,
                      onUnChecked = function()
                          gostaff()
                          MP.Visible = true
                          godmod = false
                      end
                })
                if MP.InModeStaff then
                    RageUI.Button("My player", nil, {}, true, {}, ActionPerso)
                    RageUI.Button("Player list [~y~" ..#allplayer.. "~s~]", nil, {}, true, {}, GestionJoueur)
                    RageUI.Button("World", nil, {}, true, {}, GestionWorld)
                    RageUI.Button("Other options", nil, {}, true, {}, OtherOptions)
                end
            end)
            RageUI.IsVisible(GestionWorld, function()
                RageUI.Button("Delete All Vehicles", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("MP:DvAll")
                    end
                })
                RageUI.Button("Delete Vehicle", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("MP:DeleteVehicleClosest")
                    end
                })
            end)
            RageUI.IsVisible(ActionPerso, function()
                RageUI.Checkbox("NoClip", nil, noclip, {}, {
                      onChecked = function()
                          noclip = true
                          MP.Visible = false
                      end,
                      onUnChecked = function()
                          noclip = false
                          MP.Visible = true
                      end
                  })
              
              RageUI.Checkbox("Players Names", nil, showname, {}, {
                      onChecked = function()
                          showname = true
                      end,
                      onUnChecked = function()
                          showname = false
                      end
                  })
              
              RageUI.Checkbox("Delgun", nil, delgun, {}, {
                      onChecked = function()
                          delgun = true
                      end,
                      onUnChecked = function()
                          delgun = false
                      end
                  })
                        
             RageUI.Checkbox("Invisible", nil, not MP.Visible, {}, {
                      onChecked = function()
                          MP.Visible = false
                      end,
                      onUnChecked = function()
                          MP.Visible = true
                      end
              })
              
              RageUI.Checkbox("Godmode", nil, godmod, {}, {
                      onChecked = function()
                          godmod = true
                      end,
                      onUnChecked = function()
                          godmod = false
                      end
              })
              RageUI.Button("Teleport to waypoint", nil, {}, true, {
                    onSelected = function()
                        TeleportWaypoint()
                    end
               })
            --   RageUI.Checkbox("ESP", nil, esp, {}, {
            --           onChecked = function()
            --               esp = true
            --           end,
            --           onUnChecked = function()
            --               esp = false
            --           end
            --       })

            end)
            
            
            RageUI.IsVisible(GestionJoueur, function()
                RageUI.List("Filter", {"All", "Id", "Name"}, filtree or 1, nil, {}, true, {
                    onListChange = function(Index, Items)
                        filtree = Index
                    end,
                    onSelected = function()
                        if filtree == 2 then
                            local input = tonumber(KeyboardInput("Enter id", "", 8))
                            if input ~= nil then
                                idd = input
                                name = ""
                            end
                        elseif filtree == 3 then
                            local input = KeyboardInput("Enter name", "", 100)
                            if input ~= nil then
                                idd = 0
                                name = input
                            end
                            
                        else
                         	idd = 0
                            name = ""
                        end
                    end
                })
                for i = 1, #allplayer do
                    if ((idd ~= 0 and (idd == allplayer[i].idunique)) or (name ~= "" and string.match(string.upper(allplayer[i].name), string.upper(name)))) or (idd == 0 and name == "") then
                        RageUI.Button("[" ..allplayer[i].idunique.. "] " .. allplayer[i].name, nil, {}, true, {
                            onSelected = function()
                                joueurselectactionjoueur = allplayer[i]
                            end
                        }, ActionPlayer)
                    end
                end
            end)
            
            RageUI.IsVisible(ActionPlayer, function()
                local booll = false
                for i = 1, #allplayer do
                    if joueurselectactionjoueur.idunique == allplayer[i].idunique then
                        joueurselectactionjoueur = allplayer[i]
                        booll = true
                    end
                end
                if not booll then
                    RageUI.GoBack()
                end
                RageUI.Separator("~y~[" ..joueurselectactionjoueur.idunique.. "] " ..joueurselectactionjoueur.name)
                RageUI.Button("Send Private Message", nil, {}, true, {
                    onSelected = function()
                        local input = KeyboardInput("Enter message", "", 100)
                        if input ~= nil then
                        	TriggerServerEvent("MP:SendPrivateMessage", joueurselectactionjoueur.source, input)
                        end
                    end
                })
                RageUI.Button("Go to the player", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("MP:TeleportToPlayer", joueurselectactionjoueur.source)
                    end
                })
                RageUI.Button("Bring the player to you", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("MP:TeleportPlayer", joueurselectactionjoueur.source)
                    end
                })
                RageUI.Button("Bring the player in safezone", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("MP:TeleportPlayerToSafezone", joueurselectactionjoueur.source)
                    end
                })
                RageUI.Checkbox("Spectate", nil, MP.InSpec.bool, {}, {
                    onChecked = function()
                        MP.InSpec.bool = true
                        MP.InSpec.source = joueurselectactionjoueur.source
                        mycoords = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent("MP:TeleportToPlayer", joueurselectactionjoueur.source, true)
                        SpectatePlayer(joueurselectactionjoueur.source)
                    end,
                    onUnChecked = function()
                        MP.InSpec.bool = false
                    end
                })
         		RageUI.Button("Open inventory of player", nil, {}, true, {
                    onSelected = function()
                        inventoryplayer = {inventory = {}, protected = {}}
                        MP.TriggerServerCallback("MP:GetInventoryPlayer", function(cb)
                              inventoryplayer = cb
                        end, joueurselectactionjoueur.source)
                    end
                }, InventoryPlayer)
                RageUI.Button("Player Info", nil, {}, true, {
                    onSelected = function()
                    end
                }, InformationPlayer)
                RageUI.Button("Kick", nil, {}, true, {
                    onSelected = function()
                        local input = KeyboardInput("Enter reason", "", 100)
                        if input ~= nil then
                        	TriggerServerEvent("MP:KickPlayer", joueurselectactionjoueur.source, input)
                        end
                    end
                })
                RageUI.Button("Freeze", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("MP:FreezePlayer", joueurselectactionjoueur.source)
                    end
                })
                RageUI.Button("Ban", nil, {}, true, {
                    onSelected = function()
                        local input = KeyboardInput("Enter reason", "", 100)
                        if input ~= nil then
                        	ExecuteCommand("ban " ..joueurselectactionjoueur.idunique.. " " ..input)
                        end
                    end
                })
            end)
            RageUI.IsVisible(InventoryPlayer, function()
                   RageUI.Separator("Bag Inventory Player")
                   for i = 1, #inventoryplayer.inventory do
                            RageUI.Button(inventoryplayer.inventory[i].count.."x " ..inventoryplayer.inventory[i].label, nil, {}, true, {})
                   end
                   RageUI.Separator("Protected Inventory Player")     
                   for i = 1, #inventoryplayer.protected do
                            RageUI.Button(inventoryplayer.protected[i].count.."x " ..inventoryplayer.protected[i].label, nil, {}, true, {})
                   end
            end)
            RageUI.IsVisible(InformationPlayer, function()
                local boolll = false
                for i = 1, #allplayer do
                    if joueurselectactionjoueur.idunique == allplayer[i].idunique then
                        joueurselectactionjoueur = allplayer[i]
                        boolll = true
                    end
                end
                if not boolll then
                    RageUI.GoBack()
                end
                RageUI.Button("Name : " ..joueurselectactionjoueur.name, nil, {}, true, {})
                RageUI.Button("ID : " ..joueurselectactionjoueur.idunique, nil, {}, true, {})
                RageUI.Button("Money : " ..joueurselectactionjoueur.point, nil, {}, true, {})
                RageUI.Button("KCoins : ~y~" ..joueurselectactionjoueur.kcoin, nil, {}, true, {})
                RageUI.Button("Kills : " ..joueurselectactionjoueur["stats"]["pvp"].kill, nil, {}, true, {})
                RageUI.Button("Deaths : " ..joueurselectactionjoueur["stats"]["pvp"].death, nil, {}, true, {})
                RageUI.Button("K/D : " ..(MP.Round(joueurselectactionjoueur["stats"]["pvp"].kill / joueurselectactionjoueur["stats"]["pvp"].death, 2)) or 0, nil, {}, true, {})
                RageUI.Button("Rank : " ..joueurselectactionjoueur.rank, nil, {}, true, {})
            end)
            if MP.GetPlayerData().group == "user" then open = false end
            if not RageUI.Visible(mainMenuAdmin) and not RageUI.Visible(ActionPerso) and not RageUI.Visible(GestionBags) and not RageUI.Visible(ActionBags) and not RageUI.Visible(ContenuBags) and not RageUI.Visible(GestionWorld) and not RageUI.Visible(InformationJoueur) and not RageUI.Visible(InformationJoueurContenu) and not RageUI.Visible(GestionJoueur) and not RageUI.Visible(ActionPlayer) and not RageUI.Visible(GestionStaff) and not RageUI.Visible(InformationPlayer) and not RageUI.Visible(InventoryPlayer) then open = false end
        end
    end)
end

local a = {
        {39317, 45509},
        {45509, 61163},
        {61163, 18905},
        {39317, 40269},
        {40269, 28252},
        {28252, 57005},
        {39317, 11816},
        {11816, 58271},
        {58271, 63931},
        {63931, 14201},
        {11816, 51826},
        {51826, 36864},
        {36864, 52301}
}
local function DrawSkeleton()
    for i = 1, #MP.GetPeds() do
        if MP.GetPeds()[i] ~= PlayerPedId() and IsPedAPlayer(MP.GetPeds()[i]) then
            for d = 1, #a do
                local kk = GetPedBoneCoords(MP.GetPeds()[i], a[d][1])
                local onscreen, x, y = GetScreenCoordFromWorldCoord(kk.x, kk.y, kk.z)
                local kkk = GetPedBoneCoords(MP.GetPeds()[i], a[d][2])
                local onscreenn, xx, yy = GetScreenCoordFromWorldCoord(kkk.x, kkk.y, kkk.z)
                if onscreen and onscreenn then
                    DrawLine_2d(x, y, xx, yy, 0.0008, 255, 255, 0, 255)
                end
            end
        end
    end
end

function SpectatePlayer(target)
    local leidaspec = target
    Citizen.CreateThread(function()
    --     local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    -- 	SetCamActive(cam, true)
    -- 	RenderScriptCams(true, false, 0, true, true)
    	local isnoclip = noclip
    	if noclip then
    	    noclip = false
    	end
    	MP.Visible = false
        while MP.InSpec.bool and MP.InModeStaff do
            for _, player in ipairs(GetActivePlayers()) do
                if GetPlayerServerId(player) == tonumber(leidaspec) then
                    local ped = GetPlayerPed(player)
                    local coords = GetEntityCoords(ped)
                    --local rotation = GetEntityRotation(ped, 0)
                    --local direction = RotationToDirection(rotation)
                    -- SetCamCoord(cam, coords.x - (direction.x * 2.0), coords.y - (direction.y * 2.0), coords.z + 1.0)
                    -- SetCamRot(cam, rotation, 0)
                    SetEntityVisible(PlayerPedId(), false)
                    MP.Visible = false
                    SetGameplayCamFollowPedThisUpdate(ped)
                    FreezeEntityPosition(PlayerPedId(), true)
                    
                    DrawSkeleton()
                    if #(coords-GetEntityCoords(PlayerPedId())) >= 200.0 then
                        SetEntityCoords(PlayerPedId(), vector3(coords.x, coords.y, coords.z + 75.0))
                    end
                end
            end                         
            Citizen.Wait(1)
        end

        -- DestroyCam(cam, false)
        -- SetCamActive(cam, false)
        -- RenderScriptCams(false, false, 0, true, true)
        SetEntityCoords(PlayerPedId(), mycoords)
        if isnoclip then
            noclip = true
        else
            MP.Visible = true
        end
        cam = nil
    end)
end

RegisterCommand("menuadmin", openMenuAdmin)

RegisterKeyMapping("menuadmin", "Ouvrir le menu admin", "keyboard", "F10")

local function GetIdUnique(id)
    for i = 1, #allplayer do
        if tonumber(allplayer[i].source) == tonumber(id) then
            return allplayer[i].idunique
        end
    end
    return 0
end

local function getCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
    local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

    if len ~= 0 then
        coords = coords / len
    end

    return coords
end

local NoClipSpeed = 1.0
local gamerTags = {}

function gostaff()
    if MP.GetPlayerData().group == "user" then return end
    MP.InModeStaff = not MP.InModeStaff
    delgun = MP.InModeStaff
    showname = MP.InModeStaff
    noclip = MP.InModeStaff
    TriggerServerEvent("MP:goinstaff", MP.InModeStaff)
    if MP.InModeStaff then
        SetMpGamerTagsVisibleDistance(200.0)
        Citizen.CreateThread(function()
            while MP.InModeStaff do
                if MP.GetPlayerData().group == "user" then MP.InModeStaff = false end
                SetPlayerInvincible(PlayerId(), godmod)
                SetEntityInvincible(PlayerPedId(), godmod)
                --if esp then
                   -- DrawSkeleton()
                --end
                if delgun then
                    if IsPlayerFreeAiming(PlayerId()) then
                        local _, entitys = GetEntityPlayerIsFreeAimingAt(PlayerId())
                        if GetEntityType(entitys) == 2 then
                            --if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("weapon_snspistol_mk2") then
                                if IsPedShooting(PlayerPedId()) then
                                    TriggerServerEvent("mp", GetPlayerServerId(NetworkGetEntityOwner(entitys)), "ha", NetworkGetNetworkIdFromEntity(entitys))
                                end
                            --end
                        elseif GetEntityType(entitys) == 1 then
                            --if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("weapon_snspistol_mk2") then
                                if IsPedShooting(PlayerPedId()) then
                                    if GetPlayerServerId(NetworkGetPlayerIndexFromPed(entitys)) ~= 0 and GetPlayerServerId(NetworkGetPlayerIndexFromPed(entitys)) ~= nil then
                                        TriggerServerEvent("mp", GetPlayerServerId(NetworkGetPlayerIndexFromPed(entitys)), "id", nil)
                                    else
                                        DeleteEntity(GetVehiclePedIsIn(entitys, false))
                                    end
                                end
                            --end
                        end
                    end
                end
                entity = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle ~= 0 then
                    entity = vehicle
                end
                if noclip then
                    local pCoords = GetEntityCoords(entity, false)
                    local camCoords = getCamDirection()
                    SetEntityVelocity(entity, 0.01, 0.01, 0.01)
                    SetEntityCollision(entity, 0, 1)
                    FreezeEntityPosition(entity, true)
    
                    if IsControlPressed(0, 32) then
                        pCoords = pCoords + (NoClipSpeed * camCoords)
                    end
    
                    if IsControlPressed(0, 269) then
                        pCoords = pCoords - (NoClipSpeed * camCoords)
                    end
    
                    if IsDisabledControlJustPressed(1, 15) then
                        NoClipSpeed = NoClipSpeed + 0.3
                    end
                    if IsDisabledControlJustPressed(1, 14) then
                        NoClipSpeed = NoClipSpeed - 0.3
                        if NoClipSpeed < 0 then
                            NoClipSpeed = 0
                        end
                    end
                    SetEntityCoordsNoOffset(entity, pCoords, true, true, true)
                else
                    FreezeEntityPosition(entity, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                    SetEntityCollision(entity, 1, 1)
                    SetEntityCollision(PlayerPedId(), 1, 1)
                end
                if MP.Visible and not MP.InSpec.bool then
                        SetEntityVisible(entity, 1, 0)
                        SetEntityVisible(PlayerPedId(), 1, 0)
                else
                        SetEntityVisible(entity, 0, 0)
                        SetEntityVisible(PlayerPedId(), 0, 0)
                end
                if showname then
                    local plyPed = PlayerPedId()
                    for _, player in pairs(GetActivePlayers()) do
                        local ped = GetPlayerPed(player)
                        --if ped ~= plyPed then
                            if #(GetEntityCoords(plyPed, false) - GetEntityCoords(ped, false)) < 5000.0 then
                                gamerTags[player] = CreateFakeMpGamerTag(ped, ('[%s] %s'):format(GetIdUnique(GetPlayerServerId(player)), GetPlayerName(player)), false, false, '', 0)
                                SetMpGamerTagName(gamerTags[player], ('[%s] %s'):format(GetIdUnique(GetPlayerServerId(player)), GetPlayerName(player)))
                                SetMpGamerTagAlpha(gamerTags[player], 0, 255)
                                SetMpGamerTagAlpha(gamerTags[player], 2, 255)
                                SetMpGamerTagAlpha(gamerTags[player], 4, 255)
                                SetMpGamerTagAlpha(gamerTags[player], 7, 255)
                                SetMpGamerTagVisibility(gamerTags[player], 0, true)
                                SetMpGamerTagVisibility(gamerTags[player], 2, true)
                                SetMpGamerTagVisibility(gamerTags[player], 4, NetworkIsPlayerTalking(player))
                                SetMpGamerTagVisibility(gamerTags[player], 7, DecorExistOn(ped, "staffl") and DecorGetInt(ped, "staffl") > 0)
                                SetMpGamerTagColour(gamerTags[player], 7, 55)
                                if NetworkIsPlayerTalking(player) then
                                    SetMpGamerTagHealthBarColour(gamerTags[player], 211)
                                    SetMpGamerTagColour(gamerTags[player], 4, 211)
                                    SetMpGamerTagColour(gamerTags[player], 0, 211)
                                else
                                    SetMpGamerTagHealthBarColour(gamerTags[player], 0)
                                    SetMpGamerTagColour(gamerTags[player], 4, 0)
                                    SetMpGamerTagColour(gamerTags[player], 0, 0)
                                end
                                if DecorExistOn(ped, "staffl") then
                                    SetMpGamerTagWantedLevel(ped, DecorGetInt(ped, "staffl"))
                                end
                            else
                                RemoveMpGamerTag(gamerTags[player])
                                gamerTags[player] = nil
                            end
                       -- end
                    end
                else
                    for k,v in pairs(gamerTags) do
                        RemoveMpGamerTag(v)
                    end
                    gamerTags = {}
                end
                Citizen.Wait(1)
            end
            noclip = false
            showname = false
            delgun = false
            FreezeEntityPosition(entity, false)
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityVisible(entity, 1, 0)
            SetEntityVisible(PlayerPedId(), 1, 0)
            SetEntityCollision(entity, 1, 1)
            SetEntityCollision(PlayerPedId(), 1, 1)
            SetPlayerInvincible(PlayerId(), false)
            SetEntityInvincible(PlayerPedId(), false)
            for k,v in pairs(gamerTags) do
                RemoveMpGamerTag(v)
            end
            gamerTags = {}
            allplayer = {}
        end)
    end
end