class_name Idle extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

func Enter():
	state_name = "Idle"
	if character_body.debug_state_messages:
		print("entered IDLE state")
	if animation_player:
		animation_player.play("idle")
		
		# Added to check if it came from a falling state, then applies 'squash' for landing 
		if previous_state == "Fall":
			animation_player.scale = Vector2(1.3, 0.5)

func Exit():
	pass

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
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
		
	if !Global.can_move:
		Transitioned.emit(self, "Locked")
