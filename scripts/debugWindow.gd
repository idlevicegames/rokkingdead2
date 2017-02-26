# debugWindow.gd - script for debugging window functions
extends Node

onready var column_0 = self.get_node("debugPanel/column_0")
onready var column_1 = self.get_node("debugPanel/column_1")
onready var column_2 = self.get_node("debugPanel/column_2")
onready var column_3 = self.get_node("debugPanel/column_3")

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
	column_2.add_child(_create_label("col2row0", "Fishing: "))
	column_3.add_child(_create_label("col3row0", " "))

	self.set_process(true)
	

func _process(delta):
	column_1.get_node("col1row0").set_text(str("TRUE"))
	column_1.get_node("col1row1").set_text(str(game._get_elapsed()))
	column_1.get_node("col1row2").set_text(str(game._get_population()))
	
	column_3.get_node("col3row0").set_text(str(game._get_priority_fishing()))
	
	
	pass
	
func _create_label(name, text):
	var label = Label.new()
	label.set_name(name)
	label.set_text(text)
	label.add_font_override("debugFont", load("res://fonts/debugFont.fnt"))
	return(label)
