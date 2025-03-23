extends Control

var data : SaveData
const save_path := "user://savedata.tres"
var is_in_game = false

var sfxPlayer: AudioStreamPlayer
var musicPlayer: AudioStreamPlayer

enum LOCATION {BAR, POND, MALL, HOME, ASLEEP}

enum TIME_OF_DAY {MORNING, MIDDAY, AFTERNOON, EVENING, NIGHT, DAWN}
signal time_passed




func center_da_window() -> void:
	var screenCenter = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var windowSize = get_window().get_size_with_decorations()
	get_window().set_position( screenCenter - windowSize / 2)


func load_game(applySettings : bool):
	
	data= load_data()
	
	if data:
		if applySettings:
			#if(data.isFullscreen):
			#	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
			#else:
			#	get_window().mode = Window.MODE_WINDOWED
			
			if data.isVSync:
				DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
			else:
				DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
			
			get_window().set_size(data.resolution)
			
			AudioServer.set_bus_volume_linear(0, data.volumeScaleMaster)
			AudioServer.set_bus_volume_linear(1, data.volumeScaleSFX)
			AudioServer.set_bus_volume_linear(2, data.volumeScaleMusic)
	else:
		data = SaveData.new()
		save_game()
	


func get_data() -> SaveData: #use this to modify save data (returns by reference); call save_game when modifications are complete
	return data
	



func save_game():
	var casted_data = ResourceSaver.save(data, save_path)
	
	if casted_data != OK:
		print("Error Saving Game: " + casted_data)
 
func load_data():
	var casted_data = ResourceLoader.load(save_path)
	
	if casted_data != null and casted_data is Resource:
		return casted_data
	
	else:
		print("Error loading game")
		return null
		

func apply_settings():
	if(data):
		#if(data.isFullscreen):
		#	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		#else:
		#	get_window().mode = Window.MODE_WINDOWED
			
		if data.isVSync:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		else:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
		# get_window().set_size(data.resolution)
	
		AudioServer.set_bus_volume_linear(0,data.volumeScaleMaster)
		AudioServer.set_bus_volume_linear(1, data.volumeScaleSFX)
		AudioServer.set_bus_volume_linear(2, data.volumeScaleMusic)
	else:
		data = SaveData.new()
		save_game()
	

func _ready() ->void:
	is_in_game = false
	#musicPlayer.bus = &"Music"
	#sfxPlayer.bus = &"SFX"
	load_game(true)
	
	FrogData.frog_map =  {data.frog_names[0]:0, data.frog_names[1]:1, data.frog_names[2]:2}
	
func load_scene(scenePath : String = "res://main_menu.tscn"):
	match scenePath:
		"res://main_menu.tscn":
			is_in_game = false
		"res://Credits.tscn":
			is_in_game = false
		"res://DaGame.tscn":
			is_in_game = true
			data.sceneName = scenePath
	get_tree().change_scene_to_file(scenePath)
	

func play_persistent_sound_oneshot(filePath : String):
#	if filePath.is_valid_filename():
	var file = FileAccess.open(filePath, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	sound.loop = false
		# sound.instantiate_playback()
	
	sfxPlayer.stream = sound
		
	return sound
	

func play_music(filePath : String):
#	if filePath.is_valid_filename():
	var file = FileAccess.open(filePath, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	sound.loop = true
	sound.instantiate_playback()
	
	musicPlayer.stream = sound
		
	musicPlayer.play()
	

func pass_time():
	
	if data.timeOfDay > 4:
		data.timeOfDay = 0
		data.dayNumber+=1
	else:
		data.timeOfDay += 1
	
	save_game()
	
	time_passed.emit()
func delete_save():
	
	data.reset_state()
	save_game()

func get_time_of_day() -> String:
	match data.timeOfDay:
		TIME_OF_DAY.MORNING:
			return "MORNING"
		TIME_OF_DAY.MIDDAY:
			return "MID-DAY"
		TIME_OF_DAY.AFTERNOON:
			return "AFTERNOON"
		TIME_OF_DAY.EVENING:
			return "EVENING"
		TIME_OF_DAY.NIGHT:
			return "NIGHT"
		TIME_OF_DAY.DAWN:
			return "DAWN"
	return "null"
