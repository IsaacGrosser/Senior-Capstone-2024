class_name Player extends CharacterBody2D

@export var animation_player : AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

## AUDIO PLAYER
@onready var audio = $SoundEffectsAudioPlayer

## DEBUGGER CHECKER
@export var debug_state_messages : bool = true

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

## WALLJUMP BUFFER VARIABLES
@export var walljump_buffer_length : int = 8
var walljump_buffer_counter : int = 0 # variable to hold current count state
var walljump_buffer_active : bool = false

## RAYCAST REFERENCES & VARIABLES
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight

var ray_cast_left_is_colliding : bool = false
var ray_cast_right_is_colliding : bool = false

func _ready():
	pass

func _physics_process(_delta):
	gravity()
	check_jump_buffer()
	check_walljump_buffer()
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

func check_walljump_buffer():
	if self.is_on_wall_only():
		walljump_buffer_active = true
		walljump_buffer_counter = walljump_buffer_length
		if ray_cast_left.is_colliding():
			ray_cast_left_is_colliding = true
		elif ray_cast_right.is_colliding():
			ray_cast_right_is_colliding = true
	# start counting down the buffer counter every frame if it is greater than 0
	if walljump_buffer_counter > 0:
		walljump_buffer_counter -= 1
	if walljump_buffer_counter <= 0:
		walljump_buffer_active = false
		ray_cast_left_is_colliding = false
		ray_cast_right_is_colliding = false

func check_coyote_timer():
	if coyote_counter <= 0:
		coyote_counter = coyote_buffer_length

func handle_player_death() -> void:
	Global.can_move = false
	print("Player has died")
	await get_tree().create_timer(1).timeout
	reset_player()

func reset_player() -> void:
	var level = get_tree().get_first_node_in_group("level")
	var spawn_position = level.get_spawn_position()
	self.rotation = 0
	global_position = spawn_position
	Global.can_move = true

