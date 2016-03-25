# Made with Framer
# by Qing Qu

# Import file "IG follower filter"
ig = Framer.Importer.load("imported/IG follower filter@1x")

textInputLayer = new Layer 
  x:70
  y:160
  width:600
  height:55

textInputLayer.ignoreEvents = false
textInputLayer.style = {"border" : "1px solid #c9c9c9"; "borderRadius" : "3px"}

# This creates a text input and adds some styling in plain JS
inputElement = document.createElement("input")
inputElement.style["width"]  = "#{textInputLayer.width - 32}px"
inputElement.style["height"] = "#{textInputLayer.height - 2}px"
inputElement.style["font"] = "34px/1.0em Helvetica"
inputElement.style["-webkit-user-select"] = "text"
inputElement.style["padding-left"] = "30px"
inputElement.style["outline"] = "none"

# Set the value, focus and listen for changes
inputElement.placeholder = "Search"
inputElement.value = "" 
inputElement.focus()	
inputElement.onkeyup = (e) ->
  # Draw the message
  if e.keyCode is 71
    # Set the textvalue
  	ig.result.states.switch("on")

# Place input layer on screen
textInputLayer._element.appendChild(inputElement)

# basic setup 
ig.overlay.opacity = 0
ig.result.opacity = 0
ig.keyboard.y = Screen.height
ig.cancelBtn.opacity = 0

# Settings
animateInCurve = "spring(400,30,0)"
animateOutCurve = "spring(350,35,0)"
noBounceCurve = "cubic-bezier"
noBounceCurveSpeed = "0.22"

# states
ig.overlay.states.add
	on: {opacity: 1}
	ig.overlay.states.animationOptions = curve: animateInCurve

ig.result.states.add
	on: {opacity: 1}
	ig.overlay.states.animationOptions = curve: animateInCurve
	
ig.cancelBtn.states.add
	on: {opacity: 1}
	ig.cancelBtn.states.animationOptions = curve: animateInCurve
	
textInputLayer.on Events.Click, ->
	textInputLayer.animate 
		properties: {x: 30}
		curve: "spring(500,50,15)"
		
	ig.overlay.states.switch("on")
	ig.cancelBtn.states.switch("on")
	ig.keyboard.animate
		properties: {y: Screen.height - ig.keyboard.height}
		curve: "spring(500,50,15)"
    

ig.overlay.on Events.Click, ->
	ig.overlay.states.switch("default")
	textInputLayer.animate 
		properties: {x: 75}
		curve: "spring(500,50,15)"
	ig.keyboard.animate
		properties: {y: Screen.height}
		curve: "spring(500,50,15)"
	ig.result.states.switch("default")
	ig.cancelBtn.states.switch("default");