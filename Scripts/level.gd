extends Node2D

signal level_changed()
@export var level_name = "level"
@onready var gateway = $Gateway
var changed_through_death : bool = false
@export var spawn_position : Node2D

func _ready():
	# collectible.connect("collected", start_timer)
	## THIS SYSTEM ONLY ALLOWS FOR ONE USABLE GATEWAY TO TRANSITION LEVELS in a scalible manner
	gateway.connect("entered", on_switch_level)


func on_switch_level():
	emit_signal("level_changed", level_name)


func get_level_name():
	return level_name

func get_spawn_position():
	return spawn_position.global_position
