extends Node2D

# Declare member variables here. Examples:
# var a = 2
var animate = randf()*10
var wiggleAmount = 1
var chainHeight = 313
var numChains = 8
var startY
var _position_y = 0
var _position_x = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	_position_y = -500
	_position_x = position.x
	startY = position.y-chainHeight*numChains*scale.y

func _process(delta):
	visible = true
	animate += delta*7
	wiggleAmount *= 0.98
	position.x = _position_x + 20*wiggleAmount*sin(animate)
	_position_y += 10*wiggleAmount*sin(animate)
	_position_y *= 0.8
	position.y = _position_y + startY


	
