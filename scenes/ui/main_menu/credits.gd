extends CanvasLayer


@onready var programming_container = $Background/ColorRect/ScrollerList/VBoxContainer/ProgrammingArea
@onready var art_container = $Background/ColorRect/ScrollerList/VBoxContainer/ArtArea
@onready var music_container = $Background/ColorRect/ScrollerList/VBoxContainer/MusicArea
@onready var sound_container = $Background/ColorRect/ScrollerList/VBoxContainer/SoundArea

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
	for string in list:
		var label = Label.new()
		label.text = string
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
	$SoundPlayer2D.play()
	$AnimationPlayer.play("Exit")
	await $AnimationPlayer.animation_finished
	queue_free()
