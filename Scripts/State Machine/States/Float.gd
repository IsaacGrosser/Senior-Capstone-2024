class_name Float extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

## AIR MOVE SPEED VARIABLES
@export var air_horizontal_acceleration : int = 10
@export var max_horizontal_speed : int = 90

## FLOAT GRAVITY
@export var float_gravity : int = 20

func Enter():
	state_name = "Float"
	print("entered FLOAT state")
	if animation_player:
		animation_player.play("floating")

func Exit():
	pass

func Update(delta: float):
	pass

func Physics_Update(delta: float):
	if character_body:
		character_body.velocity.y = float_gravity
	
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
	# TRANSITIONS
	if Input.is_action_just_released("jump"):
		Transitioned.emit(self, "Fall")
	if character_body:
		if character_body.is_on_floor():
			Transitioned.emit(self, "Idle")
	if character_body.is_on_wall_only() && (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")):
		Transitioned.emit(self, "Wall")
	if !Global.can_move:
		Transitioned.emit(self, "Locked")
