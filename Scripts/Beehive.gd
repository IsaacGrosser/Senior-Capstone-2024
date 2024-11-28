extends AnimatedSprite2D

@onready var area_2d = $Area2D


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		Global.score += 1
		Global.has_honey = true
		self.queue_free()
