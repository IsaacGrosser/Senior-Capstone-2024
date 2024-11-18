extends Node
class_name State

signal Transitioned # Call this signal when you want to leave this state

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
