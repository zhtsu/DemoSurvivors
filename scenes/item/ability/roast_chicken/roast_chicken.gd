extends Ability


var tscn_projectile = preload("res://scenes/item/ability/roast_chicken/roast_chicken_projectile.tscn")


func _ready():
	add_child(tscn_projectile.instantiate())
	
	
func _physics_process(delta):
	pass
