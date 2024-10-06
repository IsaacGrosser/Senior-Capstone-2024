extends CharacterBody2D

# GRAVITY VARIABLES
@export var  base_gravity : float = 50
const gravity_clamp : float = 500
@export var float_gravity : int = 40
@export var jump_end_early_gravity_mod : int = 200

# SPEED / MOVEMENT VARIABLES 
@export var  max_speed : int = 120
@export var acceleration : int = 20

# COYOTE VARIABLES 
@export var coyote_buffer_length : int = 15
var coyote_counter : int = 0

# JUMP VARIABLES
@export var  jump_force : int = 600
@export var jump_force_add : int = 100
@export var jump_buffer_length : int = 15
var jump_buffer_counter : int = 0

# STATE CHECKS
var falling_check : bool = false
var floating_check : bool = false

func _physics_process(_delta):
	# check if player is on the floor, play idle animation if true, 
	# set coyote timer to the coyote time length
	# set falling check to false since player has returned to the floor
	if is_on_floor():
		$AnimatedSprite2D.play("idle")
		falling_check = false
		coyote_counter = coyote_buffer_length
		
	# check if player is not on the floor and begin deincrementing the coyote counter every frame
	if not is_on_floor():
		if coyote_counter > 0:
			coyote_counter -= 1
		
		# add gravity to the player as they are not on the floor
		velocity.y += base_gravity
		# clamp the y velocity to the gravity max
		if velocity.y > gravity_clamp:
			velocity.y = gravity_clamp
	
	# if right direction is pressed, accelerate the player to the right
	# make animation horizontal flip false
	if Input.is_action_pressed("move_right"):
		velocity.x += acceleration
		$AnimatedSprite2D.flip_h = false
	# if left direction is pressed, accelerate the player to the right
	# make animation horizontal flip true
	elif Input.is_action_pressed("move_left"):
		velocity.x -= acceleration
		$AnimatedSprite2D.flip_h = true
	else: 
		# decelerate the player if no direction input is made
		velocity.x = lerp(velocity.x, 0.0, 0.5)
		
	# clamp x velocity to max speed
	velocity.x = clamp(velocity.x, -max_speed, max_speed)

	# if jump is pressed, set buffer counter to buffer length
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
		
	# check if y velocity is less than 0, then play jump animation
	if velocity.y < 0:
		$AnimatedSprite2D.play("jumping")
	# check if y velocity is greater than 0 & falling check is false, play falling animation
	if velocity.y > 0 and falling_check == false:
		$AnimatedSprite2D.play("falling")
		falling_check = true
	
	# check if y velocity is greater than zero & if jump button is being pressed
	if velocity.y > 0 and Input.is_action_pressed("jump"):
		# set velocity y to the float gravity
		velocity.y = float_gravity
		if floating_check == false:
			# if floating check is false, play floating animation and set it to true
			$AnimatedSprite2D.play("floating")
			floating_check = true
	
	# if jump is let go early -> add extra downward force to negate the jump velocity 
	# and apply variable jump height
	if Input.is_action_just_released("jump"):
		if velocity.y < 0:
			velocity.y = jump_end_early_gravity_mod
		# if floating is true but jump is released, set animation to falling
		if floating_check == true:
			$AnimatedSprite2D.play("falling")
			floating_check = false
	
	move_and_slide()

