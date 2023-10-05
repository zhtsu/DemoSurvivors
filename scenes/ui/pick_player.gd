extends CanvasLayer


const Assets = preload("res://scenes/global/assets.gd")

var player_data_list : Array
var enemy_data_list : Array
var map_data_list : Array
var max_player_count = 0
var selected_player_idx = 0
var selected_map_name = "Grass"

@onready var sound_player = $SoundPlayer2D
@onready var ui_player_anim = $Control/Panel/VBoxContainer/HBoxContainer/PlayerBox/PlayerAnim
@onready var ui_player_name = $Control/Panel/VBoxContainer/PlayerName
@onready var ui_player_list = $Control/Panel/VBoxContainer/Scroller/PlayerList
@onready var ui_map_list = $Control/Panel/RightBox/Maps/VBoxContainer/ScrollContainer/MapItems
@onready var ui_back_btn = $Control/Panel/LeftBox/BackButton
@onready var ui_start_btn = $Control/Panel/RightBox/StartButton

# Called when the node enters the scene tree for the first time.
func _ready():
	# Init back button's icon using reversed start button's icon
	var back_icon = ui_start_btn.icon.get_image()
	back_icon.flip_x()
	ui_back_btn.icon = ImageTexture.create_from_image(back_icon)
	$AnimationPlayer.play("Enter")
	# Update player count
	max_player_count = player_data_list.size()
	# Init player list
	for idx in player_data_list.size():
		var player_data = player_data_list[idx]
		var sprite_frames_path = Assets.dir_tres + player_data["sprite_frames_tres"] + ".tres"
		var sprite_frames = load(sprite_frames_path)
		var player_idx = idx
		var player_name = player_data["name"]
		var ui_player_item = Assets.tscn_player_item.instantiate()
		ui_player_item.connect("item_clicked", _on_player_item_clicked)
		ui_player_item.connect("mouse_entered", _play_button_hover_sound)
		ui_player_item.init_player_item(sprite_frames, player_idx, player_name)
		ui_player_list.add_child(ui_player_item)
		
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
	for map_data in map_data_list:
		var map_item = Assets.tscn_map_item.instantiate()
		map_item.init_map_item(
			map_data["name"],
			Color.from_string(map_data["theme_color"], Color.DARK_GRAY))
		map_item.map_name = map_data["name"]
		map_item.connect("clicked", _on_map_item_clicked)
		map_item.connect("hovered", _on_map_item_hovered)
		ui_map_list.add_child(map_item)
	
	var map_items = ui_map_list.get_children()
	if map_items.size() > 0:
		map_items[0].show_seleted_mask()
		
	
func _on_map_item_clicked(map_name : String):
	if selected_map_name == map_name:
		return
	
	_play_button_down_sound()
	selected_map_name = map_name
	$Control/MapDisplay.call("set_map_name", map_name)
	
	for item in ui_map_list.get_children():
		item.call("hide_selected_mask")
	
	
func _on_map_item_hovered(map_name : String):
	if selected_map_name == map_name:
		return
		
	_play_button_hover_sound()


func _reset_selected_player():
	for ui_player_item in ui_player_list.get_children():
		ui_player_item.reset()
	

func _update_player_data(player_idx: int):
	var player_list = ui_player_list.get_children()
	if player_idx < player_list.size() and player_idx >= 0:
		player_list[player_idx].grab_focus()
		player_list[player_idx].play_anim("Idle")
		
	var player_data = player_data_list[player_idx]
	var sprite_frames_path = Assets.dir_tres + player_data["sprite_frames_tres"] + ".tres"
	var sprite_frames = load(sprite_frames_path)
	var player_name = player_data["name"]
	
	ui_player_anim.sprite_frames = sprite_frames
	ui_player_name.text = player_name

	ui_player_anim.play("Walk")

func _on_player_item_clicked(player_idx : int):
	if player_idx == selected_player_idx:
		return
	
	_play_button_down_sound()
	_reset_selected_player()
	
	if player_idx < 0:
		player_idx = abs(player_idx)
	player_idx %= max_player_count
	
	selected_player_idx = player_idx
	
	_update_player_data(player_idx)


func _play_button_down_sound():
	sound_player.stream = Assets.a_button_down
	sound_player.play()
	
	
func _play_button_hover_sound():
	sound_player.stream = Assets.a_button_hover
	sound_player.play()


func _on_left_switch_pressed():
	_on_player_item_clicked(selected_player_idx + max_player_count - 1)


func _on_right_switch_pressed():
	_on_player_item_clicked(selected_player_idx + 1)


func _on_back_button_pressed():
	_play_button_down_sound()
	$AnimationPlayer.play("Exit")
	await $AnimationPlayer.animation_finished
	queue_free()


# Uesd for pass color to level's transition from current transition
var rg_color : Color = Color.GRAY

func _on_start_button_pressed():
	seed(randi())
	_play_button_down_sound()
	var transition_scene = Assets.tscn_transition.instantiate()
	var rng = RandomNumberGenerator.new()
	rg_color = Color.from_hsv(
			rng.randf_range(0.4, 0.6),
			rng.randf_range(0.4, 0.6),
			rng.randf_range(0.4, 0.6))
	transition_scene.call("init", false, rg_color)
	transition_scene.connect("finished", _create_game_level)
	add_child(transition_scene)
	
	
func _create_game_level():
	var level_scene = Assets.tscn_level.instantiate()
	level_scene.call("init", selected_map_name)
	level_scene.call("init_transition", rg_color)
	# Create player data dictionary what easy to use
	level_scene.player_data = player_data_list[selected_player_idx]
	get_tree().get_first_node_in_group("main").add_child(level_scene)
	get_tree().get_first_node_in_group("main_menu").queue_free()
