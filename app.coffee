# This imports all the layers for "NewTry" into newtryLayers
s = Framer.Importer.load "imported/NewTry"

Framer.Defaults.Animation = {
    curve: "spring(150,15,0)"
}

screen = new Layer(
	backgroundColor: "", 
	y: 34, x:0, width:640,  height:1136, 
	shadowX: -10, shadowY:40, shadowBlur: 30, shadowColor: "black",
	index: 1000,
)

showRitts = false
showStackelberg = false

swipeHint = new Layer(
	opacity: 0, image: "framer/images/cursor@2x.png"
)
swipeHint.center()
swipeHint.y += 60

splashHintRun = true
# Set up swipeHintAnimator for the splash swipe hint bobble, including checks to make sure the animation loop doesn't persist

swipeHintAnimatorRunning = false

swipeHintAnimator = ->

  if splashHintRun is false
    return
  
  if swipeHintAnimatorRunning is true
    return
  
  swipeHintAnimatorRunning = true
  
  
  swipeHint.x = 200
  swipeHint.opacity = 0
  swipeHint.scale = 1.5 

  animationsDoneCounter = 0

  fadeInAnimation = swipeHint.animate 
    properties: {scale: 1, opacity: 1}
    curve: 'ease-in'
    time: 0.2

  fadeInAnimation.on "end", ->
    swipeHint.animate 
      properties: {opacity: 0}
      curve: 'ease-in'
      time: 0.6
      delay: 0.6

  swipeHint.animate 
    properties:
      x: swipeHint.x + 300
    curve: 'linear'
    time: 1.5

  swipeHint.on "end", ->

    animationsDoneCounter++

    if animationsDoneCounter is 3
      swipeHintAnimatorRunning = false
      Utils.delay 0.6, swipeHintAnimator

swipeHintAnimator()


screen.addSubLayer(s.Start)
s.Start.visible = true
s.Meny.visible = true
screen.addSubLayer(s.Information)
s.Information.visible = false
screen.addSubLayer(s.Restaurang)
s.Restaurang.visible = false
screen.addSubLayer(s.Museikarta)
s.Museikarta.visible = false
screen.addSubLayer(s.Ritts)
s.Ritts.visible = false
screen.addSubLayer(s.Stackelberg)
s.Stackelberg.visible = false
screen.addSubLayer(s.Logga_in)
s.Logga_in.visible = false
screen.addSubLayer(s.Profil)
s.Profil.visible = false
screen.addSubLayer(s.QR)
s.QR.visible = false


screen.draggable.enabled = true
screen.draggable.speedY = 0
screen.draggable.maxDragFrame = screen.frame
screen.draggable.maxDragFrame.width = 1185

screen.states.add({
	menuClosed: {x: 0},
	menuOpened: {x: 545}
})
screen.states.animationOptions = {
    curve:"ease-in-out"
    time: 0.3
}

btn = new Layer(
	y:40, height:80, backgroundColor:"",
)
btn.states.add({
	left: {x:0},
	right: {x:545}	
})
btn.states.animationOptions = {
    curve: "ease-in-out"
}

btn.on Events.Click, -> 
	if screen.screenFrame.x < 250
		screen.states.switch("menuOpened")
		btn.states.switch("right")
		splashHintRun = false
	else
		screen.states.switch("menuClosed")
		btn.states.switch("left")
		splashHintRun = false
	
screen.on Events.DragEnd, ->
	if screen.screenFrame.x > 250
		screen.states.switch("menuOpened")
		btn.states.switch("right")
		splashHintRun = false
	else
		screen.states.switch("menuClosed")
		btn.states.switch("left")
		
s.combined.states.add({
	down: {y:298}
})
s.combined.states.animationOptions = {
    curve: "ease-in-out"
    time: 0.2
}
s.arrow.states.add({
	up: {rotation: -180}
})
s.arrow.states.animationOptions = {
    curve: "ease-in-out"
    time: 0.2
}

loggedin = false

s.exhibitionsItem.on Events.Click, ->
	s.combined.states.next()
	s.arrow.states.next()
	
s.informationItem.on Events.Click, ->
	s.Information.visible = true
	s.Restaurang.visible = false
	s.Museikarta.visible = false
	s.Ritts.visible = false
	s.Stackelberg.visible = false
	s.Logga_in.visible = false
	s.Profil.visible = false
	screen.states.switch("menuClosed")
	btn.states.switch("left")
	
s.restaurantItem.on Events.Click, ->
	s.Information.visible = false
	s.Restaurang.visible = true
	s.Museikarta.visible = false
	s.Ritts.visible = false
	s.Stackelberg.visible = false
	s.Logga_in.visible = false
	s.Profil.visible = false
	screen.states.switch("menuClosed")
	btn.states.switch("left")	

s.mapItem.on Events.Click, ->
	s.Information.visible = false
	s.Restaurang.visible = false
	s.Museikarta.visible = true
	s.Ritts.visible = false
	s.Stackelberg.visible = false
	s.Logga_in.visible = false
	s.Profil.visible = false
	screen.states.switch("menuClosed")
	btn.states.switch("left")	
	
s.rittsItem.on Events.Click, ->
	s.Information.visible = false
	s.Restaurang.visible = false
	s.Museikarta.visible = false
	s.Ritts.visible = true
	s.Stackelberg.visible = false
	s.Logga_in.visible = false
	s.Profil.visible = false
	screen.states.switch("menuClosed")
	btn.states.switch("left")	
	
s.stackelbergItem.on Events.Click, ->
	s.Information.visible = false
	s.Restaurang.visible = false
	s.Museikarta.visible = false
	s.Ritts.visible = false
	s.Stackelberg.visible = true
	s.Logga_in.visible = false
	s.Profil.visible = false
	screen.states.switch("menuClosed")
	btn.states.switch("left")		
		
s.ticketItem.on Events.Click, ->
	s.Information.visible = false
	s.Restaurang.visible = false
	s.Museikarta.visible = false
	s.Ritts.visible = false
	s.Stackelberg.visible = false
	if !loggedin
		s.Logga_in.visible = true
		s.Profil.visible = false
	else
	 	s.Profil.visible = true
	 	s.Logga_in.visible = false
	screen.states.switch("menuClosed")
	btn.states.switch("left")	
	
s.findUsActive.opacity = 0
s.openingHoursActive.opacity = 0
s.pricesActive.opacity = 0
s.contactActive.opacity = 0
s.aboutActive.opacity = 0

s.findUs.states.add({
	activated: {opacity: 0},
	about: {y: -520, opacity: 0}
})
s.openingHours.states.add({
	findUs: {y:498, opacity:1},
	activated: {y: 130, opacity: 0},
	about: {y:-390, opacity: 0}
})
s.prices.states.add({
	findUs: {y:628, opacity:1},
	openingHours: {y: 407, opacity:1},
	activated: {y: 260, opacity: 0},
	about: {y:-260, opacity: 0}
})
s.contact.states.add({
	findUs: {y:758, opacity:1},
	openingHours: {y: 537, opacity:1},
	prices: {y: 645, opacity: 1},
	activated: {y: 390, opacity: 0},
	about: {y:-130,opacity: 0}
})
s.about.states.add({
	findUs: {y:888, opacity:1},
	openingHours: {y: 667, opacity:1},
	prices: {y: 775, opacity: 1},
	contact: {y: 791, opacity: 1},
	activated: {y: 0, opacity: 0},
})
s.logotypen.states.add({
	findUs: {y:1100, opacity:1},
	openingHours: {y: 900, opacity:1},
	prices: {y: 980, opacity: 1},
	contact: {y: 1000, opacity: 1},
	about: {opacity: 0}
})
s.findUsActive.states.add({
	activated: {opacity: 1}
})
s.openingHoursActive.states.add({
	activated: {opacity: 1}
})
s.pricesActive.states.add({
	activated: {opacity: 1}
})
s.contactActive.states.add({
	activated: {opacity: 1}
})
s.aboutActive.states.add({
	activated: {opacity: 1}
})

findUsOpen = false
openingHoursOpen = false
pricesOpen = false
contactOpen = false
aboutOpen = false

s.findUs.on Events.Click, ->
	if !findUsOpen 
		s.findUs.states.switch("activated")
		s.openingHours.states.switch("findUs")
		s.prices.states.switch("findUs")
		s.contact.states.switch("findUs")
		s.about.states.switch("findUs")
		s.logotypen.states.switch("findUs")
		
		s.findUsActive.states.switch("activated")
		s.openingHoursActive.states.switch("default")
		s.pricesActive.states.switch("default")
		s.contactActive.states.switch("default")
		findUsOpen = true
		openingHoursOpen = false
		pricesOpen = false
		contactOpen = false
		aboutOpen = false
	else 
		s.findUs.states.switch("default")
		s.openingHours.states.switch("default")
		s.prices.states.switch("default")
		s.contact.states.switch("default")
		s.about.states.switch("default")
		s.logotypen.states.switch("default")
		
		s.findUsActive.states.switch("default")
		s.openingHoursActive.states.switch("default")
		s.pricesActive.states.switch("default")
		s.contactActive.states.switch("default")
		findUsOpen = false
		openingHoursOpen = false
		pricesOpen = false
		contactOpen = false
		aboutOpen = false
	
s.openingHours.on Events.Click, ->
	if !openingHoursOpen 
		s.findUs.states.switch("default")
		s.openingHours.states.switch("activated")
		s.prices.states.switch("openingHours")
		s.contact.states.switch("openingHours")
		s.about.states.switch("openingHours")
		s.logotypen.states.switch("openingHours")
		
		s.findUsActive.states.switch("default")
		s.openingHoursActive.states.switch("activated")
		s.pricesActive.states.switch("default")
		s.contactActive.states.switch("default")
		s.aboutActive.states.switch("default")
		openingHoursOpen = true
		findUsOpen = false
		pricesOpen = false
		contactOpen = false
		aboutOpen = false
	else 
		s.findUs.states.switch("default")
		s.openingHours.states.switch("default")
		s.prices.states.switch("default")
		s.contact.states.switch("default")
		s.about.states.switch("default")
		s.logotypen.states.switch("default")
		
		s.findUsActive.states.switch("default")
		s.openingHoursActive.states.switch("default")
		s.pricesActive.states.switch("default")
		s.contactActive.states.switch("default")
		s.aboutActive.states.switch("default")
		openingHoursOpen = false
		findUsOpen = false
		pricesOpen = false
		contactOpen = false
		aboutOpen = false
		
s.prices.on Events.Click, ->
	if !pricesOpen 
		s.findUs.states.switch("default")
		s.openingHours.states.switch("default")
		s.prices.states.switch("activated")
		s.contact.states.switch("prices")
		s.about.states.switch("prices")
		s.logotypen.states.switch("prices")
		
		s.findUsActive.states.switch("default")
		s.openingHoursActive.states.switch("default")
		s.pricesActive.states.switch("activated")
		s.contactActive.states.switch("default")
		s.aboutActive.states.switch("default")
		openingHoursOpen = false
		findUsOpen = false
		pricesOpen = true
		contactOpen = false
		aboutOpen = false
	else 
		s.findUs.states.switch("default")
		s.openingHours.states.switch("default")
		s.prices.states.switch("default")
		s.contact.states.switch("default")
		s.about.states.switch("default")
		s.logotypen.states.switch("default")
		
		s.findUsActive.states.switch("default")
		s.openingHoursActive.states.switch("default")
		s.pricesActive.states.switch("default")
		s.contactActive.states.switch("default")
		s.aboutActive.states.switch("default")
		openingHoursOpen = false
		findUsOpen = false
		pricesOpen = false
		contactOpen = false
		aboutOpen = false
		
s.contact.on Events.Click, ->
	if !contactOpen 
		s.findUs.states.switch("default")
		s.openingHours.states.switch("default")
		s.prices.states.switch("default")
		s.contact.states.switch("activated")
		s.about.states.switch("contact")
		s.logotypen.states.switch("contact")
		
		s.findUsActive.states.switch("default")
		s.openingHoursActive.states.switch("default")
		s.pricesActive.states.switch("default")
		s.contactActive.states.switch("activated")
		s.aboutActive.states.switch("default")
		openingHoursOpen = false
		findUsOpen = false
		pricesOpen = false
		contactOpen = true
		aboutOpen = false
	else 
		s.findUs.states.switch("default")
		s.openingHours.states.switch("default")
		s.prices.states.switch("default")
		s.contact.states.switch("default")
		s.about.states.switch("default")
		s.logotypen.states.switch("default")
		
		s.findUsActive.states.switch("default")
		s.openingHoursActive.states.switch("default")
		s.pricesActive.states.switch("default")
		s.contactActive.states.switch("default")
		s.aboutActive.states.switch("default")
		openingHoursOpen = false
		findUsOpen = false
		pricesOpen = false
		contactOpen = false
		aboutOpen = false
		
s.about.on Events.Click, ->
	if !aboutOpen 
		s.findUs.states.switch("about")
		s.openingHours.states.switch("about")
		s.prices.states.switch("about")
		s.contact.states.switch("about")
		s.about.states.switch("activated")
		s.logotypen.states.switch("about")
		
		s.findUsActive.states.switch("default")
		s.openingHoursActive.states.switch("default")
		s.pricesActive.states.switch("default")
		s.contactActive.states.switch("default")
		s.aboutActive.states.switch("activated")
		openingHoursOpen = false
		findUsOpen = false
		pricesOpen = false
		contactOpen = false
		aboutOpen = true
		
		s.about.bringToFront
	else 
		s.findUs.states.switch("default")
		s.openingHours.states.switch("default")
		s.prices.states.switch("default")
		s.contact.states.switch("default")
		s.about.states.switch("default")
		s.logotypen.states.switch("default")
		
		s.findUsActive.states.switch("default")
		s.openingHoursActive.states.switch("default")
		s.pricesActive.states.switch("default")
		s.contactActive.states.switch("default")
		s.aboutActive.states.switch("default")
		openingHoursOpen = false
		findUsOpen = false
		pricesOpen = false
		contactOpen = false
		aboutOpen = false
		
s.ropeningHoursActive.opacity = 0
s.rmenuActive.opacity = 0
s.raboutActive.opacity = 0

s.ropeningHours.states.add({
	activated: {y: 297, opacity: 0},
	about: {y:-260, opacity: 0}
})
s.rmenu.states.add({
	openingHours: {y: 624, opacity:1},
	activated: {y: 442, opacity: 0},
	about: {y:-130, opacity: 0}
})
s.rabout.states.add({
	openingHours: {y: 754, opacity:1},
	menu: {y: 754, opacity: 1},
	activated: {y: 0, opacity: 0},
})
s.rlogotypen.states.add({
	openingHours: {y: 950, opacity:1},
	menu: {y: 950, opacity: 1},
	about: {opacity: 0}
})
s.ropeningHoursActive.states.add({
	activated: {opacity: 1}
})
s.rmenuActive.states.add({
	activated: {opacity: 1}
})
s.raboutActive.states.add({
	activated: {opacity: 1}
})
s.headerImage.states.add({
	about: {y: -572}
})

ropeningHoursOpen = false
rmenuOpen = false
raboutOpen = false

s.ropeningHours.on Events.Click, ->
	if !ropeningHoursOpen 
		s.ropeningHours.states.switch("activated")
		s.rmenu.states.switch("openingHours")
		s.rabout.states.switch("openingHours")
		s.rlogotypen.states.switch("openingHours")
		s.headerImage.states.switch("default")
		
		s.ropeningHoursActive.states.switch("activated")
		s.rmenuActive.states.switch("default")
		s.raboutActive.states.switch("default")
		ropeningHoursOpen = true
		rmenuOpen = false
		raboutOpen = false
	else 
		s.ropeningHours.states.switch("default")
		s.rmenu.states.switch("default")
		s.rabout.states.switch("default")
		s.rlogotypen.states.switch("default")
		s.headerImage.states.switch("default")
		
		s.ropeningHoursActive.states.switch("default")
		s.rmenuActive.states.switch("default")
		s.raboutActive.states.switch("default")
		ropeningHoursOpen = false
		rmenuOpen = false
		raboutOpen = false
		
s.rmenu.on Events.Click, ->
	if !rmenuOpen 
		s.ropeningHours.states.switch("default")
		s.rmenu.states.switch("activated")
		s.rabout.states.switch("menu")
		s.rlogotypen.states.switch("menu")
		
		s.ropeningHoursActive.states.switch("default")
		s.rmenuActive.states.switch("activated")
		s.raboutActive.states.switch("default")
		s.headerImage.states.switch("default")
		ropeningHoursOpen = false
		rmenuOpen = true
		raboutOpen = false
	else 
		s.ropeningHours.states.switch("default")
		s.rmenu.states.switch("default")
		s.rabout.states.switch("default")
		s.rlogotypen.states.switch("default")
		s.headerImage.states.switch("default")
		
		s.ropeningHoursActive.states.switch("default")
		s.rmenuActive.states.switch("default")
		s.raboutActive.states.switch("default")
		ropeningHoursOpen = false
		rmenuOpen = false
		raboutOpen = false
		
s.rabout.on Events.Click, ->
	if !raboutOpen 
		s.ropeningHours.states.switch("about")
		s.rmenu.states.switch("about")
		s.rabout.states.switch("activated")
		s.rlogotypen.states.switch("about")
		s.headerImage.states.switch("about")
		
		s.ropeningHoursActive.states.switch("default")
		s.rmenuActive.states.switch("default")
		s.raboutActive.states.switch("activated")
		ropeningHoursOpen = false
		rmenuOpen = false
		raboutOpen = true
	else 
		s.ropeningHours.states.switch("default")
		s.rmenu.states.switch("default")
		s.rabout.states.switch("default")
		s.rlogotypen.states.switch("default")
		s.headerImage.states.switch("default")
		
		s.ropeningHoursActive.states.switch("default")
		s.rmenuActive.states.switch("default")
		s.raboutActive.states.switch("default")
		ropeningHoursOpen = false
		rmenuOpen = false
		raboutOpen = false
		
s.title2.opacity = 0
s.plan2.opacity = 0
s.rittsActive.opacity = 0
s.stackelbergActive.opacity = 0
s.downArrow.brightness = 50
plan = 1

s.upArrow.on Events.Click, ->
	if plan == 1
		if showStackelberg
			s.stackelbergActive.animate
				properties:
					opacity: 1
		s.rittsActive.animate
			properties:
				opacity: 0
		s.title1.animate
			properties:
				opacity: 0
		s.title2.animate
			properties:
				opacity: 1
		s.plan1.animate
			properties:
				opacity: 0
		s.plan2.animate
			properties:
				opacity: 1
		plan++
		s.upArrow.brightness = 50
		s.downArrow.brightness = 100
		
s.downArrow.on Events.Click, ->
	if plan == 2
		if showRitts
			s.rittsActive.animate
				properties:
					opacity: 1
		s.stackelbergActive.animate
			properties:
				opacity: 0
		s.title1.animate
			properties:
				opacity: 1
		s.title2.animate
			properties:
				opacity: 0
		s.plan1.animate
			properties:
				opacity: 1
		s.plan2.animate
			properties:
				opacity: 0
		plan--
		s.upArrow.brightness = 100
		s.downArrow.brightness = 50
		
startsida = new Layer(
	y: 1040, backgroundColor: ""
)

startsida.on Events.Click, ->
	s.Start.visible = true
	s.Information.visible = false
	s.Restaurang.visible = false
	s.Museikarta.visible = false
	splashHintRun = true
	swipeHintAnimator()
	
s.haboutActive.opacity = 0
s.hratingsActive.opacity = 0
haboutOpen = false
hratingsOpen = false

s.habout.states.add({
	activated: {y: 0, opacity: 0}
	off: {y: -260, opacity: 0}
})
s.hratings.states.add({
	activated: {y: 0, opacity: 0}
	off: {y: -260, opacity: 0}
})
s.hHeader.states.add({
	activated: {y: -472}
})
s.haboutActive.states.add({
	activated: {opacity: 1}	
})
s.hratingsActive.states.add({
	activated: {opacity: 1}	
})
s.hlogotype.states.add({
	activated: {opacity: 0}	
})

s.habout.on Events.Click, ->
	if !haboutOpen 
		s.habout.states.switch("activated")
		s.haboutActive.states.switch("activated")
		s.hratings.states.switch("off")
		s.hratingsActive.states.switch("default")
		s.hHeader.states.switch("activated")
		s.hlogotype.states.switch("activated")
		s.hShowOnMap.visible = false
		haboutOpen = true
		hratingsOpen = false
	else 
		s.habout.states.switch("default")
		s.haboutActive.states.switch("default")
		s.hratings.states.switch("default")
		s.hratingsActive.states.switch("default")
		s.hHeader.states.switch("default")
		s.hlogotype.states.switch("default")
		s.hShowOnMap.visible = true
		haboutOpen = false
		hratingsOpen = false
		
s.hratings.on Events.Click, ->
	if !hratingsOpen 
		s.habout.states.switch("off")
		s.haboutActive.states.switch("default")
		s.hratings.states.switch("activated")
		s.hratingsActive.states.switch("activated")
		s.hHeader.states.switch("activated")
		s.hlogotype.states.switch("activated")
		s.hShowOnMap.visible = false
		haboutOpen = false
		hratingsOpen = true
		
	else 
		s.habout.states.switch("default")
		s.haboutActive.states.switch("default")
		s.hratings.states.switch("default")
		s.hratingsActive.states.switch("default")
		s.hHeader.states.switch("default")
		s.hlogotype.states.switch("default")
		s.hShowOnMap.visible = true
		haboutOpen = false
		hratingsOpen = false
		
s.hShowOnMap.on Events.Click, ->
	showRitts = true
	showStackelberg = false
	s.stackelbergActive.opacity = 0
	s.rittsActive.animate
		properties:
			opacity: 1
	s.title1.animate
		properties:
			opacity: 1
	s.title2.animate
		properties:
			opacity: 0
	s.plan1.animate
		properties:
			opacity: 1
	s.plan2.animate
		properties:
			opacity: 0
	plan = 1
	s.upArrow.brightness = 100
	s.downArrow.brightness = 50
	s.Information.visible = false
	s.Restaurang.visible = false
	s.Museikarta.visible = true
	s.Ritts.visible = false
	s.Stackelberg.visible = false
	s.Logga_in.visible = false
	s.Profil.visible = false
	
				
s.eaboutActive.opacity = 0
s.eratingsActive.opacity = 0
eaboutOpen = false
eratingsOpen = false

s.eabout.states.add({
	activated: {y: 0, opacity: 0}
	off: {y: -260, opacity: 0}
})
s.eratings.states.add({
	activated: {y: 0, opacity: 0}
	off: {y: -260, opacity: 0}
})
s.eHeader.states.add({
	activated: {y: -472}
})
s.eaboutActive.states.add({
	activated: {opacity: 1}	
})
s.eratingsActive.states.add({
	activated: {opacity: 1}	
})
s.elogotype.states.add({
	activated: {opacity: 0}	
})

s.eabout.on Events.Click, ->
	if !eaboutOpen 
		s.eabout.states.switch("activated")
		s.eaboutActive.states.switch("activated")
		s.eratings.states.switch("off")
		s.eratingsActive.states.switch("default")
		s.eHeader.states.switch("activated")
		s.elogotype.states.switch("activated")
		s.eShowOnMap.visible = false
		eaboutOpen = true
		eratingsOpen = false
	else 
		s.eabout.states.switch("default")
		s.eaboutActive.states.switch("default")
		s.eratings.states.switch("default")
		s.eratingsActive.states.switch("default")
		s.eHeader.states.switch("default")
		s.elogotype.states.switch("default")
		s.eShowOnMap.visible = true
		eaboutOpen = false
		eratingsOpen = false
		
s.eratings.on Events.Click, ->
	if !eratingsOpen 
		s.eabout.states.switch("off")
		s.eaboutActive.states.switch("default")
		s.eratings.states.switch("activated")
		s.eratingsActive.states.switch("activated")
		s.eHeader.states.switch("activated")
		s.elogotype.states.switch("activated")
		s.eShowOnMap.visible = false
		eaboutOpen = false
		eratingsOpen = true
	else 
		s.eabout.states.switch("default")
		s.eaboutActive.states.switch("default")
		s.eratings.states.switch("default")
		s.eratingsActive.states.switch("default")
		s.eHeader.states.switch("default")
		s.elogotype.states.switch("default")
		s.eShowOnMap.visible = true
		eaboutOpen = false
		eratingsOpen = false
		
s.eShowOnMap.on Events.Click, ->
	showRitts = false
	showStackelberg = true
	s.rittsActive.opacity = 0
	s.stackelbergActive.animate
		properties:
			opacity: 1
	s.title1.animate
		properties:
			opacity: 0
	s.title2.animate
		properties:
			opacity: 1
	s.plan1.animate
		properties:
			opacity: 0
	s.plan2.animate
		properties:
			opacity: 1
	plan = 2
	s.upArrow.brightness = 50
	s.downArrow.brightness = 100
	s.Information.visible = false
	s.Restaurang.visible = false
	s.Museikarta.visible = true
	s.Ritts.visible = false
	s.Stackelberg.visible = false
	s.Logga_in.visible = false
	s.Profil.visible = false
	
s.loginbtn.on Events.Click, ->
	loggedin = true
	s.Information.visible = false
	s.Restaurang.visible = false
	s.Museikarta.visible = false
	s.Ritts.visible = false
	s.Stackelberg.visible = false
	s.Logga_in.visible = true
	s.Profil.visible = true
	s.Profil.opacity = 0
	s.Profil.animate
		properties:
			opacity: 1
	Utils.delay 0.3, ->
		s.Logga_in.visible = false
		
s.logout.on Events.Click, ->
	loggedin = false
	s.Information.visible = false
	s.Restaurang.visible = false
	s.Museikarta.visible = false
	s.Ritts.visible = false
	s.Stackelberg.visible = false
	s.Logga_in.visible = true
	s.Profil.visible = true
	s.Profil.opacity = 1
	s.Profil.animate
		properties:
			opacity: 0
	Utils.delay 0.3, ->
		s.Profil.visible = false
	
s.profileActive.opacity = 0
s.yourTicketsActive.opacity = 0
s.buyTicketsActive.opacity = 0

s.profile.states.add({
	activated: {opacity: 0},
})
s.yourTickets.states.add({
	profile: {y:401, opacity:1},
	activated: {y: 130, opacity: 0}
})
s.buyTickets.states.add({
	profile: {y:531, opacity:1},
	yourTickets: {y: 531, opacity:1},
	activated: {y: 260, opacity: 0},
})
s.profileActive.states.add({
	activated: {opacity: 1}
})
s.yourTicketsActive.states.add({
	activated: {opacity: 1}
})
s.buyTicketsActive.states.add({
	activated: {opacity: 1}
})

profileOpen = false
yourTicketsOpen = false
buyTicketsOpen = false

s.simpleTicket.visible = false
s.yearTicket.visible = false

s.profile.on Events.Click, ->
	if !profileOpen 
		s.profile.states.switch("activated")
		s.yourTickets.states.switch("profile")
		s.buyTickets.states.switch("profile")
		
		s.profileActive.states.switch("activated")
		s.yourTicketsActive.states.switch("default")
		s.buyTicketsActive.states.switch("default")
		profileOpen = true
		yourTicketsOpen = false
		buyTicketsOpen = false
		s.yearTicket.visible = false
		s.simpleTicket.visible = false
	else 
		s.profile.states.switch("default")
		s.yourTickets.states.switch("default")
		s.buyTickets.states.switch("default")
		
		s.profileActive.states.switch("default")
		s.yourTicketsActive.states.switch("default")
		s.buyTicketsActive.states.switch("default")
		profileOpen = false
		yourTicketsOpen = false
		buyTicketsOpen = false
		s.yearTicket.visible = false
		s.simpleTicket.visible = false
		
s.yourTickets.on Events.Click, ->
	if !yourTicketsOpen 
		s.profile.states.switch("default")
		s.yourTickets.states.switch("activated")
		s.buyTickets.states.switch("yourTickets")
		
		s.profileActive.states.switch("default")
		s.yourTicketsActive.states.switch("activated")
		s.buyTicketsActive.states.switch("default")
		s.yearTicket.visible = true
		s.simpleTicket.visible = true
		profileOpen = false
		yourTicketsOpen = true
		buyTicketsOpen = false
	else 
		s.profile.states.switch("default")
		s.yourTickets.states.switch("default")
		s.buyTickets.states.switch("default")
		
		s.profileActive.states.switch("default")
		s.yourTicketsActive.states.switch("default")
		s.buyTicketsActive.states.switch("default")
		s.yearTicket.visible = false
		s.simpleTicket.visible = false
		profileOpen = false
		yourTicketsOpen = false
		buyTicketsOpen = false
		
QR = false
s.simpleTicket.on Events.Click, ->
	QR = true
	s.QR.visible = true
	s.QR.opacity = 0
	s.QR.animate
		properties:
			opacity: 1

s.yearTicket.on Events.Click, ->
	QR = true
	s.QR.visible = true
	s.QR.opacity = 0
	s.QR.animate
		properties:
			opacity: 1
	
s.QR.on Events.Click, ->
	QR = false
	s.QR.animate
		properties:
			opacity: 0
	Utils.delay 0.3, ->
		s.QR.visible = false
		
s.buyTickets.on Events.Click, ->
	if !buyTicketsOpen 
		s.profile.states.switch("default")
		s.yourTickets.states.switch("default")
		s.buyTickets.states.switch("activated")
		
		s.profileActive.states.switch("default")
		s.yourTicketsActive.states.switch("default")
		s.buyTicketsActive.states.switch("activated")
		profileOpen = false
		yourTicketsOpen = false
		buyTicketsOpen = true
		s.yearTicket.visible = false
		s.simpleTicket.visible = false
	else 
		s.profile.states.switch("default")
		s.yourTickets.states.switch("default")
		s.buyTickets.states.switch("default")
		
		s.profileActive.states.switch("default")
		s.yourTicketsActive.states.switch("default")
		s.buyTicketsActive.states.switch("default")
		profileOpen = false
		yourTicketsOpen = false
		buyTicketsOpen = false
		s.yearTicket.visible = false
		s.simpleTicket.visible = false