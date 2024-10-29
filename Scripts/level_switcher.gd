extends Node

@onready var current_level = $"Level 1"
@onready var animation = $AnimationPlayer

var next_level = null

# Called when the node enters the scene tree for the first time.
func _ready():
	current_level.connect("level_changed", handle_level_changed)


func handle_level_changed(current_level_name: String):
	var next_level_name : String
	
	match current_level_name:
		"level_1":
			next_level_name = "2"
		"level_2":
			next_level_name = "1"
		_:
			return
	
	next_level = load("res://Scenes/level_" + next_level_name + ".tscn").instantiate()
	animation.play("fade_in")
	next_level.connect("level_changed", handle_level_changed)


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			current_level.queue_free()
			add_child(next_level)
			current_level = next_level
			next_level = null
			animation.play("fade_out")
			Global.can_move = true

