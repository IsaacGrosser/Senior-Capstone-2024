extends Node
class_name Running

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

var move_direction : Vector2

# Called when the node enters the scene tree for the first time.
func Enter():
	# if animation_player:
	#	animation_player.play("running")
	pass


func Physics_Update(delta: float):
	pass
