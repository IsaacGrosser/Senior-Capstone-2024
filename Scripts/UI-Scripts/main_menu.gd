extends Control

@onready var start = $VBoxContainer/Start
@onready var options = $VBoxContainer/Options
@onready var quit = $VBoxContainer/Quit
@onready var audio = $"Sound Effect Audio Player"

func _on_start_pressed():
	audio.play()
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_options_pressed():
	audio.play()
	get_tree().change_scene_to_file("res://Scenes/UI/options_menu.tscn")

func _on_quit_pressed():
	audio.play()
	get_tree().quit()
