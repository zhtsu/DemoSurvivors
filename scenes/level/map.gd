class_name Map
extends TileMap


# 16 x 16
const tile_size := 16
# 648 / 16
const tile_max_row := 24
# 1152 / 16
const tile_max_col := 36

# Initialization is required before use
var player : Player
var active_map_name := "Grass"

var used_tile_source: int
var resource_density := 0.1
# Coords data looks like this: [[x1, y1], [x2, y2], [x3, y3], [x4, y4]]
var used_ground_tile_coords : Array
var used_resource_tile_coords : Array
var previous_player_position := Vector2(0.0, 0.0)
var first_generate := true

@export var as_background : bool = false
@onready var anim_camera := $AnimCamera

func init(in_player : Player, in_map_name : String):
	player = in_player
	active_map_name = in_map_name
	

func _ready():
	var tile_coord_dict : Dictionary
	var json_file = FileAccess.open(Assets.path_tile_coords, FileAccess.READ)
	tile_coord_dict = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	used_tile_source = tile_coord_dict[active_map_name]["Source"]
	used_ground_tile_coords = tile_coord_dict[active_map_name]["Ground"] as Array
	used_resource_tile_coords = tile_coord_dict[active_map_name]["Resource"] as Array
	var used_tile_set = load(tile_coord_dict[active_map_name]["ResPath"]) as TileSet
	self.tile_set = used_tile_set
	
	if as_background == false:
		anim_camera.enabled = false
	
		if not player == null:
			previous_player_position = player.position
			_update_map(player.position)
			_generate_resource(_cal_boundary(player.position))
			first_generate = false
	else:
		resource_density = 1.0
		_update_map($AnimCamera.position)
		_generate_resource(_cal_boundary($AnimCamera.position))
		first_generate = false


func _process(_delta):
	if as_background:
		$AnimCamera.position += Vector2(0.6, -0.6)
		_update_map($AnimCamera.position)
	
	if not player == null and \
	   (abs(player.position.x - previous_player_position.x) > tile_size or \
	   abs(player.position.y - previous_player_position.y) > tile_size):
		_update_map(player.position)
		previous_player_position = player.position


func _cal_boundary(player_position : Vector2) -> Rect2:
	var boundary = Rect2()
	var map_width = tile_max_col * tile_size
	var map_height = tile_max_row * tile_size
	var map_half = Vector2(map_width * 0.5, map_height * 0.5)
	boundary.position = (Vector2(player_position) - map_half) / tile_size
	boundary.end = (Vector2(player_position) + map_half) / tile_size
	boundary.size = boundary.end - boundary.position
	return boundary
	
	
	
func _generate_ground(boundary : Rect2):
	if used_ground_tile_coords.is_empty():
		return
	
	for i in range(boundary.position.x, boundary.end.x):
		for j in range(boundary.position.y, boundary.end.y):
			if get_cell_source_id(0, Vector2(i, j)) == -1:
				var tile_coord = used_ground_tile_coords.pick_random() as Array[int]
				tile_coord = Vector2(tile_coord[0], tile_coord[1])
				set_cell(0, Vector2(i, j), used_tile_source, tile_coord)
				# TODO: This is a dirty design that generate resource here
				if not first_generate and randf_range(0.0, 100.0) < resource_density:
					tile_coord = used_resource_tile_coords.pick_random() as Array[int]
					tile_coord = Vector2(tile_coord[0], tile_coord[1])
					set_cell(1, Vector2(i, j), used_tile_source, tile_coord)
	
	
func _generate_resource(boundary : Rect2):
	if used_resource_tile_coords.is_empty():
		return
	
	for i in range(boundary.position.x, boundary.end.x):
		for j in range(boundary.position.y, boundary.end.y):
			if get_cell_source_id(1, Vector2(i, j)) == -1:
				var tile_coord = used_resource_tile_coords.pick_random() as Array
				tile_coord = Vector2(tile_coord[0], tile_coord[1])
				if randf_range(0.0, 100.0) < resource_density:
					set_cell(1, Vector2(i, j), used_tile_source, tile_coord)
	
	
func _clear_invisible_tiles(boundary : Rect2, layer : int):
	for cell in get_used_cells(layer):
		if not (cell.x > boundary.position.x and cell.y > boundary.position.y and \
		   cell.x < boundary.end.x and cell.y < boundary.end.y):
			set_cell(layer, Vector2(cell.x, cell.y))


func _update_map(player_position : Vector2):
	var b = _cal_boundary(player_position)
	# Generate ground
	_generate_ground(b)
	# Clear invisible tiles in all layer
	_clear_invisible_tiles(b, 0)
	_clear_invisible_tiles(b, 1)
	
