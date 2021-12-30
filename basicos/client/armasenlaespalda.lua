--ARMAS EN LA ESPALDA
local fuera = true
local si = false

function playAnim(animDict, animName, duration)
	  RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, true, false)
    RemoveAnimDict(animDict)
end



local SETTINGS = {
  back_bone = 24816,
  x = 0.15,
  y = -0.15,
  z = -0.01,
  x_rotation = 0.0,
  y_rotation = -165.0,
  z_rotation = 0.0,
  compatable_weapon_hashes = {
    -- melee:
    --["prop_golf_iron_01"] = 1141786504, -- positioning still needs work
    ["w_me_bat"] = -1786099057,
    -- assault rifles:
    ["w_ar_carbinerifle"] = -2084633992,
    ["w_ar_carbineriflemk2"] = GetHashKey("WEAPON_CARBINERIFLE_Mk2"),
    ["w_ar_assaultrifle"] = -1074790547,
    ["w_ar_specialcarbine"] = -1063057011,
    ["w_ar_bullpuprifle"] = 2132975508,
    ["w_ar_advancedrifle"] = -1357824103,
    -- sub machine guns:
    ["w_sb_microsmg"] = 324215364,
    ["w_sb_assaultsmg"] = -270015777,
    ["w_sb_smg"] = 736523883,
    ["w_sb_smgmk2"] = GetHashKey("WEAPON_SMGMk2"),
    ["w_sb_gusenberg"] = 1627465347,
    -- sniper rifles:
    ["w_sr_sniperrifle"] = 100416529,
    -- shotguns:
    ["w_sg_assaultshotgun"] = -494615257,
    ["w_sg_bullpupshotgun"] = -1654528753,
    ["w_sg_pumpshotgun"] = 487013001,
    ["w_ar_musket"] = -1466123874,
    ["w_sg_heavyshotgun"] = GetHashKey("WEAPON_HEAVYSHOTGUN"),
    -- ["w_sg_sawnoff"] = 2017895192 don't show, maybe too small?
    -- launchers:
    ["w_lr_firework"] = 2138347493
  }
}

local SETTINGS2 = {
  back_bone = 11816,
  x = -0.005,
  y = -0.13,
  z = 0.12,
  x_rotation = 190.0,
  y_rotation = 190.0,
  z_rotation = 180.0,
  compatable_weapon_hashes = {
    ["w_pi_pistol"] = GetHashKey("WEAPON_PISTOL"),
    ["w_pi_combatpistol"] = GetHashKey("WEAPON_COMBATPISTOL"),
    ["w_pi_50pistol"] = GetHashKey("WEAPON_50PISTOL"),
    ["w_pi_heavypistol"] = GetHashKey("WEAPON_HEAVYPISTOL"),
  }
}

local armasmochila = {
  "weapon_bat",
  "weapon_carbinerifle",
  "weapon_carbineriflemk2",
  "weapon_assaultrifle",
  "weapon_specialcarbine",
  "weapon_bullpuprifle",
  "weapon_advancedrifle",
  "weapon_assaultsmg",
  "weapon_smg",
  "weapon_smgmk2",
  "weapon_gusenberg",
  "weapon_sniperrifle",
  "weapon_assaultshotgun",
  "weapon_bullpupshotgun",
  "weapon_pumpshotgun",
  "weapon_musket",
  "weapon_heavyshotgun"
}


local SETTINGS3 = {
  back_bone = 11816,
  x = -0.15,
  y = -0.14,
  z = -0.12,
  x_rotation = 0.0,
  y_rotation = 90.0,
  z_rotation = 0.0,
  compatable_weapon_hashes = {
    ["w_me_knife_01"] = GetHashKey("WEAPON_KNIFE"),
  }
}


local attached_weapons = {}


RegisterCommand('armas', function()
  local conmochila = false

  local ped = PlayerPedId()

  for i = 1, #armasmochila, 1 do
    if HasPedGotWeapon(ped, GetHashKey(armasmochila[i])) then
      conmochila = true
    end
  end
  
  if IsPedArmed(ped, -1) then
    ESX.ShowNotification('No hagas esto si tienes un arma en la mano')
  else


    if conmochila then

      TriggerEvent('skinchanger:getSkin', function(skin) plySkin = skin; end)
      if (plySkin["bags_1"] ~= 0 or plySkin["bags_2"] ~= 0) then

          if fuera then
            oculto = true
            fuera = false
            ExecuteCommand('do se le veria esconder sus armas en la mochila')
            playAnim('reaction@intimidation@1h', 'outro', 1500)

          else
            fuera = true
            oculto = false
            ExecuteCommand('do se le veria sacar sus armas de la mochila')
            playAnim('reaction@intimidation@1h', 'intro', 1500)
            Citizen.Wait(1400)

              for wep_name2, wep_hash2 in pairs(SETTINGS.compatable_weapon_hashes) do
                if HasPedGotWeapon(ped, wep_hash2, false) then
                  AttachWeapon(wep_name2, wep_hash2, SETTINGS.back_bone, SETTINGS.x, SETTINGS.y, SETTINGS.z, SETTINGS.x_rotation, SETTINGS.y_rotation, SETTINGS.z_rotation, isMeleeWeapon(wep_name2))
                end
              end

            for wep_name3, wep_hash3 in pairs(SETTINGS2.compatable_weapon_hashes) do
              if HasPedGotWeapon(ped, wep_hash3, false) then
                AttachWeapon(wep_name3, wep_hash3, SETTINGS2.back_bone, SETTINGS2.x, SETTINGS2.y, SETTINGS2.z, SETTINGS2.x_rotation, SETTINGS2.y_rotation, SETTINGS2.z_rotation, isMeleeWeapon(wep_name3))
              end
            end

            for wep_name4, wep_hash4 in pairs(SETTINGS3.compatable_weapon_hashes) do
              if HasPedGotWeapon(ped, wep_hash4, false) then
                AttachWeapon(wep_name4, wep_hash4, SETTINGS3.back_bone, SETTINGS3.x, SETTINGS3.y, SETTINGS3.z, SETTINGS3.x_rotation, SETTINGS3.y_rotation, SETTINGS3.z_rotation, isMeleeWeapon(wep_name4))
              end
            end


          end

      else
        ESX.ShowNotification('Necesitas una mochila para guardar las armas')
      end

    else

        if fuera then
          oculto = true
          fuera = false
          ExecuteCommand('do se le veria esconder sus armas entre la ropa')
          playAnim('reaction@intimidation@1h', 'outro', 1500)

        else
          fuera = true
          oculto = false
          ExecuteCommand('do se le veria sacar sus armas de la ropa')
          playAnim('reaction@intimidation@1h', 'intro', 1500)
          Citizen.Wait(1400)

            for wep_name2, wep_hash2 in pairs(SETTINGS.compatable_weapon_hashes) do
              if HasPedGotWeapon(ped, wep_hash2, false) then
                AttachWeapon(wep_name2, wep_hash2, SETTINGS.back_bone, SETTINGS.x, SETTINGS.y, SETTINGS.z, SETTINGS.x_rotation, SETTINGS.y_rotation, SETTINGS.z_rotation, isMeleeWeapon(wep_name2))
              end
            end

          for wep_name3, wep_hash3 in pairs(SETTINGS2.compatable_weapon_hashes) do
            if HasPedGotWeapon(ped, wep_hash3, false) then
              AttachWeapon(wep_name3, wep_hash3, SETTINGS2.back_bone, SETTINGS2.x, SETTINGS2.y, SETTINGS2.z, SETTINGS2.x_rotation, SETTINGS2.y_rotation, SETTINGS2.z_rotation, isMeleeWeapon(wep_name3))
            end
          end

          for wep_name4, wep_hash4 in pairs(SETTINGS3.compatable_weapon_hashes) do
            if HasPedGotWeapon(ped, wep_hash4, false) then
              AttachWeapon(wep_name4, wep_hash4, SETTINGS3.back_bone, SETTINGS3.x, SETTINGS3.y, SETTINGS3.z, SETTINGS3.x_rotation, SETTINGS3.y_rotation, SETTINGS3.z_rotation, isMeleeWeapon(wep_name4))
            end
          end

    end
  end

  end
end)


Citizen.CreateThread(function()
  while true do

    Wait(1000)

    local me = PlayerPedId()
    
    for wep_name, wep_hash in pairs(SETTINGS.compatable_weapon_hashes) do
      if fuera then
        if HasPedGotWeapon(me, wep_hash, false) then
            if not attached_weapons[wep_name] then
                AttachWeapon(wep_name, wep_hash, SETTINGS.back_bone, SETTINGS.x, SETTINGS.y, SETTINGS.z, SETTINGS.x_rotation, SETTINGS.y_rotation, SETTINGS.z_rotation, isMeleeWeapon(wep_name))
            end
          end
        end
    end

    for wep_name2, wep_hash2 in pairs(SETTINGS2.compatable_weapon_hashes) do
      if fuera then
        if HasPedGotWeapon(me, wep_hash2, false) then
            if not attached_weapons[wep_name2] then
                AttachWeapon(wep_name2, wep_hash2, SETTINGS2.back_bone, SETTINGS2.x, SETTINGS2.y, SETTINGS2.z, SETTINGS2.x_rotation, SETTINGS2.y_rotation, SETTINGS2.z_rotation, isMeleeWeapon(wep_name2))
            end
          end
        end
    end

    for wep_name3, wep_hash3 in pairs(SETTINGS3.compatable_weapon_hashes) do
      if fuera then
        if HasPedGotWeapon(me, wep_hash3, false) then
            if not attached_weapons[wep_name3] then
                AttachWeapon(wep_name3, wep_hash3, SETTINGS3.back_bone, SETTINGS3.x, SETTINGS3.y, SETTINGS3.z, SETTINGS3.x_rotation, SETTINGS3.y_rotation, SETTINGS3.z_rotation, isMeleeWeapon(wep_name3))
            end
          end
        end
    end

    for name, attached_object in pairs(attached_weapons) do

        if GetSelectedPedWeapon(me) ==  attached_object.hash or not HasPedGotWeapon(me, attached_object.hash, false) then -- equipped or not in weapon wheel
          DeleteObject(attached_object.handle)
          attached_weapons[name] = nil
        elseif oculto then
          DetachEntity(attached_object.handle)
          DeleteObject(attached_object.handle)
        end
    end
  end
  
end)

function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR, isMelee)
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumber)
    RequestModel(attachModel)

    while not HasModelLoaded(attachModel) do
      Wait(100)
    end

  attached_weapons[attachModel] = {
    hash = modelHash,
    handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
  }

    if isMelee then x = 0.11 y = -0.14 z = 0.0 xR = -75.0 yR = 185.0 zR = 92.0 end -- reposition for melee items
    if attachModel == "prop_ld_jerrycan_01" then x = x + 0.3 end

      AttachEntityToEntity(attached_weapons[attachModel].handle, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end


function QuitarArmasAtras()
  for name, attached_object in pairs(attached_weapons) do
    attached_weapons[name] = nil
    DeleteObject(attached_object.handle)
  end
end

RegisterNetEvent('armasatras:quitararmas')
AddEventHandler('armasatras:quitararmas', function()
    QuitarArmasAtras()
end)



function isMeleeWeapon(wep_name)
  if wep_name == "prop_golf_iron_01" then
      return true
  elseif wep_name == "w_me_bat" then
      return true
  elseif wep_name == "prop_ld_jerrycan_01" then
    return true
  else
      return false
  end
end




--- NO CULATAZOS
Citizen.CreateThread(function()
  local pausa1 = 500
  while true do
    Citizen.Wait(pausa1)

    pausa1 = 500

    local ped = PlayerPedId()

    if IsPedArmed(ped, 6) then
      pausa1 = 0
      DisableControlAction(1, 140, true)
      DisableControlAction(1, 141, true)
      DisableControlAction(1, 142, true)
    end

    if oculto then
      pausa1 = 0
      DisableControlAction(0, 37, true)
      DisableControlAction(0, 157, true)
      DisableControlAction(0, 158, true)
    end
    
  end
end)