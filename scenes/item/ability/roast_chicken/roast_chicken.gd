extends Ability


var tscn_projectile = preload("res://scenes/item/ability/roast_chicken/roast_chicken_projectile.tscn")
var player : Player


func _init():
	super.init("Roast Chicken", false)


func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	$Timer.start(cooldown)
	$Timer.connect("timeout", _shoot)
	
	
func _shoot():
	var projectile = tscn_projectile.instantiate()
	var projectile_data := Structs.ProjectileData.new()
	projectile_data.spawn_position = player.position
	projectile_data.speed = 2.0
	projectile_data.damage_scale = 1.0
	projectile.init(projectile_data)
	get_tree().get_first_node_in_group("level").add_child(projectile)
