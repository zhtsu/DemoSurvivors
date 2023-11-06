extends CanvasLayer

signal closed

const Assets = preload("res://scenes/global/assets.gd")

@onready var player_grid = $Control/Content/Scroller/VBoxContainer/PlayerGrid
@onready var weapon_grid = $Control/Content/Scroller/VBoxContainer/WeaponGrid
@onready var ability_grid = $Control/Content/Scroller/VBoxContainer/AbilityGrid

var MAIN : Main


func _create_collection_items(data_list : Array[Dictionary], data_type : String, grid):
	for data in data_list:
		var item = Assets.tscn_collection_item.instantiate()
		var icon_path = Assets.dir_tres + data_type + "/" + data["icon"]
		item.init(data["name"], icon_path)
		grid.add_child(item)


func _ready():
	MAIN = get_tree().get_first_node_in_group("main")
	_create_collection_items(MAIN.player_data_list, "player", player_grid)
	_create_collection_items(MAIN.weapon_data_list, "weapon", weapon_grid)
	_create_collection_items(MAIN.ability_data_list, "ability", ability_grid)
	#_create_collection_items(MAIN.enemy_data_list, "enemy")
	
	$AnimationPlayer.play_backwards("Exit")

func _on_background_button_down():
	closed.emit()
	$SoundPlayer.play()
	$AnimationPlayer.play("Exit")
	await $AnimationPlayer.animation_finished
	self.queue_free()
