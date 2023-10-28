extends Projectile


const Methods = preload("res://scenes/global/methods.gd")

var MAIN : Main
var player : Player

var acceleration = 1
var target_enemy : Enemy


func _ready():
	player = get_tree().get_first_node_in_group("player")
	MAIN = get_tree().get_first_node_in_group("main")
	position = spawn_position
	
	_update_target_enemy()
	
	
func _physics_process(_delta):
	if target_enemy == null:
		_update_target_enemy()
		
	var offset = target_enemy.position - position
	position += offset.normalized() * speed
		
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
	
	
func _update_target_enemy():
	var min_dist = 10000.0
	for enemy in MAIN.visible_enemy_list:
		var dist = player.position.distance_to(enemy.position)
		if dist < min_dist:
			min_dist = dist
			target_enemy = enemy
			
			
func _on_hit_box_area_entered(hurt_box : HurtBox):
	if hurt_box == null:
		return
	
	if hurt_box.owner is Enemy:
		var damage_value = Methods.cal_damage(player.get_prop_dict(), hurt_box.owner.get_prop_dict())
		hurt_box.owner.take_damage(damage_value * damage_scale)
	
	queue_free()


func _on_hit_box_body_entered(_body):
	queue_free()
