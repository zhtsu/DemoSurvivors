class_name Player
extends Character


signal speak(witticism : String)
signal level_up(current_level : int)
signal death
signal property_updated
signal exp_added
signal item_added(ability : Item)


const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")

var current_level_up_required_exp := 10
var current_exp : int = 0
var current_level : int = 0
var witticism_dict : Dictionary
var current_witticism_pool : Array
var talk_speed : float = 1.0
# Used for UI
var icon : Texture2D
# Used for projectile
var previous_velocity : Vector2 = Vector2(0.0, 0.0)

var ability_inventory : Array[Item]
var weapon_inventory : Array[Item]


func has_ability(ability_name : String) -> bool:
	for ability in ability_inventory:
		if ability.item_name == ability_name:
			return true
	return false


func _update_hp_bar():
	$HpBar.value = hp
	property_updated.emit()
	
	
func add_exp(exp_amount : int):
	current_exp += exp_amount
	exp_added.emit()
	

func _ready():
	_init_character()
	$HpBar.hide()
	$AnimatedSprite2D.hide()
	state = ECharacterState.Appearing
	$EffectAnimator.play("Appearing")
	await $EffectAnimator.animation_finished
	$AnimatedSprite2D.show()
	$HpBar.show()
	current_witticism_pool = witticism_dict["Common"]
	speak.emit(current_witticism_pool.pick_random())
	$Timer.start(randf_range(talk_speed, 20.0))
	_update_hp_bar()
	damage.connect(_update_hp_bar)
	

func init(player_data : Dictionary, MAIN : Main):
	icon = load(Assets.dir_tres + player_data["icon_tres"])
	var sprite_frames_path = Assets.dir_tres + player_data["sprite_frames_tres"]
	var sprite_frames = load(sprite_frames_path)
	$AnimatedSprite2D.sprite_frames = sprite_frames
	character_name = player_data["name"]
	speed = float(player_data["speed"])
	physical_atk = float(player_data["physical_ATK"])
	physical_def = float(player_data["physical_DEF"])
	magical_atk = float(player_data["magical_ATK"])
	magical_def = float(player_data["magical_DEF"])
	physical_crit_bonus = float(player_data["physical_crit_bonus"])
	physical_crit_chance = float(player_data["physical_crit_chance"])
	magical_crit_bonus = float(player_data["magical_crit_bonus"])
	magical_crit_chance = float(player_data["magical_crit_chance"])
	# Load witticisms data
	var witticism_json_path = Assets.dir_data + player_data["witticisms_json"]
	var json_file = FileAccess.open(witticism_json_path, FileAccess.READ)
	witticism_dict = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	# Create default ability and weapon
	var gift_of_the_gods = Assets.tscn_GOTG.instantiate()
	var gotg_ability_data = MAIN.find_ability_data("Gift of the gods")
	gift_of_the_gods.init_ability(gotg_ability_data)
	add_item(gift_of_the_gods)
	var default_ability_data = MAIN.find_ability_data(player_data["ability"])
	if not default_ability_data.is_empty():
		var default_ability_path = Assets.dir_ability + default_ability_data["tscn"]
		var default_ability : Ability = load(default_ability_path).instantiate()
		default_ability.init_ability(default_ability_data)
		add_item(default_ability)

func set_position_smoothing(enabled : bool = true):
	$EffectCamera.position_smoothing_enabled = enabled
	

func _physics_process(delta):
	if hp <= 0:
		state = ECharacterState.Disappearing
		$AnimatedSprite2D.hide()
		$EffectAnimator.show()
		$EffectAnimator.play("Disappearing")
		await $EffectAnimator.animation_finished
		hide()
		death.emit()
		
	while current_exp >= current_level_up_required_exp:
		current_exp -= current_level_up_required_exp
		current_level += 1
		var added_required_exp = float(current_level_up_required_exp) * (1.0 + (float(current_level) * 0.2))
		current_level_up_required_exp += int(added_required_exp)
		level_up.emit(current_level)
	
	if not state == ECharacterState.Appearing or state == ECharacterState.Disappearing:
		_update_move(delta)
		_update_player_animation()


func _update_player_animation():
	if state == ECharacterState.Idle:
		$AnimatedSprite2D.play("Idle")
	elif state == ECharacterState.Walk:
		$AnimatedSprite2D.play("Walk")
	elif state == ECharacterState.Damage:
		$AnimatedSprite2D.play("Damage")
	#
	if direction == ECharacterDirection.Right:
		$AnimatedSprite2D.flip_h = false
	elif direction == ECharacterDirection.Left:
		$AnimatedSprite2D.flip_h = true


func _update_move(delta):
	if not velocity == Vector2.ZERO:
		previous_velocity = velocity
		
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Up"):
		velocity.y = -1
	elif Input.is_action_pressed("Down"):
		velocity.y = 1
	if Input.is_action_pressed("Left"):
		velocity.x = -1
	elif Input.is_action_pressed("Right"):
		velocity.x = 1
	
	position += velocity.normalized() * speed * 50 * delta
	
	if not state == ECharacterState.Damage:
		if velocity.length() > 0:
			state = ECharacterState.Walk
		else:
			state = ECharacterState.Idle
		
		if velocity.x > 0:
			direction = ECharacterDirection.Right
		elif velocity.x < 0:
			direction = ECharacterDirection.Left
		
	move_and_collide(Vector2.ZERO)


func _on_effect_animator_animation_finished():
	state = ECharacterState.Idle
	set_position_smoothing(true)
	$AnimatedSprite2D.show()
	$EffectAnimator.hide()


func get_rand_witticism() -> String:
	return current_witticism_pool.pick_random()


func _on_timer_timeout():
	# Emit talk signal to update witticism in PlayerState
	speak.emit(current_witticism_pool.pick_random())
	$Timer.start(randf_range(talk_speed, 20.0))
	
	
func get_sprite_frames():
	return $AnimatedSprite2D.sprite_frames
	
	
func get_camera():
	return $EffectCamera



func _on_hurt_box_area_entered(hit_box : HitBox):
	if hit_box == null:
		return
	
	# Pick up item
	if hit_box.owner is ExpStone:
		add_exp(hit_box.owner.exp_volume)
		hit_box.owner.queue_free()
		return
	
	var damage_value : float
	# Player is hit by an Enemy
	if hit_box.owner is Enemy:
		damage_value = Methods.cal_damage(hit_box.owner.get_prop_dict(), get_prop_dict())
	
	if hp > 0:
		take_damage(damage_value)
		
		
func get_enemy_spawn_location():
	return $EffectCamera/Path2D/EnemySpawnLocation
	
	
	
func add_item(item : Item):
	if item is ExpStone:
		add_exp(item.exp_volume)
		return
		
	if item is Ability:
		ability_inventory.append(item)
	elif item is Weapon:
		weapon_inventory.append(item)
		
	add_child(item)
	item_added.emit(item)
