extends Node2D


static var obstacle_speed : float = 10

@export var obstacle_type : String


var action_area : Area2D

func _ready():
	action_area = $ActionArea

func _process(_delta):
	move()

func move():
	position.x -= obstacle_speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func fail_obstacle():
	print("failed")
