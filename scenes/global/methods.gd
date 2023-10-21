extends Node


const Assets = preload("res://scenes/global/assets.gd")


static func load_csv_to_array(csv_file_path : String, out_list : Array) -> void:
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
	
	
static func cal_damage(hit_prop_dict : Dictionary, hurt_prop_dict : Dictionary) -> int:
	# Hit
	var hit_physical_atk : float = hit_prop_dict["physical_atk"]
	var hit_magical_atk : float = hit_prop_dict["magical_atk"]
	var hit_physical_crit_bonus : float = hit_prop_dict["physical_crit_bonus"]
	var hit_magical_crit_bonus : float = hit_prop_dict["magical_crit_bonus"]
	var hit_physical_crit_chance : float = hit_prop_dict["physical_crit_chance"]
	var hit_magical_crit_chance : float = hit_prop_dict["magical_crit_chance"]
	# Hurt
	var hurt_physical_def : float = hurt_prop_dict["physical_def"]
	var hurt_magical_def : float = hurt_prop_dict["magical_def"]
	
	var hit_physical_atk_result = cal_atk_with_crit(hit_physical_atk, hit_physical_crit_chance, hit_physical_crit_bonus)
	var hit_magical_atk_result = cal_atk_with_crit(hit_magical_atk, hit_magical_crit_chance, hit_magical_crit_bonus)
	
	var physical_damage = hit_physical_atk_result["Value"] - hurt_physical_def
	var magical_damage = hit_magical_atk_result["Value"] - hurt_magical_def
	
	if physical_damage < 0:
		physical_damage = 0
	if magical_damage < 0:
		magical_damage = 0
	
	return physical_damage + magical_damage
	
	
static func cal_atk_with_crit(base_atk : float, crit_chance : float, crit_bonus : float) -> Dictionary:
	var additional_atk = 0.0
	var crit = false
	
	if randf_range(0.0, 1.0) < crit_chance:
		crit = true
		additional_atk = base_atk * randf_range(0.0, crit_bonus)
	
	var result = {
		"Crit": crit,
		"Value": base_atk + additional_atk
	}
	
	return result
	
static func switch_scene(current_scene : Node, to_scene : Node, use_transition : bool = false):
	var main_loop = Engine.get_main_loop()
	var scene_tree = main_loop as SceneTree;
	var game_main = scene_tree.get_first_node_in_group("main") as Main
	
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
			to_transition.connect("finished", func() : scene_tree.paused = false)
			to_scene.add_child(to_transition)
			game_main.add_child(to_scene)
		)
		current_scene.add_child(current_transition)
	else:
		game_main.remove_child(current_scene)
		game_main.add_child(to_scene)
