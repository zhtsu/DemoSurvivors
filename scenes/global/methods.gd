extends Node


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
	
