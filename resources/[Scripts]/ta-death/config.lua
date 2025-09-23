Config = {}


-- ## General Settings ##

Config.Framework = "esx"  -- | # | You can specify this part as "esx" or "oldesx" or "qb" or "oldqb"
Config.ScreenTime = 2500  -- | # | Determine how long the dead person stays on the death screen.


-- ## Trigger Settings ##

RegisterNetEvent('ta-death:beforedeathscreen')
AddEventHandler('ta-death:beforedeathscreen', function()
    -- | # | In this trigger, type what you want the person to do after they die but before the death screen.
end)

RegisterNetEvent('ta-death:afterdeathscreen')
AddEventHandler('ta-death:afterdeathscreen', function()
    TriggerEvent('ta-base:function:randomspawn')
end)