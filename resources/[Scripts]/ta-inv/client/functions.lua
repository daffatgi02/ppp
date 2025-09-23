local sendItemsToJS = false
function Display(data)
    if not sendItemsToJS then
        sendItemsToJS = true
        SendNUIMessage({
            type = "setItems",
            items = Items
        })
    end
    if data.bool and disableInventory then return end
    isOpened = data.bool
    ArrangeControls(data.bool)
    local inventory, otherInventory
    if data.bool then
        openedInventoryType = data.inventoryInfo.name
        inventory = FormatItems(PlayerItems["inventory"])
        otherInventory = FormatItems(PlayerItems[data.inventoryInfo.name])
        if data.inventoryInfo then
            data.inventoryInfo.points = ESX.GetPlayerData().point
        end    
    end
    if deluxoArena then
        inventory = FormatItems(deluxoItems)
    end
    SendNUIMessage({
        type = "display",
        bool = data.bool,
        inventory = inventory,
        otherInventory = otherInventory,
        inventoryInfo = data.inventoryInfo,
        level = Config.PlayerLevel(),
        exp = ESX.GetPlayerData().xp,
    })
end

function UpdateInventory(inventoryType)
    local inventory = FormatItems(PlayerItems["inventory"])
    
    SendNUIMessage({
        type = "update",
        inventory = inventory,
        -- otherInventory = otherInventory,
        inventoryInfo = inventoryInfo
    })
end

function SetHotbar()
    SendNUIMessage({
        type = "hotbar",
        hotbar = HotbarData
    })
end

function FormatItems(inventory, key)
    local returnTable = {}
    if inventory ~= nil then
        for i = 1, #inventory do
            if inventory[i] ~= nil then
                if Items[inventory[i].name] then
                    inventory[i].image = Items[inventory[i].name].image
                    inventory[i].label = Items[inventory[i].name].label
                    inventory[i].rarity = Items[inventory[i].name].rarity
                    inventory[i].type = Items[inventory[i].name].type
                end
            end
        end
    end
    return inventory
end

function DisableInventory(bool)
    disableInventory = bool
end

function CommandFunction()
    if not isOpened then
        OpenInventory("inventory")
    else
        Display({
            bool = false
        })
        DisplayRadar(true)
        TriggerEvent("ta-hud:main-hud", true)
        TriggerEvent('ta-basics:general-hud', "fake-show")
        TriggerEvent('ta-crosshairs:action', "fake-show")
    end
end


function HasItem(inventoryType, itemName, count)
    count = count == nil and 1 or count
    if PlayerItems[inventoryType] then
        for i = 1, #PlayerItems[inventoryType] do
            local element = PlayerItems[inventoryType][i]
            if element.name == itemName then
                if count <= element.count then
                    return true
                end
            end
        end
    end
    return false
end

function OpenInventory(inventoryType)
    TriggerServerEvent("ta-inv:server:OpenInventory", inventoryType)
end

function UseSlot(id)
    local v = HotbarData[id]
    if not isOpened and v and HasItem("inventory", v.name) then
        TriggerServerEvent("ta-inv:OnItemUsed", v.name)
    end
end