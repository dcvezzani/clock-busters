extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_time = null
var available_times = []
var available_hours = [1,2,3,4,5,6,7,8,9,10,11,12]
var available_minutes = [0.0, 0.25, 0.5, 0.75]
var score = 0
var max_times = 10
var rng = RandomNumberGenerator.new()
var clocks = null

func shuffleList(list):
    var shuffledList = [] 
    var indexList = range(list.size())
    for i in range(min(list.size(), max_times)):
        var x = randi()%indexList.size()
        shuffledList.append(list[indexList[x]] + rand_minute())
        indexList.remove(x)
    return shuffledList

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()	
	var score = get_tree().get_nodes_in_group("score")[0]
	score.text = str(self.score)
	start_clocks()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_clocks():
	available_times = shuffleList(available_hours)
	var clock_value = get_tree().get_nodes_in_group("clock-value")[0]
	current_time = available_times[0]
	clock_value.text = str("%2.2f" % current_time)
	clocks = create_clocks()	

func rand_minute():
	var random_minute_idx = rng.randi_range(0, available_minutes.size()-1)
	return available_minutes[random_minute_idx]

func create_clocks():
	var scene = load("res://scenes/clocks-formation-01.tscn")
	var clocks = scene.instance()
#      scene_instance.set_name("scene")
	clocks.position = Vector2(0,0)
	var clock_instances = clocks.get_children()
	for clock in clock_instances:
		clock.set_time(available_times.pop_front())
	self.add_child(clocks)
	return clocks
	
func kill_clock(clock):
	if clock.time == current_time:
		self.score += 10
		clocks.queue_free()
		start_clocks()
	else:
		self.score -= 5
		
	var score = get_tree().get_nodes_in_group("score")[0]
	score.text = str(self.score)
