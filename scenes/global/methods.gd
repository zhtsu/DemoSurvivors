extends Node


func translate(index : int):
	if index == 0:
		TranslationServer.set_locale("en")
	elif index == 1:
		TranslationServer.set_locale("zh")


func load_csv_to_array(csv_file_path : String, out_list : Array) -> void:
	out_list.clear()
	var csv_file = FileAccess.open(csv_file_path, FileAccess.READ)
	# Generate dictionary from table data
	const maxsplit = 100
	var header_list = csv_file.get_line().rsplit(",", true, maxsplit)
	while not csv_file.eof_reached():
		var data_list = csv_file.get_line().rsplit(",", true, maxsplit)
		if csv_file.eof_reached():
			break
		if not header_list.size() == data_list.size():
			print_debug("Warning - Invalid data: ", data_list)
			break
		var dict : Dictionary = {}
		for idx in range(header_list.size()):
			dict[header_list[idx]] = data_list[idx]
		out_list.append(dict)
		
	csv_file.close()
	
	
func cal_damage(
	hiter_attr : Structs.Attributes,
	hurter_attr : Structs.Attributes,
	damage_type : Enums.EDamageType) -> Structs.DamageData:
	var hit_physical_atk_result = _cal_atk_with_crit(
		hiter_attr.physical_atk,
		hiter_attr.physical_crit_chance,
		hiter_attr.physical_crit_bonus)
	var hit_magical_atk_result = _cal_atk_with_crit(
		hiter_attr.magical_atk,
		hiter_attr.magical_crit_chance,
		hiter_attr.magical_crit_bonus)
	
	var physical_damage = hit_physical_atk_result["Value"] - hurter_attr.physical_def
	var magical_damage = hit_magical_atk_result["Value"] - hurter_attr.magical_def
	
	if physical_damage < 0.0:
		physical_damage = 0.0
	if magical_damage < 0.0:
		magical_damage = 0.0
	
	var result = Structs.DamageData.new()
	result.type = damage_type
	result.physical_damage = physical_damage
	result.with_physical_crit = bool(hit_physical_atk_result["Crit"])
	result.magical_damage = magical_damage
	result.with_magical_crit = bool(hit_magical_atk_result["Crit"])
	return result
	
	
func _cal_atk_with_crit(base_atk : float, crit_chance : float, crit_bonus : float) -> Dictionary:
	var additional_atk = 0.0
	var crit = false
	
	if randf_range(0.0, 1.0) < crit_chance:
		crit = true
		additional_atk = base_atk * randf_range(0.0, crit_bonus)
	
	return {
		"Crit": crit,
		"Value": base_atk + additional_atk
	}
	
	
func switch_scene(current_scene : Node, to_scene : Node, use_transition : bool = false):
	var scene_tree = get_tree();
	var game_main = scene_tree.get_first_node_in_group("main")
	
	if use_transition == true:
		seed(randi())
		var current_transition = Assets.tscn_transition.instantiate()
		var rng = RandomNumberGenerator.new()
		var rg_color = Color.from_hsv(
				rng.randf_range(0.4, 0.6),
				rng.randf_range(0.4, 0.6),
				rng.randf_range(0.4, 0.6))
		current_transition.call("init", rg_color, false)
		current_transition.connect("finished",
		func():
			game_main.remove_child(current_scene)
			var to_transition = Assets.tscn_transition.instantiate()
			to_transition.call("init", rg_color, true)
			to_scene.add_child(to_transition)
			game_main.add_child(to_scene)
		)
		current_scene.add_child(current_transition)
	else:
		game_main.remove_child(current_scene)
		game_main.add_child(to_scene)
