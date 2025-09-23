Config = {
    InventoryTypes = {
        ["inventory"] = {
            label = "Inventory"
        },
        ["stash"] = {
            label = "Stash"
        },
    },
    Admins = {
        ["license:290666ebe9547f4fbb2cc547b7aa566a8201856d"] = true,
    },
    DeleteBlockedItems = {
        ["deluxo"] = true,
    },
    NoImage = "https://cdn.discordapp.com/attachments/736562375062192199/995301291976831026/noimage.png",
    IdentifierType = "license" -- steam or license will be good
}

for k, v in pairs(Config.InventoryTypes) do
    Config.InventoryTypes[k].name = k
end