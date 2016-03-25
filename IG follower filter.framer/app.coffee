# Made with Framer
# by Qing Qu

# Import file "IG follower filter"
ig = Framer.Importer.load("imported/IG follower filter@1x")

textInputLayer = new Layer 
  x:25
  y:150
  width:700
  height:60

textInputLayer.ignoreEvents = false
textInputLayer.style = {"border" : "1px solid #c9c9c9"; "borderRadius" : "1px"}

# This creates a text input and adds some styling in plain JS
inputElement = document.createElement("input")
inputElement.style["width"]  = "#{textInputLayer.width - 22}px"
inputElement.style["height"] = "#{textInputLayer.height - 2}px"
inputElement.style["font"] = "34px/1.35em Helvetica"
inputElement.style["-webkit-user-select"] = "text"
inputElement.style["padding-left"] = "20px"
inputElement.style["outline"] = "none"

# Set the value, focus and listen for changes
inputElement.placeholder = "Search"
inputElement.value = ""
inputElement.focus()
inputElement.onkeyup = (e) ->
  # Draw the message
  if e.keyCode is 13
    # Set the textvalue
    textVal = inputElement.value
  
    # Clear the value
    inputElement.value = ""
    
    # Message setup
    msgWrapper = new Layer
      superLayer: convoWrapper
      y: 800 
      width: 640
      height: 140
      backgroundColor: "transparent"
    msgWrapper.states.add
      origin: {y: 800}
      dest: {y: (msgCount * msgWrapper.height)}  
    msgAvatar = new Layer 
      superLayer: msgWrapper
      x:30, y:0, width:80, height:80, image:"images/profile_Ed.png"
    
    msgBubble = new Layer
      superLayer: msgWrapper,
      x: 130
      width: 480
      height: 114
      borderRadius: 20
      backgroundColor: "#EBF2FB"
      cut: false

    msgPreBubble = new Layer
      superLayer: msgBubble,
      width: 480
      height: 114
      borderRadius: 20
      backgroundColor: "#FFF"
    msgPreBubble.style = {"border" : "2px solid #d9d9d9"}
    msgPreBubble.states.add
      hide: {opacity: 0}
    msgPreBubble.states.animationOptions = curve:"spring(800,80,0)"
    
    msgText = new Layer
      superLayer: msgBubble
      x: 20
      y: 60
      width: 420
      height: 80
      backgroundColor: "transparent"
    msgText.html = textVal
    msgText.style = {
      "color" : "#000"
    }
    
    # Message Animations
    msgWrapper.states.switch "dest", curve:"spring(800,80,0)"
    msgCount++
    
    Utils.delay .5, ->
      msgPreBubble.states.switch "hide"

# Place input layer on screen
textInputLayer._element.appendChild(inputElement)

# basic setup 
ig.overlay.opacity = 0
ig.result.opacity = 0
ig.keyboard.opacity = 0
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


textInputLayer.on Events.Click, ->
	ig.overlay.states.switch("on")

