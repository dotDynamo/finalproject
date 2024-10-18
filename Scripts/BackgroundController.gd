extends Sprite2D

@export var scroll_speed : float
@export var background_index : int
var texture_width : float

func _ready():
	centered = false
	texture_width = texture.get_width()
	position.x = texture_width * background_index

func _process(_delta):
	position.x -= scroll_speed
	reposition()

func reposition():
	if position.x < -texture_width:
		position.x += 2 * texture_width
