Config = {
    OpenCommand = "inventory",
    InteractKey = 46, -- E
    Stashes = {
        -- coords = {
        --     vector3(-532.09, -231.19, 36.7)
        -- },
        -- textData = {
        --     closeText = "E - Open Stash",
        --     farText = "Open Stash",
        --     closeDist = 5.0,
        --     farDist = 10.0
        -- }
    },
    PlayerLevel = function()
        return ESX.GetPlayerData().level
    end
}