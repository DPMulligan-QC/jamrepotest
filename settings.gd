extends Control

var helper = SaveGameHelper.new()
var data= helper.load_game()

var dataLoaded: bool = false

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
			$MasterVolume.value = data.volumeScaleMaster
			$SFXVolume.value = data.volumeScaleSFX
			$MusicVolume.value = data.volumeScaleMusic
		else:
			$FullscreenButton.button_pressed = false
	else:
		data = SaveData.new()
		helper.save_game(data)
		
	dataLoaded = true

func _on_master_volume_value_changed(value: float) -> void:
	if dataLoaded:
		AudioServer.set_bus_volume_linear(0, linear_to_db(value))
		data.volumeScaleMaster = value
		

func _on_sfx_volume_value_changed(value: float) -> void:
	if dataLoaded:
		AudioServer.set_bus_volume_linear(1, linear_to_db(value))
		data.volumeScaleSFX = value
		

func _on_music_volume_value_changed(value: float) -> void:
	if dataLoaded:
		AudioServer.set_bus_volume_linear(2, linear_to_db(value))
		data.volumeScaleMusic = value
		
