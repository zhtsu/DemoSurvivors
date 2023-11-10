extends CanvasLayer

signal closed


@onready var ui_player_grid = $Control/Content/Scroller/VBoxContainer/PlayerGrid
@onready var ui_weapon_grid = $Control/Content/Scroller/VBoxContainer/WeaponGrid
@onready var ui_ability_grid = $Control/Content/Scroller/VBoxContainer/AbilityGrid
@onready var ui_enemy_grid = $Control/Content/Scroller/VBoxContainer/EnemyGrid
@onready var ui_item_name = $Control/Content/Detail/Name
@onready var ui_intro = $Control/Content/Detail/Text

var selected_item : CollectionItem = null


func _create_collection_items(data_list : Array[Dictionary], data_type : String, grid):
	for data in data_list:
		var item = Assets.tscn_collection_item.instantiate()
		item.connect("clicked", _on_collection_clicked)
		var icon_path = Assets.dir_tres + data_type + "/" + data["icon"]
		item.init(data["name"], icon_path, data_type)
		grid.add_child(item)


func _ready():
	_create_collection_items(Data.player_data_list, "player", ui_player_grid)
	_create_collection_items(Data.weapon_data_list, "weapon", ui_weapon_grid)
	_create_collection_items(Data.ability_data_list, "ability", ui_ability_grid)
	_create_collection_items(Data.enemy_data_list, "enemy", ui_enemy_grid)
	
	# Default select the first item
	selected_item = ui_player_grid.get_children()[0]
	_on_collection_clicked(selected_item)
	
	$AnimationPlayer.play_backwards("Exit")

func _on_background_button_down():
	closed.emit()
	$SoundPlayer.play()
	$AnimationPlayer.play("Exit")
	await $AnimationPlayer.animation_finished
	self.queue_free()


func _on_collection_clicked(collection_item : CollectionItem):
	if not selected_item == null:
		selected_item.hide_hover()
		
	selected_item = collection_item
	selected_item.show_hover()
	ui_item_name.text = selected_item.collection_item_name
	
	ui_intro.text = Data.find_introduction(
		selected_item.collection_item_name,
		selected_item.collection_item_type
	)
