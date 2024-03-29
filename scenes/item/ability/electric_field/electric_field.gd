extends Ability


var player : Player
var attacking_enemy_list : Array[Enemy]

@onready var electric_field_area = $ElectricFieldArea
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer


func _ready():
	player = get_tree().get_first_node_in_group("player")
	animation_player.play("Rotate")
	timer.start(cooldown)
	

func _on_area_2d_area_entered(hurt_box : HurtBox):
	if hurt_box == null:
		return
	
	if hurt_box.owner is Enemy:
		attacking_enemy_list.append(hurt_box.owner)


func _on_area_2d_area_exited(hurt_box : HurtBox):
	if hurt_box == null:
		return
	
	if hurt_box.owner is Enemy:
		attacking_enemy_list.erase(hurt_box.owner)


func _on_timer_timeout():
	$EffectAnimPlayer.play("Attack")
	$SoundPlayer.play()
	for enemy in attacking_enemy_list:
		var damage_data = Methods.cal_damage(
			player.attr,
			enemy.attr,
			Enums.EDamageType.Both
		)
		enemy.take_damage(damage_data)

