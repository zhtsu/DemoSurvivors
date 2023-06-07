extends Control

var OpenSounds = true
var SpeakerTexture = load("res://Assets/Textures/Icons/speaker_0.png")
var SpeakerCrossedTexture = load("res://Assets/Textures/Icons/speaker_crossed.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_speaker_button_button_down():
	OpenSounds = not OpenSounds
	if OpenSounds:
		$ColorRect/VBoxContainer/SpeakerButton.icon = SpeakerTexture
	else:
		$ColorRect/VBoxContainer/SpeakerButton.icon = SpeakerCrossedTexture
