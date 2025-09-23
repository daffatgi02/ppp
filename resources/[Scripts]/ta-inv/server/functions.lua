function LoadPlayerItems(source, identifier)
    PlayerItems[identifier] = {}
    PlayerItems[identifier]["idenitfier"] = identifier
    PlayerItems[identifier]["inventory"] = {}
    PlayerItems[identifier]["hotbar"] = {}
    Hotbars[identifier] = {}
    for k, v in pairs(Hotbars[identifier]) do
        v.hasItem = GetItemByName(source, "inventory", v.name) ~= false
    end
        TriggerClientEvent("ta-inv:UpdateInventory", source, PlayerItems[identifier])
        TriggerClientEvent("ta-inv:SetHotbar", source, Hotbars[identifier])
end

function HasItem(source, inventoryType, itemName, itemCount)
    local identifier = GetIdent(source)
    if not identifier then return end
    if PlayerItems[identifier] and PlayerItems[identifier][inventoryType] then
        local item, index = GetItemByName(source, inventoryType, itemName)
        if itemCount then
            return item.count >= itemCount
        else
            return item
        end
    end
end

function AddItem(source, inventoryType, itemName, itemCount, info, forceAdd, drag)
    local infoTypes = {
        ["weapon"] = {ammo=0}
    }
    local identifier = GetIdent(source)
    if not identifier then return false end
    if not Items[itemName] then return false end
    local itemData, index = GetItemByName(source, inventoryType, itemName)
    if itemData then
        PlayerItems[identifier][inventoryType][index].count = PlayerItems[identifier][inventoryType][index].count + itemCount
        if Items[itemName].useItemInfo then
            for i = 1, itemCount do
                table.insert(PlayerItems[identifier][inventoryType][index].info, info ~= nil and info[i] or infoTypes[Items[itemName].type])
            end
            TriggerClientEvent("ta-inv:UpdateInventory", source, PlayerItems[identifier][inventoryType][index].info, inventoryType, index, "info")
        end
        TriggerClientEvent("ta-inv:UpdateInventory", source, PlayerItems[identifier][inventoryType][index].count, inventoryType, index, "count", not drag)
    else
        local infoData = {}
        if Items[itemName].useItemInfo then
            if info then
                infoData = info
            else
                for i = 1, itemCount do
                    table.insert(infoData, infoTypes[Items[itemName].type])
                end
            end
        else
            infoData = nil
        end
        table.insert(PlayerItems[identifier][inventoryType], {
            name = itemName,
            count = itemCount,
            info = infoData
        })
        if inventoryType == "inventory" then
            UpdateHotbar(source, identifier, {itemName = itemName, type = "hasItem", value = true}, false)
        end
        TriggerClientEvent("ta-inv:UpdateInventory", source, PlayerItems[identifier][inventoryType][#PlayerItems[identifier][inventoryType]], inventoryType, #PlayerItems[identifier][inventoryType], false, not drag)
    end
    return true
end

function RemoveItem(source, inventoryType, itemName, itemCount)
    local identifier = GetIdent(source)
    if not identifier then return false end
    local removedInfo = {}
    local itemData, index = GetItemByName(source, inventoryType, itemName)
    if itemData then
        if Items[itemName].useItemInfo then
            for i = PlayerItems[identifier][inventoryType][index].count, (PlayerItems[identifier][inventoryType][index].count - itemCount + 1), -1 do
                table.insert(removedInfo, PlayerItems[identifier][inventoryType][index].info[i])
                table.remove(PlayerItems[identifier][inventoryType][index].info, i)
            end
            TriggerClientEvent("ta-inv:UpdateInventory", source, PlayerItems[identifier][inventoryType][index].info, inventoryType, index, "info")
        end
        if itemCount > PlayerItems[identifier][inventoryType][index].count then
            itemCount = PlayerItems[identifier][inventoryType][index].count
        end
        PlayerItems[identifier][inventoryType][index].count = PlayerItems[identifier][inventoryType][index].count - itemCount
        if PlayerItems[identifier][inventoryType][index].count == 0 then
            table.remove(PlayerItems[identifier][inventoryType], index)
            if inventoryType == "inventory" then
                UpdateHotbar(source, identifier, {itemName = itemName, type = "hasItem", value = false}, false)
                if Items[itemName].type == "weapon" then
                    TriggerClientEvent("ta-inv:client:RemoveWeapon", source, itemName)
                end
            end
            TriggerClientEvent("ta-inv:UpdateInventory", source, nil, inventoryType, index)
        else
            TriggerClientEvent("ta-inv:UpdateInventory", source, PlayerItems[identifier][inventoryType][index].count, inventoryType, index, "count")
        end
        return true, removedInfo
    end
    return false
end

function GetItemByName(source, inventoryType, itemName)
    local identifier = GetIdent(source)
    if not identifier then return false end
    if PlayerItems[identifier] and PlayerItems[identifier][inventoryType] then
        for i = 1, #PlayerItems[identifier][inventoryType] do
            if PlayerItems[identifier][inventoryType][i].name == itemName then
                return PlayerItems[identifier][inventoryType][i], i
            end
        end
    end
    return false
end

function UpdateHotbar(source, identifier, data, hasItem)
    if data.id == nil and data.itemName then
        for k,v in pairs(Hotbars[identifier]) do
            if v.name == data.itemName then
                if data.type == "remove" then
                    table.remove(Hotbars[identifier], k)
                elseif data.type == "hasItem" then
                    Hotbars[identifier][k]["hasItem"] = data.value
                else
                    Hotbars[identifier][k] = data.value
                end
                TriggerClientEvent("ta-inv:SetHotbar", source, Hotbars[identifier][k], k)
            end
        end
    else
        Hotbars[identifier][data.id] = data.itemName == false and nil or {
            name = data.itemName,
            hasItem = hasItem or GetItemByName(source, "inventory", data.itemName) ~= false
        }    
        TriggerClientEvent("ta-inv:SetHotbar", source, Hotbars[identifier][data.id], data.id)
    end
end

RegisterServerEvent("ta-inv:ResetHotbar", function()
    ResetHotbar(source)
end)

function ResetHotbar(source)
    local identifier = GetIdent(source)
    Hotbars[identifier] = {}
    TriggerClientEvent("ta-inv:SetHotbar", source, Hotbars[identifier])
end

function GetInventory(source, inventoryType)
    inventoryType = inventoryType == nil and "inventory" or inventoryType
    local identifier = GetIdent(source)
    if not identifier then return end
    return PlayerItems[identifier] and PlayerItems[identifier][inventoryType]
end

function ClearInventory(source, inventoryType)
    inventoryType = inventoryType == nil and "inventory" or inventoryType
    local identifier = GetIdent(source)
    if not identifier then return end
    PlayerItems[identifier][inventoryType] = {}
    for k, v in pairs(Hotbars[identifier]) do
        v.hasItem = false
    end
    TriggerClientEvent("ta-inv:client:RemoveWeapon", source)
    TriggerClientEvent("ta-inv:UpdateInventory", source, PlayerItems[identifier][inventoryType], inventoryType)
    TriggerClientEvent("ta-inv:SetHotbar", source, Hotbars[identifier])
end

function CreateId()
    local id = math.random(999999)
    if CommonInventories[id] then
        Citizen.Wait(1)
        CreateId()
    else
        return id
    end
end

local UsableItems = {}
RegisterItem = function(itemName, cb)
    UsableItems[itemName] = cb
end

function GetIdent(source, idType)
    idType = idType ~= nil and idType or Config.IdentifierType
    local identifiers = GetPlayerIdentifiers(source)
    for i = 1, #identifiers do
        if identifiers[i]:match(idType) then
            return identifiers[i]
        end
    end
end

function LoadPlayerProfile(source)
    local data = {
        photo = GetSteamPP(source),
        name = GetPlayerName(source)
    }
    TriggerClientEvent("ta-inv:SetPlayerInfos", source, data)
end

function GetSteamPP(source, ident)
	local identifier = ident and ident or GetIdent(source, "steam")
    if identifier:match("steam") then
        local callback = promise:new()
        PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', identifier), 16) .. '/?xml=1', function(Error, Content, Head)
            local SteamProfileSplitted = stringsplit(Content, '\n')
            if SteamProfileSplitted ~= nil and next(SteamProfileSplitted) ~= nil then
                for i, Line in ipairs(SteamProfileSplitted) do
                    if Line:find('<avatarFull>') then
                        callback:resolve(Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', ''))
                        break
                    end
                end
            end
        end)
        local avatar = Citizen.Await(callback)
        return avatar
    end
    return Config.NoImage
end


function GetIDFromSource(Type, CurrentID)
	local ID = stringsplit(CurrentID, ':')
	if (ID[1]:lower() == string.lower(Type)) then
		return ID[2]:lower()
	end
	return nil
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end

	local t={} ; i=1
	if input ~= nil then
		for str in string.gmatch(input, '([^'..seperator..']+)') do
			t[i] = str
			i = i + 1
		end
		return t
	end
end
