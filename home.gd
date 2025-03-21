extends Control


func _ready() -> void:
	GlobalManager.data.sceneName = "res://Home.tscn"
	GlobalManager.save_game()
