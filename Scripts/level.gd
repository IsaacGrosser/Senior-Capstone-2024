extends Node2D

@onready var collectible = $Collectible
signal level_changed()
@export var level_name = "level"
@onready var gateway = $Gateway


func _ready():
	# collectible.connect("collected", start_timer)
	## THIS SYSTEM ONLY ALLOWS FOR ONE USABLE GATEWAY TO TRANSITION LEVELS in a scalible manner
	gateway.connect("entered", on_switch_level)


func on_switch_level():
	emit_signal("level_changed", level_name)


