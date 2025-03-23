extends Control

@onready var sfxPlayer: AudioStreamPlayer = $Panel/player
var movie: MoviePlayer
var isFadingToPlay: bool = false

func _on_play_button_pressed() -> void:
	if(!isFadingToPlay):
		fade_to_play()

func _on_settings_pressed() -> void:
	if(!isFadingToPlay):
		GlobalManager.load_scene("res://Settings.tscn")


func fade_to_play():
	isFadingToPlay = true
	sfxPlayer.playing = true
	$MarginContainer/VBoxContainer/Settings.disabled = true
	$MarginContainer/VBoxContainer/PlayButton.disabled = true
	$MarginContainer/VBoxContainer/Quit.disabled = true
	$MarginContainer/VBoxContainer/funnybutton.disabled = true
	await get_tree().create_timer(3).timeout
	if GlobalManager.data.sceneName=="":
		GlobalManager.load_scene("res://NameEntry.tscn")
	else:
		GlobalManager.load_scene(GlobalManager.data.sceneName)

func _on_quit_pressed() -> void:
	if(!isFadingToPlay):
		GlobalManager.load_scene("res://Credits.tscn")


func enable_buttons(enabled : bool = true):
	$MarginContainer/VBoxContainer/PlayButton.disabled = !enabled
	$MarginContainer/VBoxContainer/Settings.disabled = !enabled
	$MarginContainer/VBoxContainer/Quit.disabled = !enabled
	$MarginContainer/VBoxContainer/funnybutton.disabled = !enabled

func ready() -> void:
	GlobalManager.load_game(true)
	isFadingToPlay = false


func _on_audio_stream_player_finished() -> void:
	pass#GlobalManager.load_scene("res://NameEntry.tscn")

func _input(event: InputEvent) -> void:
	if movie!=null:
		movie.read_input_from_scene(event)
		
func _on_funnybutton_pressed() -> void:
	movie = MoviePlayer.new()
	var succ:bool = movie.set_args(get_tree())
	if succ:
		movie.movie_ended.connect(enable_buttons.bind(true))
		$MarginContainer/VBoxContainer/PlayButton.disabled = true
		$MarginContainer/VBoxContainer/Settings.disabled = true
		$MarginContainer/VBoxContainer/Quit.disabled = true
		$MarginContainer/VBoxContainer/funnybutton.disabled = true
	else:
		movie.queue_free()
