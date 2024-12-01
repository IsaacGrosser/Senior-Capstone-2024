class_name CoyoteTime extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

## AIR MOVE SPEED VARIABLES
@export var air_horizontal_acceleration : int = 10
@export var max_horizontal_speed : int = 90

## COYOTE VARIABLES 
@export var coyote_buffer_length : int = 8
var coyote_counter : int = 0 # variable to hold current count state

func Enter():
	state_name = "CoyoteTime"
	if character_body.debug_state_messages:
		print("entered COYOTE TIME state")
	coyote_counter = coyote_buffer_length
	if animation_player:
		animation_player.play("falling")

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if coyote_counter > 0:
		coyote_counter -= 1
	if Input.is_action_pressed("move_right"):
		animation_player.flip_h = false
		character_body.velocity.x += air_horizontal_acceleration * 2 # multiply to exponentially increase acc
		if character_body.velocity.x >= max_horizontal_speed:
			character_body.velocity.x = max_horizontal_speed
	elif Input.is_action_pressed("move_left"):
		animation_player.flip_h = true
		character_body.velocity.x -= air_horizontal_acceleration * 2 # multiply to exponentially increase acc
		if character_body.velocity.x <= -max_horizontal_speed:
			character_body.velocity.x = -max_horizontal_speed
	else:
		character_body.velocity.x = lerp(character_body.velocity.x, 0.0, 0.1)
		
	handle_transitions()

func handle_transitions():
	if coyote_counter > 0 && Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "Jump")
	if coyote_counter <= 0:
		Transitioned.emit(self, "Fall")
	if character_body.is_on_wall_only() && (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")):
		Transitioned.emit(self, "Wall")
	if !Global.can_move:
		Transitioned.emit(self, "Locked")
