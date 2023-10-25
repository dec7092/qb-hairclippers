QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("clippers", function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player.Functions.GetItemByName("clippers") then return end
    TriggerClientEvent("cliipers:client:shavehead", src)
end)

QBCore.Commands.Add('clipclip', "Shavehead", {}, false, function(source)
    local src = source
    TriggerClientEvent("cliipers:client:shavehead", src)
end, 'admin')

RegisterNetEvent("cliipers:server:Shavenheads",function(playerId, coords)
    TriggerClientEvent('cliipers:client:shavedhead', playerId, coords)
end)