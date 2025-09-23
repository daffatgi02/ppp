exports("isOpened", function()
    return isOpened
end)

exports("isDisabled", function()
    return disableInventory
end)

exports("DisableInventory", function(bool)
    DisableInventory(bool)
end)

exports("OpenInventory", function(inventoryType)
    OpenInventory(inventoryType)
end)

exports("GetInventory", function(inventoryType)
    return PlayerItems["inventory"]
end)

exports("HasItem", function(inventoryType, itemName, count)
    return HasItem(inventoryType, itemName, count)
end)
