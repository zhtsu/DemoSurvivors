extends Control


var map_name : String = "Default"


func _ready():
	set_map_name("Grass")


func set_map_name(in_map_name : String):
	if in_map_name == map_name:
		return
	
	map_name = in_map_name
	
	for child in $SubViewport.get_children():
		$SubViewport.remove_child(child)
	
	var map = Assets.tscn_map.instantiate()
	map.init(null, map_name)
	map.as_background = true
	$SubViewport.add_child(map)
