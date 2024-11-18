extends State
class_name Idle

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

var move_direction : Vector2

func Enter():
	if animation_player:
		animation_player.play("idle")


func Physics_Update(delta : float):
	# if State belongs to character body, set character body's velocity to slow to a stop
	if character_body:
		character_body.velocity.x = lerp(character_body.velocity.x, 0.0, 0.2)
		
