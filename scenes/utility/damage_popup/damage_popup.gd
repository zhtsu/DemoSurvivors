extends Marker2D


func init(damage_value : float, damage_type : Enums.EDamageType, is_crit : bool = false):
	$Label.text = String.num_int64(int(damage_value))
	if damage_type == Enums.EDamageType.Physical:
		pass
	elif damage_type == Enums.EDamageType.Magical:
		$Label.modulate = Color.PURPLE
		
	if is_crit:
		pass


func _get_direction():
	return Vector2(randf_range(-1, 1), -randf()) * 16


func _ready():
	randomize()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + _get_direction(), 0.75)


