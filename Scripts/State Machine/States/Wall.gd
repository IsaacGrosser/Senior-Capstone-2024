class_name Wall extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D
@export var raycast_left : RayCast2D
@export var raycast_right : RayCast2D

## WALL FRICTION
@export var wall_friction : int = 40

## AIR MOVE SPEED VARIABLES
@export var air_horizontal_acceleration : int = 10
@export var max_horizontal_speed : int = 90

func Enter():
	state_name = "Wall"
	print("ENTERED WALL STATE")
	if animation_player:
		animation_player.play("falling")

func Exit():
	pass

func Update(delta: float):
	pass

func Physics_Update(delta: float):
	if character_body:
		character_body.velocity.y = wall_friction
	
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
	
	handle_transitions()

func handle_transitions():
	# TRANSITIONS
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "WallJump")
	if ((!raycast_left.is_colliding() && !raycast_right.is_colliding()) 
		or (raycast_left.is_colliding() and !Input.is_action_pressed("move_left"))
		or (raycast_right.is_colliding() and !Input.is_action_pressed("move_right"))):
		Transitioned.emit(self, "Fall")
	if character_body:
		if character_body.is_on_floor():
			Transitioned.emit(self, "Idle")
