extends Node

signal _slider_gathering_value_change(activeSlider, sliders)

onready var sldFishing = self.get_node("sldFishing")
onready var sldDefecating = self.get_node("sldDefecating")


func _ready():		
	
	sldFishing.set_value(game._get_priority_fishing())	
	sldDefecating.set_value(game._get_priority_defecating())
	
	sldFishing.connect("value_changed", self, "_priority_fishing_change")	
	sldDefecating.connect("value_changed", self, "_priority_defecating_change")
	
func _slider_change(slider):
	var sliders = []
	var activeSlider = slider
	for n in self.get_children():
		if (n.get_name() != activeSlider.get_name()):
			sliders.append(n)	
			
	sldFishing.disconnect("value_changed", self, "_priority_fishing_change")	
	sldDefecating.disconnect("value_changed", self, "_priority_defecating_change")
	
	emit_signal("_slider_gathering_value_change", activeSlider, sliders)
	
	game._set_priority_fishing(sldFishing.get_value())
	game._set_priority_defecating(sldDefecating.get_value())
	
	sldFishing.connect("value_changed", self, "_priority_fishing_change")	
	sldDefecating.connect("value_changed", self, "_priority_defecating_change")
	
func _priority_fishing_change(value):
	#print("Firing priority fishing change")	
	_slider_change(sldFishing)
	
func _priority_defecating_change(value):
	#print("Firing priority defecating change")	
	_slider_change(sldDefecating)