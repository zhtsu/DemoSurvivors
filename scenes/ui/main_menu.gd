extends CanvasLayer


const Assets = preload("res://scenes/common/assets.gd")

@onready var music_player = $MusicPlayer2D
@onready var sound_player = $SoundPlayer2D

# Used for receive settings data form main.gd
var setting_dict : Dictionary
var player_data_list : Array

func _ready():
	# Create and add click mask to $GithubButton
	$GithubButton.texture_click_mask.create_from_image_alpha(
		$GithubButton.texture_normal.get_image()
	)
	
	$VirtualGuy.play("Idle")
	$MaskDude.play("Idle")
	$PinkMan.play("Idle")
	$NinjaFrog.play("Idle")
	
	_apply_settings()

func _apply_settings():
	if setting_dict.has("OpenSounds"):
		loud()


func _on_setting_button_button_down():
	_play_button_down_sound()
	var setting_menu_scene = Assets.tscn_setting_menu.instantiate()
	setting_menu_scene.call("init_settings", setting_dict)
	add_child(setting_menu_scene)


func _on_start_button_button_down():
	_play_button_down_sound()
	var pick_player_scene = Assets.tscn_pick_player.instantiate()
	pick_player_scene.player_data_list = player_data_list
	add_child(pick_player_scene)


func _on_credits_button_button_down():
	_play_button_down_sound()
	var credits_scene = Assets.tscn_credits.instantiate()
	add_child(credits_scene)
	
	
func _on_collection_button_button_down():
	_play_button_down_sound()
	var collection_scene = Assets.tscn_collection.instantiate()
	add_child(collection_scene)
	
	
func quit_game():
	get_tree().quit()
	
	
func _on_quit_button_button_down():
	_play_button_down_sound()
	var quit_popup_scene = Assets.tscn_popup.instantiate()
	quit_popup_scene.call("init_popup", "Are you sure to quit game?", quit_game)
	add_child(quit_popup_scene)

	
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
