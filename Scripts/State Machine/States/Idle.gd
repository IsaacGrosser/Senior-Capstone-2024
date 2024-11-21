extends State
class_name Idle

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

var move_direction : Vector2

func Enter():
	state_name = "Idle"
	print("ENTERED IDLE STATE")
	print("My previous state is " + previous_state)
	if animation_player:
		animation_player.play("idle")

func Exit():
	pass

func Update(delta : float):
	pass

func Physics_Update(delta : float):
	# if State belongs to character body, set character body's velocity to slow to a stop
	if character_body:
		character_body.velocity.x = lerp(character_body.velocity.x, 0.0, 0.2)
	handle_transitions()

func handle_transitions():
	if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		Transitioned.emit(self, "Run")
	
	if Input.is_action_just_pressed("jump") or character_body.jump_buffer_active == true:
		character_body.jump_buffer_active = false
		Transitioned.emit(self, "Jump")
	
	if character_body && character_body.velocity.y >= 1:
		Transitioned.emit(self, "CoyoteTime")




