extends Control


# Option settings
var settings_config = {
	"OpenSounds": true
}

var loud_texture = preload("res://Assets/Textures/Icons/speaker.png")
var mute_texture = preload("res://Assets/Textures/Icons/speaker_crossed.png")
var full_screen_texture = preload("res://Assets/Textures/Icons/full_screen.png")
var normal_screen_texture = preload("res://Assets/Textures/Icons/normal_screen.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.show()
	$AnimationPlayer.play("Enter")
	_update_settings_icon()


func init_settings(in_settings:Dictionary):
	settings_config = in_settings


func _update_settings_icon():
	_update_sounds_button_icon()
	_update_full_screen_button_icon()


func _update_sounds_button_icon():
	if settings_config["OpenSounds"]:
		$Background/ColorRect/VBoxContainer/SoundsButton.icon = loud_texture
	else:
		$Background/ColorRect/VBoxContainer/SoundsButton.icon = mute_texture
	

func _is_full_screen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	

func _update_full_screen_button_icon():
	if _is_full_screen():
		$Background/ColorRect/VBoxContainer/FullScreenButton.icon = normal_screen_texture
	else:
		$Background/ColorRect/VBoxContainer/FullScreenButton.icon = full_screen_texture


func _update_sounds_state():
	if settings_config["OpenSounds"]:
		get_tree().get_first_node_in_group("audio_mngr").call("loud")
	else:
		get_tree().get_first_node_in_group("audio_mngr").call("mute")


func _on_sounds_button_button_down():
	_play_button_down_sound()
	settings_config["OpenSounds"] = not settings_config["OpenSounds"]
	_update_sounds_button_icon()
	_update_sounds_state()
	

func _on_background_button_down():
	_play_button_down_sound()
	$AnimationPlayer.play("Exit")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Exit":
		var settings_json_file = FileAccess.open("user://settings.json", FileAccess.WRITE)
		settings_json_file.store_line(JSON.stringify(settings_config, "\t"))
		settings_json_file.close()
		queue_free()
		

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
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_down")