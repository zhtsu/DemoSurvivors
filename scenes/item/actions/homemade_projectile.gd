extends Node


const tscn_projectile = preload("res://scenes/item/actions/base/projectile.tscn")

var item_self : Item
var player : Player
var timer : Timer


func _ready():
	item_self = owner as Item
	player = get_tree().get_first_node_in_group("player")
	
	timer = Timer.new()
	add_child(timer)
	timer.start(2)
	timer.connect("timeout", _shoot)


func _shoot():
	var projectile = tscn_projectile.instantiate()
	projectile.init(player.position, player.previous_velocity, 4)
	add_child(projectile)
	timer.start(2)
	
	
	
