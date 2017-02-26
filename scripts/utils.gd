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