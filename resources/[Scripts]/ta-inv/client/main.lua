AddEventHandler('playerSpawned', function()
    Wait(1000)
    TriggerServerEvent("ta-inv:Load")
end)

RegisterKeyMapping(Config.OpenCommand, 'Open/Hide Inventory', 'keyboard', 'TAB')
RegisterCommand(Config.OpenCommand, function()
    CommandFunction()
end)

CreateThread(function()
    for i = 1, 7 do
        RegisterKeyMapping("useslot"..i, 'Use Slot #'..i, 'keyboard', i)
        RegisterCommand("useslot"..i, function()
            UseSlot(i)
        end)
    end
end)
