extends CanvasLayer


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
	var main_menu = load(Assets.path_tscn_main_menu).instantiate()
	var level_scene = get_tree().get_first_node_in_group("level")
	Methods.switch_scene(level_scene, main_menu, true)
	

func _on_options_button_button_down():
	_play_button_down_sound()
	var options_scene = load(Assets.path_tscn_options).instantiate()
	add_child(options_scene)


func _exit():
	get_tree().quit()
	
	
func _on_exit_button_button_down():
	_play_button_down_sound()
	var exit_popup_scene = Assets.tscn_popup.instantiate()
	exit_popup_scene.call("init_popup", "Are you sure to exit?", _exit)
	add_child(exit_popup_scene)
	

func _play_button_down_sound():
	$SoundPlayer.stream = Assets.a_button_down
	$SoundPlayer.play()

	
func _play_button_hover_sound():
	$SoundPlayer.stream = Assets.a_button_hover
	$SoundPlayer.play()

