extends Control

@onready var back = $VBoxContainer/Back

func _on_back_pressed():
	Global.can_move = true
	self.hide()
	Engine.time_scale = 1

## SETS MASTER VOLUME WHEN SLIDER IS ADJUSTED
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

## SETS SOUND EFFECTS VOLUME
func _on_sound_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), value)

## SETS MUSIC VOLUME
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

## QUITS GAME ON BUTTON PRESSED
func _on_quit_pressed():
	get_tree().quit()
