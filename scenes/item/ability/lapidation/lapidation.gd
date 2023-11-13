extends Ability


const tscn_projectile = preload("res://scenes/item/ability/lapidation/lapidation_projectile.tscn")

var player : Player
var shoot_number := 4
var knockback_distance := 6.0
var penertration := 2


@onready var sound_player = $SoundPlayer
@onready var timer = $Timer


func _init():
	super.init("Lapidation", false)
	

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	timer.start(cooldown)
	timer.connect("timeout", _shoot)
	
	

func _shoot():
	sound_player.play()
	for i in shoot_number:
		var projectile = tscn_projectile.instantiate()
		var projectile_data := Structs.ProjectileData.new()
		projectile_data.spawn_position = player.position
		var angle = deg_to_rad(360.0 / (i + 1))
		projectile_data.velocity = player.previous_velocity.rotated(angle)
		projectile_data.speed = speed
		projectile_data.distance = distance
		projectile_data.damage_scale = 1.0
		projectile_data.knockback_distance = knockback_distance
		projectile_data.penertration = penertration
		projectile.init(projectile_data)
		get_tree().get_first_node_in_group("level").add_child(projectile)
	
	
	
