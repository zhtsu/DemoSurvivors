extends CanvasLayer


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


func _update_settings_ui():
	_update_sounds_button_icon()
	_update_full_screen_button_icon()
	_update_language_combo_box()
	_update_effect_combo_box()

func _update_language_combo_box():
	var index : int = Data.user_data_dict["Language"]
	language_combo_box.select(index)
	

func _update_effect_combo_box():
	var index : int = Data.user_data_dict["Effect"]
	effect_combo_box.select(index)


func _update_sounds_button_icon():
	if Data.user_data_dict["OpenSounds"]:
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
	if Data.user_data_dict["OpenSounds"]:
		get_tree().get_first_node_in_group("main").get_music_player().play()
	else:
		get_tree().get_first_node_in_group("main").get_music_player().stop()


func _on_sounds_button_button_down():
	_play_button_down_sound()
	Data.user_data_dict["OpenSounds"] = not Data.user_data_dict["OpenSounds"]
	_update_sounds_button_icon()
	_update_sounds_state()
	

func _on_background_button_down():
	_play_button_down_sound()
	$AnimationPlayer.play("Exit")
	await $AnimationPlayer.animation_finished
	_save_updated_settings()
	queue_free()
		
		
func _save_updated_settings():
	var user_data_json_file = FileAccess.open(Assets.path_local_user_data, FileAccess.WRITE)
	user_data_json_file.store_line(JSON.stringify(Data.user_data_dict, "\t"))
	user_data_json_file.close()
	

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
	Data.user_data_dict["Effect"] = index
	var viewport_effect = get_tree().get_first_node_in_group("viewport_effect")
	viewport_effect.call("active_viewport_effect", index)


func _on_lang_selector_item_selected(index):
	_play_button_down_sound()
	Data.user_data_dict["Language"] = index
	Methods.translate(index)
	
