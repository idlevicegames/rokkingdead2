# resources.gd Parameters and functions concerning resources
extends Node

#Max probability
const MAX_PROBABILITY = 1000
var   FISH_PROBABILITY = 0.00
#
# Type                 Probability  Cumulative
# ----                 -----------  ----------
# Large Trash            10            10              (0..9 yield large trash)
# Medium Trash           40            50    (10+40)   (10..40 yield medium trash)
# Small Trash            50           100    (50+50)
#
var fish  = Dictionary()

func _ready():
	get_node("/root/game").connect("priority_fishing_changed", self, "_calc_fish_probability")	
	populate_loot_tables()
	pass

func _calc_fish_probability():
	var priority = game._get_priority_fishing()
	if priority != 0 :
		FISH_PROBABILITY = MAX_PROBABILITY / (game._get_priority_fishing()/100.00)
		#print("Max fish prob: " + str(FISH_PROBABILITY))

func populate_loot_tables():
	# Fish

	fish[1] = {"id" : 1 ,"name": "Large Trash",  "drop":   0,  "rate":     10}
	fish[2] = {"id" : 2 ,"name": "Medium Trash", "drop":  40,  "rate":     50} 
	fish[3] = {"id" : 3 ,"name": "Small Trash",  "drop":  50,  "rate":    100} 
	fish[0] = {"id" : 0 ,"name": "Nothing",      "drop":  100, "rate":   999999} 
	#print("Fish dictionary size: " + str(fish.size()))

func _get_fish():
	#print("Max fish prob: " + str(FISH_PROBABILITY))
	var catch = utils.get_random_number(FISH_PROBABILITY);
	for i in fish.keys():
		if (catch > fish[i].drop) && (catch < fish[i].rate) :
					
			if fish[i].id == 1: 
				print(str(catch))
				game._set_resource_large_trash(game._get_resource_large_trash() + 1)
				pass
			if fish[i].id == 2: 
				print(str(catch))
				game._set_resource_medium_trash(game._get_resource_medium_trash() + 1)
				pass
			if fish[i].id == 3:
				print(str(catch))
				game._set_resource_small_trash(game._get_resource_small_trash() + 1)
				pass
				
			return(fish[i])