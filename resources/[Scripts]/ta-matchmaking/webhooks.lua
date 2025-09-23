BQWebhooks = {}

BQWebhooks.sendMatchInfo = function(team1Members, team2Members)
    local mod = #team1Members.."VS"..#team1Members
    local webhookUrl = "https://discord.com/api/webhooks/1116692022586257488/_sEMulXRLfg0rtm4HOGeamxMCUa8_l6og7ZxQJOx77Jki6-0GCa6XcCFc_7rZCXA4-Lu" -- Enter your Discord webhook URL here
    local embed = {
        title = mod.." Teams Matched", description = "Here are the players of both teams:",
        fields = {
            {name = "Team 1 Players", value = "", inline = true},
            {name = "Team 2 Players", value = "", inline = true}
        },
        thumbnail = {
            url = "https://cdn.discordapp.com/attachments/1040606952352399429/1082432262534070412/Baslksz-2.png" -- Enter your logo URL here
        },
        image = {
            url = "https://cdn.discordapp.com/attachments/833516457790013511/1080970954475327568/bannerson.png" -- Enter the URL of your 1920x1080 wallpaper here
        },
        footer = {
            text = "Developed by BQ Workshop",
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") -- Current time in ISO 8601 format
    }

    for i, member in ipairs(team1Members) do
        embed.fields[1].value = embed.fields[1].value .. "**" .. member.name .. "**" .. " ["..member.rank.."]".. "\n"
    end

    for i, member in ipairs(team2Members) do
        embed.fields[2].value = embed.fields[2].value .. "**" .. member.name .. "**" .. " ["..member.rank.."]".. "\n"
    end

    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({embeds = {embed}}), {["Content-Type"] = 'application/json'})
end

BQWebhooks.sendIntoQueue = function(team1Members)
    local mod = #team1Members.."VS"..#team1Members
    local webhookUrl = "https://discord.com/api/webhooks/1116692022586257488/_sEMulXRLfg0rtm4HOGeamxMCUa8_l6og7ZxQJOx77Jki6-0GCa6XcCFc_7rZCXA4-Lu" -- Enter your Discord webhook URL here
    local embed = {
        title = mod.." Teams Entered Queue", description = "Players of the team that entered the queue:",
        fields = {
            {name = "Team Players", value = "", inline = true}
        },
        thumbnail = {
            url = "https://cdn.discordapp.com/attachments/1040606952352399429/1082432262534070412/Baslksz-2.png" -- Enter your logo URL here
        },
        image = {
            url = "https://cdn.discordapp.com/attachments/833516457790013511/1080970954475327568/bannerson.png" -- Enter the URL of your 1920x1080 wallpaper here
        },
        footer = {
            text = "Developed by BQ Workshop",
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") -- Current time in ISO 8601 format
    }

    for i, member in ipairs(team1Members) do
        embed.fields[1].value = embed.fields[1].value .. "**" .. member.name .. "**" .. " ["..member.rank.."]".. "\n"
    end

    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({embeds = {embed}}), {["Content-Type"] = 'application/json'})
end

BQWebhooks.sendMatchFinished = function(winnerTeamName, loserTeamName, team1Members, team2Members, score1, score2)
    local mod = #team1Members.."VS"..#team1Members
    local webhookUrl = "https://discord.com/api/webhooks/1116749206766506134/iPzAvExrSWZaTx4v_1FxGETsJUjSW6DwGAtnEbKWWA-IXRnhisyr9cCwkuEQBDuLYsZf" -- Enter your Discord webhook URL here
    local embed = {
        title = mod..", "..winnerTeamName.." won by the team of "..loserTeamName, description = "Scores:",
        fields = {
            {name = "Score:", value = score1.."/"..score2, inline = false},
            {name = "Team ["..winnerTeamName.."] Players", value = "", inline = true},
            {name = "Team ["..loserTeamName.."] Players", value = "", inline = true},
        },
        thumbnail = {
            url = "https://cdn.discordapp.com/attachments/1040606952352399429/1082432262534070412/Baslksz-2.png" -- Enter your logo URL here
        },
        image = {
            url = "https://cdn.discordapp.com/attachments/833516457790013511/1080970954475327568/bannerson.png" -- Enter the URL of your 1920x1080 wallpaper here
        },
        footer = {
            text = "Developed by BQ Workshop",
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") -- Current time in ISO 8601 format
    }

    for i, member in ipairs(team1Members) do
        embed.fields[2].value = embed.fields[2].value .. "**" .. member.name .. "**" .. " ["..member.rank.."]".. "\n"
    end

    for i, member in ipairs(team2Members) do
        embed.fields[3].value = embed.fields[3].value .. "**" .. member.name .. "**" .. " ["..member.rank.."]".. "\n"
    end

    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({embeds = {embed}}), {["Content-Type"] = 'application/json'})
end