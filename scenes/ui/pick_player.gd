extends Control


const Enums = preload("res://scenes/mngr/enums.gd")

# Icon for map item
const tex_icon_map_forest = preload("res://assets/textures/icons/icon_map_forest.png")
const tex_icon_map_cave = preload("res://assets/textures/icons/icon_map_cave.png")
const tex_icon_map_desert = preload("res://assets/textures/icons/icon_map_desert.png")
const tex_icon_map_tundra = preload("res://assets/textures/icons/icon_map_tundra.png")
const tex_icon_map_challenge = preload("res://assets/textures/icons/icon_map_challenge.png")
#
const tscn_level = preload("res://scenes/map/level.tscn")
const tscn_transition = preload("res://scenes/ui/transition.tscn")

const MapItemData = {
	Enums.EMap.Forest:    tex_icon_map_forest,
	Enums.EMap.Cave:      tex_icon_map_cave,
	Enums.EMap.Desert:    tex_icon_map_desert,
	Enums.EMap.Tundra:    tex_icon_map_tundra,
	Enums.EMap.Challenge: tex_icon_map_challenge
}
#
const tscn_player_item = preload("res://scenes/ui/player_item.tscn")
const tscn_map_item = preload("res://scenes/ui/map_item.tscn")

var max_player_count = Enums.EPlayer.size()
var selected_player_type = Enums.EPlayer.NinjaFrog
var selected_map_type = Enums.EMap.Forest

@onready var ui_player_anim = $Background/VBoxContainer/HBoxContainer/PlayerBox/PlayerAnim
@onready var ui_player_name = $Background/VBoxContainer/PlayerName
@onready var ui_player_list = $Background/VBoxContainer/PlayerList
@onready var ui_map_list = $Background/RightBox/Maps/VBoxContainer/ScrollContainer/MapItems

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Enter")
	# Init player list
	for player_type in Enums.EPlayer.values():
		var player_item = tscn_player_item.instantiate()
		player_item.connect("item_clicked", _on_player_item_clicked)
		player_item.connect("mouse_entered", _play_button_hover_sound)
		if player_type == Enums.EPlayer.NinjaFrog:
			player_item.init_player_item(
				load("res://tress/sf_ninja_frog.tres"), player_type, "Ninja Frog")
			ui_player_list.add_child(player_item)
		elif player_type == Enums.EPlayer.MaskDude:
			player_item.init_player_item(
				load("res://tress/sf_mask_dude.tres"), player_type, "Mask Dude")
			ui_player_list.add_child(player_item)
		elif player_type == Enums.EPlayer.PinkMan:
			player_item.init_player_item(
				load("res://tress/sf_pink_man.tres"), player_type, "Pink Man")
			ui_player_list.add_child(player_item)
		elif player_type == Enums.EPlayer.VirtualGuy:
			player_item.init_player_item(
				load("res://tress/sf_virtual_guy.tres"), player_type, "Virtual Guy")
			ui_player_list.add_child(player_item)
			
	# Init button's state in player_list
	var player_list = ui_player_list.get_children()
	if player_list.size() > 0:
		player_list[0].grab_focus()
		player_list[0].play_anim("Idle")
		# Init player box
		ui_player_anim.sprite_frames = player_list[0].get_player_sprite_frames()
		ui_player_anim.play("Walk")
		ui_player_name.text = player_list[0].player_name
	else:
		ui_player_anim.sprite_frames = null
		ui_player_name.text = "Character"
	
	# Init map items
	for map_item_key in MapItemData:
		var map_item = tscn_map_item.instantiate()
		map_item.init_map_item(Enums.EMap.keys()[map_item_key], MapItemData[map_item_key])
		map_item.type = map_item_key
		map_item.connect("clicked", _on_map_item_clicked)
		map_item.connect("mouse_entered", _play_button_hover_sound)
		ui_map_list.add_child(map_item)
	
	var map_items = ui_map_list.get_children()
	if map_items.size() > 0:
		map_items[0].show_seleted_mask()
		
	
func _on_map_item_clicked(map_icon : CompressedTexture2D, map_type : Enums.EMap):
	_play_button_down_sound()
	selected_map_type = map_type
	$MapBg.texture = map_icon
	for item in ui_map_list.get_children():
		item.hide_selected_mask()


func _reset_selected_player():
	for player_item in ui_player_list.get_children():
		player_item.reset()
	

func _update_player_data(player_type: int):
	if player_type < 0:
		player_type = abs(player_type)
	player_type %= max_player_count
	
	var player_list = ui_player_list.get_children()
	if player_type < player_list.size():
		player_list[player_type].grab_focus()
		player_list[player_type].play_anim("Idle")
	
	if player_type == Enums.EPlayer.NinjaFrog:
		ui_player_anim.sprite_frames = load("res://tress/sf_ninja_frog.tres")
		ui_player_name.text = "Ninja Frog"
	elif player_type == Enums.EPlayer.MaskDude:
		ui_player_anim.sprite_frames = load("res://tress/sf_mask_dude.tres")
		ui_player_name.text = "Mask Dude"
	elif player_type == Enums.EPlayer.PinkMan:
		ui_player_anim.sprite_frames = load("res://tress/sf_pink_man.tres")
		ui_player_name.text = "Pink Man"
	elif player_type == Enums.EPlayer.VirtualGuy:
		ui_player_anim.sprite_frames = load("res://tress/sf_virtual_guy.tres")
		ui_player_name.text = "Virtual Guy"

	ui_player_anim.play("Walk")

func _on_player_item_clicked(player_type : int):
	_play_button_down_sound()
	_reset_selected_player()
	selected_player_type = player_type as Enums.EPlayer
	_update_player_data(player_type)


func _play_button_down_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_down")
	
	
func _play_button_hover_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_hover")


func _on_left_switch_pressed():
	_on_player_item_clicked(selected_player_type + max_player_count - 1)


func _on_right_switch_pressed():
	_on_player_item_clicked(selected_player_type + 1)


func _on_back_button_pressed():
	_play_button_down_sound()
	$AnimationPlayer.play("Exit")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Exit":
		queue_free()


func _on_back_button_mouse_entered():
	_play_button_hover_sound()


func _on_start_button_pressed():
	_play_button_down_sound()
	var transition_scene = tscn_transition.instantiate()
	transition_scene.call("init", Enums.ETransitionDirection.Normal)
	transition_scene.connect("finished", _create_game_level)
	add_child(transition_scene)
	
	
func _create_game_level():
	var level_scene = tscn_level.instantiate()
	level_scene.call("init", selected_player_type, selected_map_type)
	get_tree().get_first_node_in_group("main").add_child(level_scene)
	get_tree().get_first_node_in_group("main_menu").queue_free()
	get_tree().get_first_node_in_group("audio_mngr").call("mute")


func _on_start_button_mouse_entered():
	_play_button_hover_sound()
	
