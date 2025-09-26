Config = {}

-- Leaderboard settings
Config.RefreshInterval = 1000 -- Update every 1 second
Config.TopPlayersLimit = 10 -- Show top 10 players (F6 menu)
Config.Top3PlayersLimit = 3 -- Show top 3 players (always visible)
Config.EnableRealTimeUpdates = true
Config.EnableDebug = false -- Debug prints

-- Only show leaderboard in Farm and Fight mode
Config.AllowedGamemodes = {
    "farm_and_fight"
}

-- Keybind to toggle leaderboard
-- Config.ToggleKey = "F6"