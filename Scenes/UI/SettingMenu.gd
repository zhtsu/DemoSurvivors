extends Control

signal open_sounds
signal close_sounds

var OpenSounds:bool
var SpeakerTexture = load("res://Assets/Textures/Icons/speaker.png")
var SpeakerCrossedTexture = load("res://Assets/Textures/Icons/speaker_crossed.png")
var Settings:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	self.show()
	$AnimationPlayer.play("Enter")
	
	# Read Setting
	var SettingsJsonFile = FileAccess.open("res://Assets/JSONs/settings.json", FileAccess.READ)
	if (SettingsJsonFile):
		Settings = JSON.parse_string(SettingsJsonFile.get_as_text())
		print_debug("Success to load and initialized settings:\n" + JSON.stringify(Settings))
	else:
		print_debug("Failed to load and initialized settings")
	
	# Init Settings
	OpenSounds = Settings["OpenSounds"]
	
	UpdateSpeakerIcon()


func UpdateSpeakerIcon():
	if OpenSounds:
		$Background/ColorRect/VBoxContainer/SpeakerButton.icon = SpeakerTexture
	else:
		$Background/ColorRect/VBoxContainer/SpeakerButton.icon = SpeakerCrossedTexture


func EmitSignalForUpdateSounds():
	if OpenSounds:
		emit_signal("open_sounds")
	else:
		emit_signal("close_sounds")
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	




func _on_speaker_button_button_down():
	$SpeakerDownSound.play()
	OpenSounds = not OpenSounds
	Settings["OpenSounds"] = OpenSounds
	UpdateSpeakerIcon()
	EmitSignalForUpdateSounds()
	

func _on_background_button_down():
	$SpeakerDownSound.play()
	$AnimationPlayer.play("Exit")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Exit":
		var SettingsJsonFile = FileAccess.open("res://Assets/JSONs/settings.json", FileAccess.WRITE)
		SettingsJsonFile.store_line(JSON.stringify(Settings))
		SettingsJsonFile.close()
		queue_free()
		

