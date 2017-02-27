# debugWindow.gd - script for debugging window functions
extends Node

onready var column_0 = self.get_node("debugPanel/column_0")
onready var column_1 = self.get_node("debugPanel/column_1")
onready var column_2 = self.get_node("debugPanel/column_2")
onready var column_3 = self.get_node("debugPanel/column_3")
onready var column_4 = self.get_node("debugPanel/column_4")
onready var column_5 = self.get_node("debugPanel/column_5")

func _ready():
	
	
	# DEBUG
	column_0.add_child(_create_label("col0row0", "Debug: "))
	column_1.add_child(_create_label("col1row0", " "))

	# TIME
	column_0.add_child(_create_label("col0row1", "Time: "))
	column_1.add_child(_create_label("col1row1", " "))

	# POP
	column_0.add_child(_create_label("col0row2", "Pop: "))
	column_1.add_child(_create_label("col1row2", " "))

	# Priorities
	column_2.add_child(_create_label("col2row0", "Fish %: "))
	column_3.add_child(_create_label("col3row0", " "))
	
	column_2.add_child(_create_label("col2row0", "Fish drop: "))
	column_3.add_child(_create_label("col3row1", " "))
	
	
	# Resources
	column_4.add_child(_create_label("col4row0", "Small: "))
	column_5.add_child(_create_label("col5row0", " "))
	
	column_4.add_child(_create_label("col4row1", "Medium: "))
	column_5.add_child(_create_label("col5row1", " "))
	
	column_4.add_child(_create_label("col4row2", "Large: "))
	column_5.add_child(_create_label("col5row2", " "))

	self.set_process(true)
	

func _process(delta):
	
	column_1.get_node("col1row0").set_text(str("TRUE"))
	column_1.get_node("col1row1").set_text(str(game._get_elapsed()))
	column_1.get_node("col1row2").set_text(str(game._get_population()))
	
	column_3.get_node("col3row0").set_text(str(game._get_priority_fishing()))
	column_3.get_node("col3row1").set_text(str(int(resources.FISH_PROBABILITY)))
	
	column_5.get_node("col5row0").set_text(str(game._get_resource_small_trash()))
	column_5.get_node("col5row1").set_text(str(game._get_resource_medium_trash()))
	column_5.get_node("col5row2").set_text(str(game._get_resource_large_trash()))
	
	pass
	
func _create_label(name, text):
	var label = Label.new()
	label.set_name(name)
	label.set_text(text)
	label.set_align(0)
	label.add_font_override("debugFont", load("res://fonts/debugFont.fnt"))
	return(label)
