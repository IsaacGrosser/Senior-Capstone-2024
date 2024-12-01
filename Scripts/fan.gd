extends Node2D

@onready var collision_shape = $Area2D/CollisionShape2D
@export var fan_strength : int = 100
@onready var particles = $GPUParticles2D


var is_colliding = false
var character_body
var fan_pointing_down : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if 170.0 <= self.rotation && self.rotation <= 190.0:
		fan_pointing_down = true
		particles.process_material = preload("res://Assets/Particles/downward_particles.tres")
	if is_colliding && !fan_pointing_down:
		character_body.velocity.y = -fan_strength
	if is_colliding && fan_pointing_down:
		character_body.velocity.y = fan_strength


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		character_body = body
		is_colliding = true


func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		is_colliding = false
