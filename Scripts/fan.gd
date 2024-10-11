extends Node2D

@onready var ray_cast = $RayCast2D
@onready var collision_shape = $Area2D/CollisionShape2D

@export var fan_strength : int = 100

var is_colliding = false
var character_body

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding:
		character_body.velocity.y = -fan_strength
	


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		character_body = body
		is_colliding = true


func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		is_colliding = false
