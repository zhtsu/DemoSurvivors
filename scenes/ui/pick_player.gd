extends Control

const CharacterType = preload("res://scenes/character/character_type.gd")
#
const gd_ninja_frog = preload("res://scenes/character/player/ninja_frog/ninja_frog.gd")
const gd_mask_dude = preload("res://scenes/character/player/mask_dude/mask_dude.gd")
const gd_pink_man = preload("res://scenes/character/player/pink_man/pink_man.gd")
const gd_virtual_guy = preload("res://scenes/character/player/virtual_guy/virtual_guy.gd")
#
const character_item_res = preload("res://scenes/ui/player_item.tscn")

var max_character_count = CharacterType.EPlayerType.size()
var selected_character_type = CharacterType.EPlayerType.NinjaFrog

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Enter")
	# Init character list
	for character_type in CharacterType.EPlayerType.values():
		var character_item = character_item_res.instantiate()
		character_item.connect("item_clicked", _on_character_item_clicked)
		character_item.connect("mouse_entered", _play_button_hover_sound)
		if character_type == CharacterType.EPlayerType.NinjaFrog:
			character_item.init_player_item(gd_ninja_frog.sf_ninja_frog, character_type)
			$Background/VBoxContainer/CharacterList.add_child(character_item)
		elif character_type == CharacterType.EPlayerType.MaskDude:
			character_item.init_player_item(gd_mask_dude.sf_mask_dude, character_type)
			$Background/VBoxContainer/CharacterList.add_child(character_item)
		elif character_type == CharacterType.EPlayerType.PinkMan:
			character_item.init_player_item(gd_pink_man.sf_pink_man, character_type)
			$Background/VBoxContainer/CharacterList.add_child(character_item)
		elif character_type == CharacterType.EPlayerType.VirtualGuy:
			character_item.init_player_item(gd_virtual_guy.sf_virtual_guy, character_type)
			$Background/VBoxContainer/CharacterList.add_child(character_item)
			
	# Init button's state in character_list
	var character_list = $Background/VBoxContainer/CharacterList.get_children()
	if character_list.size() > 0:
		character_list[0].grab_focus()
		character_list[0].play_anim("Idle")
		# Init character box
		$Background/VBoxContainer/HBoxContainer/CharacterBox/CharacterAnim.sprite_frames = \
			character_list[0].get_player_sprite_frames()
		$Background/VBoxContainer/HBoxContainer/CharacterBox/CharacterAnim.play("Walk")
	else:
		$Background/VBoxContainer/HBoxContainer/CharacterBox/CharacterAnim.sprite_frames = null
	
	

func _put_character_data():
	pass


func _reset_selected_character():
	for character_item in $Background/VBoxContainer/CharacterList.get_children():
		character_item.reset()
	

func _update_character_data(character_type: int):
	if character_type < 0:
		character_type = abs(character_type)
	character_type %= max_character_count
	
	var character_list = $Background/VBoxContainer/CharacterList.get_children()
	if character_type < character_list.size():
		character_list[character_type].grab_focus()
		character_list[character_type].play_anim("Idle")
	
	if character_type == CharacterType.EPlayerType.NinjaFrog:
		$Background/VBoxContainer/HBoxContainer/CharacterBox/CharacterAnim.sprite_frames = \
			gd_ninja_frog.sf_ninja_frog
	elif character_type == CharacterType.EPlayerType.MaskDude:
		$Background/VBoxContainer/HBoxContainer/CharacterBox/CharacterAnim.sprite_frames = \
			gd_mask_dude.sf_mask_dude
	elif character_type == CharacterType.EPlayerType.PinkMan:
		$Background/VBoxContainer/HBoxContainer/CharacterBox/CharacterAnim.sprite_frames = \
			gd_pink_man.sf_pink_man
	elif character_type == CharacterType.EPlayerType.VirtualGuy:
		$Background/VBoxContainer/HBoxContainer/CharacterBox/CharacterAnim.sprite_frames = \
			gd_virtual_guy.sf_virtual_guy
	
	$Background/VBoxContainer/HBoxContainer/CharacterBox/CharacterAnim.play("Walk")

func _on_character_item_clicked(character_type : int):
	_play_button_down_sound()
	_reset_selected_character()
	selected_character_type = character_type
	_update_character_data(character_type)


func _play_button_down_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_down")
	
	
func _play_button_hover_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_hover")


func _on_left_switch_pressed():
	_on_character_item_clicked(selected_character_type + max_character_count - 1)


func _on_right_switch_pressed():
	_on_character_item_clicked(selected_character_type + 1)


func _on_back_button_pressed():
	_play_button_down_sound()
	$AnimationPlayer.play("Exit")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Exit":
		queue_free()


func _on_back_button_mouse_entered():
	_play_button_hover_sound()


func _on_start_button_pressed():
	_play_button_down_sound()


func _on_start_button_mouse_entered():
	_play_button_hover_sound()
	
