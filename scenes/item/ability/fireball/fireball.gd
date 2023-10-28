extends Ability


const tscn_projectile = preload("res://scenes/item/ability/fireball/fireball_projectile.tscn")

var player : Player
var MAIN : Main

@onready var sound_player = $SoundPlayer
@onready var timer = $Timer


func _init():
	super.init("Fireball", false)
	$Sprite2D.modulate = Color.RED
	

func _ready():
	player = get_tree().get_first_node_in_group("player")
	MAIN = get_tree().get_first_node_in_group("main")
	
	timer.start(cooldown)
	timer.connect("timeout", _shoot)


func _shoot():
	if MAIN.visible_enemy_list.is_empty():
		return
		
	sound_player.play()
	var projectile = tscn_projectile.instantiate()
	projectile.init(player.position, player.velocity, speed, distance, damage_scale)
	get_tree().get_first_node_in_group("level").add_child(projectile)
	
	
