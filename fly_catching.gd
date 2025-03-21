extends Node2D
enum LINE_STATE {RETRACTED, EXTENDING, EXTENDED, RETRACTING}

@onready var linestate : LINE_STATE = LINE_STATE.RETRACTED
@onready var data : SaveData = GlobalManager.data
@onready var flies_caught: int = 0
@onready var times_casted : int = 0

func _ready() -> void:
	pass

func cast_line():
	times_casted+=1
	pass
	

func reel_line():
	pass
	

func reel_finished():
	data.flies += flies_caught
	GlobalManager.save_game()
	if times_casted >=3:
		GlobalManager.pass_time()
		times_casted = 0
	pass
