QBCore = exports['qb-core']:GetCoreObject()

-- v_serv_bs_clippers   prop_clippers_01
RegisterNetEvent('cliipers:client:shavehead', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    local ped = PlayerPedId()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)
        if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) then      
            local behindPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, 0.0)
            TaskGoToCoordAnyMeans(ped, behindPos, 1000, 0, 0, 786603, 0)
            local pos2 = GetEntityCoords(ped)
            local propModel = CreateObject(`v_serv_bs_clippers`, pos2.x, pos2.y, pos2.z, true, true, true)
            AttachEntityToEntity(propModel, ped, GetPedBoneIndex(ped, 57005), 0.14, 0, -0.03, 90.0, -90.0, 250.0, true, true, false, true, 1, true)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "clippers", 0.3)
            Wait(2000)
            QBCore.Functions.Progressbar("shaving_player", "Shaving Head..", 8000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, { -- misshair_shop@hair_dressers keeper_hair_cut_b
                animDict = "misshair_shop@hair_dressers",
                anim = "keeper_hair_cut_b",
                flags = 16,
            }, {}, {}, function() -- Done
                local plyCoords = GetEntityCoords(playerPed)
                local pos = GetEntityCoords(ped)
                DeleteObject(propModel)
                if #(pos - plyCoords) < 2.5 then
                    StopAnimTask(ped, "misshair_shop@hair_dressers", "keeper_hair_cut_b", 1.0)
                    TriggerServerEvent("cliipers:server:Shavenheads", playerId, pos)
                else
                    QBCore.Functions.Notify("noone nearby", "error")
                    StopAnimTask(ped, "misshair_shop@hair_dressers", "keeper_hair_cut_b", 1.0)
                end
            end, function() -- Cancel
                StopAnimTask(ped, "misshair_shop@hair_dressers", "keeper_hair_cut_b", 1.0)
                QBCore.Functions.Notify("Cancelled", "error")
                DeleteObject(propModel)
            end)
        end
    else
        QBCore.Functions.Notify("Noone nearby", "error")
    end
end)


RegisterNetEvent('cliipers:client:shavedhead', function(coords)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    print(coords)
    if #(pos - coords) < 2.5 then 
        if IsEntityPlayingAnim(ped, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) then
            SetPedComponentVariation(ped, 2, 0, 0, 0)
        end
    end
end)
