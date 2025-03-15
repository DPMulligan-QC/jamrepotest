extends Control


var manager = GameManager.new()

var data: SaveData

var dataLoaded: bool = false #This flag is set to true after the widgets are set accurately

func _on_button_pressed() -> void:
	manager.save_game()
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	if dataLoaded:
		if(toggled_on):
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
			data.isFullscreen = true
		else:
			get_window().mode = Window.MODE_WINDOWED
			data.isFullscreen = false;


func _on_vsync_button_toggled(toggled_on: bool) -> void:
	if dataLoaded:
		if toggled_on:
			data.isVSync = true
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		else:
			data.isVSync = false
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)



func _ready():
	manager.load_data(false)
	data = manager.get_data()
	
	if data:  #DATA LOADED AND FOUND, SET WIDGET STATUS ACCORDINGLY
		
		$MasterVolume.value = data.volumeScaleMaster
		$SFXVolume.value = data.volumeScaleSFX
		$MusicVolume.value = data.volumeScaleMusic
		
		if(data.isFullscreen):
			$FullscreenButton.button_pressed =true
		else:
			$FullscreenButton.button_pressed = false
		if data.isVSync:
			$VsyncButton.button_pressed = true
		else:
			$VsyncButton.button_pressed = false	
			
	else: # DATA NOT FOUND, SOMEHOW
		print("FILE SOMEHOW NOT FOUND DAWG WHAT THE HELL ")
		
	for i in data.resolutionsList:
		$ResolutionOptionButton.add_item(i)
		
	$ResolutionOptionButton.selected = data.resolutionsList.keys().find(data.resolutionString)
		
	dataLoaded = true #FINISHED LOADING FLAG

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
		


func _on_resolution_option_button_item_selected(index: int) -> void:
	if dataLoaded:
		var key = $ResolutionOptionButton.get_item_text(index)
		data.resolutionString = key
		data.resolution = data.resolutionsList[key]
		get_window().set_size(data.resolutionsList[key])
		
