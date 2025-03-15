extends Node2D

var manager = GameManager.new()

func _ready() -> void:
	manager.load_data(false)
	
