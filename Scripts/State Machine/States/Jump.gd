class_name Jump extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

## JUMP VARIABLES
@export var jump_velocity : int = 285

## AIR MOVE SPEED VARIABLES
@export var air_horizontal_acceleration : int = 10
@export var max_horizontal_speed : int = 90

func Enter():
	state_name = "Jump"
	print("entered JUMP state")
	if animation_player:
		animation_player.play("jumping")
	if (character_body && character_body.is_on_floor()) or character_body && previous_state == "CoyoteTime":
		character_body.velocity.y =  -jump_velocity

func Exit():
	pass

func Update(delta: float):
	pass

func Physics_Update(delta: float):
	if Input.is_action_pressed("move_right"):
		animation_player.flip_h = false
		character_body.velocity.x += air_horizontal_acceleration * 2 # multiply to exponentially increase acc
		if character_body.velocity.x >= max_horizontal_speed:
			character_body.velocity.x = max_horizontal_speed
	if Input.is_action_pressed("move_left"):
		animation_player.flip_h = true
		character_body.velocity.x -= air_horizontal_acceleration * 2 # multiply to exponentially increase acc
		if character_body.velocity.x <= -max_horizontal_speed:
			character_body.velocity.x = -max_horizontal_speed
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		character_body.velocity.x = lerp(character_body.velocity.x, 0.0, 0.1)
	
	handle_transitions()

func handle_transitions():
	# TRANSITIONS
	if character_body.velocity.y >= 0 or Input.is_action_just_released("jump"):
		Transitioned.emit(self, "Fall")
	if Input.is_action_pressed("jump") && character_body.velocity.y >= 0:
		Transitioned.emit(self, "Float")



