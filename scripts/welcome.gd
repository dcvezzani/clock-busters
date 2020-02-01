extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game = null
var game_over_score = null

# Called when the node enters the scene tree for the first time.
func _ready():
	loadGame()

func loadGame():
	self.game = preload("res://scenes/level.tscn").instance()

func loadScore():
	self.game_over_score = preload("res://scenes/game_over_score.tscn").instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	print(">>> you pressed me")
	self.add_game()
	self.loadScore()
	hide()

func _on_show_score_game_over():
	print(">>> show score")
	self.remove_game()
	self.add_score()
	self.loadGame()
	hide()

func _on_show_welcome_game_over():
	self.remove_score()
	self.add_game()
	self.loadScore()	
	show()

func add_score():
	get_tree().get_root().add_child(self.game_over_score)
	var gameOverScore = get_tree().get_nodes_in_group("game-over-score")[0]
	gameOverScore.connect("goto_welcome", self, "_on_show_welcome_game_over")
	#signal goto_welcome
	#signal start_new_game	

func remove_score():
	var levelGameplay = get_tree().get_nodes_in_group("game-over-score")[0]
	levelGameplay.disconnect("goto_welcome", self, "_on_show_welcome_game_over")	
	get_tree().get_root().remove_child(self.game_over_score)
	self.game_over_score.queue_free()
	
func add_game():
	get_tree().get_root().add_child(self.game)
	var levelGameplay = get_tree().get_nodes_in_group("level-gameplay")[0]
	levelGameplay.connect("game_over", self, "_on_show_score_game_over")
		
func remove_game():
	var levelGameplay = get_tree().get_nodes_in_group("level-gameplay")[0]
	levelGameplay.disconnect("game_over", self, "_on_show_score_game_over")	
	get_tree().get_root().remove_child(self.game)
	self.game.queue_free()
	