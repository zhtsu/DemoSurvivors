extends CanvasLayer


const Assets = preload("res://scenes/global/assets.gd")

var player : Player
var game_time_secs := 0
var show_property = false


func init(in_player : Player):
	player = in_player
	$Main/Body/Box/HBox/ShowPropButton.icon = player.icon
	$Main/ExpBar.max_value = player.current_level_up_required_exp
	_update_props()
	_update_exp_bar()
	player.connect("speak", _update_witticism)
	player.connect("property_updated", _update_props)
	player.connect("exp_added", _update_exp_bar)
	player.connect("level_up", _pop_pick_item)


func _pop_pick_item(_current_level : int):
	_update_current_level_text()
	var pick_item = Assets.tscn_pick_item.instantiate()
	pick_item.connect("pick_completed", _pick_item_completed)
	add_child(pick_item)


func _pick_item_completed(item_data : Dictionary):
	_update_exp_bar()
	
	if item_data.is_empty():
		return


func _update_prop_box():
	if show_property == true:
		$Main/Body/Box/PropertyBox.show()
	else:
		$Main/Body/Box/PropertyBox.hide()


func _update_props():
	$Main/Body/Box/PropertyBox/H5/HP.call("set_property", "HP", String.num(player.hp))
	$Main/Body/Box/PropertyBox/H5/Speed.call("set_property", "Speed", String.num(player.speed))
	$Main/Body/Box/PropertyBox/H1/PATK.call("set_property", "Physical ATK", String.num(player.physical_atk))
	$Main/Body/Box/PropertyBox/H1/PDEF.call("set_property", "Physical DEF", String.num(player.physical_def))
	$Main/Body/Box/PropertyBox/H2/MATK.call("set_property", "Magical ATK", String.num(player.magical_atk))
	$Main/Body/Box/PropertyBox/H2/MDEF.call("set_property", "Magical DEF", String.num(player.magical_def))
	$Main/Body/Box/PropertyBox/H3/PCritC.call("set_property", "Physical Crit Chance", String.num(player.physical_crit_chance))
	$Main/Body/Box/PropertyBox/H3/PCritB.call("set_property", "Physical Crit Bonus", String.num(player.physical_crit_bonus))
	$Main/Body/Box/PropertyBox/H4/MCritC.call("set_property", "Magical Crit Chance", String.num(player.magical_crit_chance))
	$Main/Body/Box/PropertyBox/H4/MCritB.call("set_property", "Magical Crit Bonus", String.num(player.magical_crit_bonus))


func _update_exp_bar():
	$Main/ExpBar.max_value = player.current_level_up_required_exp
	$Main/ExpBar.value = player.current_exp


func _update_current_level_text():
	$Main/ExpBar/CurrentLevel.text = "Level: %d" % player.current_level


func _ready():
	$Timer.start(1.0)
	_update_prop_box()


func _update_witticism(talk_content : String):
	$Main/Body/Box/HBox/Witticism.text = talk_content


func _on_timer_timeout():
	game_time_secs += 1
	var mins = float(game_time_secs) / 60
	var secs = game_time_secs % 60
	$Main/Body/Time.text = "%02d : %02d " % [mins, secs]


func _on_show_prop_button_button_down():
	_play_button_down_sound()
	show_property = not show_property
	_update_prop_box()


func _on_pause_button_button_down():
	_play_button_down_sound()
	$Main/Body/PauseButton.disabled = true
	await $SoundPlayer.finished
	$Main/Body/PauseButton.disabled = false
	var pause_menu = Assets.tscn_pause_menu.instantiate()
	add_child(pause_menu)
	
	
func _play_button_down_sound():
	$SoundPlayer.stream = Assets.a_button_down
	$SoundPlayer.play()
	
	
func _play_button_hover_sound():
	$SoundPlayer.stream = Assets.a_button_hover
	$SoundPlayer.play()
