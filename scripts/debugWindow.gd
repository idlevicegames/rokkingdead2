# debugWindow.gd - script for debugging window functions
extends Node

func _ready():
	var c1 = self.get_node("debugPanel/column_1")
	var c2 = self.get_node("debugPanel/column_2")
	
	var c1r1 = Label.new()	
	c1r1.add_font_override("debugFont", load("res://fonts/debugFont.fnt"))
	c1r1.set_text("Time")
	c1.add_child(c1r1)
	
	var c2r1 = Label.new()	
	c2r1.set_name("c2r1")
	c2r1.add_font_override("debugFont", load("res://fonts/debugFont.fnt"))
	c2.add_child(c2r1)
	self.set_process(true)

func _process(delta):
	get_node("debugPanel/column_2").get_node("c2r1").set_text(str(game._get_elapsed()))
	pass