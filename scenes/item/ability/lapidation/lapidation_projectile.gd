extends Projectile


var player : Player
var acceleration = 1
var penetrated_count := 0


func _ready():
	player = get_tree().get_first_node_in_group("player")
	position = data.spawn_position


func _physics_process(_delta):
	var direction = Vector2.RIGHT.rotated(data.velocity.angle())
	position += direction * data.speed
	
	if position.distance_to(data.spawn_position) > data.distance:
		queue_free()
	


func _on_hit_box_area_entered(hurt_box : HurtBox):
	if hurt_box == null:
		return
	
	if hurt_box.owner is Enemy:
		# Damage
		var damage_data = Methods.cal_damage(
			player.attr,
			hurt_box.owner.attr,
			Enums.EDamageType.Physical
		)
		hurt_box.owner.take_damage(damage_data)
		# Knockback
		if hurt_box.owner.hp > 0.0:
			var direction = position.direction_to(hurt_box.owner.position)
			var knockback = direction * data.knockback_distance
			hurt_box.owner.position += knockback
	
	# Penertration
	penetrated_count += 1
	if penetrated_count == data.penertration:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hit_box_body_entered(_body):
	queue_free()
