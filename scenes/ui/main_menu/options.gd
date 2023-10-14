extends CanvasLayer

const Assets = preload("res://scenes/global/assets.gd")

var option_dict : Dictionary

@onready var full_screen_button = $RootPanel/VBoxContainer/UpBox/FullScreenButton
@onready var sounds_button = $RootPanel/VBoxContainer/UpBox/SoundsButton
@onready var language_combo_box = $RootPanel/VBoxContainer/DownBox/LangBox/LangSelector
@onready var effect_combo_box = $RootPanel/VBoxContainer/DownBox/EffectBox/EffectSelector
@onready var sound_player = $SoundPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.show()
	$AnimationPlayer.play("Enter")
	_update_settings_ui()


func init_options(in_options : Dictionary):
	option_dict = in_options


func _update_settings_ui():
	_update_sounds_button_icon()
	_update_full_screen_button_icon()
	_update_language_combo_box()
	_update_effect_combo_box()

func _update_language_combo_box():
	var index : int = option_dict["Language"]
	language_combo_box.select(index)
	

func _update_effect_combo_box():
	var index : int = option_dict["Effect"]
	effect_combo_box.select(index)


func _update_sounds_button_icon():
	if option_dict["OpenSounds"]:
		sounds_button.icon = Assets.tex_loud
	else:
		sounds_button.icon = Assets.tex_mute
	

func _is_full_screen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	

func _update_full_screen_button_icon():
	if _is_full_screen():
		full_screen_button.icon = Assets.tex_normal_screen
	else:
		full_screen_button.icon = Assets.tex_full_screen


func _update_sounds_state():
	if option_dict["OpenSounds"]:
		get_tree().get_first_node_in_group("main").get_music_player().play()
	else:
		get_tree().get_first_node_in_group("main").get_music_player().stop()


func _on_sounds_button_button_down():
	_play_button_down_sound()
	option_dict["OpenSounds"] = not option_dict["OpenSounds"]
	_update_sounds_button_icon()
	_update_sounds_state()
	

func _on_background_button_down():
	_play_button_down_sound()
	$AnimationPlayer.play("Exit")
	await $AnimationPlayer.animation_finished
	_save_updated_settings()
	queue_free()
		
		
func _save_updated_settings():
	var options_json_file = FileAccess.open(Assets.path_local_options, FileAccess.WRITE)
	options_json_file.store_line(JSON.stringify(option_dict, "\t"))
	options_json_file.close()
	

func _update_full_screen():
	if _is_full_screen():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_full_screen_button_button_down():
	_play_button_down_sound()
	_update_full_screen()
	_update_full_screen_button_icon()
	
	
func _play_button_down_sound():
	sound_player.stream = Assets.a_button_down
	sound_player.play()


func _on_effect_selector_item_selected(index):
	_play_button_down_sound()
	# 0 Normal
	# 1 CRT
	# 2 Gray
	option_dict["Effect"] = index
	var viewport_effect = get_tree().get_first_node_in_group("viewport_effect")
	viewport_effect.call("active_viewport_effect", index)


func _on_lang_selector_item_selected(index):
	_play_button_down_sound()
	option_dict["Language"] = index
	
