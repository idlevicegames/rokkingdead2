# game.gd - core game scripts
extends Node

# Determine debugging level - default 2
export(bool) var DEBUG = true

## Core game variables
export(int) var elapsed setget _set_elapsed, _get_elapsed
signal elapsed_changed

func _ready():
	_set_elapsed(0)

func _start_debug():
	if (DEBUG):
		var debugWindow = preload("res://scenes/debugWindow.tscn").instance()
		var world = get_node("/root/world")
		world.add_child(debugWindow)

func _set_elapsed(new_value):
	elapsed = new_value
	emit_signal("elapsed_changed")
	pass

func _get_elapsed():
	return(elapsed)