extends CanvasLayer


const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")


func _ready():
	$AnimationPlayer.play("Enter")


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
	get_tree().paused = false
	var main_menu = Assets.tscn_main_menu.instantiate()
	var level_scene = get_tree().get_first_node_in_group("level")
	Methods.switch_scene(level_scene, main_menu, true)
