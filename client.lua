---------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------ver0.1---
-- PASSIVE MODE for RedM by Jackson92 -------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- Github:	https://github.com/92jackson/redm-passive-mode ----------------------------------------
-- Discord: https://discord.gg/e3eXGTJbjx (join for support, feedback, fixes, updates etc) --------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
local PlayerID = PlayerId()
local PlayerPed = 0
local MountedHorse = 0

Citizen.CreateThread(function()
	SetPlayerInvincible(PlayerID, true)
	SetMaxWantedLevel(0)
	SetPlayerCanBeHassledByGangs(PlayerID, false)
	SetPlayerCanUseCover(PlayerID, false)
	SetEveryoneIgnorePlayer(PlayerID, true)
	
	while true do
		Citizen.Wait(0) -- Every tick
		
		PlayerPed = PlayerPedId()
		MountedHorse = GetMount(PlayerPed)
		
		SetEntityInvincible(PlayerPed, true)
		SetPedCanRagdoll(PlayerPed, false)
		
		DisablePlayerFiring(PlayerID, true)
		RemoveAllPedWeapons(PlayerPed, true)
		
		SetPedConfigFlag(PlayerPed, 26, true) -- PCF_DisableMelee
		SetPedConfigFlag(PlayerPed, 169, true) -- PCF_DisableGrappleByPlayer
		SetPedConfigFlag(PlayerPed, 192, true) -- NPCs cant attack ped
		SetPedConfigFlag(PlayerPed, 218, true) -- PCF_DisablePickups
		SetPedConfigFlag(PlayerPed, 249, true) -- PCF_BlockWeaponSwitching
		SetPedConfigFlag(PlayerPed, 265, true) -- PCF_DrownsInWater
		
		-- Ped related
		for key,Ped in pairs(GetGamePool("CPed")) do
			SetEntityInvincible(Ped, true)
			SetPedCanRagdoll(Ped, false)
			
			if not IsPedAPlayer(Ped) then -- NPC
				SetPedConfigFlag(Ped, 113, true) -- PCF_DisableShockingEvents
				SetPedConfigFlag(Ped, 265, true) -- PCF_DrownsInWater
				SetPedConfigFlag(Ped, 305, true) -- PCF_DisableHeadGore
				SetPedConfigFlag(Ped, 306, true) -- PCF_DisableLimbGore
				SetPedConfigFlag(Ped, 340, true) -- PCF_DisableAllMeleeTakedowns
				SetPedConfigFlag(Ped, 456, true) -- Knock-out instead of death
				SetPedConfigFlag(Ped, 488, true) -- PCF_DiesInstantlyToMeleeFromAnimals
				SetPedConfigFlag(Ped, 522, true) -- PCF_DontFleeFromDroppedAnimals
				SetPedConfigFlag(Ped, 592, true) -- Disabling full body hit reacts
				
				SetBlockingOfNonTemporaryEvents(Ped, true)
				
				-- Is human ped?
				if IsPedHuman(Ped) then
					RemoveAllPedWeapons(Ped, true)
					
					SetPedConfigFlag(Ped, 26, true) -- PCF_DisableMelee
					SetPedConfigFlag(Ped, 77, true) -- PCF_DisableExplosionReactions
					SetPedConfigFlag(Ped, 87, true) -- PCF_DisablePedAvoidance
					SetPedConfigFlag(Ped, 89, true) -- PCF_DisablePanicInVehicle
					SetPedConfigFlag(Ped, 169, true) -- PCF_DisableGrappleByPlayer
					SetPedConfigFlag(Ped, 233, true) -- PCF_PedIsEnemyToPlayer
					SetPedConfigFlag(Ped, 286, true) -- PCF_DisableEvasiveDives
					SetPedConfigFlag(Ped, 340, true) -- PCF_DisableAllMeleeTakedowns
					SetPedConfigFlag(Ped, 429, false) -- PCF_KnockOutDuringHogtie
					SetPedConfigFlag(Ped, 503, true) -- PCF_DisableSpecialGreetChains
					
					DisablePedPainAudio(Ped, true)
				else
					SetPedConfigFlag(Ped, 174, true) -- PCF_DisableEvasiveStep
					SetPedConfigFlag(Ped, 312, true) -- PCF_DisableHorseGunshotFleeResponse
					SetPedConfigFlag(Ped, 546, true) -- PCF_IgnoreOwnershipForHorseFeedAndBrush
				end
			else -- Human player
				SetPedConfigFlag(Ped, 26, true) -- PCF_DisableMelee
				SetPedConfigFlag(Ped, 169, true) -- PCF_DisableGrappleByPlayer
				SetPedConfigFlag(Ped, 192, true) -- NPCs cant attack ped
				SetPedConfigFlag(Ped, 218, true) -- PCF_DisablePickups
				SetPedConfigFlag(Ped, 249, true) -- PCF_BlockWeaponSwitching
				SetPedConfigFlag(Ped, 265, true) -- PCF_DrownsInWater
			end
		end
		
	end
end)