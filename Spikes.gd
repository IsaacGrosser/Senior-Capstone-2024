extends Node2D

@onready var timer = $Timer
var randGen = RandomNumberGenerator.new()

func _on_area_2d_body_entered(body):
	if body is Player:
		print("You have died!")
		body.rotation = randGen.randf_range(-70, 70)
		# gets player collision body and removes it so character falls through the floor when dying
		# body.get_node("CollisionShape2D").queue_free()
		body.handle_player_death()
