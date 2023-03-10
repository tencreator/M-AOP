--Made By FuriousFoxGG.#0001, DM For Support or for more support join: https://discord.gg/cPSAuJppyr

if Config.ScriptEnabled then

AOP = Config.Misc.DefaultAOP
if Config.PTEnabled then 
Peacetime = false 
end

RegisterCommand(Config.Misc.AOPCommand, function(source, args, raw)
    if IsPlayerAceAllowed(source, "furiousfoxgg.aop") then 
    if args[1] then
        TriggerClientEvent("M:ClearAOPBans", -1)
        Announce("error", "AOP Announcement", "AOP Has changed to \"" ..table.concat(args, " ").. "\" Please move there or you risk being teleported..")
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

if Config.PTEnabled then 
RegisterCommand(Config.Misc.PTCommand, function(source, args, raw)
    if IsPlayerAceAllowed(source, 'furiousfoxgg.aop') then
        Peacetime = not Peacetime
        TriggerClientEvent("M:SetPeacetime", -1, Peacetime)
        if Peacetime then 
        Announce("error", "Peacetime Announcement", "Peacetime is now Enabled. You may be kicked if you shoot.")
        else
        Announce("error", "Peacetime Announcement", "Peacetime is now Disabled. You may shoot with roleplay.")
            end
        end
    end)
end

function Announce(style, title, msg)
    TriggerClientEvent('t-notify:client:Custom', -1, {
        style  =  style,
        duration  =  10000,
        title  =  title,
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

RegisterNetEvent("M:ServerSetPeacetime")
AddEventHandler("M:ServerSetPeacetime", function()
    TriggerClientEvent("M:SetPeacetime", source, Peacetime)
end)

end
