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
	self.scenes.leaderBoard = preload("res://scenes/leader-board.tscn").instance()
	
func sceneFactory (sceneLabel):
	match sceneLabel:
		'game-over-score':
			return  preload("res://scenes/game_over_score.tscn").instance()
		'leader-board':
			return  preload("res://scenes/leader-board.tscn").instance()
		'welcome':
			return  preload("res://scenes/welcome.tscn").instance()
		'game':
			return  preload("res://scenes/level.tscn").instance()
	# self.scenes.game_over = preload("res://scenes/game_over.tscn").instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
