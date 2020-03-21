extends Node2D

signal goto_welcome
signal start_new_game
signal goto_leader_board

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_gotowelcome_pressed():
	emit_signal("goto_welcome")


func _on_playagain_pressed():
	emit_signal("start_new_game")


func _on_highscores_pressed():
	emit_signal("goto_leader_board")
