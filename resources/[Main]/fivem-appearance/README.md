# oxmysql-converted-fivem-appearance

This is something I converted, I take no credit for the UI all I've done is convert the script from mysql-aync to oxmysql the original post was from https://forum.cfx.re/t/release-fivem-appearance/2438537

## Dependencies

- ESX
- NeroHiro’s Context Menu https://forum.cfx.re/t/release-standalone-nerohiro-s-context-menu-dynamic-event-firing-menu/2564083
    Requires you to replace this callback with the one below in client.lua
```
    RegisterNUICallback("dataPost", function(data, cb)
        SetNuiFocus(false)
        TriggerEvent(data.event, data.arg1, data.arg2, data.arg3)
        cb('ok')
    end)
 ```
- NeroHiro’s Keyboard (Can be easily replaced) https://forum.cfx.re/t/release-standalone-nerohiro-s-keyboard-dynamic-nui-keyboard-input/2506326
- CD Draw text UI (Can be easily replaced) https://forum.cfx.re/t/free-release-draw-text-ui/1885313

## Conflicts

This rescorce is meant to replace these two so it cannot be used while these rescorces are running 
- esx_skin
- skinchanger

## Setup

- Run Outfits.sql

If you're using esx_multicharacter or most rescorces using esx_skin or skinchanger this should work out of the box thansk to edits made by Linden however if it does not you can use the trigger below on the client side after the player loads in order to set their skin 

```cfg
ESX.TriggerServerCallback('fivem-appearance:getPlayerSkin', function(appearance)
    exports['fivem-appearance']:setPlayerAppearance(appearance)
end)
```

## Server Config

```cfg
ensure fivem-appearance
setr fivem-appearance:locale "en"
```

## Preview

![](https://i.imgur.com/Cs1fvNC.jpeg"")
![](https://i.imgur.com/sA55YgF.jpeg"")
![](https://i.imgur.com/dR3U3Uu.jpeg"")
![](https://i.imgur.com/hyhXldt.jpeg"")
![](https://i.imgur.com/ACKPHv3.jpeg"")

## Converted to oxmysql by Gucci
