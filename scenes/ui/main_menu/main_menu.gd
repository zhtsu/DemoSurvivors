extends CanvasLayer


const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")

@onready var sound_player = $SoundPlayer2D


# Used for receive settings data form main.gd
var option_dict : Dictionary
var player_data_list : Array[Dictionary]
var enemy_data_list : Array[Dictionary]
var map_data_list : Array[Dictionary]
var music_player : AudioStreamPlayer2D

func _pause_anim():
	$VirtualGuy.pause()
	$MaskDude.pause()
	$PinkMan.pause()
	$NinjaFrog.pause()
	

func _play_anim():
	$VirtualGuy.play()
	$MaskDude.play()
	$PinkMan.play()
	$NinjaFrog.play()


func _ready():
	# Create and add click mask to $GithubButton
	$GithubButton.texture_click_mask.create_from_image_alpha(
		$GithubButton.texture_normal.get_image()
	)
	
	$VirtualGuy.play("Idle")
	$MaskDude.play("Idle")
	$PinkMan.play("Idle")
	$NinjaFrog.play("Idle")
	
	music_player = get_tree().get_first_node_in_group("main").get_music_player()
	
	var json_file = FileAccess.open(Assets.path_local_options, FileAccess.READ)
	option_dict = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	# Read data from csv
	Methods.load_csv_to_array(Assets.path_player_table, player_data_list)
	Methods.load_csv_to_array(Assets.path_enemy_table, enemy_data_list)
	Methods.load_csv_to_array(Assets.path_map_table, map_data_list)
	
	_apply_settings()
	

func _apply_settings():
	if option_dict["OpenSounds"]:
		loud()


func _on_options_button_button_down():
	_play_button_down_sound()
	var options_scene = Assets.tscn_options.instantiate()
	options_scene.call("init_options", option_dict)
	add_child(options_scene)


func _on_start_button_button_down():
	_play_button_down_sound()
	var pick_player_scene = Assets.tscn_pick_player.instantiate()
	pick_player_scene.player_data_list = player_data_list
	pick_player_scene.enemy_data_list = enemy_data_list
	pick_player_scene.map_data_list = map_data_list
	add_child(pick_player_scene)


func _on_credits_button_button_down():
	_play_button_down_sound()
	var credits_scene = Assets.tscn_credits.instantiate()
	add_child(credits_scene)
	
	
func _on_collection_button_button_down():
	_play_button_down_sound()
	var collection_scene = Assets.tscn_collection.instantiate()
	add_child(collection_scene)
	
	
func exit_game():
	get_tree().quit()
	
	
func _on_exit_button_button_down():
	_play_button_down_sound()
	var exit_popup_scene = Assets.tscn_popup.instantiate()
	exit_popup_scene.call("init_popup", "Are you sure to exit game?", exit_game)
	add_child(exit_popup_scene)

	
func mute():
	music_player.stop()
	

func loud():
	music_player.play()
	
	
func _play_button_down_sound():
	sound_player.stream = Assets.a_button_down
	sound_player.play()
	
	
func _play_button_hover_sound():
	sound_player.stream = Assets.a_button_hover
	sound_player.play()


func _on_github_button_button_down():
	_play_button_down_sound()
	OS.shell_open("https://github.com/zhtsu/DemoSurvivors")
