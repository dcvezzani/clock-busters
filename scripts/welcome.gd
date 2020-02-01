extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game = null

# Called when the node enters the scene tree for the first time.
func _ready():
	loadGame()

func loadGame():
	self.game = preload("res://scenes/level.tscn").instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	print(">>> you pressed me")
	get_tree().get_root().add_child(self.game)
	var levelGameplay = get_tree().get_nodes_in_group("level-gameplay")[0]
	levelGameplay.connect("game_over", self, "_on_welcome_game_over")
	hide()

func _on_welcome_game_over():
	print(">>>the game is over")
	
	var levelGameplay = get_tree().get_nodes_in_group("level-gameplay")[0]
	levelGameplay.disconnect("game_over", self, "_on_welcome_game_over")	
	get_tree().get_root().remove_child(self.game)
	#print("child count " + str(get_tree().get_root().get_child_count()))
	#for child in get_tree().get_root().get_children():
	#	get_tree().get_root().remove_child(child)
	#self.game.hide()
	self.game.queue_free()
	loadGame()
	show()