rcore = exports.rcore
rcore:getEsxServerInstance(function(obj)
    ESX = obj
end)

AddEventHandler('onResourceStart',function()
    local numResources = GetNumResources()
    local foundErrors = 0
    for i=1,numResources,1 do
        local res = GetResourceByFindIndex(i)
        if res then
            dprint('^2[rcore_secure] ^7Scanning resource %s',res)
            local numMetadata = GetNumResourceMetadata(res,'client_script')
            if tonumber(numMetadata) > 0 then
                dprint('^2[rcore_secure] ^7Client script found num %s',tonumber(numMetadata))
                for k=1, tonumber(numMetadata), 1 do
                    local script = GetResourceMetadata(res,'client_script',k)
                    if script then
                        local load = LoadResourceFile(res,script)
                        if load then
                            local found = string.find(load,Config.FindString)
                            if found ~= nil then
                                dprint('^1[rcore_secure] ^7 DANGER! Find discord webhook at %s:%s',res,script)
                                foundErrors = foundErrors + 1
                            else
                                if Config.ShowResourceClear then
                                    print('^3[rcore_secure] ^7Resources %s:%s is clear! ',res,script)
                                end
                            end
                        else
                            if Config.ShowCantLoad then
                                print('^1[rcore_secure] ^7 Cannot load %s:%s',res,script)
                            end
                        end

                    end
                end
            else
                dprint('^1[rcore_secure] ^7 Cannot find any client side scripts')
            end
        end
    end

    if foundErrors > 0 then
        dprint('^1[rcore_secure] ^7 Found errors! Please fix them.')
    else
        dprint('^2[rcore_secure] ^7Resources are clear! Good job!')
    end
end)
