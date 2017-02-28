# hud.gd - hud functions
extends Node

# Max Priorities
var MAX_PRIORITIES = 100

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
	var amountToRedistribute = MAX_PRIORITIES - int(slider.get_value())	
	var amountRedistributed = 0
	print(str("Setting slider " + slider.get_name() + " amount left: " +  str(int(amountToRedistribute))));
	
	# Determine sum  of the other sliders
	var otherSlidersWeight = 0	
	for s in sliders:
		# Look into all other sliders that 
		if (s.get_name() != slider.get_name()):
			print("  Adding: " + str(s.get_value()) + " for: " + s.get_name())
			otherSlidersWeight += int(s.get_value())
	
	print("Other slider weight: " + str(otherSlidersWeight))
	
	for s in sliders:
		# Look into all other sliders that 
		if (s.get_name() != slider.get_name()):
			var newValue = 0;
			newValue = floor(s.get_value()/otherSlidersWeight * amountToRedistribute/sliders.size())
			if newValue <0: newValue = 0
			if newValue >= 100: newValue = 100
			print("  Giving: " + str(newValue) + " to: " + s.get_name())
			s.set_value(newValue)
			amountRedistributed += s.get_value()
	
	amountToRedistribute -= amountRedistributed	
	print("Amount left to redistribute: " + str(amountRedistributed))
		
	sldFishing.connect("value_changed", self, "_priority_fishing_change")
	sldScrapping.connect("value_changed", self, "_priority_scrapping_change")
	sldDefecating.connect("value_changed", self, "_priority_defecating_change")
	

func _priority_change(slider):
	
	var currentFishing = game._get_priority_fishing()
	var currentScrapping  = game._get_priority_scrapping()
	var currentDefecating =  game._get_priority_defecating()
	
	var total = slider.get_value()
	print(str("Setting slider: " +  slider.get_name() + " to: " +  str(int(total))));
		
	#game._set_priority_fishing(value)
	#game.emit_signal("priority_fishing_changed")
	# Get current total
	# Determine sum  of the other sliders
	var delta = MAX_PRIORITIES - total
	print("Slider delta: " + str(int(delta)))
	
	
	if (slider.get_name() == "sldFishing"):			

		currentDefecating = currentDefecating + int(delta/3)
		if (currentDefecating < 0 || total == 100):
			currentDefecating = 0;
		if (currentDefecating > 100):
			currentDefecating = 100;		
		sldDefecating.disconnect("value_changed", self, "_priority_defecating_change")
		sldDefecating.set_value(currentDefecating)
		game._set_priority_defecating(currentDefecating)
		sldDefecating.connect("value_changed", self, "_priority_defecating_change")
		
		currentScrapping = currentScrapping + int(delta/3)
		if (currentScrapping < 0 || total == 100):
			currentScrapping = 0;
		if (currentScrapping > 100):
			currentScrapping = 100;			
		sldScrapping.disconnect("value_changed", self, "_priority_scrapping_change")
		sldScrapping.set_value(currentScrapping)
		game._set_priority_scrapping(currentScrapping)
		sldScrapping.connect("value_changed", self, "_priority_scrapping_change")
	
	if (slider.get_name() == "sldScrapping"):
		
		currentFishing = currentFishing + int(delta/3)		
		if (currentFishing < 0 || total == 100):
        	currentFishing = 0;
		if (currentFishing > 100):
        	currentFishing = 100;		
		sldFishing.disconnect("value_changed", self, "_priority_fishing_change")
		sldFishing.set_value(currentFishing)
		game._set_priority_fishing(currentFishing)
		sldFishing.connect("value_changed", self, "_priority_fishing_change")		
		
		currentDefecating = currentDefecating + int(delta/3)
		if (currentDefecating < 0 || total == 100):
			currentDefecating = 0;
		if (currentDefecating > 100):
			currentDefecating = 100;		
		sldDefecating.disconnect("value_changed", self, "_priority_defecating_change")
		sldDefecating.set_value(currentDefecating)
		game._set_priority_defecating(currentDefecating)
		sldDefecating.connect("value_changed", self, "_priority_defecating_change")

	if (slider.get_name() == "sldDefecating"):		
		
		currentFishing = currentFishing + int(delta/3)		
		if (currentFishing < 0 || total == 100):
			currentFishing = 0;
		if (currentFishing > 100):
         	currentFishing = 100;		
		sldFishing.disconnect("value_changed", self, "_priority_fishing_change")
		sldFishing.set_value(currentFishing)
		game._set_priority_fishing(currentFishing)
		sldFishing.connect("value_changed", self, "_priority_fishing_change")		
		
		currentScrapping = currentScrapping + int(delta/3)
		if (currentScrapping < 0 || total == 100):
			currentScrapping = 0;
		if (currentScrapping > 100):
			currentScrapping = 100;			
		sldScrapping.disconnect("value_changed", self, "_priority_scrapping_change")
		sldScrapping.set_value(currentScrapping)
		game._set_priority_scrapping(currentScrapping)
		sldScrapping.connect("value_changed", self, "_priority_scrapping_change")