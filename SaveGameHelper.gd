extends Resource
class_name SaveGameHelper

const save_path := "user://savedata.tres"


func save_game(save_data: Resource):
	var data = ResourceSaver.save(save_data, save_path)
	
	if data != OK:
		print("Error Saving Game: " + data)
 
func load_game():
	var loaded_data = ResourceLoader.load(save_path)
	
	if loaded_data != null and loaded_data is Resource:
		return loaded_data
	
	else:
		print("Error loading game")
		return null
