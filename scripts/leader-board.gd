extends Node2D

signal goto_welcome
signal start_new_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func loadConnections(sources):
	#sources.gameOverScore.connect("goto_leader_board", self, "on_goto_leader_board")
	pass

func _on_gotowelcome_pressed():
	emit_signal("goto_welcome")


func _on_playagain_pressed():
	emit_signal("start_new_game")


func _on_savehighscore_pressed():
	var initials = $"leader-board-ui/leader-initials-update-01".text
	$"leader-board-ui/leader-initials-update-01".hide()
	$"leader-board-ui/save-highscore".hide()
	
	# END OF GAME
	# pull storage for high scores
	# locate desired entry
	#	given a score, determine if it is in the top 5; if so, 
	#	what position will it be in?
	# if in the top 5, immediately go to leader board after game
	#	open in "edit mode" 
	
	# ON SCORE SAVE
	#	update high score storage
	#	re-render highscores based on storage
	#	switch to "view mode"
	
	$"leader-board-ui/leader-initials-01".text = initials
	$"leader-board-ui/play-again".show()
	$"leader-board-ui/goto-welcome".show()
	
	pass # Replace with function body.
