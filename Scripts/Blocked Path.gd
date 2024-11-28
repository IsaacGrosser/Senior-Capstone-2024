extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.has_honey:
		self.queue_free()

