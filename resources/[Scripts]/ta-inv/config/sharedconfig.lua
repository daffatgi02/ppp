Config.RemoveInventoriesWhenDead = {
    bool = function(source)
       return true -- you can put your inSafe export to make it dynamic
    end,
    deathEvent = "esx:onPlayerDeath",
    reviveEvent = "esx:onPlayerSpawn", --seconds
    types = {
        "inventory",
    }
}