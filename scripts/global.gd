extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scenes = {
	"game": null, 
	"welcome": null, 
	"game_over": null
}

# Called when the node enters the scene tree for the first time.
func _ready():
 	self.scenes.game = preload("res://scenes/level.tscn").instance()
 	self.scenes.welcome = preload("res://scenes/welcome.tscn").instance()
 	# self.scenes.game_over = preload("res://scenes/game_over.tscn").instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
