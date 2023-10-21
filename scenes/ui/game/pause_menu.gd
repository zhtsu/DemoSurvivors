extends CanvasLayer


const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")


func _ready():
	get_tree().paused = true
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play_backwards("Exit")

func _on_continue_button_button_down():
	_play_button_down_sound()
	$AnimationPlayer.play("Exit")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	queue_free()


func _on_main_menu_button_button_down():
	_play_button_down_sound()
	var main_menu_popup_scene = Assets.tscn_popup.instantiate()
	main_menu_popup_scene.call("init_popup", "Back to the main menu?", _back_to_main_menu)
	add_child(main_menu_popup_scene)
	
	

func _back_to_main_menu():
	get_tree().paused = false
	var main_menu = Assets.tscn_main_menu.instantiate()
	var level_scene = get_tree().get_first_node_in_group("level")
	Methods.switch_scene(level_scene, main_menu, true)
	

func _on_options_button_button_down():
	_play_button_down_sound()
	
	var json_file = FileAccess.open(Assets.path_local_options, FileAccess.READ)
	var option_dict = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	var options_scene = Assets.tscn_options.instantiate()
	options_scene.call("init_options", option_dict)
	add_child(options_scene)

func exit_game():
	get_tree().quit()
	
	
func _on_exit_button_button_down():
	_play_button_down_sound()
	var exit_popup_scene = Assets.tscn_popup.instantiate()
	exit_popup_scene.call("init_popup", "Are you sure to exit game?", exit_game)
	add_child(exit_popup_scene)
	

func _play_button_down_sound():
	$SoundPlayer.stream = Assets.a_button_down
	$SoundPlayer.play()

	
func _play_button_hover_sound():
	$SoundPlayer.stream = Assets.a_button_hover
	$SoundPlayer.play()

