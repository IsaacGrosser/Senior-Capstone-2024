class_name Fall extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

@export var short_jump_threshold : int = 250
@export var jump_end_early_gravity_mod : int = 10

## AIR MOVE SPEED VARIABLES
@export var air_horizontal_acceleration : int = 10
@export var max_horizontal_speed : int = 90

func Enter():
	state_name = "Fall"
	print("entered FALL state")
	if animation_player && !animation_player.animation == "falling":
		animation_player.play("falling")
	if character_body && character_body.velocity.y >= -short_jump_threshold && previous_state == "Jump":
		character_body.velocity.y = jump_end_early_gravity_mod

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
	elif Input.is_action_pressed("move_left"):
		animation_player.flip_h = true
		character_body.velocity.x -= air_horizontal_acceleration * 2 # multiply to exponentially increase acc
		if character_body.velocity.x <= -max_horizontal_speed:
			character_body.velocity.x = -max_horizontal_speed
	else:
		character_body.velocity.x = lerp(character_body.velocity.x, 0.0, 0.1)
	
	handle_transitions()

func handle_transitions():
	if character_body:
		if character_body.is_on_floor():
			Transitioned.emit(self, "Idle")
		if Input.is_action_pressed("jump"):
			Transitioned.emit(self, "Float")
		
	if character_body.is_on_wall_only() && (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")):
		Transitioned.emit(self, "Wall")
	if !Global.can_move:
		Transitioned.emit(self, "Locked")