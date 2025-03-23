extends Control

@onready var data : SaveData
#var hud
#var hud_scene

var movie : MoviePlayer

@onready var isFirstDay:bool

func time_passed():
	if isFirstDay && data.dayNumber >0:
		first_day_ended()
	


func _ready() -> void:
	data =  GlobalManager.data
	#hud_scene = load("res://HUDScene.tscn")
	#hud = $HUDCONTROL
	#hud.set_name("HUD")
	#get_tree().get_first_node_in_group().add_child(hud)
	#hud.phone_on.connect(disable_buttons)
	#hud.phone_off.connect(enable_buttons)
	await get_tree().create_timer(0.1).timeout
	if data.dayNumber == 0: # these actions are unavailable on day 0
		isFirstDay = true
	GlobalManager.time_passed.connect(time_passed)
	GlobalManager.data.sceneName = "res://TheSwimminghHole.tscn"
	GlobalManager.save_game()
	
	await get_tree().create_timer(0.1).timeout
	enable_buttons()


func first_day_ended():
	#get_tree().root.remove_child(hud)
	#hud.queue_free()
	movie = MoviePlayer.new()
	var succ:bool = movie.set_args(get_tree(),"res://Home.tscn","res://assets/videos/logos/qcdev.ogv")
	if !succ:
		movie.queue_free()
		


func _on_darts_button_pressed() -> void:
	GlobalManager.pass_time()


func _on_bull_button_pressed() -> void:
	GlobalManager.pass_time()


func _on_drink_button_pressed() -> void:
	GlobalManager.pass_time()


func _on_talk_button_pressed() -> void:
	pass


func _on_shop_button_pressed() -> void:
	pass


func _on_wait_button_pressed() -> void:
	GlobalManager.pass_time()


func _on_leave_button_pressed() -> void:
	pass # Replace with function body.
	
func leave(new_scene_name : String):
	#if hud:
	#	get_tree().root.remove_child(hud)
	#	hud.queue_free()
	GlobalManager.load_scene(new_scene_name)
	
	
func enable_buttons():
	$Panel/drinkButton.disabled=false
	$Panel/dartsButton.disabled=false
	$Panel/bullButton.disabled=false
	$Panel/talkButton.disabled=false
	$Panel/waitButton.disabled=false
	$Panel/shopButton.disabled=false
	$Panel/leaveButton.disabled=false
	
	$Panel/drinkButton.visible=true
	$Panel/dartsButton.visible=true
	$Panel/bullButton.visible=true
	$Panel/talkButton.visible=true
	$Panel/waitButton.visible=true
	$Panel/shopButton.visible=true
	$Panel/leaveButton.visible=true
	if isFirstDay:
		$Panel/waitButton.disabled=true
		$Panel/waitButton.visible=false
		$Panel/leaveButton.disabled=true
		$Panel/leaveButton.visible=false
		$Panel/shopButton.disabled=true
		$Panel/shopButton.visible=false
		#hud.phone_button.visible = false
		#hud.phone_button.disabled = true

func disable_buttons():
	$Panel/drinkButton.disabled=true
	$Panel/dartsButton.disabled=true
	$Panel/bullButton.disabled=true
	$Panel/talkButton.disabled=true
	$Panel/waitButton.disabled=true
	$Panel/shopButton.disabled=true
	$Panel/leaveButton.disabled=true
	
	$Panel/drinkButton.visible=false
	$Panel/dartsButton.visible=false
	$Panel/bullButton.visible=false
	$Panel/talkButton.visible=false
	$Panel/waitButton.visible=false
	$Panel/shopButton.visible=false
	$Panel/leaveButton.visible=false
