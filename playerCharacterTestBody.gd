extends CharacterBody2D

@export var speed = 400
@export var health = 100
@export var maxHealth = 100

var mousePosition : Vector2i
enum INPUT_STATES {IDLE, ACTIVE}
enum MOVE_STATES {IDLE, WALKING, RUNNING, PUSHING}
enum OTHER_STATES {NONE, FLINCH, DEAD}
enum ANIM_DISPLAY {IDLE, WALKING, RUNNING, PUSHING, FLINCH, DEAD}

@export var anim_display: ANIM_DISPLAY = ANIM_DISPLAY.IDLE

func get_walk_input():
	var inputDirection = Input.get_vector("InputLeft", "InputRight","InputUp","InputDown")
	velocity = inputDirection * speed
	if velocity.length()<1:
		input_state = INPUT_STATES.ACTIVE
	elif velocity.length()<100:
		move_state = MOVE_STATES.WALKING
	else:
		move_state = MOVE_STATES.RUNNING
	
func _physics_process(delta: float) -> void:
	get_walk_input()
	move_and_slide()
	
var other_state:int = OTHER_STATES.NONE:
	set(new_value):
		print(
			"other state transitioned from ", OTHER_STATES.keys()[other_state],
			" to ", OTHER_STATES.keys()[new_value] )
	get:
		return other_state
		
	
var move_state:int = MOVE_STATES.IDLE:
	set(new_value):	
		print(
			"move state transitioned from ", MOVE_STATES.keys()[move_state],
			" to ", MOVE_STATES.keys()[new_value] )
			
			
	get:
		return move_state		

var input_state:int = INPUT_STATES.IDLE:
	set(new_value):
		# print new input state
		print(
			"input state transitioned from ", INPUT_STATES.keys()[input_state],
			" to ", INPUT_STATES.keys()[new_value] )
		
		match input_state:
			INPUT_STATES.IDLE:
				match other_state:
					OTHER_STATES.NONE:
						anim_display = ANIM_DISPLAY.IDLE
					OTHER_STATES.FLINCH:
						anim_display = ANIM_DISPLAY.FLINCH
					OTHER_STATES.DEAD:
						anim_display = ANIM_DISPLAY.DEAD
						
			INPUT_STATES.ACTIVE:
				match other_state:
					OTHER_STATES.NONE:
						match move_state:
							MOVE_STATES.WALKING:
								anim_display = ANIM_DISPLAY.WALKING
							MOVE_STATES.RUNNING:
								anim_display = ANIM_DISPLAY.RUNNING
							MOVE_STATES.PUSHING:
								anim_display = ANIM_DISPLAY.PUSHING
						anim_display = ANIM_DISPLAY.IDLE
					OTHER_STATES.FLINCH:
						anim_display = ANIM_DISPLAY.FLINCH
					OTHER_STATES.DEAD:
						anim_display = ANIM_DISPLAY.DEAD
	get:
		return input_state		



func _input(event: InputEvent) -> void:
	mousePosition = get_global_mouse_position()
	
	if event.is_released():
		input_state = INPUT_STATES.IDLE
	else:
		input_state = INPUT_STATES.ACTIVE
	
