local insquad = false
local mySquadHash
RegisterCommand("squad", function()
    ArrangeControls(true)
    SendNUIMessage({
        type = "squad",
        action = "open"
    })
        
end)

RegisterKeyMapping("squad", "Open squad", "keyboard", "J")

RegisterNUICallback("squadclose", function()
    ArrangeControls(false)
end)

RegisterNUICallback("joinsquad", function(data)
    TriggerServerEvent("MP:JoinSquad", data.idsquad)
end)

RegisterNUICallback("createsquad", function(data)
    TriggerServerEvent("MP:CreateSquad")
end)

RegisterNUICallback("leavesquad", function(data)
    TriggerServerEvent("MP:LeaveSquad")
end)

RegisterNUICallback("kicksquad", function(data)
    TriggerServerEvent("MP:KickSquad", tonumber(data.id))
end)

RegisterNUICallback("deletesquad", function()
        TriggerServerEvent("MP:DeleteSquad")
end)

RegisterNUICallback("changeprivate", function(data)
        TriggerServerEvent("MP:ChangePrivateSquad", data.isprivate)
end)

RegisterNetEvent("MP:RefreshSquad")
AddEventHandler("MP:RefreshSquad", function(squad)
    SendNUIMessage({
        type = "squad",
        action = "refreshsquad",
        data = squad
    })
end)

RegisterNetEvent("MP:AddMemberInSquad")
AddEventHandler("MP:AddMemberInSquad", function(lemember)
        SendNUIMessage({
              type = "squad",
              action = "addmemberinhudsquad",
              data = lemember
        })
end)

RegisterNetEvent("MP:RemoveMemberInSquad")
AddEventHandler("MP:RemoveMemberInSquad", function(id)
        SendNUIMessage({
              type = "squad",
              action = "removememberinhudsquad",
              id = id
        })
end)


local function removeAllBlip()
    for i = 1, #MP.MySquad do
        RemoveBlip(MP.MySquad[i].blip)
    end
end
RegisterNetEvent("MP:RefreshMemberSquad")
AddEventHandler("MP:RefreshMemberSquad", function(membersquad)
   	DeleteAllGamerTagsSquad()
    removeAllBlip()
    MP.MySquad = membersquad
    for i = 1, #MP.MySquad do
            if tonumber(MP.MySquad[i].id) ~= tonumber(GetPlayerServerId(PlayerId())) then
                
                        MP.MySquad[i].blip = AddBlipForEntity(GetPlayerPed(GetPlayerFromServerId(MP.MySquad[i].id)))
                        SetBlipSprite(blip, 1)
                        ShowFriendIndicatorOnBlip(MP.MySquad[i].blip, true)
                        SetBlipColour(MP.MySquad[i].blip, 37)
                        SetBlipScale(MP.MySquad[i].blip, 0.75)
                        ShowHeadingIndicatorOnBlip(MP.MySquad[i].blip, true)
                        SetBlipShowCone(MP.MySquad[i].blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(MP.MySquad[i].name)
                        EndTextCommandSetBlipName(MP.MySquad[i].blip)
           end
    end
    if not MP.IhaveSquad then
		MP.IhaveSquad = true
        StartRelationLoop(membersquad[1].idsquad)
       -- StartLoopSquad()
    end
    SendNUIMessage({
        type = "squad",
        action = "refreshmembersquad",
        data = membersquad,
        myid = GetPlayerServerId(PlayerId()),
    })
end)

RegisterNetEvent("MP:UpdateHudSquad")
AddEventHandler("MP:UpdateHudSquad", function(t)
        SendNUIMessage({
              action = "updatehud",
              type = "squad",
              data = t
        })
end)

RegisterNetEvent("MP:LeaveSquad")
AddEventHandler("MP:LeaveSquad", function()
        MP.IhaveSquad = false
        DeleteAllGamerTagsSquad()
    removeAllBlip()
        MP.MySquad = {}
        SendNUIMessage({
                type = "squad",
                action = "quitsquad"
            })
        if DoesRelationshipGroupExist(mySquadHash) then
            SetPedRelationshipGroupHash(PlayerPedId(), 0x6F0783F5)
            SetEntityCanBeDamagedByRelationshipGroup(PlayerPedId(), true,  mySquadHash)
            RemoveRelationshipGroup(mySquadHash)
            mySquadHash = nil
        end
        
end)


function SetRelationDamage(id)
    if id and (mySquadHash == nil or not DoesRelationshipGroupExist(mySquadHash)) then
        local retval, hash = AddRelationshipGroup(("squad_%s"):format(id))
        SetPedRelationshipGroupHash(PlayerPedId(), hash)
        SetEntityCanBeDamagedByRelationshipGroup(PlayerPedId(), false,  hash)
        mySquadHash = hash
    else
        SetPedRelationshipGroupHash(PlayerPedId(), mySquadHash)
        SetEntityCanBeDamagedByRelationshipGroup(PlayerPedId(), false,  mySquadHash)
    end
    return mySquadHash
end

function StartRelationLoop(id)
    Citizen.CreateThread(function()
        local hash = SetRelationDamage(id)
        while mySquadHash ~= nil do
            Citizen.Wait(2000)
            SetRelationDamage()
        end
        if DoesRelationshipGroupExist(mySquadHash) then
            SetPedRelationshipGroupHash(PlayerPedId(), 0x6F0783F5)
            SetEntityCanBeDamagedByRelationshipGroup(PlayerPedId(), true,  mySquadHash)
            RemoveRelationshipGroup(mySquadHash)
            mySquadHash = nil
        end
    end)
end


--[[function StartLoopSquad()
    Citizen.CreateThread(function()
          while MP.IhaveSquad do
                Citizen.Wait(100)
                PedHealthArmor()
          end
    end)
end]]

AddEventHandler("onResourceStop", function(name)
    if name == GetCurrentResourceName() then
        if DoesRelationshipGroupExist(mySquadHash) then
            SetPedRelationshipGroupHash(PlayerPedId(), 0x6F0783F5)
            SetEntityCanBeDamagedByRelationshipGroup(PlayerPedId(), true,  mySquadHash)
            RemoveRelationshipGroup(mySquadHash)
            mySquadHash = nil
        end
    end
end)

function ArrangeControls(bool)
    SetNuiFocus(bool, bool)
    SetNuiFocusKeepInput(bool)
    insquad = bool
    if bool then
        Citizen.CreateThread(function()
            while insquad do
                Citizen.Wait(0)
                DisableControlAction(0, 1, true) -- disable mouse look
                DisableControlAction(0, 2, true) -- disable mouse look
                DisableControlAction(0, 3, true) -- disable mouse look
                DisableControlAction(0, 4, true) -- disable mouse look
                DisableControlAction(0, 5, true) -- disable mouse look
                DisableControlAction(0, 6, true) -- disable mouse look

                DisableControlAction(0, 1, true) -- disable aim
                DisableControlAction(0, 2, true)
                DisableControlAction(0, 156, true) -- disable aim
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(0, 26, true)
                DisableControlAction(0, 79, true)
                DisableControlAction(0, 80, true)
                DisableControlAction(0, 263, true) -- disable melee
                DisableControlAction(0, 264, true) -- disable melee
                DisableControlAction(0, 257, true) -- disable melee
                DisableControlAction(0, 140, true) -- disable melee
                DisableControlAction(0, 141, true) -- disable melee
                DisableControlAction(0, 142, true) -- disable melee
                DisableControlAction(0, 143, true) -- disable melee
                DisableControlAction(0, 24, true) -- disable attack
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(0, 47, true) -- disable weapon
                DisableControlAction(0, 58, true) -- disable weapon
                DisableControlAction(0, 245, true) -- chat
                DisableControlAction(0, 303, true) -- U

                DisableControlAction(0, 36, true) -- ctrl
                DisableControlAction(0, 29, true) -- b
                DisableControlAction(0, 73, true) -- X
                DisableControlAction(0, 85, true) -- Q
                DisableControlAction(0, 18, true) -- left click
                DisableControlAction(0, 69, true) -- left click
                DisableControlAction(0, 122, true) -- left click
                DisableControlAction(0, 229, true) -- left click
                DisableControlAction(0, 237, true) -- left click
                DisableControlAction(0, 329, true) -- left click
                DisableControlAction(0, 346, true) -- left click
                DisableControlAction(0, 92, true) -- left click
                DisableControlAction(0, 106, true) -- left click
                DisableControlAction(0, 135, true) -- left click
                DisableControlAction(0, 144, true) -- left click
                DisableControlAction(0, 176, true) -- left click
                DisableControlAction(0, 223, true) -- left click
                -- DisablePlayerFiring(PlayerId(), true)

                DisableControlAction(0, 199, true) -- P
                DisableControlAction(0, 200, true) -- esc
                DisableControlAction(0, 177, true) -- esc
                DisableControlAction(0, 202, true) -- esc
                DisableControlAction(0, 322, true) -- esc
                
            end
        end)
    end
end