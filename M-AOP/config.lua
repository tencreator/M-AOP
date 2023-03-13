Config = {}

Config.AOPAnnounce = "AOP Has changed to %s Please move there or you risk being teleported." --%s is the curren AOP For example if the MSG is AOP: %s it would say AOP: Sandy banned for example.

Config.ScriptEnabled = true --Don't change this please, if you don't want my script in your server delete it but if you want to be awkward and just disable it set this to false
Config.PTEnabled = true --Set to false if you don't want the peacetime script
Config.Debug = true --Set to false if you don't want things logged in console, informs of what is going on etc

Config.Hud = {
    x = .165,
    y = .95,
    scale = .45,
    TextColour = "~b~",
}

Config.TeleportCoords = { --The coords it will teleport the user to if they are not in AOP {for example if AOP is Los Santos DO NOT Teleport the user to coords in BLaine County, it WILL bug them...}
    {Sandy_Banned = {x = 2043.48, y = 3445.57, z = 43.78}},  --The coords it will teleport them to if Sandy Shores is banned
    {Paleto_Banned = {x = 2043.48, y = 3445.57, z = 43.78}}, --The coords it will teleport them to if Paleto Bay is banned
    {Legion_Banned = {x = -1031.7, y = -2730.71, z = 13.76}},
    {Blaine_County = {x = 2043.48, y = 3445.57, z = 43.78}}, --The coords it will teleport them to if AOP is Blaine County
    {Los_Santos = {x = -1031.7, y = -2730.71, z = 13.76}},    --The coords it will teleport them to if AOP is Los Santos
}

Config.Misc = {
    AOPCommand = "aop",
    PTCommand = "peacetime",
    DefaultAOP = "State Wide",
}
