extends Control

const nextSceneName: String = "res://main_menu.tscn"
var movie : MoviePlayer

func _ready() -> void:
	await get_tree().create_timer(0.05).timeout
	movie = MoviePlayer.new()
	var succ:bool = movie.set_args(get_tree(),nextSceneName,"res://assets/videos/logos/qcdev.ogv", false, true)
	if !succ:
		movie.queue_free()

func _input(event: InputEvent) -> void:
	if movie!=null:
		movie.read_input_from_scene(event)
