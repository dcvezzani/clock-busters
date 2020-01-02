extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_clock_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			print("mouse button click detected")
			get_parent().get_parent().kill_clock(self)

func set_time(time):
	self.time = time
	$time.text = str(time)
	$clockHands.updateHands(time * 1.0)