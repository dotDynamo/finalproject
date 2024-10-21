extends CharacterBody2D

var hitbox : Area2D

var obstacle = null

var cleared : bool = false

@export var gravity : float

func _ready():
	hitbox = $PlayerHitbox

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
	position.x = 250
	move_and_slide()

func _input(event):
	if event.is_action_pressed("jump"):
		if obstacle:
			obstacle.get_parent().clear_obstacle()
			clear_obstacle()
			cleared = true
		else:
			emote()

func _on_player_hitbox_area_entered(area):
	obstacle = area

func _on_player_hitbox_area_exited(area):
	if not cleared:
		area.get_parent().fail_obstacle() #if obstacle animates
		fail_obstacle()
	obstacle = null
	cleared = false

func fail_obstacle():
	$Sprite.modulate = Color("red")
	await get_tree().create_timer(0.5).timeout
	$Sprite.modulate = Color("black")

func emote():
	$Sprite.modulate = Color("white")
	await get_tree().create_timer(0.5).timeout
	$Sprite.modulate = Color("black")

func clear_obstacle():
	$Sprite.modulate = Color("green")
	await get_tree().create_timer(0.5).timeout
	$Sprite.modulate = Color("black")
