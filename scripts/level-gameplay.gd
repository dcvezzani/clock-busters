extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal game_over

# export (String,FILE) var clockFormation1 = null

var current_time = null
var available_times = []
var available_hours = [1,2,3,4,5,6,7,8,9,10,11,12]
var available_minutes = [0.0, 0.25, 0.5, 0.75]
var score = 0
var countDownMax = 90
var countDown = countDownMax
var rng = RandomNumberGenerator.new()
var clocks = null
var max_times = 6

onready var clock_formations = [
  "res://scenes/clocks-formation-01.tscn",
  "res://scenes/clocks-formation-02.tscn",
  "res://scenes/clocks-formation-03.tscn",
  "res://scenes/clocks-formation-04.tscn",
  "res://scenes/clocks-formation-05.tscn",
  "res://scenes/clocks-formation-06.tscn",
  "res://scenes/clocks-formation-07.tscn",
  "res://scenes/clocks-formation-08.tscn",
  "res://scenes/clocks-formation-09.tscn",
  "res://scenes/clocks-formation-10.tscn"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()	
	var score = get_tree().get_nodes_in_group("score")[0]
	score.text = str(self.score)
	create_clocks()
	
func _on_clock_clicked(clock):
	kill_clock(clock)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var value = self.countDown - delta
	if value > 0:
		if value < 0:
			value = 0
		update_count_down(value)
	else:
		update_count_down(0)
		print(">>>emitting game over")
		# update_score(-15)
		# self.create_clocks()
		emit_signal("game_over")
		# queue_free()
		# goto_welcome_page()

func goto_welcome_page():
	var welcome = load("res://scenes/welcome.tscn").instance()
	get_tree().get_root().add_child(welcome)
	hide()

func shuffleList(list):
    var shuffledList = [] 
    var indexList = range(list.size())
    for i in range(min(list.size(), max_times)):
        var x = randi()%indexList.size()
        shuffledList.append(list[indexList[x]] + rand_minute())
        indexList.remove(x)
    return shuffledList
	
func create_clocks():
	if clocks:
		delete_clocks()
		
	# reset_count_down()
	available_times = shuffleList(available_hours)
	# current_time = available_times[0]
	var results = render_clocks()
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
	clock_value.text = format_time(time)
	
func rand_minute():
	var random_minute_idx = rng.randi_range(0, available_minutes.size()-1)
	return available_minutes[random_minute_idx]

func get_clock_formation_clocks(clocks):
	var _clocks = get_tree().get_nodes_in_group("clock")
	return _clocks

func delete_clocks():
	if clocks:
		var clock_instances = get_clock_formation_clocks(clocks)
		for clock in clock_instances:
			clock.disconnect("clock_clicked", self, "_on_clock_clicked")
			clock.remove_from_group("clock")
		clocks.queue_free()
		clocks = null

func init_clocks(clocks):
	var viewportHeight = get_viewport().get_visible_rect().size.y	
	clocks.position = Vector2(0,(-1) * viewportHeight)

func render_clocks():
	var viewportHeight = get_viewport().get_visible_rect().size.y
	var viewportWidth = get_viewport().get_visible_rect().size.x
	
	var random_clock_formation_idx = rng.randi_range(0, clock_formations.size()-1)	
	var clock_formation = clock_formations[random_clock_formation_idx]
		
	var scene = load(clock_formation)
	var clocks = scene.instance()
	
	# init_clocks(clocks)
	
	self.add_child(clocks)
	
	var clock_instances = get_clock_formation_clocks(clocks)
	var random_clock_idx = rng.randi_range(0, max_times-1)
	var cnt = 0
	var target_time = null
	for clock in clock_instances:
		if (cnt < max_times):
			clock.connect("clock_clicked", self, "_on_clock_clicked")
			var next_time = available_times.pop_front()
			# print_debug(">>>cnt: ", [cnt, next_time, available_times.size()])
			clock.set_time(next_time)
			if cnt == random_clock_idx:
				target_time = next_time
		cnt += 1
		
	return {"clocks": clocks, "current_time": target_time}
	
func kill_clock(clock):
	# print_debug(">>>clock.time: ", clock.time)
	if clock.time == current_time:
		update_score(10)
		clocks.withdraw(self)
	else:
		update_score(-5)

func on_clocks_withdrawn():
	create_clocks()

func update_score(amt):
	var score = get_tree().get_nodes_in_group("score")[0]
	self.score += amt
	score.text = str(self.score)

func reset_count_down():
	self.countDown = self.countDownMax

func update_count_down(value):
	var countDown = get_tree().get_nodes_in_group("clock-countdown")[0]
	self.countDown = value
	countDown.text = str(ceil(self.countDown))
