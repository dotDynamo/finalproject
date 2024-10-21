extends Node2D

@export var scroll_speed : float

func _process(delta):
	position.x -= scroll_speed * delta
	despawn()

func despawn():
	if position.x < 0:
		queue_free()
