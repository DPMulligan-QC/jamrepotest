extends Control

var movie : MoviePlayer


func _on_button_pressed() -> void:
	var nameEntry: String = $LineEdit.text
	
	if nameEntry.length()>0:
		GlobalManager.data.playerName = nameEntry
		GlobalManager.is_in_game = true
		GlobalManager.save_game()
		$Button.disabled = true
		$AudioStreamPlayer.play()
		fade_to_play()
	else:
		$Label.text = "cmon tell us your name beefcake ;)"
		


func _on_audio_stream_player_finished() -> void:
	pass#GlobalManager.load_scene("res://TheSwimminghHole.tscn")

func _input(event: InputEvent) -> void:
	if movie!=null:
		movie.read_input_from_scene(event)

func fade_to_play():
	$AudioStreamPlayer.playing=true
	$Button.disabled = true
	await get_tree().create_timer(3).timeout
	
	movie = MoviePlayer.new()
	var succ:bool = movie.set_args(get_tree(),"res://TheSwimminghHole.tscn","res://assets/videos/logos/qcdev.ogv")
	if !succ:
		movie.queue_free()
