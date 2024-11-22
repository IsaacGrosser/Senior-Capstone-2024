class_name State extends Node

signal Transitioned # Call this signal when you want to leave this state
var previous_state = "None"
var state_name = ""

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
