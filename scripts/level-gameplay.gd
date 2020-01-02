extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_time = null
var available_times = []
var available_hours = [1,2,3,4,5,6,7,8,9,10,11,12]
var available_minutes = [0.0, 0.25, 0.5, 0.75]
var score = 0
var rng = RandomNumberGenerator.new()
var clocks = null
var active_clock_instance_cnt = 0

var max_times = 10
var clock_formation = "res://scenes/clocks-formation-01.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()	
	var score = get_tree().get_nodes_in_group("score")[0]
	score.text = str(self.score)
	start_clocks()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func shuffleList(list):
    var shuffledList = [] 
    var indexList = range(list.size())
    for i in range(min(list.size(), max_times)):
        var x = randi()%indexList.size()
        shuffledList.append(list[indexList[x]] + rand_minute())
        indexList.remove(x)
    return shuffledList
func start_clocks():
	if clocks:
		clocks.queue_free()
	active_clock_instance_cnt = 0
	available_times = shuffleList(available_hours)
	# current_time = available_times[0]
	var results = create_clocks()
	clocks = results.clocks
	update_current_time(results.current_time)

func format_time(time):
	var hour = floor(time)
	var hour_fraction = time - hour
	var minutes = 60 * hour_fraction
	return str(hour) + ":" + str("%02d" % minutes)

func update_current_time(time):
	current_time = time
	var clock_value = get_tree().get_nodes_in_group("clock-value")[0]
	#clock_value.text = str("%2.2f" % time)
	clock_value.text = format_time(time)
	
func rand_minute():
	var random_minute_idx = rng.randi_range(0, available_minutes.size()-1)
	return available_minutes[random_minute_idx]

func create_clocks():
	var viewportHeight = get_viewport().get_visible_rect().size.y
	var viewportWidth = get_viewport().get_visible_rect().size.x
		
	var scene = load(clock_formation)
	var clocks = scene.instance()
#      scene_instance.set_name("scene")
	clocks.position = Vector2(0,(-1) * viewportHeight)
	var clock_instances = clocks.get_children()
	var random_clock_idx = rng.randi_range(0, max_times-1)
	var cnt = 0
	var target_time = null
	for clock in clock_instances:
		var next_time = available_times.pop_front()
		clock.set_time(next_time)
		if cnt == random_clock_idx:
			target_time = next_time
		cnt += 1
		active_clock_instance_cnt += 1
		
	self.add_child(clocks)
	return {"clocks": clocks, "current_time": target_time}
	
func die_clock(clock):	
	active_clock_instance_cnt -= 1
	# print("die_clock: " + str(active_clock_instance_cnt))
	if active_clock_instance_cnt <= 0:
		update_score(-15)
		start_clocks()
	clock.queue_free()	
	
func kill_clock(clock):
	if clock.time == current_time:
		active_clock_instance_cnt -= 1		
		update_score(10)
		start_clocks()
	else:
		update_score(-5)

func update_score(amt):
	var score = get_tree().get_nodes_in_group("score")[0]
	self.score += amt
	score.text = str(self.score)