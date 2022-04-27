local isSpawn = false

AddEventHandler("playerSpawned", function()
    isSpawn = true
end)

local isAdmin = false

QBCore = nil

CreateThread(function()
    while QBCore == nil do
        TriggerEvent(EZPXC.SharedObject, function(obj) QBCore = obj end)
        Wait(0)
    end
end)

RegisterNetEvent('qb-admin:client:openMenu')
AddEventHandler('qb-admin:client:openMenu', function(group, dealers)
    if group ~= "user" then
        isAdmin = true
    end
end)


RegisterNetEvent('EZPX:DeleteEntity')
AddEventHandler('EZPX:DeleteEntity', function(entity)
    if DoesEntityExist(entity) then
        Wait(EZPXC.CitizenWait)
        NetworkRequestControlOfEntity(entity)
        SetEntityAsMissionEntity(entity, true, true)
        DetachEntity(entity, 1, 1)
        DeleteEntity(entity)
        DeleteObject(entity)
   end
end)

if EZPXC.AntiSpectate then
    CreateThread(function()
        while true do
            Wait(EZPXC.CitizenWait)
            if NetworkIsInSpectatorMode() and not isAdmin then
                TriggerServerEvent("AntiSpectate", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Spectate", "Try For Spectate Player")
            end
        end
    end)
end

if EZPXC.ThermalVision then
CreateThread(function ()
    Wait(EZPXC.CitizenWait)
        if GetUsingseethrough(true) then
            TriggerServerEvent("AntiThermalVision", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Thermal Vision", "Try For Thermal Vision")
        end
    end)
end

if EZPXC.AntiInfinityAmmo then
    CreateThread(function()
        while true do
            Wait(EZPXC.CitizenWait)
            SetPedInfiniteAmmoClip(PlayerPedId(), false)
        end
    end)
end

if EZPXC.AntiNightVision then
    CreateThread(function ()
        while true do
            Wait(EZPXC.CitizenWait)
            if GetUsingnightvision(true) then
                TriggerServerEvent("AntiNightVision", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Night Vision", "Try For Night Vision")
            end
        end
    end)
end

if EZPXC.AntiInvisble then
    CreateThread(function()
        while true do
            Wait(EZPXC.CitizenWait)
            if isSpawn and not isAdmin then
                local ped = GetPlayerPed(-1)
                if GetGameTimer() - 120000  > 0 then
                    if not IsEntityVisible(ped) then
                        SetEntityVisible(ped, 1, 0)
                        TriggerServerEvent("AntiInvisble", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Invisble", "Try For Invisble in Server")
                    end
                end
            end
        end
    end)
end

if EZPXC.AntiCheat then
    CreateThread(function()
        while true do
            Wait(EZPXC.CitizenWait)
            if not isAdmin then
                local playerid = PlayerPedId()
                SetPedInfiniteAmmoClip(playerid, false)
                SetPlayerInvincible(playerid, false)
                SetEntityInvincible(playerid, false)
                SetEntityCanBeDamaged(playerid, true)
                SetPlayerHealthRechargeMultiplier(playerid, 0.0)
                SetEntityProofs(ped, false, true, true, false, false, false, false, false)
                ResetEntityAlpha(playerid)
                local cs = IsPedFalling(playerid)
                local ct = IsPedRagdoll(playerid)
                local cu = GetPedParachuteState(playerid)
                if cu >= 0 or ct or cs then
                    SetEntityMaxSpeed(playerid, 80.0)
                else
                    SetEntityMaxSpeed(playerid, 7.1)
                end
            end
        end
    end)
end

if EZPXC.AntiBlackListWeapon then
    CreateThread(function()
            while true do
                Wait(50)
                for cb, cl in ipairs(AMWEAPON.BlackListWeapon) do
                    local cm = PlayerPedId()
                    if HasPedGotWeapon(cm, GetHashKey(cl), false) == 1 then
                        RemoveAllPedWeapons(cm, true)
                        TriggerServerEvent("BlackListWeapon", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Black List Weapon", "Try For Add Black List Weapon")
                    end
                end
            Wait(EZPXC.CitizenWait)
        end
    end)
end

if EZPXC.AntiGodmode then
    CreateThread(function()
        while true do
          Wait(EZPXC.CitizenWait)
            local curPed = PlayerPedId()
            local curHealth = GetEntityHealth(curPed)
            SetEntityHealth( curPed, curHealth-2)
            local curWait = math.random(10,150)
            Wait(curWait)
            if PlayerPedId() == curPed and GetEntityHealth(curPed) == curHealth and GetEntityHealth(curPed) ~= 0 and GetEntityHealth(curPed) > 2 then
                if isSpawn and not isAdmin then
                    TriggerServerEvent("AntiGodMod", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti God Mode", "Try For God Mod")
                end
            elseif GetEntityHealth(curPed) == curHealth-2 then
                SetEntityHealth(curPed, GetEntityHealth(curPed)+2)
            end
            if GetPlayerInvincible(PlayerId()) then
               if GetGameTimer() - 120000  > 0 then
                if isSpawn and not isAdmin then
                   TriggerServerEvent("AntiGodMod", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti God Mode", "Try For God Mod")
                end
                Wait(EZPXC.CitizenWait)
                end
            end
        end
    end)
end

if EZPXC.AntiTeleport then
    CreateThread(function()
        Wait(EZPXC.CitizenWait)
        while true do
            Wait(EZPXC.CitizenWait)
            local ped = PlayerPedId()
            local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
            local still = IsPedStill(ped)
            local vel = GetEntitySpeed(ped)
            local ped = PlayerPedId()
            local speed = GetEntitySpeed(ped)
            Wait(EZPXC.CitizenWait)
            local more = speed - 8.0
            if not IsEntityVisible(PlayerPedId()) then
                SetEntityHealth(PlayerPedId(), -100)
            end
            newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
            newPed = PlayerPedId()
            if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 1 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed and not isAdmin then
                TriggerServerEvent("AntiTeleport", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Teleport", "Try For Teleport in other coords")
            end
        end
    end)
end

if EZPXC.AntiFastRun then
    CreateThread(function()
        Wait(EZPXC.CitizenWait)
        local ped = GetPlayerPed(-1)
        local speed = GetEntitySpeed(ped)
        local runing = IsPedRunning(ped)
        if runing and speed > 5 then
            TriggerServerEvent("AntiFastRun", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Fast Run", "Try For Fast Run")
        end
    end)
end

if EZPXC.AntiBlips then
    CreateThread(function()
        while true do
            Wait(EZPXC.CitizenWait)
            local playerblips = 0
            local playersonline = GetActivePlayers()
            for i = 1, #playersonline do
                local id = playersonline[i]
                local blipped = GetPlayerPed(id)
                if blipped ~= PlayerPedId(-1) then
                    local blipped = GetBlipFromEntity(blipped)		
                    if not DoesBlipExist(blipped) then
                    else
                        playerblips = playerblips+1
                    end
                end
            end
            if playerblips > 0 then
                TriggerServerEvent("AntiPlayerBlip", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti All Player Blip", "Try For Show All Player Blip")
            end
        end
    end)
end

if EZPXC.VehicleSpwan then
    CreateThread(function()
        while true do
            Wait(EZPXC.CitizenWait)
            local ped = GetPlayerPed(-1)
            local veh = GetVehiclePedIsIn(ped)
            local DriverSeat = GetPedInVehicleSeat(veh, -1)
            local plate = GetVehicleNumberPlateText(veh)
            if IsPedInAnyVehicle(ped, true) then
                for _, BlockedPlate in pairs(AMPLATE.BlacklistedPlates) do
                    if plate == BlockedPlate then
                        if DriverSeat == ped then
                            DeleteVehicle(veh)
                            TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Spawn Car", "Try For Spawn Car By Menu Plate : ".. plate .."")
                        end
                    end
                end
            end
         end
    end)
end

if EZPXC.AntiRequestVehicle then
    CreateThread(function()
        while true do
            Wait(2000)
            local cars = GetGamePool('CVehicle')
            for _, car in pairs(cars) do
                if car and IsEntityAttached(car) then
                    EntityRoPakKon(car, true)
                end
            end
        end
    end)
end

if EZPXC.AntiSuperJump then
    CreateThread(function()
        while true do
            Wait(EZPXC.CitizenWait)
                if IsPedJumping(PlayerPedId()) then
                local firstCoord = GetEntityCoords(GetPlayerPed(-1))
                while IsPedJumping(PlayerPedId()) do
                    Wait(EZPXC.CitizenWait)
                end
                local secondCoord = GetEntityCoords(GetPlayerPed(-1))
                local jumplength = GetDistanceBetweenCoords(firstCoord, secondCoord, false)
                if jumplength > EZPXC.SuperJumpMaxLength then
                    TriggerServerEvent("AntiSuperJump", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Super Jump", "Player Try For Super Jump")	
                end
            end
        end
    end)
end

if EZPXC.AntiSpeedHack then
   CreateThread(function()
 while true do
    Wait(EZPXC.CitizenWait)
    local ped = GetPlayerPed(-1)
    local speed = GetEntitySpeed(ped) 
    local inveh = IsPedInAnyVehicle(ped, false)
    local ragdoll = IsPedRagdoll(ped)
    local jumping = IsPedJumping(ped)
    local falling = IsPedFalling(ped)
          if not inveh then
               if not ragdoll then 
                  if not falling then 
                        if not jumping then 
                            if speed > EZPXC.MaxSpeed then 
                                TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Speed Hack", "Try For Speed Hack")
                            end
                        end
                    end
                end
             end
         end
    end)
end

if EZPXC.AntiWeaponDamageChange or EZPXC.AntiWeaponsExplosive then
    CreateThread(function()
        while true do
            Wait(EZPXC.CitizenWait)
            local weaponHash = GetSelectedPedWeapon(GetPlayerPed(-1))
            if EZPXC.AntiWeaponDamageChange then
                local WeaponDamage = math.floor(GetWeaponDamage(weaponHash))
                if EZPXC.WeaponDamages[weaponHash] and WeaponDamage > EZPXC.WeaponDamages[weaponHash].damage then
                    local src = source
                    TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Damage Changer", "Try To Change Weapon Damage")
                end
            end
            if EZPXC.AntiWeaponsExplosive then
                local wgroup = GetWeapontypeGroup(weaponHash)
                local dmgt = GetWeaponDamageType(weaponHash)
                if wgroup == -1609580060 or wgroup == -728555052 or weaponHash == -1569615261 then
                    if dmgt ~= 2 then
                        local src = source
                        TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Damage Changer", "Try To Change Weapon Damage")
                    end
                elseif wgroup == 416676503 or wgroup == -957766203 or wgroup == 860033945 or wgroup == 970310034 or wgroup == -1212426201 then
                    if dmgt ~= 3 then
                        local src = source
                        TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Damage Changer", "Try To Change Weapon Damage")
                    end
                end
            end
        end
    end)
end

if EZPXC.AntiCheatEngine then
    CreateThread(function()
        while true do
            Wait(EZPXC.CitizenWait)
            local RI = GetVehiclePedIsUsing(GetPlayerPed(-1))
            local RJ = GetEntityModel(RI)
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                if RI == RY and RJ ~= RZ and RZ ~= nil and RZ ~= 0 then
                    DeleteVehicle(RI)
                    local src = source
                     TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Cheat Engine", "Try For Use CheatEngine (Hash Changer)")
                    return
                end
            end
            RY = RI
            RZ = RJ
        end
    end)
end

if EZPXC.AntiResourceStopper then
    AddEventHandler("onClientResourceStop", function(resource)
        if isSpawn then
            TriggerServerEvent("AntiResourceStop", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Resource Stoper", "Try For Stop resource : "..resource.."")
        end
    end)
end

if EZPXC.AntiResourceStarter then
AddEventHandler('onClientResourceStart', function (resource)
    if isSpawn then
        TriggerServerEvent("AntiResourceStart", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Resource Start", "Try For Start resource : "..resource.."")    
    end
  end)
end

AddEventHandler('gameEventTriggered', function (EventName, args)
    if isSpawn then
        TriggerServerEvent('EZPX:Event', EventName)
    end
end)

function EntityRoPakKon(object, detach)
    if DoesEntityExist(object) then
        if detach then
            DetachEntity(object, 0, false)
        end
        SetEntityCollision(object, false, false)
        SetEntityAlpha(object, 0.0, true)
        SetEntityAsMissionEntity(object, true, true)
        SetEntityAsNoLongerNeeded(object)
        DeleteEntitity(object)
    end
end

if EZPXC.AntiUnLoadPlayer then
    CreateThread(function()
        while true do
            Wait(100)
            if isSpawn then
                Wait(60000)
                TriggerServerEvent("EZPX:LoadMapCollision")
            end
        end
    end)
end

RegisterNetEvent('EZPX:checkentity')
AddEventHandler('EZPX:checkentity',function(obj)
    if EZPXC.VehicleSpwan then
        if obj == nil then return end
        local ent = NetworkGetEntityFromNetworkId(obj)
        local type = GetEntityType(ent)
        local model = GetEntityModel(ent)
        if type == 2 then
            local script = GetEntityScript(ent)
            if script ~= nil and script ~= "qb-core" and script ~= "qb-humanlabs" and script ~= "qb-cocaine" and script ~= "qb-donoshop" and script ~= "qb-vehicleshop" and script ~= "qb-trains" and model ~= 0 then
                TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Spawn Car", "Try For Spawn vehicle("..model..") By Script : ".. script .."")
                QBCore.Functions.DeleteVehicle(ent)
            else
                local thread = true
                SetTimeout(60000,function()
                    thread = false
                end)
                CreateThread(function()
                    while thread do
                        Wait(1000)
                        if DoesEntityExist(ent) then
                            if IsEntityAttached(ent) then
                                if GetEntityAttachedTo(ent) ~= PlayerPedId() and GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetEntityAttachedTo(ent))) ~= 0 then
                                    TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Spawn Car", "Try For Spawn vehicle("..model..") To Player: "..GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetEntityAttachedTo(ent))).."")
                                    QBCore.Functions.DeleteVehicle(ent)
                                end
                            end
                        end
                    end
                end)
            end
        end
    end
end)

RegisterNUICallback('EZPX:OpenNUIDevtoolsDetected', function()
    if EZPXC.NuiDevtools then
        TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Nui Devtool", "Try For Open Nui Devtools")
    end
end)

if EZPXC.AntiNoclip then
    Citizen.CreateThread(function()
        Citizen.Wait(60000)
        while true do
            Citizen.Wait(0)
            if not isAdmin and isSpawn then
                local ped = PlayerPedId()
                local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
                local still = IsPedStill(ped)
                local vel = GetEntitySpeed(ped)
                local ped = PlayerPedId()
                Wait(EZPXC.CitizenWait)
                local newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
                local newPed = PlayerPedId()
                if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 200 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
                    TriggerServerEvent("EZPX:SetLog", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()), "Anti Noclip", "Try To Noclip")
                end
            end
        end
    end)
end

if EZPXC.AntiFlyCars then
    Citizen.CreateThread(function()
        local lastcoords = vector3(0.0, 0.0, 0.0)
        while true do
            Citizen.Wait(5)
            if isSpawn then
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                if IsPedSittingInAnyVehicle(ped) then
                    if GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped then
                        if Vdist(coords, lastcoords) >= 10.0 and coords.z > 30 then
                            CreateThread(function()
                                for height = 1, 1000 do
                                    SetPedCoordsKeepVehicle(ped, lastcoords.x, lastcoords.y, height + 0.0)
                                    local foundGround, zPos = GetGroundZFor_3dCoord(lastcoords.x, lastcoords.y, height + 0.0)
                                    if foundGround then
                                        SetPedCoordsKeepVehicle(ped, lastcoords.x, lastcoords.y, height + 0.0)
                                        break
                                    end
                                    Citizen.Wait(5)
                                end
                            end)
                        end
                        Citizen.Wait(5)
                    end
                end
                lastcoords = coords
            else
                Citizen.Wait(1000)
            end
        end
    end)
end