extends Control


var manager  = GameManager.new()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://DaGame.tscn")




func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Settings.tscn")




func _on_quit_pressed() -> void:
	get_tree().quit()




func ready() -> void:
	manager.load_data(true)
