extends Node

@onready var current_level = $"Level 1"
@onready var animation = $AnimationPlayer
@onready var label = $UI/PanelContainer/MarginContainer/GridContainer/Label
@onready var music_audio = $"Music Audio Player"
@onready var pause_menu = $"UI/Pause Menu"

var next_level = null
var paused

# Called when the node enters the scene tree for the first time.
func _ready():
	current_level.connect("level_changed", handle_level_changed)
	pause_menu.hide()
	#music_audio.play()

func _process(_delta):
	label.text = "Honeycomb: " + str(Global.score)
	if Input.is_action_just_pressed("pause"):
		handle_pause_menu()

func handle_level_changed(current_level_name: String):
	var next_level_name : String
	
	match current_level_name:
		"level_1":
			next_level_name = "2"
		"level_2":
			next_level_name = "3"
		"level_3":
			next_level_name = "4"
		"level_4":
			next_level_name = "5"
		"level_5":
			next_level_name = "6"
		"level_6":
			next_level_name = "7"
		"level_7":
			next_level_name = "8"
		_:
			return
	
	next_level = load("res://Scenes/Levels/level_" + next_level_name + ".tscn").instantiate()
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

func _on_music_audio_player_finished():
	music_audio.play()

func handle_pause_menu():
	if paused:
		Global.can_move = true
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		Global.can_move = false
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

