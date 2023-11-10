class_name Character
extends CharacterBody2D


signal damage


const tscn_damage_popup = preload("res://scenes/utility/damage_popup/damage_popup.tscn")
#
const ECharacterState = Enums.EState
const ECharacterDirection = Enums.EDirection

var character_name = "角色名称"
var speed : float = 1
var hp : float = 100.0
var damage_interval := 0.2
var attr := Structs.Attributes.new()
var spawn_position = Vector2(0, 0)
var direction = ECharacterDirection.Right
var state = ECharacterState.Idle
var size : Vector2


func _init_character():
	position = spawn_position
	size = $CollisionShape2D.shape.get_rect().size
	

# Make sure call this function once before _ready()
# Otherwise, the action script will not work
func _set_action_gdscript(script : Script):
	$Action.set_script(script)
	
	
func take_damage(damage_data : Structs.DamageData):
	if state == ECharacterState.Damage:
		state = ECharacterState.Idle
		if self is Enemy:
			state = ECharacterState.Walk
		return
	
	state = ECharacterState.Damage
	
	if self is Enemy:
		_popup_damage_value(damage_data)
	
	hp -= float(damage_data.physical_damage + damage_data.magical_damage)
	damage.emit()
	$DamageTimer.start(damage_interval)


func _popup_damage_value(damage_data : Structs.DamageData):
	var damage_type = Enums.EDamageType.values()[int(damage_data.type)]
	if damage_type == Enums.EDamageType.Both:
		var physical_damage_value = damage_data.physical_damage
		var physical_crit = damage_data.with_physical_crit
		_create_damage_popup(physical_damage_value, Enums.EDamageType.Physical, physical_crit)
		var magical_damage_value = damage_data.magical_damage
		var magical_crit = damage_data.with_physical_crit
		_create_damage_popup(magical_damage_value, Enums.EDamageType.Magical, magical_crit)
	else:
		if damage_data.type == Enums.EDamageType.Physical:
			_create_damage_popup(
				damage_data.physical_damage,
				Enums.EDamageType.Physical,
				damage_data.with_physical_crit)
		elif damage_data.type == Enums.EDamageType.Magical:
			_create_damage_popup(
				damage_data.magical_damage,
				Enums.EDamageType.Magical,
				damage_data.with_magical_crit)

func _create_damage_popup(damage_value : float, damage_type : Enums.EDamageType, is_crit : bool):
	var damage_popup = tscn_damage_popup.instantiate()
	damage_popup.init(damage_value, damage_type, is_crit)
	damage_popup.position = position
	get_tree().get_first_node_in_group("level").add_child(damage_popup)


func _on_damage_timer_timeout():
	var overlapping_areas = $HurtBox.get_overlapping_areas()
	if overlapping_areas.size() > 0:
		for hit_box in overlapping_areas:
			$HurtBox.area_entered.emit(hit_box)
	else:
		state = ECharacterState.Idle
		if self is Enemy:
			state = ECharacterState.Walk


func _on_hurt_box_area_exited(_area):
	state = ECharacterState.Idle
	if self is Enemy:
		state = ECharacterState.Walk
