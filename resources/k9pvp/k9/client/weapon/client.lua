local open = false
local mainMenuWeapon = RageUI.CreateMenu("Weapon", "Weapon")
local subMenuWeapon = RageUI.CreateSubMenu(mainMenuWeapon, "Weapon", "Weapon")
local mywea = {}
RegisterNetEvent("MP:AddAllWeapon")
AddEventHandler("MP:AddAllWeapon", function(a)
        mywea = a
end)
local itemselect = {}
local function foundWeapon(name)
    local hash = name
    for i = 1, #Config.Weapons do
        if GetHashKey(Config.Weapons[i].name) == hash then
            return true, Config.Weapons[i]
        end
    end
    return false
end
function openmenu()
    if open then return end
    open = true
    local itemss = exports["k9-inventory"]:PlayerItems()
    RageUI.Visible(mainMenuWeapon, true)
    Citizen.CreateThread(function()
            while open do
                Citizen.Wait(1)
                RageUI.IsVisible(mainMenuWeapon, function()
                        local items = exports["k9-inventory"]:PlayerItems()["inventory"]
                        local allitem = exports["k9-inventory"]:Items()
                        for i = 1, #items do
                            if allitem[items[i].name].type == "weapon" then
                                RageUI.Button(allitem[items[i].name].label, nil, {}, true, {
                                        onSelected = function()
                                            itemselect = items[i].name
                                        end
                                }, subMenuWeapon)
                            end
                        end
                end)
                RageUI.IsVisible(subMenuWeapon, function()
                        local bool, weapon = foundWeapon(GetHashKey(itemselect))
                        if bool then
                        	for i = 1, #weapon.components do
                                RageUI.Checkbox(weapon.components[i].label, nil, HasPedGotWeaponComponent(PlayerPedId(), GetHashKey(itemselect), weapon.components[i].hash), {}, {
                                    onChecked = function()
                                        GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(itemselect), weapon.components[i].hash)
                                        TriggerServerEvent("MP:RemoveComponentWeapon", itemselect, weapon.components[i].hash)
                                    end,
                                    onUnChecked = function()
                                        RemoveWeaponComponentFromPed(PlayerPedId(), GetHashKey(itemselect), weapon.components[i].hash)
                                        TriggerServerEvent("MP:AddComponentWeapon", itemselect, weapon.components[i].hash)
                                    end
                                })
                            end
                        end
                end)
                if not RageUI.Visible(mainMenuWeapon)  and not RageUI.Visible(subMenuWeapon) then open = false end
            end
    end)
end

local function foundWeaponInList(weapon)
    for i = 1, #mywea do
        if GetHashKey(mywea[i].weapon) == weapon then
            return true, mywea[i].weaponcomponent
        end
    end
  	return false
end

local function IsDeleteWeaponComp(weapon, compenant)
    local bool, lesweaponcomp = foundWeaponInList(weapon)
    print(bool, "isdelete")
    if bool then
        for i = 1, #lesweaponcomp do
            if lesweaponcomp[i] == compenant then
                return true
            end
        end
    end
    return false
end


local b = GetHashKey("weapon_unarmed")
Citizen.CreateThread(function()
        while true do
            Citizen.Wait(100)
            SetBlackout(false)
            ClearOverrideWeather()
            ClearWeatherTypePersist()
            SetWeatherTypePersist('EXTRASUNNY')
            SetWeatherTypeNow('EXTRASUNNY')
            SetWeatherTypeNowPersist('EXTRASUNNY')
            if b ~= GetSelectedPedWeapon(PlayerPedId()) then
                local bool, weapon = foundWeapon(GetSelectedPedWeapon(PlayerPedId()))
                if bool then
                    for i = 1, #weapon.components do
                        if not IsDeleteWeaponComp(GetSelectedPedWeapon(PlayerPedId()), weapon.components[i].hash) then
                            GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), weapon.components[i].hash)
                        end
                    end
                end
                b = GetSelectedPedWeapon(PlayerPedId())
            end
            
        end
end)