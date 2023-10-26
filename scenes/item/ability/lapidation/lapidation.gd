extends Ability


const tscn_projectile = preload("res://scenes/item/ability/lapidation/projectile.tscn")

var player : Player

@onready var sound_player = $SoundPlayer
@onready var timer = $Timer


func _init():
	super.init("Lapidation", false)
	

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	timer.start(2)
	timer.connect("timeout", _shoot)


func _shoot():
	sound_player.play()
	var projectile = tscn_projectile.instantiate()
	projectile.init(player.position, player.previous_velocity, 4)
	get_tree().get_first_node_in_group("level").add_child(projectile)
	timer.start(2)
	
	
	
