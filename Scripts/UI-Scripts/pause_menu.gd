extends Control

@onready var back = $VBoxContainer/Back
@onready var master_slider = $VBoxContainer/master_slider

var current_master_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
var current_sound_effect_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound Effects"))
var current_music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))

func _ready():
	master_slider.grab_focus()

func _on_back_pressed():
	Global.can_move = true
	self.hide()
	Engine.time_scale = 1

## SETS MASTER VOLUME WHEN SLIDER IS ADJUSTED
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	current_master_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))

## SETS SOUND EFFECTS VOLUME
func _on_sound_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), value)
	current_sound_effect_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound Effects"))

## SETS MUSIC VOLUME
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	current_music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))

## QUITS GAME ON BUTTON PRESSED
func _on_quit_pressed():
	get_tree().quit()

func get_master_volume():
	return current_master_volume

func get_sound_effect_volume():
	return current_sound_effect_volume

func get_music_volume():
	return current_music_volume


