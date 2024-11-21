class_name Float extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D
@export var raycast_left : RayCast2D
@export var raycast_right : RayCast2D

## JUMP VARIABLES
@export var short_jump_threshold : int = 250
@export var jump_end_early_gravity_mod : int = 10

## AIR MOVE SPEED VARIABLES
@export var air_horizontal_acceleration : int = 10
@export var max_horizontal_speed : int = 90

## FLOAT GRAVITY
@export var float_gravity : int = 40 

func Enter():
	state_name = "Float"
	print("ENTERED FLOAT STATE")
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
	if Input.is_action_just_released("jump"):
		Transitioned.emit(self, "Fall")
	if character_body:
		if character_body.is_on_floor():
			Transitioned.emit(self, "Idle")
	#if raycast_left.is_colliding() or raycast_right.is_colliding():
		#Transitioned.emit(self, "Wall")
	if character_body.is_on_wall_only() && (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")):
		Transitioned.emit(self, "Wall")

