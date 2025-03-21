extends Control
class_name HUD

enum PHONE_STATE {AWAY, RETRIEVING, USING, STOWING}

signal phone_on
signal phone_off

const phone_timer_length : float = .5
const phone_y_stowed: float = 848.0
const phone_y_using: float = 128.0

var phone_timer: float

@onready var background_ref: Panel = $BackgroundImage
@onready var phone_state: PHONE_STATE = PHONE_STATE.AWAY
@onready var data : SaveData = GlobalManager.get_data()
@onready var phone_panel : Panel = $PhoneScreen
@onready var phone_button: Button = $PhoneButton
@onready var phone_x : float

@onready var fly_count_label : Label = $FlyEnergyCount/FlySprite/Label
@onready var location_label : Label = $TimeDisplay/Location
@onready var time_label : Label = $TimeDisplay/TimeCount

func _ready() -> void:
	phone_x = phone_panel.offset_right
	phone_timer = 0.0
	pass
	
func _process(delta: float) -> void:
	match phone_state:
		PHONE_STATE.AWAY:
			pass
		PHONE_STATE.RETRIEVING:
			phone_timer = minf(phone_timer + delta, phone_timer_length)
			phone_panel.offset_bottom = lerpf(phone_y_stowed,phone_y_using,minf(phone_timer/phone_timer_length,1.0))
			print("y = ", phone_panel.offset_bottom)
			pass
		PHONE_STATE.USING:
			pass
			
		PHONE_STATE.STOWING:
			phone_timer = minf(phone_timer + delta, phone_timer_length)
			phone_panel.offset_bottom = lerpf(phone_y_using,phone_y_stowed,minf(phone_timer/phone_timer_length,1.0))
			print("y = ", phone_panel.offset_bottom)
			pass	
	
func put_away_phone():
	print("phone away!!!!!")
	phone_timer = 0.0
	phone_state = PHONE_STATE.STOWING
	await get_tree().create_timer(phone_timer_length).timeout
	phone_state = PHONE_STATE.AWAY
	phone_off.emit()
	pass

func take_out_phone():
	print("phone out!!!!!")
	phone_timer = 0.0
	phone_state = PHONE_STATE.RETRIEVING
	await get_tree().create_timer(phone_timer_length).timeout
	phone_state = PHONE_STATE.USING
	pass

func toggle_phone():
	
	match phone_state:
		PHONE_STATE.AWAY:
			phone_on.emit()
			take_out_phone()
			pass
		PHONE_STATE.RETRIEVING:
			pass
		PHONE_STATE.USING:
			phone_off.emit()
			put_away_phone()
			
		PHONE_STATE.STOWING:
			pass	


func _on_phone_button_pressed() -> void:
	toggle_phone()


func _on_cancel_phone_button_pressed() -> void:
	toggle_phone()
	

func call_input(event: InputEvent) -> void:
	if event.is_action_pressed("Phone"):
		toggle_phone()
		
		
func _draw() -> void:
	fly_count_label.text = str(": ",data.flies)
	location_label.text = "LOCATION_NAME"
	time_label.text = str("DAY ",data.dayNumber," - ", GlobalManager.get_time_of_day())
