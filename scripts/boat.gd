extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass


func _add_module(body, x, y):
	
	var boat = preload("res://scenes/boat.tscn").instance()
	
	var shape = RigidBody2D.new()
	shape.set_pos(Vector2(x,y))
	#shape.set_extents(Vector2(16,16))
	
	var sprite = Sprite.new()
	sprite.set_texture(load("res://sprites/boatModule.png"))
	sprite.set_offset(Vector2(x,y))
	
	var matrix = Matrix32(Vector2(0,1),Vector2(1,0),Vector2(x,y))
	
	body.add_shape(shape, matrix)
	body.add_child(boat)
	