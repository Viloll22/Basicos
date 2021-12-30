-- INVISIBLE
ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(500)
  end
end)

local invisible = false

AddEventHandler('chatMessage', function(source, name, msg)
	if msg == "/inv" then
		local source = source
		TriggerEvent('es:getPlayerFromId', source, function(user)
			local esadmin = user.getGroup()
			if esadmin == "superadmin" or esadmin == "admin" then 
				CancelEvent()
				TriggerClientEvent('wld:inv',source)
			end
		end)
end
end)

RegisterNetEvent('wld:inv')
AddEventHandler('wld:inv',function()
	if invisible == false then
		SetEntityVisible(GetPlayerPed(-1),false)
		invisible = true
		SetNotificationTextEntry("STRING")
		AddTextComponentString("Eres invisible." )
		DrawNotification(false, true)
	else
		SetEntityVisible(GetPlayerPed(-1),true)
		invisible = false
		SetNotificationTextEntry("STRING")
		AddTextComponentString("Ya no eres invisible." )
		DrawNotification(false, true)
	end

end)