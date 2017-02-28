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
export(int) var priority_scrapping = 0 setget _set_priority_scrapping, _get_priority_scrapping
export(int) var priority_defecating = 100 setget _set_priority_defecating, _get_priority_defecating

signal priority_fishing_changed
signal priority_scrapping_changed
signal priority_defecating_changed

# Resources

export(int) var small_trash = 0 setget _set_resource_small_trash, _set_resource_small_trash
export(int) var medium_trash = 0 setget _set_resource_medium_trash, _set_resource_medium_trash
export(int) var large_trash = 0 setget _set_resource_large_trash, _set_resource_large_trash

export(int) var defecation = 0 setget _set_resource_defecation, _set_resource_defecation

signal small_trash_changed
signal medium_trash_changed
signal large_trash_changed
signal defecation_changed

func _ready():
	_set_elapsed(0)
	game.connect("elapsed_changed", self, "_time_change")

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

func _set_priority_scrapping(new_value):
	priority_scrapping = new_value
	emit_signal("priority_scrapping_changed")
	pass

func  _get_priority_scrapping():
	return(priority_scrapping)
	
func _set_priority_defecating(new_value):
	priority_defecating = new_value
	emit_signal("priority_defecating_changed")
	pass

func  _get_priority_defecating():
	return(priority_defecating)

# Resources

func _set_resource_small_trash(new_value):
	small_trash += new_value
	emit_signal("small_trash_changed")
	pass

func  _get_resource_small_trash():
	return(small_trash)

func _set_resource_medium_trash(new_value):
	medium_trash += new_value
	emit_signal("medium_trash_changed")
	pass

func  _get_resource_medium_trash():
	return(medium_trash)
	
func _set_resource_large_trash(new_value):
	large_trash += new_value
	emit_signal("large_trash_changed")
	pass

func  _get_resource_large_trash():
	return(large_trash)	

func _set_resource_defecation(new_value):
	defecation += new_value
	emit_signal("defecation_changed")
	pass

func  _get_resource_defecation():
	return(defecation)	
	
# Central time controls
func _time_change():
	workers.work();
	pass