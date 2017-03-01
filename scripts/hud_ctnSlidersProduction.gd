extends Node

signal _slider_production_value_change(activeSlider, sliders)

onready var sldScrapping = self.get_node("sldScrapping")
onready var sldRefining = self.get_node("sldRefining")
onready var sldCrafting = self.get_node("sldCrafting")


func _ready():			
	
	sldScrapping.set_value(game._get_priority_scrapping())
	sldRefining.set_value(game._get_priority_refining())
	sldCrafting.set_value(game._get_priority_crafting())
	
	sldScrapping.connect("value_changed", self, "_priority_scrapping_change")
	sldRefining.connect("value_changed", self, "_priority_refining_change")
	sldCrafting.connect("value_changed", self, "_priority_crafting_change")
	

func _slider_change(slider):	
	var sliders = []
	var activeSlider = slider
	for n in self.get_children():
		if (n.get_name() != activeSlider.get_name()):
			sliders.append(n)	
			
	sldScrapping.disconnect("value_changed", self, "_priority_scrapping_change")
	sldRefining.disconnect("value_changed", self, "_priority_refining_change")
	sldCrafting.disconnect("value_changed", self, "_priority_crafting_change")
	
	emit_signal("_slider_production_value_change", activeSlider, sliders)
	
	game._set_priority_scrapping(sldScrapping.get_value())
	game._set_priority_refining(sldRefining.get_value())
	game._set_priority_crafting(sldCrafting.get_value())
	
	sldScrapping.connect("value_changed", self, "_priority_scrapping_change")
	sldRefining.connect("value_changed", self, "_priority_refining_change")
	sldCrafting.connect("value_changed", self, "_priority_crafting_change")
	
# Change of fishing priority driven by signal

func _priority_scrapping_change(value):
	#print("Firing priority scrapping change")	
	_slider_change(sldScrapping)
	
func _priority_refining_change(value):
	#print("Firing priority refining change")	
	_slider_change(sldRefining)
	
func _priority_crafting_change(value):
	#print("Firing priority crafting change")	
	_slider_change(sldCrafting)