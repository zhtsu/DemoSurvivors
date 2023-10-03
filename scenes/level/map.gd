extends TileMap

class_name Map

const tile_size := 16
# 648 / 16
const tile_max_row := 41
# 1152 / 16
const tile_max_col := 72
var noise := FastNoiseLite.new()
# Player's initialization is required before use
var player : Player
@export var as_background : bool = false
@onready var anim_camera := $AnimCamera

func _ready():
	if as_background == false:
		anim_camera.enabled = false
		
	randomize()
	noise.seed = randi()
	
	for i in tile_max_row:
		for j in tile_max_col:
			set_cell(0, Vector2(j, i), 0, Vector2(2, 4))
			
	print_debug(cal_boundary(Vector2(0, 0)))
	var b = cal_boundary(Vector2(0, 0))
	for i in range(b.position.x, b.end.x):
		for j in range(b.position.y, b.end.y):
			set_cell(0, Vector2(i, j), 0, Vector2(7, 2))
			


func cal_boundary(player_position : Vector2) -> Rect2i:
	var boundary = Rect2i()
	var map_width = tile_max_col * tile_size
	var map_height = tile_max_row * tile_size
	var map_half = Vector2i(map_width / 2, map_height / 2)
	boundary.position = (Vector2i(player_position) - map_half) / tile_size
	boundary.end = (Vector2i(player_position) + map_half) / tile_size
	boundary.size = boundary.end - boundary.position
	return boundary

func generate_map(player_position : Vector2):
	var pos = local_to_map(player_position)
