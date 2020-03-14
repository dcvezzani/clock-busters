extends Node

signal update_highscore

var highscore = 0 setget set_highscore
const filepath = "user://highscore.data"

func _ready():
	load_highscore()
	pass
	
func load_highscore():
	var file = File.new()
	if not file.file_exists(filepath): return
	file.open(filepath, File.READ)
	highscore = file.get_var()
	file.close()
	pass

func save_highscore():
	var file = File.new()
	file.open(filepath, File.WRITE)	
	file.store_var(highscore)
	file.close()
	pass
	
func set_highscore(new_value):
	print(">>>trace 2: " + str(new_value))
	highscore = new_value
	emit_signal("update_highscore")
	pass
