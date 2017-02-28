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
export(int) var priority_fishing = 30 setget _set_priority_fishing, _get_priority_fishing
export(int) var priority_scrapping = 30 setget _set_priority_scrapping, _get_priority_scrapping
export(int) var priority_defecating = 40 setget _set_priority_defecating, _get_priority_defecating

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
	
#	
#Greedy Algorithm
#
#When a slider moves up (down), all others need to move down (up). Each one has some space it can move (for down - their position, for up: 100-position).
#
#So when one slider moves, take the other sliders, sort them by the space they can move, and simply iterate through them.
#
#On each iteration, move the slider in the needed direction by (total to move left / sliders left in queue) or the distance it can move, whichever is smaller.
#
#This is linear in complexity (since you can use the same ordered queue over and over, once it has been sorted).
#
#In this scenario, no sliders get stuck, all try to move as much as they can, but only up to their fair share.
#
#Weighted move
#
#A different approach would be to weight the move they need to do. I think this is what you tried to do, judging by your "sliders get stuck at 0" statement. IMHO this is more natural, you just need to do more tweaking.
#
#Speculating again, I would say you try to weight the moves of different sliders by their position (This would directly translate to your stuck at 0 problem). However note that you can view the slider position from different directions - from the start or from the end. If you weight by position from start when decreasing and position from end when increasing, you should avoid your problem.
#
#This is quite similar in terminology to the previous part - don't weight the move to make by the position of the sliders, weight it by the space they have left to move in that direction.
#	