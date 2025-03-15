extends Control
class_name GameManager

var data : SaveData
var helper = SaveGameHelper.new()


func center_da_window() -> void:
	var screenCenter = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var windowSize = get_window().get_size_with_decorations()
	get_window().set_position( screenCenter - windowSize / 2)


func load_data(applySettings : bool):
	
	data= helper.load_game()
	
	if data:
		if applySettings:
			if(data.isFullscreen):
				get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
			else:
				get_window().mode = Window.MODE_WINDOWED
			
			if data.isVSync:
				DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
			else:
				DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
			
			get_window().set_size(data.resolution)
			
			AudioServer.set_bus_volume_linear(0, linear_to_db(data.volumeScaleMaster))
			AudioServer.set_bus_volume_linear(1, linear_to_db(data.volumeScaleSFX))
			AudioServer.set_bus_volume_linear(2, linear_to_db(data.volumeScaleMusic))
	else:
		data = SaveData.new()
		helper.save_game(data)
	

#func ready() -> void:
#	load_data()

func get_data() -> SaveData: #use this to modify save data (returns by reference); call save_game when modifications are complete
	return data
	

func save_game():
	helper.save_game(data)
