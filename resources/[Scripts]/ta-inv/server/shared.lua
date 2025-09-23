function IsAdmin(source, identifier)
    if identifier == nil then
        identifier = GetIdent(source)
    end
    return Config.Admins[identifier] --or your admin function
end

function banPlayer(source, identifier)
    -- your ban function here
end

function Notify(source, text)
    -- your notify function here
end
