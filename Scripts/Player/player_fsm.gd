class_name Player extends CharacterBody2D

@export var animation_player : AnimatedSprite2D

## GRAVITY VARIABLES
@export var gravity_clamp : float = 225# MAX GRAVITY
@export var base_gravity : float = 12 
@export var gravity_mod : float = 0.5 # THIS IS FOR FALLING GRAVITY AMP
@export var jump_gravity_threshold : float = 2.0 # THIS IS FOR ENTERING/EXITING HANG TIME STATE

## COYOTE VARIABLES 
@export var coyote_buffer_length : int = 11
var coyote_counter : int = 0 # variable to hold current count state

## JUMP BUFFER VARIABLES
# @export var jump_force_add : int = 100 - not sure what this was for ?
@export var jump_buffer_length : int = 8
var jump_buffer_counter : int = 0 # variable to hold current count state
var jump_buffer_active : bool = false

func _ready():
	pass

func _physics_process(_delta):
	gravity()
	check_jump_buffer()
	check_coyote_timer()
	move_and_slide()
	
	# Added to return player to normal scale when outside of jump
	animation_player.scale.x = move_toward(animation_player.scale.x, 1, .1)
	animation_player.scale.y = move_toward(animation_player.scale.y, 1, .1)

## GRAVITY MECHANIC
func gravity():
	# add gravity to the player as they are not on the floor
	velocity.y += base_gravity
	
	if velocity.y > 0:
		velocity.y += base_gravity * gravity_mod
	# clamp the y velocity to the gravity max
	if velocity.y > gravity_clamp:
		velocity.y = gravity_clamp

func check_jump_buffer():
	if Input.is_action_just_pressed("jump"):
		jump_buffer_active = true
		jump_buffer_counter = jump_buffer_length
		# start counting down the buffer counter every frame if it is greater than 0
	if jump_buffer_counter > 0:
		jump_buffer_counter -= 1
	if jump_buffer_counter <= 0:
		jump_buffer_active = false

func check_coyote_timer():
	if coyote_counter <= 0:
		coyote_counter = coyote_buffer_length


