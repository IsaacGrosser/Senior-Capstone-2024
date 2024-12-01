class_name Jump extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

@export var gravity_threshold : float = 2.0

## JUMP VARIABLES
@export var jump_velocity : int = 285

## AIR MOVE SPEED VARIABLES
@export var air_horizontal_acceleration : int = 10
@export var max_horizontal_speed : int = 90

var rng = RandomNumberGenerator.new()

func Enter():
	state_name = "Jump"
	if character_body.debug_state_messages:
		print("entered JUMP state")
	if animation_player:
		animation_player.play("jumping")
		# Adds squish for jumping
		animation_player.scale = Vector2(0.5, 1.6)
	if (character_body && character_body.is_on_floor()) or character_body && previous_state == "CoyoteTime":
		var random_pitch = rng.randf_range(1.3, 1.7)
		character_body.audio.pitch_scale = random_pitch
		character_body.audio.stream = preload("res://Assets/Sounds/Sound Effects/JumpSwoosh.wav")
		character_body.audio.play()
		character_body.velocity.y =  -jump_velocity

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
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
	#if character_body.velocity.y >= 0 or Input.is_action_just_released("jump"):
		#Transitioned.emit(self, "Fall")
	if character_body && character_body.velocity.y >= -gravity_threshold or Input.is_action_just_released("jump"):
		Transitioned.emit(self, "JumpHangTime")
	if Input.is_action_pressed("jump") && character_body.velocity.y >= 0:
		Transitioned.emit(self, "Float")
	if !Global.can_move:
		Transitioned.emit(self, "Locked")


