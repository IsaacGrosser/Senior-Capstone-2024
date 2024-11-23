class_name Locked extends State

@export var character_body : CharacterBody2D
@export var animation_player : AnimatedSprite2D

func Enter():
	state_name = "Locked"
	print("entered LOCKED state")
	if animation_player:
		animation_player.stop()

func Exit():
	pass

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
	# if State belongs to character body, set character body's velocity to slow to a stop
	if character_body:
		character_body.velocity.x = 0
		character_body.velocity.y = 0
	handle_transitions()

func handle_transitions():
	if Global.can_move == true:
		Transitioned.emit(self, "Idle")

