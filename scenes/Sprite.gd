extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var prevPosition = null
var actualRotation_degrees = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if prevPosition != null:
		#var rotationShift = -(rotation_degrees) + global_rotation_degrees
		var changeAmount = (actualRotation_degrees + (global_position - prevPosition).x*20)/2-actualRotation_degrees
		actualRotation_degrees += changeAmount/10
		actualRotation_degrees *= 0.9
		rotation_degrees = rotation_degrees-global_rotation_degrees + actualRotation_degrees
	
	prevPosition = global_position

