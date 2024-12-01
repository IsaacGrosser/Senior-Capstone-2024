class_name Run extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

## SPEED / MOVEMENT VARIABLES 
@export var max_speed : int = 100
@export var acceleration : int = 12

# Called when the node enters the scene tree for the first time.
func Enter():
	state_name = "Run"
	if character_body.debug_state_messages:
		print("entered RUN state")
	if animation_player:
		animation_player.play("running")
		if character_body:
			character_body.audio.pitch_scale = 1.0
			character_body.audio.stream = preload("res://Assets/Sounds/Sound Effects/WalkingSounds.wav")
			character_body.audio.play()
		# Added to check if it came from a falling state, then applies 'squash' for landing 
		if previous_state == "Fall":
			animation_player.scale = Vector2(1.3, 0.7)

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if character_body:
		if Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left") && character_body.is_on_floor():
			animation_player.flip_h = false
			character_body.velocity.x += acceleration * 2 # multiply to exponentially increase acc
			if character_body.velocity.x >= max_speed:
				character_body.velocity.x = max_speed
		elif Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right") && character_body.is_on_floor():
			animation_player.flip_h = true
			character_body.velocity.x -= acceleration * 2 # multiply to exponentially increase acc
			if character_body.velocity.x <= -max_speed:
				character_body.velocity.x = -max_speed
	
	handle_transitions()

func handle_transitions():
	# RELEASE CONDITIONS
	if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left"):
		if character_body:
			character_body.audio.stop()
		Transitioned.emit(self, "Idle")
	if Input.is_action_just_pressed("jump") or character_body.jump_buffer_active == true:
		if character_body:
			character_body.audio.stop()
		character_body.jump_buffer_active = false
		Transitioned.emit(self, "Jump")
	if Input.is_action_pressed("move_right") && Input.is_action_pressed("move_left"):
		if character_body:
			character_body.audio.stop()
		Transitioned.emit(self, "Idle")
	if (character_body && character_body.velocity.y >= 1) or !character_body.is_on_floor():
		if character_body:
			character_body.audio.stop()
		Transitioned.emit(self, "CoyoteTime")
	if !Global.can_move:
		if character_body:
			character_body.audio.stop()
		Transitioned.emit(self, "Locked")

func _on_sound_effects_audio_player_finished():
	if character_body:
		if character_body.audio.stream == preload("res://Assets/Sounds/Sound Effects/WalkingSounds.wav"):
			character_body.audio.play()
		else:
			return
