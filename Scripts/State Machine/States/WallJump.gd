class_name WallJump extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

## WALL JUMP VARIABLES / FRICTION VARIABLES
@export var walljump_velocity : int = 275
@export var walljump_speed : int = 70

func Enter():
	state_name = "WallJump"
	print("entered WALL JUMP state")
	if animation_player:
		animation_player.play("jumping")
		
	if character_body && Input.is_action_pressed("move_left"):
		character_body.velocity.x = walljump_speed
		character_body.velocity.y = -walljump_velocity
		
	if character_body && Input.is_action_pressed("move_right"):
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

