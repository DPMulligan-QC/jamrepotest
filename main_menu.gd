extends Control

var data = SaveData.new()
var helper = SaveGameHelper.new()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://DaGame.tscn")




func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Settings.tscn")




func _on_quit_pressed() -> void:
	get_tree().quit()




func ready() -> void:
	data= helper.load_game()
	if data:
		if(data.isFullscreen):
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED
	else:
		data = SaveData.new()
		helper.save_game(data)
