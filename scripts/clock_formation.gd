extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var withdrawSpeed = 10
var isWithdrawing = false
var withdrawAmount = 500
var clockController = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func withdraw(objIn):
	isWithdrawing = true
	clockController = objIn
	
func _process(delta):
	if isWithdrawing == true:
		position.y-= withdrawSpeed
		if position.y < - withdrawAmount:
			clockController.on_clocks_withdrawn()
