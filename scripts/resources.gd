# resources.gd Parameters and functions concerning resources
extends Node


#Max probability

const MAX_PROBABILITY = 1000
var   FISH_PROBABILITY = 0.00
var   FISH_MODIFIER = 1

var   POOP_PROBABILITY = 100
var   POOP_MODIFIER = 0.1
#
# Type                 Probability  Cumulative
# ----                 -----------  ----------
# Large Trash            10            10              (0..9 yield large trash)
# Medium Trash           40            50    (10+40)   (10..40 yield medium trash)
# Small Trash            50           100    (50+50)
#
var resources = {}

const resource_file = "res://data/resource_table.json"

func _ready():
	#get_node("/root/game").connect("priority_fishing_changed", self, "_calc_fish_probability")	
	populate_loot_tables()
	pass

func _calc_fish_probability():
	var priority = game._get_priority_fishing()
	if priority != 0 :
		FISH_PROBABILITY = MAX_PROBABILITY / (game._get_priority_fishing()/100.00)
		#print("Max fish prob: " + str(FISH_PROBABILITY))

func populate_loot_tables():
	# Fish	
	resources = utils._jason_to_dic(resource_file)
	#print(resources.size())
	#print("Fish dictionary size: " + str(resources.fish.size()))
	

func _get_fish():
	_calc_fish_probability()
	#print("Max fish prob: " + str(FISH_PROBABILITY))
	var catch = utils.get_random_number(FISH_PROBABILITY);
	for i in range(resources.fish.size()):		
		if (catch > resources.fish[i].drop) && (catch < float(resources.fish[i].rate)) :
			#print(str(catch))
			if resources.fish[i].id == 1: 
				#print(str(catch))
				game._set_resource_large_trash(1 * FISH_MODIFIER)
				pass
			if resources.fish[i].id == 2: 
				#print(str(catch))
				game._set_resource_medium_trash(1 * FISH_MODIFIER)
				pass
			if resources.fish[i].id == 3:
				#print(str(catch))
				game._set_resource_small_trash(1 * FISH_MODIFIER)
				pass				
			return(resources.fish[i])
			
func _get_poop():
	var poopChance = utils.get_random_number(POOP_PROBABILITY);
	var poop = 0;
	
	for i in range(resources.poop.size()):		
		if (poopChance > float(resources.poop[i].drop)) && (poopChance < float(resources.poop[i].rate)) :
					
			if resources.poop[i].id == 1: 
				poop = 1;
				pass		
			
		poop = poop * (game._get_priority_defecating() * POOP_MODIFIER)
		game._set_resource_defecation(poop)
		return(poop)
	