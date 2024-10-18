extends Node2D

var hitbox : Area2D

var obstacle = null

var cleared : bool = false

func _ready():
	hitbox = $PlayerHitbox

func _input(event):
	if event.is_action_pressed("jump"):
		print("interacted")
		if obstacle:
			obstacle.clear_obstacle()
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
	pass #emote so player does something while no obstacles
