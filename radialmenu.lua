-- Menu state
local showMenu = false

-- Keybind Lookup table
local keybindControls = {
	["Rigbrac"] = 0x4AF4D473
}

-- Main thread
Citizen.CreateThread(function()
    -- Update every frame
    while true do
        Citizen.Wait(0)

        -- Loop through all menus in config
        for _, menuConfig in pairs(menuConfigs) do
            -- Check if menu should be enabled
            if menuConfig:enableMenu() then
                -- When keybind is pressed toggle UI
                local keybindControl = keybindControls[menuConfig.data.keybind]
                if IsControlJustReleased(0, keybindControl) then
                    -- Init UI
                    showMenu = true
                    SendNUIMessage({
                        type = 'init',
                        data = menuConfig.data,
                        resourceName = GetCurrentResourceName()
                    })

                    -- set focus
                    SetNuiFocus(true, true)

                    -- Play sound
                    PlaySoundFrontend(-1, "NAV", "HUD_SHOP_SOUNDSET", 1)

                    -- Prevent menu from showing again until key is released
                    while showMenu == true do Citizen.Wait(100) end
                    Citizen.Wait(100)
                    while IsControlJustReleased(0, keybindControl) do Citizen.Wait(100) end
                end
            end
        end
    end
end)

-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_SHOP_SOUNDSET", 1)

    -- Send ACK to callback function
    cb('ok')
end)

-- Callback function for when a slice is clicked, execute command
RegisterNUICallback('sliceclicked', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_SHOP_SOUNDSET", 1)

    -- Run command
    ExecuteCommand(data.command)

    -- Send ACK to callback function
    cb('ok')
end)

-- Callback function for testing
RegisterNUICallback('testprint', function(data, cb)
    -- Print message
    TriggerEvent('chatMessage', "[test]", {255,0,0}, data.message)

    -- Send ACK to callback function
    cb('ok')
end)

--commands
RegisterCommand('ecancel', function(source, args, rawCommand)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedTasks(PlayerPedId())
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
    DeleteObject(prop)
end, false)
RegisterCommand('esleep', function(source, args, rawCommand)
	RequestAnimDict('amb_rest@world_human_passed_out_floor@male_a@idle_a')
    while not HasAnimDictLoaded('amb_rest@world_human_passed_out_floor@male_a@idle_a') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_passed_out_floor@male_a@idle_a', 'idle_b', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('elean', function(source, args, rawCommand)
	RequestAnimDict('amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c')
    while not HasAnimDictLoaded('amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c', 'idle_g', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('esit', function(source, args, rawCommand)
	RequestAnimDict('amb_rest_sit@world_human_depressed_sit_ground@male_a@idle_b')
    while not HasAnimDictLoaded('amb_rest_sit@world_human_depressed_sit_ground@male_a@idle_b') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_rest_sit@world_human_depressed_sit_ground@male_a@idle_b', 'idle_d', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('ewash', function(source, args, rawCommand)
	RequestAnimDict('amb_misc@world_human_wash_kneel_river@female_a@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_wash_kneel_river@female_a@idle_b') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_wash_kneel_river@female_a@idle_b', 'idle_d', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
	Wait(1000)
	ClearPedEnvDirt(PlayerPedId())
end, false)
RegisterCommand('edance', function(source, args, rawCommand)
	RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_b@idle_a') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_a', 'idle_b', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('enotes', function(source, args, rawCommand)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("world_human_write_notebook"), 100000,true,false, false, false)
end, false)
RegisterCommand('epiano', function(source, args, rawCommand)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("PROP_HUMAN_PIANO"), 100000,true,false, false, false)
end, false)
RegisterCommand('ework', function(source, args, rawCommand)
	RequestAnimDict('amb_work@world_human_repair@high@oilcan@male_b@idle_a')
    while not HasAnimDictLoaded('amb_work@world_human_repair@high@oilcan@male_b@idle_a') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_work@world_human_repair@high@oilcan@male_b@idle_a', 'idle_a', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('emourn', function(source, args, rawCommand)
	RequestAnimDict('amb_misc@world_human_grave_mourning@kneel@female_a@stand_exit')
    while not HasAnimDictLoaded('amb_misc@world_human_grave_mourning@kneel@female_a@stand_exit') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_grave_mourning@kneel@female_a@stand_exit', 'exit_front', 8.0, -8.0, 4200, 1, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('echew', function(source, args, rawCommand)
	RequestAnimDict('amb_misc@world_human_chew_tobacco@male_b@idle_c')
    while not HasAnimDictLoaded('amb_misc@world_human_chew_tobacco@male_b@idle_c') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_chew_tobacco@male_b@idle_c', 'idle_g', 8.0, -8.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('ebeg', function(source, args, rawCommand)
	RequestAnimDict('amb_misc@world_human_begging_mother@female_a@react_begging')
    while not HasAnimDictLoaded('amb_misc@world_human_begging_mother@female_a@react_begging') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_begging_mother@female_a@react_begging', 'react_begging_frontleft', 8.0, -8.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('epee', function(source, args, rawCommand)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("world_human_pee"), 100000,true,false, false, false)
end, false)
RegisterCommand('ecough', function(source, args, rawCommand)
	RequestAnimDict('amb_misc@world_human_coughing@male_d@wip_base')
    while not HasAnimDictLoaded('amb_misc@world_human_coughing@male_d@wip_base') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_coughing@male_d@wip_base', 'wip_base', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('epuke', function(source, args, rawCommand)
	RequestAnimDict('amb_misc@world_human_vomit_kneel@male_a@idle_c')
    while not HasAnimDictLoaded('amb_misc@world_human_vomit_kneel@male_a@idle_c') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_vomit_kneel@male_a@idle_c', 'idle_g', 8.0, -8.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)
RegisterCommand('edrink', function(source, args, rawCommand)
	RequestAnimDict('amb_rest_drunk@world_human_drinking@male_a@idle_a')
    while not HasAnimDictLoaded('amb_rest_drunk@world_human_drinking@male_a@idle_a') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_rest_drunk@world_human_drinking@male_a@idle_a', 'idle_a', 8.0, -8.0, 9999999999, 31, 0, true, 0, false, 0, false)
    local playerPed = PlayerPedId()
    prop_name = 'p_bottlebeer01x'
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    prop = CreateObject(GetHashKey(prop_name), x, y, z, true, true, true)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_Finger12")
    AttachEntityToEntity(prop, playerPed,boneIndex, 0.08, -0.03, 0.145, 0.0, -160.0, -70.0, true, true, false, true, 1, true)
end, false)
RegisterCommand('esmoke', function(source, args, rawCommand)
	Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_CAMP_DUTCH_SMOKE_CIGAR"), 100000,true,false, false, false)
end, false)