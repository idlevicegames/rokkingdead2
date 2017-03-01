# hud.gd - hud functions
extends Node

# Max Priorities
var MAX_PRIORITIES = 100.00

# Array of the sliders
var sliders = []


onready var sldFishing = self.get_node("hudPriority/ctnSliders/sldFishing")
onready var sldScrapping = self.get_node("hudPriority/ctnSliders/sldScrapping")
onready var sldDefecating = self.get_node("hudPriority/ctnSliders/sldDefecating")

func _ready():		
	
	for n in self.get_node("hudPriority/ctnSliders/").get_children():
		sliders.append(n)
		#print(n.get_name())
	# Before connecting the slider signals, set the value for all of the avaialble sliders	
	sldFishing.set_value(game._get_priority_fishing())
	sldScrapping.set_value(game._get_priority_scrapping())
	sldDefecating.set_value(game._get_priority_defecating())

	# Connect all of the signals listening for a change in one of the sliders
	sldFishing.connect("value_changed", self, "_priority_fishing_change")
	sldScrapping.connect("value_changed", self, "_priority_scrapping_change")
	sldDefecating.connect("value_changed", self, "_priority_defecating_change")
		
	# Set processing to start
	self.set_process(true)

func _process(delta):
	pass

# Change of fishing priority driven by signal
func _priority_fishing_change(value):
	print("Firing priority fishing change")
	#_priority_change(sldFishing)
	_slider_change(sldFishing)
	
# Change of scraping priority driven by signal
func _priority_scrapping_change(value):
	print("Firing priority scrapping change")
	#_priority_change(sldScrapping)
	_slider_change(sldScrapping)
	
# Change of defecating priority driven by signal
func _priority_defecating_change(value):
	print("Firing priority defecating change")
	#_priority_change(sldDefecating)
	_slider_change(sldDefecating)

func _slider_change(slider):
	
	sldFishing.disconnect("value_changed", self, "_priority_fishing_change")
	sldScrapping.disconnect("value_changed", self, "_priority_scrapping_change")
	sldDefecating.disconnect("value_changed", self, "_priority_defecating_change")
	
	# Current total of the changing slider
	var amountToRedistribute = MAX_PRIORITIES - slider.get_value()	
	var amountRedistributed = 0
	print(str("Setting slider " + slider.get_name() + " amount left: " +  str(amountToRedistribute)));
	

	 #Determine sum  of the other sliders
	var otherSlidersWeight = 0	
	for s in sliders:
		# Look into all other sliders that 
		if (s.get_name() != slider.get_name()):
			print("  Adding: " + str(s.get_value()) + " for: " + s.get_name())
			otherSlidersWeight += s.get_value()
	
	print("Other slider weight: " + str(otherSlidersWeight))
	
	for s in sliders:
		# Look into all other sliders that 
		if (s.get_name() != slider.get_name()):
			if (slider.get_value() >= 100):
				s.set_value(0)			
			elif (slider.get_value() <= 0 || otherSlidersWeight <= 0):
				s.set_value(50)
			else:			
				var newValue = 0;
				var currentValue= s.get_value()
				newValue = floor( s.get_value()/otherSlidersWeight * amountToRedistribute)
				print("  Current" +  str(currentValue) + " plus " + str(newValue) + " to: " + s.get_name())
				s.set_value(newValue)
				amountRedistributed += s.get_value()
				#print("Amount left to redistribute: " + str(amountRedistributed))	
		#amountToRedistribute -= amountRedistributed	
		#print("Amount left to redistribute: " + str(amountRedistributed))
	game._set_priority_fishing(sldFishing.get_value())
	game._set_priority_scrapping(sldScrapping.get_value())
	game._set_priority_defecating(sldDefecating.get_value())
		
	sldFishing.connect("value_changed", self, "_priority_fishing_change")
	sldScrapping.connect("value_changed", self, "_priority_scrapping_change")
	sldDefecating.connect("value_changed", self, "_priority_defecating_change")
	
	