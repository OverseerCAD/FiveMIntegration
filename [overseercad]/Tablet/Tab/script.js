function Visible(module, visible) {
	var doc = document.getElementById(module + "Div")
		if (visible) {
		doc.style.display = "block"
		} else {
		doc.style.display = "none"
		}
	}

	window.addEventListener("message", function(event) {
	if(event.data.type == "display") {
		Visible(event.data.module, event.data.enabled)
	}
		if(event.data.type == "refresh") {
		var time = new Date().getTime();
		var link = document.getElementById('IFRAME').src;
		document.getElementById('IFRAME').src = link + "&" + time.toString();
	}
	if (event.data.type == "setURL") {
		document.getElementById("IFRAME").src = event.data.url;
}
	if(event.data.type == "size") {
	document.getElementById('IFRAME').width = event.data.widthNew;
	document.getElementById('IFRAME').height = event.data.heightNew;
	document.getElementById('cadDiv').style.width = event.data.widthNew;
	document.getElementById('cadDiv').style.height = event.data.heightNew;
}
	})


document.onkeyup = function (data) {
	if(data.which == 27) {
			$.post('https://Tablet/NUIFocusOff', JSON.stringify({}));
	}
};
