extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var withdrawSpeed = 10
var isWithdrawing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func withdraw():
	isWithdrawing = true
	
func _process(delta):
	position.y-= withdrawSpeed