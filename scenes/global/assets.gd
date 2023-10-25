extends Node


# File path
const path_local_options = "user://options.json"
const path_tile_coords = "res://assets/data/used_tile_coords.json"
const path_default_options = "res://assets/data/default_options.json"
const path_player_table = "res://assets/data/player_table.csv"
const path_enemy_table = "res://assets/data/enemy_table.csv"
const path_map_table = "res://assets/data/map_table.csv"
const path_tex_start = "res://assets/textures/icons/start.png"
const path_tscn_options = "res://scenes/ui/main_menu/options.tscn"
const path_tscn_main_menu = "res://scenes/ui/main_menu/main_menu.tscn"
# Folder path
const dir_tres = "res://tress/"
const dir_data = "res://assets/data/"
const dir_player_actions = "res://scenes/character/player/actions/"
const dir_enemy_actions = "res://scenes/character/enemy/actions/"
# Scene
const tscn_options = preload("res://scenes/ui/main_menu/options.tscn")
const tscn_popup = preload("res://scenes/ui/main_menu/popup.tscn")
const tscn_pick_player = preload("res://scenes/ui/pick_player/pick_player.tscn")
const tscn_credits = preload("res://scenes/ui/main_menu/credits.tscn")
const tscn_collection = preload("res://scenes/ui/main_menu/collection.tscn")
const tscn_level = preload("res://scenes/level/level.tscn")
const tscn_transition = preload("res://scenes/ui/transition.tscn")
const tscn_player_item = preload("res://scenes/ui/pick_player/player_item.tscn")
const tscn_player = preload("res://scenes/character/player/player.tscn")
const tscn_map = preload("res://scenes/level/map.tscn")
const tscn_enemy = preload("res://scenes/character/enemy/enemy.tscn")
const tscn_map_item = preload("res://scenes/ui/pick_player/map_item.tscn")
const tscn_pause_menu = preload("res://scenes/ui/game/pause_menu.tscn")
const tscn_main_menu = preload("res://scenes/ui/main_menu/main_menu.tscn")
const tscn_item = preload("res://scenes/item/item.tscn")
const tscn_pick_item = preload("res://scenes/ui/game/pick_item.tscn")
const tscn_particles_emitter = preload("res://scenes/utility/particles_emitter.tscn")
const tscn_death = preload("res://scenes/ui/game/death.tscn")
const tscn_camera = preload("res://scenes/utility/effect_camera.tscn")
const tscn_enemy_spawner = preload("res://scenes/level/enemy_spawner.tscn")
const tscn_exp_stone = preload("res://scenes/item/loot/exp_stone/exp_stone.tscn")
# Audio
const a_button_down = preload("res://assets/sounds/button_down.mp3")
const a_button_hover = preload("res://assets/sounds/button_hover.mp3")
# Texture
const tex_loud = preload("res://assets/textures/icons/speaker.png")
const tex_mute = preload("res://assets/textures/icons/speaker_crossed.png")
const tex_full_screen = preload("res://assets/textures/icons/full_screen.png")
const tex_normal_screen = preload("res://assets/textures/icons/normal_screen.png")
# .tres
const tres_sm_effect_crt = preload("res://tress/sm_effect_crt.tres")
const tres_sm_effect_gray = preload("res://tress/sm_effect_gray.tres")
const tres_sf_ninja_frog = preload("res://tress/sf_ninja_frog.tres")
const tres_sf_mask_dude = preload("res://tress/sf_mask_dude.tres")
const tres_sf_pink_man = preload("res://tress/sf_pink_man.tres")
const tres_virtual_guy = preload("res://tress/sf_virtual_guy.tres")
const tres_sbf_ui_transparent_mask = preload("res://tress/sbf_ui_transparent_mask.tres")
