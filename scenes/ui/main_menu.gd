extends CanvasLayer

const tscn_setting_menu = preload("res://scenes/ui/setting_menu.tscn")
const tscn_popup = preload("res://scenes/ui/popup.tscn")
const tscn_pick_player = preload("res://scenes/ui/pick_player.tscn")
const tscn_credits = preload("res://scenes/ui/credits.tscn")
const tscn_collection = preload("res://scenes/ui/collection.tscn")
# data
const DEFAULT_SETTINGS_FILE_PATH = "res://assets/data/default_settings.json"
const SETTINGS_USER_DATA_PATH = "user://settings.json"


var setting_dict : Dictionary


func _ready():
	# Create and add click mask to $GithubButton
	$GithubButton.texture_click_mask.create_from_image_alpha(
		$GithubButton.texture_normal.get_image()
	)
	
	$VirtualGuy.play("Idle")
	$MaskDude.play("Idle")
	$PinkMan.play("Idle")
	$NinjaFrog.play("Idle")
	
	var default_settings_file = FileAccess.open(DEFAULT_SETTINGS_FILE_PATH, FileAccess.READ)
	var default_settings = JSON.parse_string(default_settings_file.get_as_text())
	default_settings_file.close()
	
	# Create local user data file if not exist
	if not FileAccess.file_exists(SETTINGS_USER_DATA_PATH):
		var settings_user_data_file = FileAccess.open(SETTINGS_USER_DATA_PATH, FileAccess.WRITE)
		settings_user_data_file.store_line(JSON.stringify(default_settings, "\t"))
		settings_user_data_file.close()
		print_debug("Success to create local settings data file")
	
	var local_settings_file = FileAccess.open(SETTINGS_USER_DATA_PATH, FileAccess.READ)
	setting_dict = JSON.parse_string(local_settings_file.get_as_text())
	local_settings_file.close()
	
	_apply_settings()

func _apply_settings():
	if setting_dict.has("OpenSounds"):
		loud()
	var viewport_effect = get_tree().get_first_node_in_group("viewport_effect")
	viewport_effect.call("active_viewport_effect", setting_dict["Effect"])

func _on_setting_button_button_down():
	_play_button_down_sound()
	var setting_menu_scene = tscn_setting_menu.instantiate()
	setting_menu_scene.call("init_settings", setting_dict)
	add_child(setting_menu_scene)


func _on_start_button_mouse_entered():
	_play_button_hover_sound()


func _on_setting_button_mouse_entered():
	_play_button_hover_sound()


func _on_exit_button_mouse_entered():
	_play_button_hover_sound()


func _on_start_button_button_down():
	_play_button_down_sound()
	var pick_player_scene = tscn_pick_player.instantiate()
	add_child(pick_player_scene)




func _on_credits_button_button_down():
	_play_button_down_sound()
	var credits_scene = tscn_credits.instantiate()
	add_child(credits_scene)
	
	
func _on_collection_button_button_down():
	_play_button_down_sound()
	var collection_scene = tscn_collection.instantiate()
	add_child(collection_scene)
	
	
func quit_game():
	get_tree().quit()
	
	
func _on_quit_button_button_down():
	_play_button_down_sound()
	var quit_popup_scene = tscn_popup.instantiate()
	quit_popup_scene.call("init_popup", "Are you sure to quit game?", quit_game)
	add_child(quit_popup_scene)

	
func mute():
	get_tree().get_first_node_in_group("audio_mngr").call("mute")
	

func loud():
	get_tree().get_first_node_in_group("audio_mngr").call("loud")
	
	
func _play_button_down_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_down")
	
	
func _play_button_hover_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_hover")


func _on_github_button_button_down():
	_play_button_down_sound()
	OS.shell_open("https://github.com/zhtsu/DemoSurvivors")
