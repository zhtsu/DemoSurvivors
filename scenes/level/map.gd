extends TileMap

class_name Map


const Assets = preload("res://scenes/global/assets.gd")

# 16 x 16
const tile_size := 16
# 648 / 16
const tile_max_row := 18
# 1152 / 16
const tile_max_col := 28

# Initialization is required before use
var player : Player
var active_map_name := "Desert"

var used_ground_tile_coords : Array
var previous_player_position := Vector2(0.0, 0.0)

@export var as_background : bool = false
@onready var anim_camera := $AnimCamera

func init(in_player : Player, in_map_name : String):
	player = in_player
	active_map_name = in_map_name
	

func _ready():
	if as_background == false:
		anim_camera.enabled = false
	
	var tile_coord_dict : Dictionary
	var json_file = FileAccess.open(Assets.path_tile_coords, FileAccess.READ)
	tile_coord_dict = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	used_ground_tile_coords = tile_coord_dict[active_map_name]["Ground"] as Array
	var used_tile_set = load(tile_coord_dict[active_map_name]["ResPath"]) as TileSet
	self.tile_set = used_tile_set
	
	if not player == null:
		previous_player_position = player.position
		generate_map(player.position)


func _process(_delta):
	if not player == null and \
	   (abs(player.position.x - previous_player_position.x) > tile_size or \
	   abs(player.position.y - previous_player_position.y) > tile_size):
		previous_player_position = player.position
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
				var tile_coord = used_ground_tile_coords.pick_random() as Array
				set_cell(0, Vector2(i, j), 0, Vector2(tile_coord[0], tile_coord[1]))
				
	for cell in get_used_cells(0):
		if not (cell.x > b.position.x and cell.y > b.position.y and \
		   cell.x < b.end.x and cell.y < b.end.y):
			set_cell(0, Vector2(cell.x, cell.y))
