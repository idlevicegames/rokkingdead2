# hud.gd - hud functions
extends Node

onready var sldFishing = self.get_node("hudPanel/sldFishing")

func _ready():
	# Priorities	
	sldFishing.set_value(game._get_priority_fishing())		
	sldFishing.connect("value_changed", self, "_priority_fishing_change")
	self.set_process(true)

func _process(delta):
	pass
	
func _priority_fishing_change(value):
	game._set_priority_fishing(value)
	game.emit_signal("priority_fishing_changed")