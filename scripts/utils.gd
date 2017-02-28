# utils.gd - generic utility functions autoloaded
extends Node

func _ready():
	pass

func get_main_node():
	var root_node = get_tree().get_root()
	return root_node.get_child(root_node.get_child_count()-1)
	pass

func create_map(w, h):
    var map = []
    for x in range(w):
        var col = []
        col.resize(h)
        map.append(col)
    return map

func get_random_number(ceiling):
    randomize()
    return rand_range(1,ceiling)

func _jason_to_dic(json):
	var dict = {}
	var file = File.new()
	file.open(json, file.READ)
	var text = file.get_as_text()
	dict.parse_json(text)
	file.close()
	return(dict)