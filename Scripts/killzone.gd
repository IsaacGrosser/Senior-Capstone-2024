extends Area2D

@onready var timer = $Timer
var randGen = RandomNumberGenerator.new()

func _on_body_entered(body):
	if body is CharacterBody2D:
		print("You have died!")
		body.rotation = randGen.randf_range(-70, 70)
		# gets player collision body and removes it so character falls through the floor when dying
		body.get_node("CollisionShape2D").queue_free()
		
		# Sets time to go at half speed! Must reset it!
		Engine.time_scale = 0.5
		timer.start()


func _on_timer_timeout():
	# Sets time to go at default speed
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
