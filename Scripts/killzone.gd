extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	print("You have died!")
	
	# get_tree().get_first_node_in_group("Player")
	
	# Sets time to go at half speed! Must reset it!
	Engine.time_scale = 0.5
	timer.start()


func _on_timer_timeout():
	# Sets time to go at default speed
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
