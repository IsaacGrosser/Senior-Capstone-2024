extends Area2D

@export var gravity_clamp : int = 225
@export var player_gravity : int = 12

func _on_body_entered(body):
	if body is CharacterBody2D:
		Global.can_float = false
		body.velocity.x = 0
		body.velocity.y += player_gravity
	
	if body.velocity.y >= gravity_clamp:
		body.velocity.y == gravity_clamp

func _on_body_exited(body):
	if body is CharacterBody2D:
		Global.can_float = true

