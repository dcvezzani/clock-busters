extends Area2D

signal clock_clicked

var time = null

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var viewportHeight = get_viewport().get_visible_rect().size.y
#	var viewportWidth = get_viewport().get_visible_rect().size.x
#	var spriteHeight = $clockFace.get_rect().size.y
#	# print("clock off the board?: " + str(global_position.y) + ", " + str(viewportHeight + spriteHeight/2))
#
#	if global_position.y > (viewportHeight + spriteHeight/4):
#		get_parent().get_parent().kill_clock(self)

func _on_clock_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		# print_debug(">>>clicked: ", self.time)
		if event.button_index == BUTTON_LEFT && event.pressed:
			# print("mouse button click detected")
			emit_signal("clock_clicked", self)

func set_time(time):
	# print_debug(">>>setting time: ", time, ", ", $clockHands)
	self.time = time
	$time.text = str(time)
	$clockHands.updateHands(time * 1.0)