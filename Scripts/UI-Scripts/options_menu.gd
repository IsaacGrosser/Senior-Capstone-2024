extends Control

@onready var back = $VBoxContainer/Back

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

## SETS MASTER VOLUME WHEN SLIDER IS ADJUSTED
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

## SETS SOUND EFFECTS VOLUME
func _on_sound_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), value)

## SETS MUSIC VOLUME
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
