# person.gd - world script
extends RigidBody2D

func _ready():
	#self.set_pos(Vector2(512,381.9))
	game._set_population(game._get_population() + 1)
