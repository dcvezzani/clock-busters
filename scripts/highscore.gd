extends Node

# currently saves a single score
# create a new script that saves the top 5 scores, but continues
#	to track the top most score as it does now
# consider using JSON; https://godotengine.org/qa/8291/how-to-parse-a-json-file-i-wrote-myself

# var text_json = "{\"error\": false, \"data\": {\"player_id\": 1}}"
# var result_json = JSON.parse(text_json)
# var result = {}
# 
# if result_json.error == OK:  # If parse OK
#     var data = result_json.result
#     print(data)
# else:  # If parse has errors
#     print("Error: ", result_json.error)
#     print("Error Line: ", result_json.error_line)
#     print("Error String: ", result_json.error_string)
# 

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
