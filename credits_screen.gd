extends Control






func _on_button_pressed() -> void:
	if GlobalManager.is_in_game==false || !GlobalManager.data || GlobalManager.data.sceneName == "":
		get_tree().change_scene_to_file("res://main_menu.tscn")
	else:
		get_tree().change_scene_to_file(GlobalManager.data.sceneName)
