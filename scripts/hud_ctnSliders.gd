extends Node

var activeSlider

signal _slider_value_change(activeSlider, sliders)



onready var sldFishing = self.get_node("sldFishing")
onready var sldScrapping = self.get_node("sldScrapping")
onready var sldDefecating = self.get_node("sldDefecating")


func _ready():		
	
	sldFishing.set_value(game._get_priority_fishing())
	sldScrapping.set_value(game._get_priority_scrapping())
	sldDefecating.set_value(game._get_priority_defecating())
	
	sldFishing.connect("value_changed", self, "_priority_fishing_change")
	sldScrapping.connect("value_changed", self, "_priority_scrapping_change")
	sldDefecating.connect("value_changed", self, "_priority_defecating_change")
	

func _slider_change(slider):
	var sliders = []
	activeSlider = slider
	for n in self.get_children():
		if (n.get_name() != activeSlider.get_name()):
			sliders.append(n)	
			
	sldFishing.disconnect("value_changed", self, "_priority_fishing_change")
	sldScrapping.disconnect("value_changed", self, "_priority_scrapping_change")
	sldDefecating.disconnect("value_changed", self, "_priority_defecating_change")
	
	emit_signal("_slider_value_change", activeSlider, sliders)
	
	game._set_priority_fishing(sldFishing.get_value())
	game._set_priority_scrapping(sldScrapping.get_value())
	game._set_priority_defecating(sldDefecating.get_value())
	
	sldFishing.connect("value_changed", self, "_priority_fishing_change")
	sldScrapping.connect("value_changed", self, "_priority_scrapping_change")
	sldDefecating.connect("value_changed", self, "_priority_defecating_change")
	
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