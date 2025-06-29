RegisterNetEvent('removeMoneyAndHeal')
AddEventHandler('removeMoneyAndHeal', function(pourcentage, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = xPlayer.getAccount('black_money').money

    print("Cash dispo : $" ..blackMoney )

    if blackMoney < price then
        TriggerClientEvent('esx:showNotification', source, "Pas assez d'argent.")
        return
    end

    xPlayer.removeAccountMoney('black_money', price)
    print("Cash restant : $" ..blackMoney )
    TriggerClientEvent('applyHeal', source, pourcentage)
end)
