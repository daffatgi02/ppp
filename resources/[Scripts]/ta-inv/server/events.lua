RegisterServerEvent("ta-inv:server:OpenInventory", function(inventoryType, identifierInput, items)
    local src = source
    local identifier = GetIdent(src)
    if not identifier then return end
    if identifierInput then
        if not IsAdmin(src, identifier) then
            banPlayer(src, identifier)
            return
        else
            identifier = identifierInput
            if not PlayerItems[identifier] then
                Notify(source, Locales["inventory_not_found"])
                return
            end
        end
    end
    TriggerClientEvent("ta-inv:OpenInventory", src, {
        inventoryInfo = Config.InventoryTypes[inventoryType]
    })
end)

RegisterServerEvent("ta-inv:ItemDrag", function(data)
    local itemName, itemCount, fromType, toType = data.itemName, data.count, data.fromType, data.toType
    local src = source
    local identifier = GetIdent(src)
    if not identifier then return end
    if Config.InventoryTypes[toType] then
        local bool, removed = RemoveItem(source, fromType, itemName, itemCount)
        if bool then
            AddItem(source, toType, itemName, itemCount, Items[itemName].useItemInfo and removed or nil, true, true)
        end
    end
end)

RegisterServerEvent("ta-inv:RemoveItem", function(data)
    local src = source
    local identifier = GetIdent(src)
    if not identifier then return end
    if Config.DeleteBlockedItems[data.itemName] then return end
    local bool, removed = RemoveItem(source, data.fromType, data.itemName, data.count)
end)

RegisterServerEvent("ta-inv:UpdateHotbar", function(data, force)
    local src = source
    local identifier = GetIdent(src)
    if not identifier then return end
    UpdateHotbar(src, identifier, data, force)
end)

RegisterServerEvent("ta-inv:OnItemUsed", function(itemName)
    local info
    local item = GetItemByName(source, "inventory", itemName)
    if item then
        if Items[itemName].useItemInfo then
            if Items[itemName].type == "weapon" then
                info = item.info[math.random(#item.info)]
            else
                info = item.info
            end
        end
        TriggerClientEvent("ta-inv:client:OnItemUsed", source, itemName, info)
    end
end)

local Load = {}

RegisterServerEvent("ta-inv:Load", function()
    local src = source
    if Load[src] then return end
    Load[src] = true
    local identifier = GetIdent(src)
    if not identifier then return end
    LoadPlayerItems(src, identifier)
    if LoadPlayerProfile then
        LoadPlayerProfile(src)
    end
end)

AddEventHandler("onResourceStart", function(name)
    if name == GetCurrentResourceName() then
        Wait(750)
        local players = GetPlayers()
        for i = 1, #players do
            local identifier = GetIdent(players[i])
            if identifier then
                LoadPlayerItems(players[i], identifier)
                if LoadPlayerProfile then
                    LoadPlayerProfile(players[i])
                end
            end
        end
    end
end)

RegisterServerEvent(Config.RemoveInventoriesWhenDead.deathEvent, function()
    if Config.RemoveInventoriesWhenDead.bool(source) then
        for i = 1, #Config.RemoveInventoriesWhenDead.types do
            ClearInventory(source, Config.RemoveInventoriesWhenDead.types[i])
            
        end
    end
end)