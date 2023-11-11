extends HBoxContainer


func set_property(prop_name : String, prop_value : String, font_size : int = -1):
	if not font_size == -1:
		$Name.add_theme_font_size_override("font_size", font_size)
		$Label.add_theme_font_size_override("font_size", font_size)
		$Value.add_theme_font_size_override("font_size", font_size)
		
	$Name.text = prop_name
	$Value.text = prop_value
