local open = false

RegisterNUICallback("exit" , function()
    TriggerEvent("ta-base:stopEditing")
    SetNuiFocus(false, false)
    open = false
end)

RegisterNUICallback("loadData" , function()
    for k,v in pairs(Roda.Crosshairs) do 
        SendNUIMessage({
            action = 'Load',
            imagenes = v.img,
            valor = v.name, 
            label = v.label
        })
    end
end)

RegisterNUICallback("startEditing" , function()
    if not open then 
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openMenu'
        })
        open = true
    end
end)

RegisterNetEvent("ta-crosshairs:showCrosshair", function(show)
    if show then SendNUIMessage({action = 'show'}) else SendNUIMessage({action = 'hide'}) end
end)

RegisterNetEvent("ta-crosshairs:action")
AddEventHandler("ta-crosshairs:action", function(action)
    if action == "fake-show" then
         SendNUIMessage({action = 'fake-show'})
    elseif action == "fake-hide" then
         SendNUIMessage({action = 'fake-hide'})
    end
end)