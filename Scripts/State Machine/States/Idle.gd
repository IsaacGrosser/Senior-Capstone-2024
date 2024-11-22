class_name Idle extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

func Enter():
	state_name = "Idle"
	print("entered IDLE state")
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
		character_body.velocity.x = lerp(character_body.velocity.x, 0.0, 0.3)
	handle_transitions()

func handle_transitions():
	if (Input.is_action_just_pressed("jump") or character_body.jump_buffer_active == true):
		character_body.jump_buffer_active = false
		Transitioned.emit(self, "Jump")
		
	if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		Transitioned.emit(self, "Run")
	
	if character_body && character_body.velocity.y >= 1:
		Transitioned.emit(self, "CoyoteTime")




