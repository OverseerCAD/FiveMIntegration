
local playerLocation = ''
local Coordinates = { x = 0, y = 0, z = 0}
local lastKnownLocation = 'Unknown'

Citizen.CreateThread(function()
Wait (5000)
while true do
while not NetworkIsPlayerActive(PlayerId()) do 
Wait(1)
end
Location()
Citizen.Wait(5000)
end
end)


function Location()
local cords = GetEntityCoords(PlayerPedId())
local s1, s2 = GetStreetNameAtCoord(cords.x, cords.y, cords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
local Name = GetStreetNameFromHashKey(s1)
local Cross = GetStreetNameFromHashKey(s2)
if (Cross == "") then
playerLocation = Name
else
playerLocation = Name .. "/" .. Cross
end
if(playerLocation ~= lastKnownLocation) then
TriggerServerEvent('OverseerCAD:Locations', playerLocation)
lastKnownLocation = playerLocation
Coordinates = cords
end
end

RegisterCommand('cadLink', function(source, args)
if not args[1] and not args[2] then return end
UserAPI = args[1]
CommunityAPI = args[2]
TriggerServerEvent("OverseerCAD:ConnectLocation", UserAPI, CommunityAPI)
end)

TriggerEvent('chat:addSuggestion', '/cadLink', 'Connect your FiveM to your OverseerCAD Account To Get Updated Locations', {
 { name = 'UserApi', help='Find Your API In Your Acct Settings' }, { name='CommunityApi', help='Find Community Administrators To Get The Required Argument'}
})