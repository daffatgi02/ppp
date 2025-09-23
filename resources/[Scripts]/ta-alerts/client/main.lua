RegisterNetEvent('ta-alerts:out-of-zone')
AddEventHandler('ta-alerts:out-of-zone', function(action)
    if action == "show" then
        SendNUIMessage({action = "out-of-zone"})
    elseif action == "hide" then
        SendNUIMessage({action = "out-of-zone-close"})
    end
end)

RegisterNetEvent('ta-alerts:roof-camp')
AddEventHandler('ta-alerts:roof-camp', function(action)
    if action == "show" then
        SendNUIMessage({action = "roof-camp"})
    elseif action == "hide" then
        SendNUIMessage({action = "roof-camp-close"})
    end
end)
