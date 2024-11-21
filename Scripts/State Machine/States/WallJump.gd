class_name WallJump extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D
@export var raycast_left : RayCast2D
@export var raycast_right : RayCast2D

## WALL JUMP VARIABLES / FRICTION VARIABLES
@export var walljump_force : int = 500
@export var walljump_speed : int = 200
@export var wall_friction : int = 60

func Enter():
	state_name = "WallJump"
	print("ENTERED WALL JUMP STATE")
	if animation_player:
		animation_player.play("jumping")

func Exit():
	pass

func Update(delta: float):
	pass

func Physics_Update(delta: float):
	# CHECK WHICH RAYCAST IS COLLIDING AND JUMP OPPOSITE DIRECTION
	if raycast_left.is_colliding() && character_body:
		character_body.velocity.x += walljump_speed
		character_body.velocity.y = -walljump_force
	if raycast_right.is_colliding() && character_body:
		character_body.velocity.x += -walljump_speed
		character_body.velocity.y = -walljump_force
	
	handle_transitions()

func handle_transitions():
	# TRANSITIONS
	if character_body.velocity.y >= 0:
		Transitioned.emit(self, "Fall")
	if Input.is_action_just_released("jump"):
		Transitioned.emit(self, "Fall")
	if Input.is_action_pressed("jump") && character_body.velocity.y >= 0:
		Transitioned.emit(self, "Float")
	if raycast_left.is_colliding() or raycast_right.is_colliding():
		Transitioned.emit(self, "Wall")


