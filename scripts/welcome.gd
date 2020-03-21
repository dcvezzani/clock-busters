extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game = null
var game_over_score = null
var leaderBoard = null
onready var clickSound = get_tree().get_nodes_in_group("Click")[0]
onready var correctSound = get_tree().get_nodes_in_group("Correct")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	loadGame()

func loadGame():
	self.game = global.sceneFactory('game')

func loadScore():
	# self.game_over_score = preload("res://scenes/game_over_score.tscn").instance()
	self.game_over_score = global.sceneFactory('game-over-score')
	
func loadLeaderBoard():	
	self.leaderBoard = global.sceneFactory('leader-board')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	play_click_sound()
	correctSound.play()
	print(">>> you pressed me")
	self.add_game()
	self.loadScore()
	self.loadLeaderBoard()
	hide()
	
func play_click_sound():
	pass

func _on_show_leader_board_game_over():
	print(">>> show leader board")
	self.remove_game()
	self.remove_score()
	self.add_leader_board()
	self.loadGame()
	self.loadScore()
	hide()
	
func _on_show_score_game_over():
	print(">>> show score")
	self.remove_game()
	self.remove_leader_board()
	self.add_score()
	self.loadGame()
	self.loadLeaderBoard()	
	hide()	

func _on_show_welcome_game_over():
	self.remove_score()
	self.remove_leader_board()
	#self.add_game()
	#self.loadScore()	
	show()

func _on_start_new_game_game_over():
	self.remove_score()
	self.remove_leader_board()
	self.add_game()
	self.loadScore()
	self.loadLeaderBoard()	
	hide()

func add_leader_board():
	get_tree().get_root().add_child(self.leaderBoard)
	var leaderBoard = get_tree().get_nodes_in_group("leader-board")[0]
	leaderBoard.connect("goto_welcome", self, "_on_show_welcome_game_over")
	leaderBoard.connect("start_new_game", self, "_on_start_new_game_game_over")	

func getFirstNodeInGroup(groupName):
	if get_tree().get_nodes_in_group(groupName):
		return get_tree().get_nodes_in_group(groupName)[0]
		
func remove_leader_board():
	var leaderBoard = getFirstNodeInGroup("leader-board")
	if leaderBoard:
		leaderBoard.disconnect("goto_welcome", self, "_on_show_welcome_game_over")
		leaderBoard.disconnect("start_new_game", self, "_on_start_new_game_game_over")	
	if self.leaderBoard:
		get_tree().get_root().remove_child(self.leaderBoard)
		self.leaderBoard.queue_free()
		self.leaderBoard = null
		
func add_score():
	get_tree().get_root().add_child(self.game_over_score)
	var gameOverScore = get_tree().get_nodes_in_group("game-over-score")[0]
	gameOverScore.connect("goto_welcome", self, "_on_show_welcome_game_over")
	gameOverScore.connect("start_new_game", self, "_on_start_new_game_game_over")
	gameOverScore.connect("goto_leader_board", self, "_on_show_leader_board_game_over")
	#signal goto_welcome
	#signal start_new_game	

func remove_score():
	var gameOverScore = getFirstNodeInGroup("game-over-score")
	if gameOverScore:
		gameOverScore.disconnect("goto_welcome", self, "_on_show_welcome_game_over")
		gameOverScore.disconnect("start_new_game", self, "_on_start_new_game_game_over")
		gameOverScore.disconnect("goto_leader_board", self, "_on_show_leader_board_game_over")
	if self.game_over_score:
		get_tree().get_root().remove_child(self.game_over_score)
		self.game_over_score.queue_free()
		self.game_over_score = null
	
func add_game():
	get_tree().get_root().add_child(self.game)
	var levelGameplay = get_tree().get_nodes_in_group("level-gameplay")[0]
	levelGameplay.connect("game_over", self, "_on_show_score_game_over")
		
func remove_game():
	var levelGameplay = getFirstNodeInGroup("level-gameplay")
	if levelGameplay:
		levelGameplay.disconnect("game_over", self, "_on_show_score_game_over")	
	if self.game:
		get_tree().get_root().remove_child(self.game)
		self.game.queue_free()
		self.game = null
	
