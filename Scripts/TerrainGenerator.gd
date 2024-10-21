extends Node2D

var straight_scene = preload("res://Scenes/Terrain/StraightTerrain.tscn")
var upwards_scene = preload("res://Scenes/Terrain/UpwardsTerrain.tscn")
var downwards_scene = preload("res://Scenes/Terrain/DownwardsTerrain.tscn")
var new_terrain
var prev_terrain_vpos = 0
var new_terrain_vpos = 0
var current_terrain_y = 600

@export_category("TerrainAssets")
@export var straight_sprites : Array[Sprite2D]
@export var downwards_sprites : Array[Sprite2D]
@export var upwards_sprites : Array[Sprite2D]

@export_category("TerrainVariables")
@export var change_speed : float
var uplevel_num : int
var downlevel_num : int
var current_level : int = 0

func _ready():
	uplevel_num = 1#downwards_sprites.size()
	downlevel_num = -1#upwards_sprites.size()


func _on_timer_timeout():
	set_new_terrain_pos()

func set_new_terrain_pos():
	new_terrain_vpos = randi_range(0,6)
	match new_terrain_vpos:
		0, 1, 2, 3, 4:
			maintain_terrain_level()
		5:
			if current_level == uplevel_num:
				new_terrain_vpos = randi_range(0, 5)
				if new_terrain_vpos == 0:
					reduce_terrain_level()
				else:
					maintain_terrain_level()
			else:
				raise_terrain_level()
		6:
			if current_level == downlevel_num:
				new_terrain_vpos = randi_range(0, 5)
				if new_terrain_vpos == 0:
					raise_terrain_level()
				else:
					maintain_terrain_level()
			else:
				reduce_terrain_level()
	new_terrain.position.y = current_terrain_y
	new_terrain.position.x = DisplayServer.window_get_size().x + 350
	add_child(new_terrain)
	new_terrain = null

func raise_terrain_level():
	new_terrain = upwards_scene.instantiate()
	current_terrain_y -= 300
	current_level += 1

func reduce_terrain_level():
	new_terrain = downwards_scene.instantiate()
	current_terrain_y += 300
	current_level -= 1

func maintain_terrain_level():
	new_terrain = straight_scene.instantiate()
