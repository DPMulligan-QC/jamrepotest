extends Control


signal finished
var array_length: int

var trigger_player_response #bool array defined by func set_args, if true, enable player response buttons

func _ready() -> void:
	pass
	

func set_args(_trigger_player_response: Array = [false,true,false], ):
	trigger_player_response = _trigger_player_response
	array_length = trigger_player_response.size()
	pass
