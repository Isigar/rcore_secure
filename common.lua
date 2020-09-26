function triggerName(event)
    return string.format('rcore_secure:%s',event)
end

function dprint(str,...)
    if Config.Debug then
        print(''..string.format(str,...))
    end
end
