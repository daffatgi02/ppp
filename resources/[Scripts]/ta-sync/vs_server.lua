AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}
CurrentWeather = "EXTRASUNNY"
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local blackout = false
local newWeatherTimer = 10

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

RegisterServerEvent('ssa-vsync:requestSync')
AddEventHandler('ssa-vsync:requestSync', function()
    TriggerClientEvent('ssa-vsync:updateWeather', -1, CurrentWeather, blackout)
    ShiftToMinute(0)
    ShiftToHour(9)
    TriggerClientEvent('ssa-vsync:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        ShiftToMinute(0)
        ShiftToHour(9)
        TriggerClientEvent('ssa-vsync:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        TriggerClientEvent('ssa-vsync:updateWeather', -1, CurrentWeather, blackout)
    end
end)
