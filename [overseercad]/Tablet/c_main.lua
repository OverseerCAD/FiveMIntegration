
Citizen.CreateThread(function()
	Wait(1000)
	CadURL("cad", GetConvar("overseercad_cadURL", 'https://overseercad.co.uk/invite/Tablet?code='..GetConvar("overseercad_invite_code", "INVITE_CODE_HERE")))
end)

function CadURL(module, url)
	SendNUIMessage({
		type = "setURL",
		url = url,
		module = module
	})
end

function Display(module, show)
	SendNUIMessage({
		type = "display",
		module = module,
		enabled = show
	})
end

function Focused(focused)
	nuiFocused = focused
	SetNuiFocus(nuiFocused, nuiFocused)
end

RegisterNUICallback('NUIFocusOff', function()
Display("cad", false)
Focused(false)
end)

function Refresh(module, show)
	SendNUIMessage({
		type = "refresh",
		module = module,
		enabled = show
	})
end

function SetSize(module, width, height)
	SendNUIMessage({
		type = "size",
		module = module,
		widthNew = width,
		heightNew = height
	})
	SetResourceKvp(module .. "width", width)
	SetResourceKvp(module .. "height", height)
end
RegisterCommand("cad", function(source, args, rawCommand)
	Display("cad", true)
	Focused(true)
end, false)
RegisterKeyMapping('cad', 'CAD Tablet', 'keyboard', '')

TriggerEvent('chat:addSuggestion', '/cadsize', "Resize CAD to specific width and height in pixels. Default is 1100x510", {
	{ name="Width", help="Width in pixels" }, { name="Height", help="Height in pixels" }
})
RegisterCommand("cadsize", function(source,args)
	if not args[1] and not args[2] then return end
	SetSize("cad", args[1], args[2])
end)
RegisterCommand("cadrefresh", function()
	Refresh("cad")
end)
