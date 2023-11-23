extends Ability


const tscn_projectile = preload("res://scenes/item/ability/fireball/fireball_projectile.tscn")

var player : Player

@onready var sound_player = $SoundPlayer
@onready var timer = $Timer


func _init():
	super.init("Fireball", false)
	$Sprite2D.modulate = Color.RED
	

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	timer.start(cooldown)
	timer.connect("timeout", _shoot)


func _shoot():
	if Data.visible_enemy_list.is_empty():
		return
		
	sound_player.play()
	var projectile = tscn_projectile.instantiate()
	var projectile_data := Structs.ProjectileData.new()
	projectile_data.spawn_position = player.position
	projectile_data.speed = speed
	projectile_data.distance = distance
	projectile_data.damage_scale = damage_scale
	projectile.init(projectile_data)
	get_tree().get_first_node_in_group("level").add_child(projectile)
	
	
