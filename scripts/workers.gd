# workers.gd - worker functions
extends Node

func _ready():
	pass
	
func work():
	if (game._get_priority_fishing()) > 0: fish();
	
func fish():
 # Fish and determine loot
	var fish = resources._get_fish();
	#print(fish.name)