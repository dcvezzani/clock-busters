extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	rotation_degrees = OS.get_time()['hour']*30-90+OS.get_time()['minute']/2
