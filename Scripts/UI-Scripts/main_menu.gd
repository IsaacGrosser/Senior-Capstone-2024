extends Control

@onready var quit = $VBoxContainer/Quit
@onready var audio = $"Sound Effect Audio Player"
@onready var play_again = $"VBoxContainer/Play Again"
@onready var main_menu = $"VBoxContainer/Main Menu"

func _on_start_pressed():
	audio.play()
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_options_pressed():
	audio.play()
	get_tree().change_scene_to_file("res://Scenes/UI/options_menu.tscn")

func _on_quit_pressed():
	audio.play()
	get_tree().quit()


