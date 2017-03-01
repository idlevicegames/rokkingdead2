# hud.gd - hud functions
extends Node

func _ready():		

	# Connect all of the signals listening for a change in one of the sliders
	self.get_node("hudPriority/ctnSliders/").connect("_slider_gathering_value_change", self, "_slider_change")	
	self.get_node("hudPriority/ctnSlidersProduction/").connect("_slider_production_value_change", self, "_slider_change")	
	# Set processing to start
	self.set_process(true)

func _process(delta):
	pass

func _slider_change(slider, sliders):	
	# Max Priorities
	var MAX_PRIORITIES = 100.00
	
	# Current total of the changing slider
	var amountToRedistribute = MAX_PRIORITIES - slider.get_value()	
	var amountRedistributed = 0
	#print(str("Setting slider " + slider.get_name() + " amount left: " +  str(amountToRedistribute)));
	

	 #Determine sum  of the other sliders
	var otherSlidersWeight = 0	
	for s in sliders:
		# Look into all other sliders that 
		if (s.get_name() != slider.get_name()):
			#print("  Adding: " + str(s.get_value()) + " for: " + s.get_name())
			otherSlidersWeight += s.get_value()
	
	#print("Other slider weight: " + str(otherSlidersWeight))
	
	for s in sliders:
		# Look into all other sliders that 
		if (s.get_name() != slider.get_name()):
			if (slider.get_value() >= 100):
				s.set_value(0)			
			elif (slider.get_value() <= 0 || otherSlidersWeight <= 0):
				s.set_value(100 / sliders.size())
			elif (amountToRedistribute == 1 || amountToRedistribute == 2):
				s.set_value(amountToRedistribute / sliders.size())			
			else:			
				var newValue = 0;
				var currentValue= s.get_value()
				newValue = floor( s.get_value()/otherSlidersWeight * amountToRedistribute)
				#print("  Current" +  str(currentValue) + " plus " + str(newValue) + " to: " + s.get_name())
				s.set_value(newValue)
				amountRedistributed += s.get_value()
