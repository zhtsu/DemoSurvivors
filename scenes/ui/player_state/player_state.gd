extends CanvasLayer


var player : Player
var game_time_secs := 0
var show_property = false

@onready var ability_box = $Main/Body/AbilityBox
@onready var weapon_box = $Main/Body/WeaponBox


func init(in_player : Player):
	player = in_player
	$Main/Body/Box/HBox/ShowPropButton.icon = player.icon
	$Main/ExpBar.max_value = player.current_level_up_required_exp
	_update_props()
	_update_exp_bar()
	_update_item_box()
	player.connect("speak", _update_witticism)
	player.connect("property_updated", _update_props)
	player.connect("exp_added", _update_exp_bar)
	player.connect("level_up", _update_current_level_text)
	player.connect("item_added", _on_item_added)
	player.connect("damage", _on_player_damage)


func _process(_delta):
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second())
	if Engine.get_frames_per_second() < 30:
		$FPS.modulate = Color.RED
	else:
		$FPS.modulate = Color.WHITE
	$EnemyCount.text = "Enemies: " + str(get_tree().get_first_node_in_group("enemy_spawner").current_enemy_count)


func reset_expbar():
	$Main/ExpBar.value = 0
	
	
func _on_player_damage():
	$AnimationPlayer.play("PlayerDamage")
	_player_player_damage_sound()
	

func _update_item_box():
	ability_box.update(player.ability_inventory)
	weapon_box.update(player.weapon_inventory)
	
func _on_item_added(item : Item):
	if item is Ability:
		ability_box.update(player.ability_inventory)
	elif item is Weapon:
		weapon_box.update(player.weapon_inventory)


func _update_prop_box():
	if show_property == true:
		$Main/Body/Box/PropertyBox.show()
	else:
		$Main/Body/Box/PropertyBox.hide()


func _update_props():
	$Main/Body/Box/PropertyBox/H5/HP.set_property("HP", String.num_int64(int(player.hp)), 12)
	$Main/Body/Box/PropertyBox/H5/Speed.set_property("Speed", String.num(player.speed), 12)
	$Main/Body/Box/PropertyBox/H1/PATK.set_property("Physical ATK", String.num(player.attr.physical_atk), 12)
	$Main/Body/Box/PropertyBox/H1/PDEF.set_property("Physical DEF", String.num(player.attr.physical_def), 12)
	$Main/Body/Box/PropertyBox/H2/MATK.set_property("Magical ATK", String.num(player.attr.magical_atk), 12)
	$Main/Body/Box/PropertyBox/H2/MDEF.set_property("Magical DEF", String.num(player.attr.magical_def), 12)
	$Main/Body/Box/PropertyBox/H3/PCritC.set_property("Physical Crit Chance", String.num(player.attr.physical_crit_chance), 12)
	$Main/Body/Box/PropertyBox/H3/PCritB.set_property("Physical Crit Bonus", String.num(player.attr.physical_crit_bonus), 12)
	$Main/Body/Box/PropertyBox/H4/MCritC.set_property("Magical Crit Chance", String.num(player.attr.magical_crit_chance), 12)
	$Main/Body/Box/PropertyBox/H4/MCritB.set_property("Magical Crit Bonus", String.num(player.attr.magical_crit_bonus), 12)


func _update_exp_bar():
	$Main/ExpBar.max_value = player.current_level_up_required_exp
	$Main/ExpBar.value = player.current_exp


func _update_current_level_text(current_level : int):
	$Main/ExpBar/HBoxContainer/CurrentLevel.text = "%d" % current_level


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
	
	
func _player_player_damage_sound():
	if Data.player_damage_sound_array.is_empty():
		var damage_sound = Assets.tscn_once_sound.instantiate()
		damage_sound.init(Assets.a_player_damage, -12)
		Data.player_damage_sound_array.append(damage_sound)
		get_tree().get_first_node_in_group("level").add_child(damage_sound)
		
	
func _play_button_hover_sound():
	$SoundPlayer.stream = Assets.a_button_hover
	$SoundPlayer.play()
