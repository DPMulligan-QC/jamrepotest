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
		AudioServer.set_bus_volume_linear(0, linear_to_db(data.volumeScaleMaster))
		AudioServer.set_bus_volume_linear(1, linear_to_db(data.volumeScaleSFX))
		AudioServer.set_bus_volume_linear(2, linear_to_db(data.volumeScaleMusic))
	else:
		data = SaveData.new()
		helper.save_game(data)
