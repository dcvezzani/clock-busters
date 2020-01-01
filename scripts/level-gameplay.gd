extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	create_clocks()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_clocks():
	var scene = load("res://scenes/clocks-formation-01.tscn")
	var clocks = scene.instance()
#      scene_instance.set_name("scene")
	clocks.position = Vector2(0,0)
	self.add_child(clocks)
	