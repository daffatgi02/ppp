BQVersus = {} -- Do not touch this

BQVersus.SaveDataSecond = 60 --60 Second

BQVersus.LobbyLocation = vector4(288.7541, -1585.3895, 30.5319, 20.3181)

BQVersus.ReviveTrigger = "esx_ambulancejob:revive" -- **Client Trigger Event** You need change this. You can view no_escrow.lua (if you use qbcore "hospital:client:Revive", if you use esx "esx_ambulancejob:revive")

BQVersus.maxRounds = 5 -- The match will end when a team wins maxRounds matches.
BQVersus.Points = {
    killPoints = 10,
    deathPoints = 5, -- (-)
    winPoints = 50,
    lossPoints = 20 -- (-)
}

BQVersus.Maps = { -- Map name, Map name, Map name
    ["1VS1"] = {
        [1] = {
            [1] = vector3(-3865.7, 4575.95, 761.540), -- First spawn point
            [2] = vector3(-3891.2, 4570.24, 761.540), -- Second spawn point
        }
    },
    ["2VS2"] = {
        [1] = {
            [1] = vector3(461.1412, -3720.38, 9.134), -- First spawn point
            [2] = vector3(435.2836, -3719.78, 17.134), -- Second spawn point
        }
    },
    ["3VS3"] = {
        [1] = {
            [1] = vector3(461.1412, -3720.38, 9.134), -- First spawn point
            [2] = vector3(435.2836, -3719.78, 17.134), -- Second spawn point
        }
    },
    ["4VS4"] = {
        [1] = {
            [1] = vector3(37.39871, -159.061, 366.92), -- First spawn point
            [2] = vector3(11.59380, -238.114, 373.32), -- Second spawn point
        }
    },
    ["5VS5"] = {
        [1] = {
            [1] = vector3(37.39871, -159.061, 366.92), -- First spawn point
            [2] = vector3(11.59380, -238.114, 373.32), -- Second spawn point
        }
    },
    ["15VS15"] = {
        [1] = {
            [1] = vector3(2481.95, 2953.75, 40.9839), -- First spawn point
            [2] = vector3(2790.16, 4355.53, 49.7290), -- Second spawn point
        }
    },
}


BQVersus.NoLeaugeName = "Unranked"
BQVersus.Ranks = {
    {name = "Bronze V", pts = 1000},
    {name = "Bronze IV", pts = 1100},
    {name = "Bronze III", pts = 1200},
    {name = "Bronze II", pts = 1300},
    {name = "Bronze I", pts = 1400},
    {name = "Silver V", pts = 1500},
    {name = "Silver IV", pts = 1600},
    {name = "Silver III", pts = 1700},
    {name = "Silver II", pts = 1800},
    {name = "Silver I", pts = 1900},
    {name = "Gold V", pts = 2000},
    {name = "Gold IV", pts = 2100},
    {name = "Gold III", pts = 2200},
    {name = "Gold II", pts = 2300},
    {name = "Gold I", pts = 2400},
    {name = "Platinum V", pts = 2600},
    {name = "Platinum IV", pts = 2800},
    {name = "Platinum III", pts = 3000},
    {name = "Platinum II", pts = 3200},
    {name = "Platinum I", pts = 3400},
    {name = "Diamond V", pts = 3600},
    {name = "Diamond IV", pts = 3800},
    {name = "Diamond III", pts = 4000},
    {name = "Diamond II", pts = 4200},
    {name = "Diamond I", pts = 4400},
    {name = "Master", pts = 4800},
    {name = "Grandmaster", pts = 5200},
    {name = "Conqueror", pts = 5600}
}


BQVersus.Notify = {
    playerinbug = "Player in bug.",
    sentinvite = "Team invite sent to %s [ID: %d].",
    hasteam = " already has a team!",
    joinplayer = "A player has joined your team!",
    leftplayer = "Your teammate has left the game!",
    youkickedfromteam = "You have been kicked from the team!",
    OnlyCanOwners = "Only team owners can do this",
    queuefailedplayerleft = "Queue cancelled due to a player leaving the team!",
    playerleftyourteam = "%s [ID: %d] has left your team.", --%s player name, %d player server id
    teamdeletedbyowner = "Team owner has deleted the team.",
    youdefeatforleftplayer = "You lost because %s left your team.",
    youwonforleftplayer = "You won because %s left the opposing team.",
    alreadyingame = "You are already in the game!",
    notmatchthenumber = "Your team does not have enough players!",
    youinvited = "You have been invited by %s. Do you want to join?",
    losemessage = "You lost! Try again later.",
    matchmakingqueuestoppedbyname = "Maç %s tarafından bozuldu",
    winmessage = "You won! Congratulations."
}