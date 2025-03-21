extends Control

<<<<<<< Updated upstream
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
=======
var dataLoaded: bool = false #This flag is set to true after the widgets are set accurately

func _on_button_pressed() -> void:
	GlobalManager.save_game()
	
	if GlobalManager.is_in_game == false:
		get_tree().change_scene_to_file("res://main_menu.tscn")
	elif GlobalManager.data == null or GlobalManager.data.sceneName == "":
		get_tree().change_scene_to_file("res://main_menu.tscn")
	else:
		get_tree().change_scene_to_file(GlobalManager.data.sceneName)


func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	if dataLoaded:
		if(toggled_on):
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
			#GlobalManager.data.isFullscreen = true
		else:
			get_window().mode = Window.MODE_WINDOWED
			#GlobalManager.data.isFullscreen = false;


func _on_vsync_button_toggled(toggled_on: bool) -> void:
	if dataLoaded:
		if toggled_on:
			GlobalManager.data.isVSync = true
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		else:
			GlobalManager.data.isVSync = false
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
>>>>>>> Stashed changes



func _ready():
<<<<<<< Updated upstream
	if data:
		if(data.isFullscreen):
=======
	
	if GlobalManager.data:  #DATA LOADED AND FOUND, SET WIDGET STATUS ACCORDINGLY
		
		$MasterVolume.value = GlobalManager.data.volumeScaleMaster
		$SFXVolume.value = GlobalManager.data.volumeScaleSFX
		$MusicVolume.value = GlobalManager.data.volumeScaleMusic
		
		if(get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN):
>>>>>>> Stashed changes
			$FullscreenButton.button_pressed =true
			$MasterVolume.value = data.volumeScaleMaster
			$SFXVolume.value = data.volumeScaleSFX
			$MusicVolume.value = data.volumeScaleMusic
		else:
			$FullscreenButton.button_pressed = false
<<<<<<< Updated upstream
	else:
		data = SaveData.new()
		helper.save_game(data)
		
	dataLoaded = true
=======
		if GlobalManager.data.isVSync:
			$VsyncButton.button_pressed = true
		else:
			$VsyncButton.button_pressed = false	
			
		for i in GlobalManager.data.resolutionsList:
			$ResolutionOptionButton.add_item(i)
		
		$ResolutionOptionButton.selected = GlobalManager.data.resolutionsList.keys().find(GlobalManager.data.resolutionString)
			
	else: # DATA NOT FOUND, SOMEHOW
		print("FILE SOMEHOW NOT FOUND DAWG WHAT THE HELL ")
		

		
	dataLoaded = true #FINISHED LOADING FLAG
>>>>>>> Stashed changes

func _on_master_volume_value_changed(value: float) -> void:
	if dataLoaded:
		AudioServer.set_bus_volume_linear(0, value)
		GlobalManager.data.volumeScaleMaster = value
		

func _on_sfx_volume_value_changed(value: float) -> void:
	if dataLoaded:
		AudioServer.set_bus_volume_linear(1, value)
		GlobalManager.data.volumeScaleSFX = value
		

func _on_music_volume_value_changed(value: float) -> void:
	if dataLoaded:
		AudioServer.set_bus_volume_linear(2, value)
		GlobalManager.data.volumeScaleMusic = value
		
<<<<<<< Updated upstream
=======


func _on_resolution_option_button_item_selected(index: int) -> void:
	if dataLoaded:
		var key = $ResolutionOptionButton.get_item_text(index)
		GlobalManager.data.resolutionString = key
		GlobalManager.data.resolution = GlobalManager.data.resolutionsList[key]
		get_window().set_size(GlobalManager.data.resolutionsList[key])
		
>>>>>>> Stashed changes
