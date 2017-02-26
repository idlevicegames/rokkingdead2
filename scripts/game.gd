# game.gd - core game scripts
extends Node

# Determine debugging level - default 2
export(bool) var DEBUG = true

## Core game variables
export(int) var elapsed setget _set_elapsed, _get_elapsed
export(int) var population = 0 setget _set_population, _get_population
signal elapsed_changed

signal population_changed
# Priorities
export(int) var priority_fishing = 0 setget _set_priority_fishing, _get_priority_fishing

signal priority_fishing_changed



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

func _set_population(new_value):
	population = new_value
	emit_signal("population_changed")
	pass

func _get_population():
	return(population)

# Priorities
func _set_priority_fishing(new_value):
	priority_fishing = new_value
	emit_signal("priority_fishing_changed")
	pass

func  _get_priority_fishing():
	return(priority_fishing)
	