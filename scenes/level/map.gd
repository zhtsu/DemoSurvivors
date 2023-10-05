extends TileMap

class_name Map


const Enums = preload("res://scenes/global/enums.gd")


const tile_size := 16
# 648 / 16
const tile_max_row := 16
# 1152 / 16
const tile_max_col := 26
var noise_x := FastNoiseLite.new()
var noise_y := FastNoiseLite.new()
# Player's initialization is required before use
var player : Player
@export var as_background : bool = false
@onready var anim_camera := $AnimCamera

func _ready():
	if as_background == false:
		anim_camera.enabled = false
		
	randomize()
	noise_x.seed = randi()
	noise_y.seed = randi()
	
	player = get_tree().get_first_node_in_group("player")
	generate_map(player.position)


func _process(_delta):
	if player.state == Enums.EState.Walk:
		generate_map(player.position)


func cal_boundary(player_position : Vector2) -> Rect2:
	var boundary = Rect2()
	var map_width = tile_max_col * tile_size
	var map_height = tile_max_row * tile_size
	var map_half = Vector2(map_width * 0.5, map_height * 0.5)
	boundary.position = (Vector2(player_position) - map_half) / tile_size
	boundary.end = (Vector2(player_position) + map_half) / tile_size
	boundary.size = boundary.end - boundary.position
	return boundary
	

func generate_map(player_position : Vector2):
	var b = cal_boundary(player_position)
	for i in range(b.position.x, b.end.x):
		for j in range(b.position.y, b.end.y):
			if get_cell_source_id(0, Vector2(i, j)) == -1:
				var x = randi_range(1, 11)
				var y = randi_range(39, 42)
				set_cell(0, Vector2(i, j), 0, Vector2(x, y))
				
	for cell in get_used_cells(0):
		if not (cell.x > b.position.x and cell.y > b.position.y and \
		   cell.x < b.end.x and cell.y < b.end.y):
			set_cell(0, Vector2(cell.x, cell.y))
