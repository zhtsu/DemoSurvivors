extends Control


# Option settings
var Settings = {
	"OpenSounds": true
}

var SpeakerTexture = preload("res://Assets/Textures/Icons/speaker.png")
var SpeakerCrossedTexture = preload("res://Assets/Textures/Icons/speaker_crossed.png")
var FullScreenTexture = preload("res://Assets/Textures/Icons/full_screen.png")
var NormalScreenTexture = preload("res://Assets/Textures/Icons/normal_screen.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.show()
	$AnimationPlayer.play("Enter")
	UpdateSettingsIcon()


func InitSettings(InSettings:Dictionary):
	Settings = InSettings


func UpdateSettingsIcon():
	UpdateSoundsButtonIcon()
	UpdateFullScreenButtonIcon()


func UpdateSoundsButtonIcon():
	if Settings["OpenSounds"]:
		$Background/ColorRect/VBoxContainer/SoundsButton.icon = SpeakerTexture
	else:
		$Background/ColorRect/VBoxContainer/SoundsButton.icon = SpeakerCrossedTexture
	

func IsFullScreen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	

func UpdateFullScreenButtonIcon():
	if IsFullScreen():
		$Background/ColorRect/VBoxContainer/FullScreenButton.icon = NormalScreenTexture
	else:
		$Background/ColorRect/VBoxContainer/FullScreenButton.icon = FullScreenTexture


func UpdateSoundsState():
	if Settings["OpenSounds"]:
		get_tree().get_first_node_in_group("audio_mngr").call("Sound")
	else:
		get_tree().get_first_node_in_group("audio_mngr").call("Mute")


func _on_sounds_button_button_down():
	PlayButtonDownSound()
	Settings["OpenSounds"] = not Settings["OpenSounds"]
	UpdateSoundsButtonIcon()
	UpdateSoundsState()
	

func _on_background_button_down():
	PlayButtonDownSound()
	$AnimationPlayer.play("Exit")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Exit":
		var SettingsJsonFile = FileAccess.open("user://settings.json", FileAccess.WRITE)
		SettingsJsonFile.store_line(JSON.stringify(Settings, "\t"))
		SettingsJsonFile.close()
		queue_free()
		

func UpdateFullScreen():
	if IsFullScreen():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_full_screen_button_button_down():
	PlayButtonDownSound()
	UpdateFullScreen()
	UpdateFullScreenButtonIcon()
	
	
func PlayButtonDownSound():
	get_tree().get_first_node_in_group("audio_mngr").call("PlayButtonDown")
