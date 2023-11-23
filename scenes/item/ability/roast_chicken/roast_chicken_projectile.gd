extends Projectile


var player : Player
var reverse_rotation := false
var direction := Vector2(0.0, 0.0)


func _ready():
	player = get_tree().get_first_node_in_group("player")
	$AnimationPlayer.play("Rotate")
	position = data.spawn_position
	direction = Vector2.RIGHT.rotated(deg_to_rad(randf_range(0.0, 360.0)))
	

func _physics_process(_delta):
	position += direction * data.speed


func _on_hit_box_body_entered(body):
	if body.is_in_group("camera_boundary"):
		reverse_rotation = not reverse_rotation
		if reverse_rotation:
			$AnimationPlayer.play_backwards("Rotate")
		else:
			$AnimationPlayer.play("Rotate")


func _on_hit_box_area_entered(hurt_box : HurtBox):
	if hurt_box == null:
		return
	
	if hurt_box.owner is Enemy:
		var damage_data = Methods.cal_damage(
			player.attr,
			hurt_box.owner.attr,
			Enums.EDamageType.Both
		)
		hurt_box.owner.take_damage(damage_data)
