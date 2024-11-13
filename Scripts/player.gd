extends CharacterBody2D

## GRAVITY VARIABLES
const gravity_clamp : float = 300 # MAX GRAVITY
@export var base_gravity : float = 12 
@export var gravity_mod : float = 0.5 # THIS IS FOR FALLING GRAVITY AMP
@export var float_gravity : int = 40
@export var jump_end_early_gravity_mod : int = 10

## SPEED / MOVEMENT VARIABLES 
@export var max_speed : int = 90
@export var acceleration : int = 12

## JUMP VARIABLE
@export var jump_force : int = 275
 
## WALL JUMP VARIABLES / FRICTION VARIABLES
@export var walljump_force : int = 200
@export var walljump_speed : int = 400
@export var wall_friction : int = 30

## COYOTE VARIABLES 
@export var coyote_buffer_length : int = 10
var coyote_counter : int = 0 # variable to hold current count state

## JUMP BUFFER VARIABLES
# @export var jump_force_add : int = 100 - not sure what this was for ?
@export var jump_buffer_length : int = 13
var jump_buffer_counter : int = 0 # variable to hold current count state

## STATE CHECKS
var falling_check : bool = false
var floating_check : bool = false

## CHARACTER NODE VARIABLES
@onready var animated_sprite = $AnimatedSprite2D
@onready var collider = $CollisionShape2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight


func _physics_process(delta):
	# clamp x velocity to max speed
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	# check if player is on the floor, play idle animation if true, 
	# set coyote timer to the coyote time length
	# set falling check to false since player has returned to the floor
	if is_on_floor():
		$AnimatedSprite2D.play("idle")
		falling_check = false
		coyote_counter = coyote_buffer_length
		
	# check if player is not on the floor and begin deincrementing the coyote counter every frame
	if not is_on_floor():
		set_coyote_counter()
		set_gravity()

	if Global.can_move:
		check_jump()

		move()

		# drop_down()

		play_animation()

		check_walljump()

		check_short_jump()
		
		check_floating()

		move_and_slide()


func move():
	if Input.is_action_pressed("move_right"):
		move_right()
		if ray_cast_right.is_colliding() and not is_on_floor() and velocity.y > 0:
			velocity.y = wall_friction
	elif Input.is_action_pressed("move_left"):
		move_left()
		if ray_cast_left.is_colliding() and not is_on_floor() and velocity.y > 0:
			velocity.y = wall_friction
	else:
		stop_moving()


## COYOTE COUNTER 
func set_coyote_counter():
	if coyote_counter > 0:
			coyote_counter -= 1

## GRAVITY MECHANIC
func set_gravity():
	# add gravity to the player as they are not on the floor
	velocity.y += base_gravity
	
	if velocity.y > 0:
		velocity.y += base_gravity * gravity_mod
	# clamp the y velocity to the gravity max
	if velocity.y > gravity_clamp:
		velocity.y = gravity_clamp

## MOVE RIGHT
func move_right():
	# checks if character is on the floor, if so, multiples acceleration
	if not is_on_floor():
		velocity.x += acceleration * 2
	else:
		velocity.x += acceleration
	$AnimatedSprite2D.flip_h = false

## MOVE LEFT 
func move_left():
	# checks if character is on the floor, if so, multiples acceleration
	if not is_on_floor():
		velocity.x -= acceleration * 2
	else:
		velocity.x -= acceleration
	$AnimatedSprite2D.flip_h = true

## DECELLERATION MECHANIC
func stop_moving():
	# decelerate the player if no direction input is made
	velocity.x = lerp(velocity.x, 0.0, 0.2)

## JUMP MECHANIC - Coyote timer + Jump buffer
func check_jump():
	if Input.is_action_just_pressed("jump"):
		jump_buffer_counter = jump_buffer_length
			
		# start counting down the buffer counter every frame if it is greater than 0
		if jump_buffer_counter > 0:
			jump_buffer_counter -= 1
			
		# Check if jump is allowed, then jump (Buffer must be active and coyote counter must be active)
		if jump_buffer_counter > 0 and coyote_counter > 0:
			# set y velocity to the negative jump force
			velocity.y = -jump_force

			# set jump buffer & coyote to zero so you cannot jump again
			jump_buffer_counter = 0
			coyote_counter = 0

## JUMP / FALLING ANIMATION PLAYER
func play_animation():
		# check if y velocity is less than 0, then play jump animation
	if velocity.y < 0 and floating_check == false:
		$AnimatedSprite2D.play("jumping")
	# check if y velocity is greater than 0 & falling check is false, play falling animation
	if velocity.y > 0 and falling_check == false:
		$AnimatedSprite2D.play("falling")
		falling_check = true

## FLOATING MECHANIC
func check_floating():
	# check if y velocity is greater than zero & if jump button is being pressed
	if velocity.y > 0 and Input.is_action_pressed("jump"):
		# set velocity y to the float gravity
		velocity.y = float_gravity
		if floating_check == false:
			# if floating check is false, play floating animation and set it to true
			$AnimatedSprite2D.play("floating")
			floating_check = true
	if Input.is_action_just_released("jump"):
		# if floating is true but jump is released, set animation to falling
		if floating_check == true:
			$AnimatedSprite2D.play("falling")
			floating_check = false

## SHORT HOP MECHANIC
func check_short_jump():
	# if jump is let go early -> add extra downward force to negate the jump velocity 
	# and apply variable jump height
	if Input.is_action_just_released("jump"):		
		if -250 < velocity.y && velocity.y < 0: # This keeps the jump from ending super short, 
			# but it causes a weird glitch where the jump buffer sends you to max jump
			velocity.y = jump_end_early_gravity_mod

## WALL JUMP MECHANIC 
func check_walljump():
	# checks to see if left raycast is colliding with a wall, if player jumps, and if they are not
	# on the floor to prevent mega jumps, then sets jump force to variable and sets speed to opp
	# direction of the wall to 'push' the character away from the wall
	if ray_cast_left.is_colliding() and Input.is_action_just_pressed("jump") and not is_on_floor():
		velocity.x += walljump_speed
		velocity.y = -walljump_force
	if ray_cast_right.is_colliding() and Input.is_action_just_pressed("jump") and not is_on_floor():
		velocity.y = -walljump_force
		velocity.x += -walljump_speed


## ALLOW FOR DROPPING THROUGH ONE WAY PLATFORMS
#func drop_down():
	#if Input.action_press("move_down") and :
		#





