extends Node


const tscn_projectile = preload("res://scenes/item/actions/base/projectile.tscn")

var item_self : Item
var player : Player
var timer : Timer
var sound_player : AudioStreamPlayer


func _ready():
	item_self = owner as Item
	player = get_tree().get_first_node_in_group("player")
	
	sound_player = AudioStreamPlayer.new()
	sound_player.stream = load("res://assets/sounds/homemade_projectile.mp3")
	sound_player.volume_db = -12
	add_child(sound_player)
	
	timer = Timer.new()
	add_child(timer)
	timer.start(2)
	timer.connect("timeout", _shoot)


func _shoot():
	sound_player.play()
	var projectile = tscn_projectile.instantiate()
	projectile.init(player.position, player.previous_velocity, 4)
	add_child(projectile)
	timer.start(2)
	
	
	
