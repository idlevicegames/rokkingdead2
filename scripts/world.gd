# world.gd - world script
extends Node

# Timer to keep track of world time
var timer

func _ready():
	var player = preload("res://scenes/person.tscn").instance()
	get_node(".").add_child(player)
	
	var hud = preload("res://scenes/hud.tscn").instance()
	get_node(".").add_child(hud)
	
	_start_time()
	self.set_process(true)
	game._start_debug()

	
func _start_time():
	timer = get_node("timer")
	timer.set_wait_time(1)
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()

func _stop_time():
	timer.stop();

func _process(delta):
	pass

func _on_Timer_timeout():
	game._set_elapsed(game._get_elapsed() + 1)
	timer.start()
