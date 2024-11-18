extends Node2D

@onready var ray_cast_left = $Raycasts/RayCastLeft
@onready var ray_cast_right = $Raycasts/RayCastRight
@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 50
var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# checks to see if the right raycast is hitting a wall and if it is,
	# it changes directions of the movement and the animation 
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	# checks to see if the left raycast is hitting a wall and if it is,
	# it changes directions of the movement and the animation 
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	# moves position of x based on the direction the character is facing and
	# the speed they can move, and the delta to account for dif framerates
	position.x += direction * SPEED * delta


