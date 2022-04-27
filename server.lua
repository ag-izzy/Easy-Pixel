QBCore = nil
TriggerEvent(EZPXS.SharedObject, function(obj) QBCore = obj end)

ExecuteCommand('sets Easy-Pixel Active')

local d = LoadResourceFile(GetCurrentResourceName(),    "configs/serverconfig.lua")
local e = LoadResourceFile(GetCurrentResourceName(), 	"configs/clientconfig.lua")
local f = LoadResourceFile(GetCurrentResourceName(), 	"tables/blacklistedmodels.lua")
local g = LoadResourceFile(GetCurrentResourceName(), 	"tables/blacklistedevents.lua")
local h = LoadResourceFile(GetCurrentResourceName(), 	"tables/blacklistedexplosions.lua")
local i = LoadResourceFile(GetCurrentResourceName(), 	"tables/blacklistedwords.lua")
local P = LoadResourceFile(GetCurrentResourceName(),	"tables/blacklistped.lua")
local a = LoadResourceFile(GetCurrentResourceName(),	"tables/blacklistbuilding.lua")
local y = LoadResourceFile(GetCurrentResourceName(),	"tables/blacklistweapons.lua")
local U = LoadResourceFile(GetCurrentResourceName(),	"tables/blacklistplate.lua")
local j = LoadResourceFile(GetCurrentResourceName(),	"tables/whitelistjob.lua")

if not d or d == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(EZPXS) ~= "table" or EZPXS == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end;
if not e or e == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(EZPXC) ~= "table" or EZPXC == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end;
if not f or f == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(AM) ~= "table" or AM == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end;
if not a or a == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(AMBUILDING) ~= "table" or AMBUILDING == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end;
if not P or P == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(AMPEDS) ~= "table" or AMPEDS == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end;
if not U or U == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(AMPLATE) ~= "table" or AMPLATE == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end;
if not y or y == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(AMWEAPON) ~= "table" or AMWEAPON == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end;
if not g or g == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(AMEVENT) ~= "table" or AMEVENT == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end;
if not h or h == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(AMEXP) ~= "table" or AMEXP == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end;
if not i or i == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(AMWOERD) ~= "table" or AMWOERD == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end
if not j or j == "" then
	StopResource(GetCurrentResourceName())
	return false
else
	if type(AMJOBS) ~= "table" or AMJOBS == nil then
		StopResource(GetCurrentResourceName())
		return false
	end
end

function isWhitelisted(player)
    local allowed = false
	if EZPXS.WhitelistedRank ~= false then
		if QBCore.Functions.HasPermission(player, EZPXS.WhitelistedRank) then
			allowed = true
		end
	end
    for i,id in ipairs(EZPXS.WhitelistedMember) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

local dlay = {}

function EZPXLog(source, s, t, u)
	if not isWhitelisted(source) then
		local name = GetPlayerName(source)
		if name == nil then
			name = "User"
		end
		if EZPXS.Chat then
			if not dlay[source] then
				dlay[source] = true
				local xPlayers = QBCore.Functions.GetPlayers()
				for i=1, #xPlayers, 1 do
					if QBCore.Functions.HasPermission(xPlayers[i], EZPXS.Alarm) then
						if not u then
							TriggerClientEvent('chatMessage', xPlayers[i], "^2[Easy Pixel] ^0", "warning", "Warning 📢| Player ^1".. name .."^2(".. source ..")^0 Cheating From Server : ^5".. s .. " ")
						else
							TriggerClientEvent('chatMessage', xPlayers[i], "^2[Easy Pixel] ^0", "error", "Kick ⚡️| Player ^1".. name .."^2(".. source ..")^0 Cheating From Server : ^5".. s .. " ")
						end
					end
				end
				SetTimeout(30000,function()
                    dlay[source] = nil
                end)
			end
		end
		if u then
			if EZPXS.Alarm ~= false then
				if not QBCore.Functions.HasPermission(source, EZPXS.Alarm) then
					DropPlayer(source, EZPXS.Messege)
				end
			else
				DropPlayer(source, EZPXS.Messege)
			end
		end
	end
end

local J = ""
local K = ""

RegisterServerEvent("EZPX:SvKPEsAvKhtZAGPa")
AddEventHandler("EZPX:SvKPEsAvKhtZAGPa", function(U)	
	if U == "bLzDREqLxxSUqrKh" then
		TriggerClientEvent("EZPX:APGzFvGKABCeWRvL", source, "sKzMrhphedtnZdeZ", EZPXC, AM, true, J, K)
	else
		TriggerClientEvent("EZPX:APGzFvGKABCeWRvL", source, "sKzMrhphedtnZdeZ", EZPXC, AM, false, J)
	end
end)

RegisterNetEvent("EZPX:SetLog")
AddEventHandler("EZPX:SetLog", function(playerid, user, log, reason)
	EZPXLog(source, log, reason, EZPXS.AntiClientAbuseKick)
end)

RegisterServerEvent("EZPX:LoadMapCollision")
AddEventHandler("EZPX:LoadMapCollision", function()
    local source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer or xPlayer == nil or xPlayer == "" or xPlayer == "null" then
		EZPXLog(source, "Unload Player", "The Player Is't Load", EZPXS.AntiUnloadKick)
    end
end)

local pcount = {}
AddEventHandler("ptFxEvent", function(sender, data)
    local _src = sender
    local steam = GetPlayerIdentifiers(_src, 1)[1]
    if pcount[steam] == nil then
        pcount[steam] = {
            count = 1,
            timestamp = os.time()
        }
    else
        pcount[steam].count = pcount[steam].count + 1
        if pcount[steam].count > 1 then
            local fs = os.time() - pcount[steam].timestamp
            if fs < 10 then
                pcount[steam].count = 0
                if GetPlayerName(_src) ~= nil then
					EZPXLog(_src, " Anti Particle", "Try For Spam Particle", EZPXS.AntiSpamParticleKick)
        		else
                    error('Error code 100')
                end
                pcount[steam] = {
                    count = 1,
                    timestamp = os.time()
                }
            else
                pcount[steam] = {
                    count = 1,
                    timestamp = os.time()
                }
            end
        end
    end
end)

RegisterNetEvent("AntiPlayerBlip")
AddEventHandler("AntiPlayerBlip", function(playerid, user, log, reason)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if not AMJOBS.Whitelist[xPlayer.PlayerData.job.name] then
		EZPXLog(source, log, reason, EZPXS.AntiBlipPlayerKick)
	end
end)

RegisterNetEvent("AntiSuperJump")
AddEventHandler("AntiSuperJump", function(playerid, user, log, reason)
	EZPXLog(source, log, reason, EZPXS.AntiSuperJumpKick)
end)

RegisterNetEvent("AntiSpectate")
AddEventHandler("AntiSpectate", function(playerid, user, log, reason)
	EZPXLog(source, log, reason, EZPXS.AntiSpectateKick)
end)

RegisterNetEvent("AntiSpeedHack")
AddEventHandler("AntiSpeedHack", function(playerid, user, log, reason)
	EZPXLog(source, log, reason, EZPXS.AntiSpeedHackKick)
end)

RegisterNetEvent("AntiThermalVision")
AddEventHandler("AntiThermalVision", function(playerid, user, log, reason)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if not AMJOBS.Whitelist[xPlayer.PlayerData.job.name] then
		EZPXLog(source, log, reason, EZPXS.AntiThermalVisionKick)
	end
end)

if EZPXS.AntiAddWeapon then
	AddEventHandler("giveWeaponEvent", function(sender, data)
        if data.givenAsPickup == false then
            	EZPXLog(sender, 'Anti Add Weapon', 'Try to Add weapon for other Plater', EZPXS.AntiAddWeaponKick)
            CancelEvent()
        end
    end)
end

if EZPXS.AntiRemoveWeapon then
	AddEventHandler("RemoveWeaponEvent", function(sender, data)
        CancelEvent()
		EZPXLog(sender, 'Anti Remove Weapon', 'Try to Remove weapon form other Plater', EZPXS.AntiRemoveWeaponKick)
    end)
end

if EZPXS.AntiRemoveAllWeapon then
AddEventHandler("RemoveAllWeaponsEvent",function(sender, data)
        CancelEvent()
		EZPXLog(sender, 'Anti Remove Weapon', 'Try to Remove weapon form other Plater', EZPXS.AntiRemoveAllWeaponKick)
    end)
end

if EZPXS.TriggerAbuse then
    for i=1 , #AMEVENT.Events do
        RegisterNetEvent(AMEVENT.Events[i])
        AddEventHandler(AMEVENT.Events[i], function()
			EZPXLog(source, 'Anti Black List Trigger', 'Try to use Black List Trigger`' ..AMEVENT.Events[i].. '`', EZPXS.TriggerAbuseKick)
			return CancelEvent()
		end)
    end
end

RegisterServerEvent('db:updateUser')
AddEventHandler('db:updateUser', function()
	if EZPXS.AntiGivePerm then
		CancelEvent()
		EZPXLog(source, " Anti Give Perm", "Try For Add perm", EZPXS.AntiGivePermKick)
	end
end)

if EZPXS.AntiTazePlayer then
	AddEventHandler("weaponDamageEvent", function(sender, data)
		local xPlayer = QBCore.Functions.GetPlayer(sender)
		if data.weaponType == 911657153 then
			if not AMJOBS.Whitelist[xPlayer.PlayerData.job.name] then
				EZPXLog(source, "Anti Taze Player", "Try For Taze Other Player", EZPXS.AntiTazePlayerKick)
				CancelEvent()
				return
			end
		end
	end)
end

RegisterServerEvent("AntiInvisble")
AddEventHandler("AntiInvisble", function()
	EZPXLog(source, "Anti Invisble", "Player Try For Invisble in Server", EZPXS.AntiInvisbleKick)
end)

RegisterNetEvent("AntiGodMod")
AddEventHandler("AntiGodMod", function(playerid, user, log, reason)
	EZPXLog(source, log, reason, EZPXS.AntiGodModKick)
end)

RegisterNetEvent("AntiResourceStart")
AddEventHandler("AntiResourceStart", function(playerid, user, log, reason)
	EZPXLog(source, log, reason, EZPXS.AntiResourceStopperKick)
end)

RegisterNetEvent("AntiResourceStop")
AddEventHandler("AntiResourceStop", function(playerid, user, log, reason)
	EZPXLog(source, log, reason, EZPXS.AntiResourceStopperKick)
end)

RegisterNetEvent("AntiNightVision")
AddEventHandler("AntiNightVision", function(playerid, user, log, reason)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if not AMJOBS.Whitelist[xPlayer.PlayerData.job.name] then
		EZPXLog(source, log, reason, EZPXS.AntiNightVisionKick)
	end
end)

RegisterNetEvent("AntiTeleport")
AddEventHandler("AntiTeleport", function(playerid, user, log, reason)
	EZPXLog(source, log, reason, EZPXS.AntiTeleportKick)
end)

RegisterNetEvent("BlackListWeapon")
AddEventHandler("BlackListWeapon", function(playerid, user, log, reason)
	EZPXLog(source, log, reason, EZPXS.AntiBlackListWeaponKick)
end)

AddEventHandler('explosionEvent', function(a7, a8)
	if EZPXS.ExplosionsAbuse then
		if AMEXP.ExplosionsList[a8.explosionType] then
			local a9 = AMEXP.ExplosionsList[a8.explosionType]
			if a9.log then
				EZPXLog(a7, "Detected Explosion: "..a9.name, "The user created this explosion and got detected", false)
			end;
			CancelEvent()
		end;
	end
end)

RegisterCommand("dvallobj", function()
    Citizen.CreateThread(function()
        for k, v in pairs(GetAllObjects()) do
            DeleteEntity(v)
        end
    end)
end)

AddEventHandler('entityCreating', function(entity)
	if EZPXS.AntiObjectSpawner then
		local src = NetworkGetEntityOwner(entity)
		local model = GetEntityModel(entity)
		for _,blacklistedentity in ipairs(AM.BlacklistedEntities) do
			if model == GetHashKey(blacklistedentity) then
				-- CancelEvent()
				-- TriggerClientEvent('EZPX:DeleteEntity', entity)
				EZPXLog(src, " Blacklisted Object", "Player Try for spawn Black List Object: **"..blacklistedentity.."**", EZPXS.AntiObjectSpawnerKick)
				break
	   		end
		end
	end
end)


AddEventHandler('entityCreating', function(ped)
	if EZPXS.AntiBlackListPed then
		local src = NetworkGetEntityOwner(ped)
		local model = GetEntityModel(ped)
		for _,blacklistedentity in ipairs(AMPEDS.BlacklistedPeds) do
			if model == GetHashKey(blacklistedentity) then
				-- CancelEvent()
				-- TriggerClientEvent('EZPX:DeleteEntity', ped)
				EZPXLog(src, " Blacklisted Ped", "Player Try For Spawn Black List Ped : **"..blacklistedentity.."**", EZPXS.AntiBlackListPedKick)
				break
	   		end
		end
	end
end)


AddEventHandler('entityCreating', function(Building)
	if EZPXS.AntiBuildingSpawner then
		local src = NetworkGetEntityOwner(Building)
		local model = GetEntityModel(Building)
		for _,blacklistedentity in ipairs(AMBUILDING.BlackListBuilding) do
			if model == GetHashKey(blacklistedentity) then
				CancelEvent()
				TriggerClientEvent('EZPX:DeleteEntity', Building)
				EZPXLog(src, " Blacklisted Building", "Player Try For Spawn Black List Building: **"..blacklistedentity.."**", EZPXS.AntiBuildingSpawnerKick)
				break
	   		end
		end
	end
end)

local validResourceList

local function collectValidResourceList()
	validResourceList = {}
	for i=0,GetNumResources()-1 do
    	validResourceList[GetResourceByFindIndex(i)] = true
  	end
end

collectValidResourceList()
AddEventHandler("onResourceListRefresh", collectValidResourceList)
RegisterNetEvent("EZPX:CmR")
AddEventHandler("EZPX:CmR", function(givenList)
  for _, resource in ipairs(givenList) do
    if not validResourceList[resource] then
	  EZPXLog(source, " ResourceChecker", "This player tried to inject a resource that is not listed: **"..resource.."**", true)
      break
    end
  end
end)

if EZPXS.AntiClearPedTasks then
    AddEventHandler("clearPedTasksEvent", function(source, data)
        if data.immediately then
			EZPXLog(source, "Anti Clear Ped Tasks", "Try For Clear Ped Tasks", EZPXS.AntiClearPedTasksKick)
        end
    end)
end

local ANTIFREEZE = {}
if EZPXS.AntiFreezeLobby then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(7000)
			ANTIFREEZE = {}
		end
	end)
	AddEventHandler("clearPedTasksEvent",function(source, args)
		local source = source
		if args.immediately then
			CancelEvent()
			if ANTIFREEZE[source] then
				ANTIFREEZE[source].LOBBY = ANTIFREEZE[source].LOBBY + tonumber("1")
			else
				ANTIFREEZE[source] = {}
				ANTIFREEZE[source].LOBBY = tonumber("1")
			end
			if ANTIFREEZE[source].LOBBY > tonumber("1") then
				EZPXLog(source, " Anti Freeze Loby", "Try To Freeze Loby", EZPXS.AntiFreezeLobyKick)
			end
		end
	end)
end

local vehicle = {}
AddEventHandler('entityCreating', function(entity)
	if EZPXS.AntiSpamVehicle then
    local entity = entity
    if not DoesEntityExist(entity) then
        return
    end
    local entID = NetworkGetNetworkIdFromEntity(entity)
	local src = NetworkGetEntityOwner(entity)
    local type = GetEntityType(entity) 
    local hex = GetPlayerIdentifiers(src,1)[1]
    if type ~= 0 then
        if GetEntityPopulationType(entity) ~= 7 then
        return
        end		
        local model = GetEntityModel(entity)
        if type == 2 then -- vehicle
          if vehicle[hex] == nil then
			vehicle[hex] = {
			count = 1,
			timestamp = os.time()
			} 
			else
			vehicle[hex].count = vehicle[hex].count + 1
			if vehicle[hex].count > 4 then
			local fs = os.time() - vehicle[hex].timestamp
			if fs < 10 then
			vehicle[hex].count = 0
			if GetPlayerName(src) ~= nil then
				EZPXLog(src, " Anti Spam Vehicle", "Try For Spam Vehicle", EZPXS.AntiSpamVehicleKick)
			end
			for k,v in pairs(GetAllVehicles()) do
             local vehHash = GetEntityModel(v)
			 local src2 = NetworkGetEntityOwner(v)
             if src2 == src then
				DeleteEntity(v)
				TriggerClientEvent("EZPX:DeleteEntity",-1,v)
             end
            end
			vehicle[hex] = {
			count = 1,
			timestamp = os.time()
			} 
			else
			vehicle[hex] = {
			count = 1,
			timestamp = os.time()
			} 
            end			
			end
			end

        end

    end
end
end)

local ped = {}
AddEventHandler('entityCreating', function(entity)
	local src = NetworkGetEntityOwner(entity)
	local entIDd = NetworkGetNetworkIdFromEntity(entity)
    TriggerClientEvent("EZPX:checkentity", src, entIDd)
	if EZPXS.AntiSpamPed then
    local entity = entity
    if not DoesEntityExist(entity) then
        return
    end
	local src = NetworkGetEntityOwner(entity)
    local type = GetEntityType(entity) 
    local hex = GetPlayerIdentifiers(src,1)[1]
    if type ~= 0 then
        if GetEntityPopulationType(entity) ~= 7 then
        return
        end		
        local model = GetEntityModel(entity)
        if type == 1 then -- ped
          if ped[hex] == nil then
			ped[hex] = {
			count = 1,
			timestamp = os.time()
			} 
			else
				ped[hex].count = ped[hex].count + 1
			if ped[hex].count > 4 then
			local fs = os.time() - ped[hex].timestamp
			if fs < 10 then
				ped[hex].count = 0
			if GetPlayerName(src) ~= nil then
				EZPXLog(src, " Anti Spam ped", "Try For Spam ped", EZPXS.AntiSpamPedKick)
			end
			for k,v in pairs(GetAllVehicles()) do
             local vehHash = GetEntityModel(v)
			 local src2 = NetworkGetEntityOwner(v)
             if src2 == src then
				DeleteEntity(v)
				TriggerClientEvent("EZPX:DeleteEntity",-1,v)
             end
            end
			vehicle[hex] = {
			count = 1,
			timestamp = os.time()
			} 
			else
			vehicle[hex] = {
			count = 1,
			timestamp = os.time()
			} 
            end			
			end
			end

        end
	end
end
end)

local object = {}
AddEventHandler('entityCreating', function(entity)
	if EZPXS.AntiSpamPed then
    local entity = entity
    if not DoesEntityExist(entity) then
        return
    end
    local entID = NetworkGetNetworkIdFromEntity(entity)
	local src = NetworkGetEntityOwner(entity)
    local type = GetEntityType(entity) 
    local hex = GetPlayerIdentifiers(src,1)[1]
    if type ~= 0 then
        if GetEntityPopulationType(entity) ~= 7 then
        return
        end		
        local model = GetEntityModel(entity)
        if type == 3 then -- object
          if object[hex] == nil then
			object[hex] = {
			count = 1,
			timestamp = os.time()
			} 
			else
				object[hex].count = object[hex].count + 1
			if object[hex].count > 4 then
			local fs = os.time() - ped[hex].timestamp
			if fs < 10 then
				object[hex].count = 0
			if GetPlayerName(src) ~= nil then
				EZPXLog(src, " Anti Spam object", "Try For Spam object", EZPXS.AntiSpamPedKick)
			end
			for k,v in pairs(GetAllVehicles()) do
             local vehHash = GetEntityModel(v)
			 local src2 = NetworkGetEntityOwner(v)
             if src2 == src then
				DeleteEntity(v)
				TriggerClientEvent("EZPX:DeleteEntity",-1,v)
             end
            end
			vehicle[hex] = {
			count = 1,
			timestamp = os.time()
			} 
			else
			vehicle[hex] = {
			count = 1,
			timestamp = os.time()
			} 
            end			
			end
			end

        end

	end
end
end)

function splitString(inputstr, sep)
	local t= {}; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end