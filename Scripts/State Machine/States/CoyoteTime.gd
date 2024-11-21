extends State
class_name CoyoteTime

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

## COYOTE VARIABLES 
@export var coyote_buffer_length : int = 8
var coyote_counter : int = 0 # variable to hold current count state

func Enter():
	state_name = "CoyoteTime"
	print("ENTERED COYOTE TIME STATE")
	coyote_counter = coyote_buffer_length

func Exit():
	pass

func Update(delta: float):
	pass

func Physics_Update(delta: float):
	if coyote_counter > 0:
		coyote_counter -= 1
		print(coyote_counter)
		
	handle_transitions()

func handle_transitions():
	if coyote_counter > 0 && Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")
	if coyote_counter <= 0:
		Transitioned.emit(self, "Fall")
