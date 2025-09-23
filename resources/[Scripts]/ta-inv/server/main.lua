RegisterCommand("additem", function(source, args)
        local target, inventoryType, itemName, itemCount = tonumber(args[1]), args[2], args[3], tonumber(args[4])
        AddItem(target, inventoryType, itemName, itemCount)
end)

RegisterCommand("removeitem", function(source, args)
        local target, inventoryType, itemName, itemCount = tonumber(args[1]), args[2], args[3], tonumber(args[4])
        RemoveItem(target, inventoryType, itemName, itemCount)
end)

RegisterCommand("clearinventory", function(source, args)
        ClearInventory(tonumber(args[1]), args[2])
end)