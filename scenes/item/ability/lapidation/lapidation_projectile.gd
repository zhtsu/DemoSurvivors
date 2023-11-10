extends Projectile


var player : Player
var acceleration = 1


func _ready():
	player = get_tree().get_first_node_in_group("player")
	position = spawn_position


func _physics_process(_delta):
	var direction = Vector2.RIGHT.rotated(velocity.angle())
	position += direction * speed
	
	if position.distance_to(spawn_position) > distance:
		queue_free()
	


func _on_hit_box_area_entered(hurt_box : HurtBox):
	if hurt_box == null:
		return
	
	if hurt_box.owner is Enemy:
		var damage_data = Methods.cal_damage(
			player.attr,
			hurt_box.owner.attr,
			Enums.EDamageType.Physical
		)
		hurt_box.owner.take_damage(damage_data)
	
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hit_box_body_entered(_body):
	queue_free()
