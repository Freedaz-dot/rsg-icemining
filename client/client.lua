local RSGCore = exports['rsg-core']:GetCoreObject()

-- prompts and blips
Citizen.CreateThread(function()
    for _, v in pairs(Config.IceMiningLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds[Config.KeyBindIceMining], Lang:t('lang_1') .. v.name, {
            type = 'client',
            event = 'rsg-icemining:client:StartIceMining',
        })
        if v.showblip == true then
            local MiningBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(MiningBlip, joaat("blip_ambient_tracking"), true)
            SetBlipScale(MiningBlip, 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, MiningBlip, v.name)
        end
    end
    for _, v in pairs(Config.IceLocations) do
        local name = v.name
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds[Config.KeyBindIce], Lang:t('lang_2') .. v.name .. Lang:t('lang_3'), {
            type = 'client',
            event = 'rsg-icemining:client:menu',
            args = { name },
        })
        if v.showblip == true then
            local IceBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(IceBlip, joaat(Config.IceBlip.blipSprite), true)
            SetBlipScale(Config.IceBlip.blipScale, 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, IceBlip, Config.IceBlip.blipName)
        end
    end
end)

---------- ice minin
local iceminingstarted = false
local testAnimDict = 'amb_work@world_human_pickaxe@wall@male_d@base'
local testAnim = 'base'

local LoadAnimDict = function(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do Wait(0) end
    end
end

RegisterNetEvent('rsg-icemining:client:StartIceMining')
AddEventHandler('rsg-icemining:client:StartIceMining', function()
    if iceminingstarted then
        lib.notify({ title = Lang:t('lang_4'), description = Lang:t('lang_5'), type = 'primary' })
        return
    end

    local player = PlayerPedId()
    local hasItem = RSGCore.Functions.HasItem('pickaxe', 1)

    if not hasItem then
        lib.notify({ title = Lang:t('lang_6'), description = Lang:t('lang_7'), type = 'error' })
        return
    end

    local randomNumber = math.random(1, 100)
    if randomNumber > 90 then
        TriggerServerEvent('rsg-icemining:server:removeitem', 'pickaxe')
        lib.notify({ title = Lang:t('lang_8'), description = Lang:t('lang_9'), type = 'error' })
        return
    end

    local coords = GetEntityCoords(player)
    local boneIndex = GetEntityBoneIndexByName(player, "SKEL_R_Finger00")
    local prop = CreateObject(GetHashKey("p_pickaxe01x"), coords, true, true, true)

    iceminingstarted = true

    SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
    FreezeEntityPosition(player, true)
    ClearPedTasksImmediately(player)
    AttachEntityToEntity(prop, player, boneIndex, -0.35, -0.21, -0.39, -8.0, 47.0, 11.0, true, false, true, false, 0, true)

    TriggerEvent('rsg-icemining:client:MiningIceAnimation')

    RSGCore.Functions.Progressbar("miningice", Lang:t('lang_10'), 18000, false, true,
    {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasksImmediately(player)
        FreezeEntityPosition(player, false)

        TriggerServerEvent('rsg-icemining:server:giveMiningIceReward')
        
        SetEntityAsNoLongerNeeded(prop)
        DeleteEntity(prop)
        DeleteObject(prop)

        iceminingstarted = false
    end)
end)

AddEventHandler('rsg-icemining:client:MiningIceAnimation', function()
    local ped = PlayerPedId()

    LoadAnimDict(testAnimDict)

    Wait(100)

    TaskPlayAnim(ped, testAnimDict, testAnim, 3.0, 3.0, -1, 1, 0, false, false, false)
end)

---------------------- SELL
RegisterNetEvent('rsg-icemining:client:sellice')
AddEventHandler('rsg-icemining:client:sellice', function()
    RSGCore.Functions.Progressbar('make-product', Lang:t('lang_11'), Config.SellTime, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
    TriggerServerEvent('rsg-icemining:server:sellice')
    end)
end)

---------------- delivery ice

local carthash = nil
local cargohash = nil
local lighthash = nil
local distance = nil
local wagonSpawned = false

local playerMissions = {}  -- Tabla para rastrear el estado de la misión actual de cada jugador

local MissionSecondsRemaining = 0
local missionicetime = 0
local missionactive = false


local function GetRandomDelivery()
    local randomIndex = math.random(1, #Config.DeliveryIceLocations)
    local selectedDelivery = Config.DeliveryIceLocations[randomIndex]
    
    return selectedDelivery
end

-- mission timer
local function MissionIceTimer(missionicetime, vehicle, endcoords)
    
    MissionSecondsRemaining = (missionicetime * 60)
    
    Citizen.CreateThread(function()
        while true do
            if MissionSecondsRemaining > 0 then
                Wait(1000)
                MissionSecondsRemaining = MissionSecondsRemaining - 1
                if MissionSecondsRemaining == 0 and wagonSpawned == true then
                    ClearGpsMultiRoute(endcoords)
                    endcoords = nil
                    DeleteVehicle(vehicle)
                    wagonSpawned = false
                    missionactive = false
                    lib.notify({ title = Lang:t('lang_12'), description = Lang:t('lang_13'), type = 'error' })
                end
            end

            if missionactive == true then
                local minutes = math.floor((MissionSecondsRemaining % 3600) / 60) -- El resto de segundos convertidos a minutos
                local seconds = MissionSecondsRemaining % 60 -- Los segundos restantes
                
                lib.showTextUI(Lang:t('lang_14')..minutes..':'..seconds)
                Wait(0)
            else
                lib.hideTextUI()
            end
            Wait(0)
        end
    end)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end
------------- MENU

RegisterNetEvent('rsg-icemining:client:menu')
AddEventHandler('rsg-icemining:client:menu', function(icemining)
local playerPed = PlayerPedId()  -- Obtén el ID de red del jugador actual
if not playerMissions[playerPed] then
    local selectedDeliveryIce = GetRandomDelivery()

    -- Debug: Print the selected mission for testing
    print('Debug: Selected Delivery - deliveryid: ' .. selectedDeliveryIce.deliveryid .. ', name: ' .. selectedDeliveryIce.name)

    local deliveryArgs = {
        name = selectedDeliveryIce.name,
        cart = selectedDeliveryIce.cart,
        cartspawn = selectedDeliveryIce.cartspawn,
        cargo = selectedDeliveryIce.cargo,
        light = selectedDeliveryIce.light,
        endcoords = selectedDeliveryIce.endcoords,
        showgps = selectedDeliveryIce.showgps,
        missionicetime = selectedDeliveryIce.missionicetime
    }

    lib.registerContext(
    {id = 'icemining_menu',
        title = icemining,
        position = 'top-right',
        options = {
            {   title = Lang:t('lang_15'),
                description = Lang:t('lang_16') ..selectedDeliveryIce.name,
                icon = "fa-solid fa-money-bills",
                event = 'rsg-icemining:client:vehiclespawn',
                onSelect = function()

                    TriggerEvent('rsg-icemining:client:vehiclespawn', selectedDeliveryIce.deliveryid, deliveryArgs.cart, deliveryArgs.cartspawn, deliveryArgs.cargo, deliveryArgs.light, deliveryArgs.endcoords, deliveryArgs.showgps, deliveryArgs.missionicetime)
                    lib.notify({ title = Lang:t('lang_17') ..selectedDeliveryIce.name, description = Lang:t('lang_18'), type = 'primary' })
                    playerMissions[playerPed] = true

                end
            },
            {   title = Lang:t('lang_19'),
                description = Lang:t('lang_20'),
                icon = 'fa-solid fa-sack-dollar',
                event = 'rsg-icemining:client:sellice',
            },
        }
    })
    lib.showContext('icemining_menu')
    else
        local selectedDeliveryIce = GetRandomDelivery()
        lib.notify({ title = Lang:t('lang_21'), description = Lang:t('lang_22') ..selectedDeliveryIce.name.. Lang:t('lang_23'), type = 'error' })
    end
end)

------------- SPAWN

RegisterNetEvent('rsg-icemining:client:vehiclespawn')
AddEventHandler('rsg-icemining:client:vehiclespawn', function(deliveryid, cart, cartspawn, cargo, light, endcoords, showgps, missionicetime)
    local playerPed = PlayerPedId()  -- Obtén el ID de red del jugador actual
    
    if wagonSpawned == false and not playerMissions[playerPed] then

        if not deliveryid then
            print('Debug: deliveryid = ' .. tostring(deliveryid)) -- Add this line for debugging
            return
        end

        local carthash = GetHashKey(cart)
        local cargohash = GetHashKey(cargo)
        local lighthash = GetHashKey(light)
        local coordsCartSpawn = vector3(cartspawn.x, cartspawn.y, cartspawn.z)
        local coordsEnd = vector3(endcoords.x, endcoords.y, endcoords.z)
        local distance = #(coordsCartSpawn - coordsEnd)
        local cashreward = (math.floor(distance) / 100)

        if Config.Debug == true then
            print('carthash '..carthash)
            print('cargohash '..cargohash)
            print('lighthash '..lighthash)
            print('distance '..distance)
            print('cashreward '..cashreward)
        end
        
        RequestModel(carthash, cargohash, lighthash)
        while not HasModelLoaded(carthash, cargohash, lighthash) do
            RequestModel(carthash, cargohash, lighthash)
            Wait(0)
        end 

        local coords = vector3(cartspawn.x, cartspawn.y, cartspawn.z)
        local heading = cartspawn.w
        local vehicle = CreateVehicle(carthash, coords, heading, true, false)
        SetVehicleOnGroundProperly(vehicle)
        Wait(200)
        SetModelAsNoLongerNeeded(carthash)
        Citizen.InvokeNative(0xD80FAF919A2E56EA, vehicle, cargohash)
        Citizen.InvokeNative(0xC0F0417A90402742, vehicle, lighthash)
        --TaskEnterVehicle(playerPed, vehicle, 10000, -1, 1.0, 1, 0)
        if showgps == true then
            StartGpsMultiRoute(GetHashKey("COLOR_RED"), true, true)
            AddPointToGpsMultiRoute(endcoords.x, endcoords.y, endcoords.z)
            SetGpsMultiRouteRender(true)
        end
        wagonSpawned = true
        missionactive = true
        MissionIceTimer(missionicetime, vehicle, endcoords)
        playerMissions[playerPed] = true  -- Actualiza el estado de la misión para este jugador
        while true do
            local sleep = 1000
            if wagonSpawned == true then
                local vehpos = GetEntityCoords(vehicle, true)
                if #(vehpos - endcoords) < 15.0 then
                    sleep = 0
                    DrawText3D(endcoords.x, endcoords.y, endcoords.z + 0.98, "DELIVERY POINT")
                    if #(vehpos - endcoords) < 3.0 then
                        if showgps == true then
                            ClearGpsMultiRoute(endcoords)
                        end
                        endcoords = nil
                        DeleteVehicle(vehicle)
                        TriggerServerEvent('rsg-icemining:server:givereward', cashreward)
                        wagonSpawned = false
                        missionactive = false
                        playerMissions[playerPed] = nil  -- Restablece el estado de la misión para este jugador
                        lib.notify({ title = Lang:t('lang_24'), description = Lang:t('lang_25'), type = 'success' })
                    end
                end
            end
            Wait(sleep)
        end
    end
end)

------------- STOP RESOURCE

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        
        ClearGpsMultiRoute(endcoords)
        ClearPedTasks(playerPed)
        DeleteVehicle(vehicle)
        wagonSpawned = false
        missionactive = false
        lib.hideTextUI()

        print('Recurso detenido: ' .. resourceName)
    end
end)
