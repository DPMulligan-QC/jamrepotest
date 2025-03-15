extends Control

var helper = SaveGameHelper.new()
var data= helper.load_game()

func _on_button_pressed() -> void:
	helper.save_game(data)
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		data.isFullscreen = true
	else:
		get_window().mode = Window.MODE_WINDOWED
		data.isFullscreen = false;


func _ready():
	if data:
		if(data.isFullscreen):
			$FullscreenButton.button_pressed =true
		else:
			$FullscreenButton.button_pressed = false
	else:
		data = SaveData.new()
		helper.save_game(data)
