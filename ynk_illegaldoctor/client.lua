local ESX = exports['es_extended']:getSharedObject()

local pedName = Config.ped
local pedHash = GetHashKey(pedName)
local player = PlayerPedId()

local pedSpawned = false
local createdPed = nil

RegisterNetEvent('applyHeal')
AddEventHandler('applyHeal', function(pourcentage)
    local player = PlayerPedId()
    local currentHealth = GetEntityHealth(player)

    lib.progressBar({ duration = 3000,label = 'Soin', useWhileDead = false,canCancel = true,disable = {car = true,}})

    SetEntityHealth(player, currentHealth + pourcentage)
    playerHealedEffect()
    print("Tu as été soigné de " .. pourcentage .. " %")
end)

function makePedAttack()
  GiveWeaponToPed(createdPed, GetHashKey("WEAPON_PISTOL"), 10, false, true)

  SetPedCombatAttributes(createdPed, 46, true)        
  SetPedAsEnemy(createdPed, true)                    
  SetPedCanRagdoll(createdPed, true)
  SetPedCombatAbility(createdPed, 2)                  
  SetPedCombatRange(createdPed, 2)                    
  SetPedAlertness(createdPed, 3)                     
  SetPedAccuracy(createdPed, 50)                     

  TaskCombatPed(createdPed, player, 0, 16)

  Citizen.SetTimeout(5000, function() 
      ClearPedTasks(createdPed)
      RemoveWeaponFromPed(createdPed, GetHashKey("WEAPON_PISTOL"))
  end)
end

function payment(pourcentage, price)
    local input = lib.inputDialog('Paiement', {
    {type = 'input', label = "Veut tu payer ?", description = 'oui / non', required = true, max = 3},
    })

    if input[1] == 'oui' then
        TriggerServerEvent('removeMoneyAndHeal', pourcentage, price)
    elseif input[1] == 'non' then
        ESX.ShowNotification('il faut payer sinon tu dégage .')
        makePedAttack()
    end
end

function playerHealedEffect()
  RequestAnimSet("move_m@drunk@verydrunk")

  while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
      Wait(10)
  end
  StartScreenEffect("DrugsTrevorClownsFight", 0, false)
  SetPedMovementClipset(PlayerPedId(), "move_m@drunk@verydrunk", 1.0)

  Wait(Config.drugEffect)

  StopScreenEffect("DrugsTrevorClownsFight")
  ResetPedMovementClipset(PlayerPedId(), 0.0)
  ResetPedWeaponMovementClipset(PlayerPedId())
  ResetPedStrafeClipset(PlayerPedId())

end


--illegal_medical

lib.registerContext({
  id = 'illegal_medical',
  title = 'Médecin illégal',
  options = {
    {
      title = "30% heal for 50",
      icon = 'heart-pulse',
      iconColor = 'red',
      onSelect = function()
        payment(Config.heal[1].pourcentage, Config.heal[1].price)
      end,
    },
    {
      title = "60% heal for 100",
      icon = 'heart-pulse',
      iconColor = 'yellow',
      onSelect = function()
        print("60% heal for 100")
        payment(Config.heal[2].pourcentage, Config.heal[2].price)
      end,
    },
    {
      title = "100% heal for 150",
      icon = 'heart-pulse',
      iconColor = 'green',
      onSelect = function()
        print("100% heal for 150")
        payment(Config.heal[3].pourcentage, Config.heal[3].price)
      end,
    }
  }
})


    local pedPosition = Config.pedPosition

    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(0)
    end

    createdPed = CreatePed(4, pedHash, pedPosition.x, pedPosition.y, pedPosition.z - 1.0, 0.0, false, true)
    SetEntityInvincible(createdPed, true)
    FreezeEntityPosition(createdPed, true)
    TaskStartScenarioInPlace(createdPed, "WORLD_HUMAN_CLIPBOARD", 0, true)

exports.ox_target:addLocalEntity(createdPed, {
    {
        name = 'open_drug_menu',
        icon = 'fas fa-capsules',
        label = 'Parler au docteur',
        distance = 2.0,
        onSelect = function(data)
            lib.showContext("illegal_medical")
        end
    }
})
