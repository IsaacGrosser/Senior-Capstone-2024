extends Control

@onready var start = $VBoxContainer/Start
@onready var options = $VBoxContainer/Options
@onready var quit = $VBoxContainer/Quit



func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
