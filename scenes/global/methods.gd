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
	
	
static func cal_crit_atk(base_atk : float, crit_prob : float, crit_bonus : float) -> Dictionary:
	var additional_atk = 0.0
	var crit = false

	if randf_range(0.0, 1.0) < crit_prob:
		crit = true
		additional_atk = base_atk * randf_range(0.0, crit_bonus)
	
	var result = {
		"Crit": crit,
		"Value": base_atk + additional_atk
	}
	
	return result
	
