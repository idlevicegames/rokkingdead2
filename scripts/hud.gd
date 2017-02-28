# hud.gd - hud functions
extends Node

# Max Priorities
var MAX_PRIORITIES = 100

onready var sldFishing = self.get_node("hudPriority/sldFishing")
onready var sldScrapping = self.get_node("hudPriority/sldScrapping")
onready var sldDefecating = self.get_node("hudPriority/sldDefecating")

func _ready():
		
	# Priorities	
	sldFishing.set_value(game._get_priority_fishing())
	sldScrapping.set_value(game._get_priority_scrapping())
	sldDefecating.set_value(game._get_priority_defecating())

	sldFishing.connect("value_changed", self, "_priority_fishing_change")
	sldScrapping.connect("value_changed", self, "_priority_scrapping_change")	
	sldDefecating.connect("value_changed", self, "_priority_defecating_change")
	
	self.set_process(true)

func _process(delta):
	pass
	
func _priority_fishing_change(value):
	print("Firing priority fishing change")
	_priority_change(sldFishing)

func _priority_scrapping_change(value):
	print("Firing priority scrapping change")
	_priority_change(sldScrapping)

func _priority_defecating_change(value):
	print("Firing priority defecating change")
	_priority_change(sldDefecating)
	
func _priority_change(slider):
	
	var currentFishing = game._get_priority_fishing()
	var currentScrapping  = game._get_priority_scrapping()
	var currentDefecating =  game._get_priority_defecating()
	
	var total = slider.get_value()
	print(str("Setting slider: " +  slider.get_name() + " to: " +  str(int(total))));
		
	#game._set_priority_fishing(value)
	#game.emit_signal("priority_fishing_changed")
	# Get current total
	
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