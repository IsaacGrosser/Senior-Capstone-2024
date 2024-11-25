class_name Wall extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

## WALL FRICTION
@export var wall_friction : int = 15

func Enter():
	state_name = "Wall"
	print("entered WALL state")
	if animation_player:
		animation_player.play("falling")

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if character_body:
		character_body.velocity.y = wall_friction
	
	if Input.is_action_pressed("move_right"):
		animation_player.flip_h = false
	
	if Input.is_action_pressed("move_left"):
		animation_player.flip_h = true
	
	handle_transitions()

func handle_transitions():
	# TRANSITIONS
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "WallJump")
	
	if character_body:
		if (!Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left")):
			Transitioned.emit(self, "Fall")
	
	if character_body && !character_body.is_on_wall_only():
			Transitioned.emit(self, "Fall")
	
	if character_body:
		if character_body.is_on_floor():
			Transitioned.emit(self, "Idle")
		
	if !Global.can_move:
		Transitioned.emit(self, "Locked")



