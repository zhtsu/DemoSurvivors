extends Node


# File path
const path_default_settings = "res://assets/data/default_settings.json"
const path_player_table = "res://assets/data/player_table.csv"
const path_enemy_table = "res://assets/data/enemy_table.csv"
# Folder path
const dir_tres = "res://tress/"
const dir_player_actions = "res://scenes/character/player/actions/"
const dir_enemy_actions = "res://scenes/character/enemy/actions/"
# Scene
const tscn_setting_menu = preload("res://scenes/ui/setting_menu.tscn")
const tscn_popup = preload("res://scenes/ui/popup.tscn")
const tscn_pick_player = preload("res://scenes/ui/pick_player.tscn")
const tscn_credits = preload("res://scenes/ui/credits.tscn")
const tscn_collection = preload("res://scenes/ui/collection.tscn")
const tscn_level = preload("res://scenes/level/level.tscn")
const tscn_transition = preload("res://scenes/ui/transition.tscn")
const tscn_player_item = preload("res://scenes/ui/player_item.tscn")
const tscn_player = preload("res://scenes/character/player/player.tscn")
const tscn_enemy = preload("res://scenes/character/enemy/enemy.tscn")
const tscn_map_item = preload("res://scenes/ui/map_item.tscn")
const tscn_map_forest = preload("res://scenes/level/map_forest.tscn")
const tscn_map_cave = preload("res://scenes/level/map_cave.tscn")
const tscn_map_desert = preload("res://scenes/level/map_desert.tscn")
const tscn_map_tundra = preload("res://scenes/level/map_tundra.tscn")
const tscn_map_challenge = preload("res://scenes/level/map_challenge.tscn")
# Audio
const a_button_down = preload("res://assets/sounds/button_down.mp3")
const a_button_hover = preload("res://assets/sounds/button_hover.mp3")
# Texture
const tex_icon_map_forest = preload("res://assets/textures/icons/icon_map_forest.png")
const tex_icon_map_cave = preload("res://assets/textures/icons/icon_map_cave.png")
const tex_icon_map_desert = preload("res://assets/textures/icons/icon_map_desert.png")
const tex_icon_map_tundra = preload("res://assets/textures/icons/icon_map_tundra.png")
const tex_icon_map_challenge = preload("res://assets/textures/icons/icon_map_challenge.png")
const tex_loud = preload("res://Assets/Textures/Icons/speaker.png")
const tex_mute = preload("res://Assets/Textures/Icons/speaker_crossed.png")
const tex_full_screen = preload("res://Assets/Textures/Icons/full_screen.png")
const tex_normal_screen = preload("res://Assets/Textures/Icons/normal_screen.png")
# .tres
const tres_sm_effect_crt = preload("res://tress/sm_effect_crt.tres")
const tres_sm_effect_gray = preload("res://tress/sm_effect_gray.tres")
const tres_sf_ninja_frog = preload("res://tress/sf_ninja_frog.tres")
const tres_sf_mask_dude = preload("res://tress/sf_mask_dude.tres")
const tres_sf_pink_man = preload("res://tress/sf_pink_man.tres")
const tres_virtual_guy = preload("res://tress/sf_virtual_guy.tres")
