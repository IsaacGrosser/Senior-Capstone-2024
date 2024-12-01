class_name WallJump extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

## WALL JUMP VARIABLES / FRICTION VARIABLES
@export var walljump_velocity : int = 275
@export var walljump_speed : int = 70

## RAYCAST REFERENCES
@export var ray_cast_left = RayCast2D
@export var ray_cast_right = RayCast2D

var rng = RandomNumberGenerator.new()

func Enter():
	state_name = "WallJump"
	if character_body.debug_state_messages:
		print("entered WALL JUMP state")
	if animation_player:
		animation_player.play("jumping")
		var random_pitch = rng.randf_range(1.3, 1.7)
		character_body.audio.pitch_scale = random_pitch
		character_body.audio.stream = preload("res://Assets/Sounds/Sound Effects/JumpSwoosh.wav")
		character_body.audio.play()
		
	if character_body && character_body.ray_cast_left_is_colliding:
		character_body.velocity.x = walljump_speed
		character_body.velocity.y = -walljump_velocity
		
	elif character_body && character_body.ray_cast_right_is_colliding:
		character_body.velocity.x = -walljump_speed
		character_body.velocity.y = -walljump_velocity

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	handle_transitions()

func handle_transitions():
	# TRANSITIONS
	if character_body.velocity.y >= 0:
		Transitioned.emit(self, "Fall")
	if Input.is_action_just_released("jump"):
		Transitioned.emit(self, "Fall")
	if Input.is_action_pressed("jump") && character_body.velocity.y >= 0:
		Transitioned.emit(self, "Float")
	if character_body && character_body.is_on_wall_only() && (Input.is_action_pressed("move_left") 
		or Input.is_action_pressed("move_right")):
		Transitioned.emit(self, "Wall")
	if !Global.can_move:
		Transitioned.emit(self, "Locked")

