extends Node


# File path
const path_local_user_data = "user://user_data.json"
const path_introductions = "res://assets/data/introductions.json"
const path_tile_coords = "res://assets/data/used_tile_coords.json"
const path_default_user_data = "res://assets/data/default_user_data.json"
const path_player_table = "res://assets/data/player_table.csv"
const path_enemy_table = "res://assets/data/enemy_table.csv"
const path_map_table = "res://assets/data/map_table.csv"
const path_ability_table = "res://assets/data/ability_table.csv"
const path_weapon_table = "res://assets/data/weapon_table.csv"
const path_tex_start = "res://assets/textures/icons/start.png"
const path_tscn_options = "res://scenes/ui/main_menu/options.tscn"
const path_tscn_main_menu = "res://scenes/ui/main_menu/main_menu.tscn"
# Folder path
const dir_tres = "res://tress/"
const dir_tres_weapon = "res://tress/weapon/"
const dir_tres_ability = "res://tress/ability/"
const dir_tres_loot = "res://tress/loot/"
const dir_tres_misc = "res://tress/misc/"
const dir_tres_player = "res://tress/player/"
const dir_tres_enemy = "res://tress/enemy/"
const dir_data = "res://assets/data/"
const dir_music = "res://assets/musics/"
const dir_ability = "res://scenes/item/ability/"
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
const tscn_item_state = preload("res://scenes/ui/player_state/item_state.tscn")
const tscn_pick_item = preload("res://scenes/ui/game/pick_item.tscn")
const tscn_particles_emitter = preload("res://scenes/utility/particles_emitter/particles_emitter.tscn")
const tscn_death = preload("res://scenes/ui/game/death.tscn")
const tscn_camera = preload("res://scenes/utility/effect_camera/effect_camera.tscn")
const tscn_enemy_spawner = preload("res://scenes/level/enemy_spawner.tscn")
const tscn_exp_stone = preload("res://scenes/item/consumables/exp_stone/exp_stone.tscn")
const tscn_GOTG = preload("res://scenes/item/ability/GOTG/GOTG.tscn")
const tscn_magnetism = preload("res://scenes/item/ability/magnetism/magnetism.tscn")
const tscn_weapon = preload("res://scenes/item/weapon/weapon.tscn")
const tscn_collection_item = preload("res://scenes/ui/main_menu/collection_item.tscn")
# Audio
const a_button_down = preload("res://assets/sounds/button_down.mp3")
const a_button_hover = preload("res://assets/sounds/button_hover.mp3")
const a_enemy_death = preload("res://assets/sounds/enemy_death.mp3")
const a_player_damage = preload("res://assets/sounds/player_damage.mp3")
# Texture
const tex_loud = preload("res://assets/textures/icons/speaker.png")
const tex_mute = preload("res://assets/textures/icons/speaker_crossed.png")
const tex_full_screen = preload("res://assets/textures/icons/full_screen.png")
const tex_normal_screen = preload("res://assets/textures/icons/normal_screen.png")
# .tres
# Misc
const tres_sm_effect_crt = preload("res://tress/misc/sm_effect_crt.tres")
const tres_sm_effect_gray = preload("res://tress/misc/sm_effect_gray.tres")
const tres_sbf_ui_transparent_mask = preload("res://tress/misc/sbf_ui_transparent_mask.tres")
# Player
const tres_sf_ninja_frog = preload("res://tress/player/sf_ninja_frog.tres")
const tres_sf_mask_dude = preload("res://tress/player/sf_mask_dude.tres")
const tres_sf_pink_man = preload("res://tress/player/sf_pink_man.tres")
const tres_virtual_guy = preload("res://tress/player/sf_virtual_guy.tres")

