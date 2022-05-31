local Community
local Key
AddEventHandler('playerConnecting', function(name, setKickReason, defferrals)
	local identifiers = GetPlayerIdentifiers(source)
	local source = source
	for k, v in pairs(identifiers) do
	if string.match(v, 'steam:') then
t = v:gsub("steam:", "")
Key = t
end
end

function Grab (error, result)
 if not Key then 
Key = nil
else -- Do If Steam Is Not Found
if(error == 200) then 
local res = json.decode(result)
local response = res.response.results;
for i, value in pairs(response) do
if(value.APIKEY == Key) then
Community = value.Community
end
if not Community then
Community = nil
end
end
else 
Community = nil -- Error Code Result
end
end
end
PerformHttpRequest('https://overseercad.co.uk/api/1.1/obj/FiveM_Connects', Grab, 'GET') -- Check If User Is Linked To From System To System
end)


RegisterServerEvent('OverseerCAD:Locations')
AddEventHandler('OverseerCAD:Locations', function(location)
if(Community ~= nil or Key ~= nil) then
PerformHttpRequest("https://overseercad.co.uk/api/1.1/wf/location", function(err, text, header) end, "POST", json.encode({APIKEY = Key, Location = location, Community = Community, LoggedIn = true}), {["Content-Type"] = 'application/json'})
else
return;
end
end)

RegisterServerEvent('OverseerCAD:ConnectLocation')
AddEventHandler('OverseerCAD:ConnectLocation', function(user, community)
if Key ~= nil then
if not Community then
PerformHttpRequest("https://overseercad.co.uk/api/1.1/wf/apiconnect", function(err, text, header) end, "POST", json.encode({APIKEY = Key, Location = location, Community = community, APIUSER = user, LoggedIn = true}), {["Content-Type"] = 'application/json'})
TriggerClientEvent('chatMessage', source, 'OverseerCAD: ', {56,78,117}, 'Request Sent - Please Check Your Community Dashboard To Check If The Operation Was A Success. Please Leave & Rejoin If The Operation Was A Success.')
else 
TriggerClientEvent('chatMessage', source, 'OverseerCAD: ', {56,78,117}, 'Your account is already linked. If the locations are not updated. Please leave and rejoin.')
end
else
TriggerClientEvent('chatMessage', source, 'OverseerCAD: ', {56,78,117}, 'There was an error finding your information, please leave and rejoin the server then retry.')
end
end)

AddEventHandler('playerDropped', function()
PerformHttpRequest("https://overseercad.co.uk/api/1.1/wf/location", function(err, text, header) end, "POST", json.encode({APIKEY = Key, Location = 'Unknown', Community = Community, LoggedIn = false}), {["Content-Type"] = 'application/json'})
end)