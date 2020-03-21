extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _process(delta):
	rotation_degrees = OS.get_time()['minute']*6-90

