# workers.gd - worker functions
extends Node

func _ready():
	pass
	
func work():
	if (game._get_priority_fishing()) > 0: fish();
	# Always poop, doesn't matter if it's a big priority!
	defecate();
	
func fish():
 # Fish and determine loot
	var fish = resources._get_fish();
	#print(fish.name)

func defecate():
# Poop
	var amount = resources._get_poop();
	