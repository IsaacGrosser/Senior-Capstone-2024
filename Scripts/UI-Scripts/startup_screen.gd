extends Node2D

@onready var timer = $Timer
@onready var animation = $AnimatedSprite2D
@onready var start_game_timer = $"Start Game Timer"
@onready var audio = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	audio.play()

func _on_timer_timeout():
	animation.play()


func _on_animated_sprite_2d_animation_finished():
	start_game_timer.start()


func _on_start_game_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
