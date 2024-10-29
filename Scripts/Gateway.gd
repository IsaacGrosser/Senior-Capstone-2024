extends Node2D

@onready var area2d = $Area2D

signal entered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		Global.can_move = false
		print("You have entered a gateway!")
		emit_signal("entered")
