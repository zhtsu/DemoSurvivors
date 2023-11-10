extends CanvasLayer


@onready var sound_player = $SoundPlayer


var music_player : AudioStreamPlayer

@onready var ui_title = $CenterBox/Title
@onready var ui_start_button = $CenterBox/MenuItems/StartButton
@onready var ui_options_button = $CenterBox/MenuItems/OptionsButton
@onready var ui_collection_button = $CenterBox/MenuItems/CollectionButton
@onready var ui_credits_button = $CenterBox/MenuItems/CreditsButton
@onready var ui_exit_button = $CenterBox/MenuItems/ExitButton


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
	get_tree().paused = false
	# Create and add click mask to $GithubButton
	$GithubButton.texture_click_mask.create_from_image_alpha(
		$GithubButton.texture_normal.get_image()
	)
	
	$VirtualGuy.play("Idle")
	$MaskDude.play("Idle")
	$PinkMan.play("Idle")
	$NinjaFrog.play("Idle")
	
	var MAIN = get_tree().get_first_node_in_group("main")
	music_player = MAIN.get_music_player()
	MAIN.set_bgm("dongcidaci.wav", -6, false)
	
	_apply_settings()
	

func _apply_settings():
	if Data.user_data_dict["OpenSounds"] and not music_player.playing:
		loud()


func _on_options_button_button_down():
	_play_button_down_sound()
	var options_scene = Assets.tscn_options.instantiate()
	add_child(options_scene)


func _on_start_button_button_down():
	_play_button_down_sound()
	var pick_player_scene = Assets.tscn_pick_player.instantiate()
	add_child(pick_player_scene)


func _on_credits_button_button_down():
	_play_button_down_sound()
	var credits_scene = Assets.tscn_credits.instantiate()
	add_child(credits_scene)
	
	
func _on_collection_button_button_down():
	_play_button_down_sound()
	var collection_scene = Assets.tscn_collection.instantiate()
	add_child(collection_scene)
	
	
func _exit():
	get_tree().quit()
	
	
func _on_exit_button_button_down():
	_play_button_down_sound()
	var exit_popup_scene = Assets.tscn_popup.instantiate()
	exit_popup_scene.call("init_popup", "Are you sure to exit?", _exit)
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
