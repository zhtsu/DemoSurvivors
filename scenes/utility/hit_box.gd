extends Area2D


func set_custom_shape(custom_shape : Shape2D):
	$CollisionShape2D.shape = custom_shape


func _on_area_entered(area):
	print_debug(area)
