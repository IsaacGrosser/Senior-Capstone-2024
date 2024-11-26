extends AnimatedSprite2D

@onready var action_label = $"Action Label"
@onready var directions_label = $"Directions Label"
@onready var honeyjar = $"."
@onready var timer = $Timer
@onready var audio = $AudioStreamPlayer2D
@onready var countdown_label = $"Countdown Label"

var is_in_area = false
var time_left : float 

# Called when the node enters the scene tree for the first time.
func _ready():
	action_label.hide()
	directions_label.hide()
	countdown_label.hide()
	countdown_label.text = str(ceil(timer.wait_time))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_in_area:
		if Input.is_action_just_pressed("interact") && !Global.has_honey:
			directions_label.show()
		if Input.is_action_just_pressed("interact") && Global.has_honey:
			honeyjar.play()
	var countdown_time = ceil(timer.time_left)
	countdown_label.text = str(countdown_time)

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		action_label.show()
		is_in_area = true

func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		action_label.hide()
		is_in_area = false

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/UI/win_screen.tscn") # Change scene to end win screen

func _on_animation_finished():
	audio.play()
	countdown_label.show()
	timer.start()
