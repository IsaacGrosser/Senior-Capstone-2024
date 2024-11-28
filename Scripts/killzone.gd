extends Area2D

signal player_died()
@onready var timer = $Timer
var randGen = RandomNumberGenerator.new()
var level_name = ""

func _ready():
	if get_parent().has_method("get_level_name"):
		var parent = get_parent()
		level_name = parent.get_level_name()

func _on_body_entered(body):
	if body is Player:
		print("You have died!")
		body.rotation = randGen.randf_range(-70, 70)
		body.handle_player_death()




