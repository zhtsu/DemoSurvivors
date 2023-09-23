extends Control

@onready var programming_container = $Background/ColorRect/HBoxContainer/VBoxContainer/ProgrammingArea/List
@onready var art_container = $Background/ColorRect/HBoxContainer/VBoxContainer/ArtArea/List2
@onready var music_container = $Background/ColorRect/HBoxContainer/VBoxContainer/MusicArea/List3
@onready var sound_container = $Background/ColorRect/HBoxContainer/VBoxContainer/SoundArea/List3

const programming_list = [
	"zhtsu"
]

const art_list = [
	"art 01",
	"art 02"
]

const music_list = [
	"music 01",
	"music 02"
]

const sound_list = [
	"sound 01",
	"sound 02"
]


func _create_item_to_container(container, list):
	for str in list:
		var label = Label.new()
		label.text = str
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		container.add_child(label)

func _ready():
	_create_item_to_container(programming_container, programming_list)
	_create_item_to_container(art_container, art_list)
	_create_item_to_container(music_container, music_list)
	_create_item_to_container(sound_container, sound_list)
	
	self.show()
	$AnimationPlayer.play("Enter")
	

func _on_background_button_down():
	_play_button_down_sound()
	$AnimationPlayer.play("Exit")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Exit":
		queue_free()
	
	
func _play_button_down_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_down")


func _on_back():
	_play_button_down_sound()
	$AnimationPlayer.play("Exit")
