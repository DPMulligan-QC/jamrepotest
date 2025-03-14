extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED
