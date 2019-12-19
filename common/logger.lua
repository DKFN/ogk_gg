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