if Config.ScriptEnabled then

local AOP = Config.AOP.DefaultAOP
RegisterCommand(Config.AOP.Command, function(source, args, raw)
    if IsPlayerAceAllowed(source, "furiousfoxgg.aop") then 
    if args[1] then
        TriggerClientEvent("M:ClearAOPBans", -1)
        Announce("error", "AOP Has changed to \"" ..table.concat(args, " ").. "\" Please move there or you risk being teleported..")
        local FinalAOP = CapitalizeFirstLetterOfWord(table.concat(args, " "))
        AOP = FinalAOP
    if string.find(string.lower(table.concat(args, " ")), "sandy banned") then
        TriggerClientEvent("M:CreatePolyAOP", -1, "Sandy")
    end
    if string.find(string.lower(table.concat(args, " ")), "paleto banned") then
        TriggerClientEvent("M:CreatePolyAOP", -1, "Paleto")
    end
    if string.find(string.lower(table.concat(args, " ")), "legion banned") then 
        TriggerClientEvent("M:CreatePolyAOP", -1, "Legion")
    end
    if string.find(string.lower(table.concat(args, " ")), "blaine county") then
        TriggerClientEvent("M:CreatePolyAOP", -1, "BC")
    end
    if string.find(string.lower(table.concat(args, " ")), "los santos") then
        TriggerClientEvent("M:CreatePolyAOP", -1, "LS")
            end
        TriggerClientEvent("M:UpdateAOP", -1, FinalAOP)
        else
        TriggerClientEvent('t-notify:client:Custom', source, {style  =  "error", duration  =  10000, title  =  'ERROR, Incorrect Usage', message  =  "USAGE: ``/AOP [AOP]``", sound  =  false})
        end
    else
       TriggerClientEvent('t-notify:client:Custom', source, {style  =  "error", duration  =  10000, title  =  'ERROR', message  =  "You do not have permission to use this command. Staff May have be contacted.", sound  =  false})
    end
end)

function Announce(style, msg)
    TriggerClientEvent('t-notify:client:Custom', -1, {
        style  =  style,
        duration  =  10000,
        title  =  'AOP Announcement',
        message  =  msg,
        sound  =  false
    })
end

--Do not remove this beautiful peace of art work
function CapitalizeFirstLetterOfWord(string)
    TriggerClientEvent("M:DebugLog", -1, "Capitalizing First Letter of Word Cause FuriousFoxGG.#0001 is a W")
    return string:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest:lower()
    end)
    
end


--Keep this here or I will cry :(
RegisterNetEvent("M:ServerUpdateAOP")
AddEventHandler("M:ServerUpdateAOP", function()
   TriggerClientEvent("M:UpdateAOP", source, AOP)
   if string.find(AOP, "Sandy Banned") then
    TriggerClientEvent("M:CreatePolyAOP", source, "Sandy")
   end
   if string.find(AOP, "Paleto Banned") then
    TriggerClientEvent("M:CreatePolyAOP", source, "Paleto")
   end
   if string.find(AOP, "Paleto Banned") then
    TriggerClientEvent("M:CreatePolyAOP", source, "Legion")
   end
   if string.find(AOP, "Blaine County") then
    TriggerClientEvent("M:CreatePolyAOP", -1, "BC")
   end
   if string.find(AOP, "Los Santos") then
    TriggerClientEvent("M:CreatePolyAOP", -1, "LS")
   end
end)

end