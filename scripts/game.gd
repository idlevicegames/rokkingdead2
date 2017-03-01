# game.gd - core game scripts
extends Node

# Determine debugging level - default 2
export(bool) var DEBUG = true

## Core game variables
export(int) var elapsed setget _set_elapsed, _get_elapsed
export(int) var population = 0 setget _set_population, _get_population
signal elapsed_changed
signal population_changed

# Global (earth) environment conditions

export(float) var oceanBioDiversity = 100.00 #setget _set_oceanBioDiversity, _get_oceanBioDiversity
export(float) var oceanIce = 100.00 #setget _set_oceanIce, _get_oceanIce
export(float) var oceanToxicity = 0.00 #setget _set_oceanToxicity, _get_oceanToxicity
export(float) var oceanTemperature = 0.00 #setget _set_oceanTemperature, _get_oceanTemperature
export(float) var oceanLevel = 0.00 #setget _set_oceanLevel, _get_oceanLevel 
export(float) var airTemp = 0.00 #setget _set_airTemp, _get_airTemp


signal oceanTemperature_changed
signal airTemp_changed
signal oceanIce_changed
signal oceanLevel_changed
signal oceanToxicity_changed
signal oceanBioDiversity_changed


# Priorities
export(int) var priority_fishing = 50 setget _set_priority_fishing, _get_priority_fishing

export(int) var priority_defecating = 50 setget _set_priority_defecating, _get_priority_defecating

export(int) var priority_scrapping = 100 setget _set_priority_scrapping, _get_priority_scrapping
export(int) var priority_refining = 0  setget _set_priority_refining, _get_priority_refining
export(int) var priority_crafting = 0 setget _set_priority_crafting, _get_priority_crafting

signal priority_fishing_changed
signal priority_scrapping_changed
signal priority_defecating_changed
signal priority_refining_changed
signal priority_crafting_changed


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
	
func _set_priority_refining(new_value):
	priority_refining = new_value
	emit_signal("priority_refining_changed")
	pass

func  _get_priority_refining():
	return(priority_refining)

func _set_priority_crafting(new_value):
	priority_crafting = new_value
	emit_signal("priority_crafting_changed")
	pass

func  _get_priority_crafting():
	return(priority_crafting)


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
	
	
# Environmental impacts

func _set_oceanBioDiversity(new_value):
	oceanBioDiversity += new_value
	emit_signal("oceanBioDiversity_changed")
	pass
func  _get_oceanBioDiversity():
	return(oceanBioDiversity)	
	
func _set_oceanIce(new_value):
	oceanIce += new_value
	emit_signal("oceanIce_changed")
	pass
func  _get_oceanIce():
	return(oceanIce)	

func _set_oceanToxicity(new_value):
	oceanToxicity += new_value
	emit_signal("oceanToxicity_changed")
	pass
func  _get_oceanToxicity():
	return(oceanToxicity)	
	
func _set_oceanTemperature(new_value):
	oceanTemperature += new_value
	emit_signal("oceanTemperature_changed")
	pass
func  _get_oceanTemperature():
	return(oceanTemperature)	

func _set_oceanLevel(new_value):
	oceanLevel += new_value
	emit_signal("oceanLevel_changed")
	pass
func  _get_oceanLevel():
	return(oceanLevel)	

func _set_airTemp(new_value):
	airTemp += new_value
	emit_signal("airTemp_changed")
	pass
func  _get_airTemp():
	return(airTemp)	

# Central time controls
func _time_change():
	workers.work();
	pass
	