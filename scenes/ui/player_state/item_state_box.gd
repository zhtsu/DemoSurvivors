extends Control


signal clicked


@export_enum("Left", "Right") var direction = 0

const Assets = preload("res://scenes/global/assets.gd")
var open := false


func _ready():
	if direction == 0:
		$Button.position.x = 0.0
		$Button.modulate = Color.DARK_SEA_GREEN
		$Grid.layout_direction = LAYOUT_DIRECTION_LTR
		$Grid.position.x = -100.0
	else:
		$Button.position.x = size.x - $Button.size.x
		$Button.modulate = Color.SKY_BLUE
		$Grid.layout_direction = LAYOUT_DIRECTION_RTL
		$Grid.position.x = 100.0


func _process(_delta):
	pass


func _on_button_button_down():
	$Button.disabled = true
	_play_button_down_sound()
	open = not open
	
	if direction == 0 and open:
		$AnimationPlayer.play("LeftEnter")
	elif direction == 0 and not open:
		$AnimationPlayer.play("LeftExit")
	if direction == 1 and open:
		$AnimationPlayer.play("RightEnter")
	elif direction == 1 and not open:
		$AnimationPlayer.play("RightExit")
	
	await $AnimationPlayer.animation_finished
	$Button.disabled = false
	
	
func _play_button_down_sound():
	$SoundPlayer.stream = Assets.a_button_down
	$SoundPlayer.play()
	
	
func _play_button_hover_sound():
	$SoundPlayer.stream = Assets.a_button_hover
	$SoundPlayer.play()
	
	
func update(item_list : Array[Item]):
	clear()
	for item in item_list:
		var item_state = Assets.tscn_item_state.instantiate()
		item_state.set_item_state(item)
		$Grid.add_child(item_state)
		
		
func clear():
	for child in $Grid.get_children():
		$Grid.remove_child(child)
