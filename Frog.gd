extends Node
class_name GayFrog

enum EXPRESSION {NEUTRAL, DISGUSTED, HAPPY,FLIRTY}

var frog_name: String
var frog_index:int

var expression: EXPRESSION = EXPRESSION.NEUTRAL
var sprite_path: String

var affinity: int
var hates_player:bool
var loves_player:bool


signal affinity_changed
signal trigger_loves_player
signal trigger_hates_player

var location: GlobalManager.LOCATION
var schedule: Dictionary = {GlobalManager.TIME_OF_DAY.MORNING: GlobalManager.LOCATION.ASLEEP, 
GlobalManager.TIME_OF_DAY.MIDDAY: GlobalManager.LOCATION.POND, GlobalManager.TIME_OF_DAY.AFTERNOON: GlobalManager.LOCATION.BAR,
GlobalManager.TIME_OF_DAY.EVENING: GlobalManager.LOCATION.BAR, GlobalManager.TIME_OF_DAY.NIGHT: GlobalManager.LOCATION.BAR,
GlobalManager.TIME_OF_DAY.DAWN: GlobalManager.LOCATION.ASLEEP}

var sprite_map: Dictionary

func _ready() -> void:
	GlobalManager.time_passed.connect(on_time_passed())

func export_data() -> Array:
	return [frog_name, affinity, schedule, sprite_map]

func import_data(_frog_name:String, _affinity:int, _schedule:Dictionary, _sprite_map:Dictionary):
	frog_name = _frog_name
	affinity = _affinity
	schedule = _schedule
	sprite_map = _sprite_map
	
	if affinity == 0:
		hates_player = true
	elif affinity ==100:
		loves_player = true

func add_affinity(delta:int):
	if !hates_player:
		if loves_player:
			affinity=100
		else:
			affinity = max(min(affinity+delta,100),0)
			if affinity == 0:
				hates_player = true
				trigger_hates_player.emit()
			elif affinity == 100:
				loves_player = true
				trigger_loves_player.emit()
			if delta!=0:
				affinity_changed.emit()
		#GlobalManager.data.
	
	

func on_time_passed():
	location = schedule[GlobalManager.get_time_of_day()]
	add_affinity(-1)
	
func destruct():
	GlobalManager.time_passed.disconnect(on_time_passed())
