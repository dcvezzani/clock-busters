extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_time = null
var available_times = [1,2,3,4,5,6,7,8,9,10]
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var score = get_tree().get_nodes_in_group("score")[0]
	score.text = str(self.score)
	
	var clock_value = get_tree().get_nodes_in_group("clock-value")[0]
	current_time = available_times[0]
	clock_value.text = str(current_time)
	create_clocks()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_clocks():
	var scene = load("res://scenes/clocks-formation-01.tscn")
	var clocks = scene.instance()
#      scene_instance.set_name("scene")
	clocks.position = Vector2(0,0)
	var clock_instances = clocks.get_children()
	for clock in clock_instances:
		clock.set_time(available_times.pop_front())
	self.add_child(clocks)
	
func kill_clock(clock):
	if clock.time == current_time:
		self.score += 10
		clock.queue_free()
	else:
		self.score -= 5
		
	var score = get_tree().get_nodes_in_group("score")[0]
	score.text = str(self.score)
