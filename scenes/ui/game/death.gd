extends CanvasLayer


var revive_count : int = 0


func _ready():
	$AnimationPlayer.play("Enter")
	if revive_count == 0:
		$Down/VBox/Buttons/ReviveButton.hide()


func _play_button_down_sound():
	$SoundPlayer.stream = Assets.a_button_down
	$SoundPlayer.play()
	
	
func _play_button_hover_sound():
	$SoundPlayer.stream = Assets.a_button_hover
	$SoundPlayer.play()


func _on_revive_button_button_down():
	_play_button_down_sound()


func _on_quit_button_button_down():
	_play_button_down_sound()
	var main_menu = load(Assets.path_tscn_main_menu).instantiate()
	var level_scene = get_tree().get_first_node_in_group("level")
	Methods.switch_scene(level_scene, main_menu, true)
