Logger = {}

local function printer(level, from, msg)
    print("[OGK]["..level.."]["..from.."] "..msg)
end

function Logger.info(from, msg)
    printer("INFO", from, msg)
end

function Logger.err(from, msg)
    printer("ERROR", from, msg)
end

function OnScriptError(message)
    AddPlayerChat('<span color="#ff0000bb" style="bold" size="10">'..message..'</>')
end
AddEvent("OnScriptError", OnScriptError)