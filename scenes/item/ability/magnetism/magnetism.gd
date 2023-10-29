extends Ability


var player : Player


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _physics_process(_delta):
	var exp_stone_list = get_tree().get_nodes_in_group("exp_stone")
	var attracted_exp_stone_list : Array[ExpStone] = []
	for exp_stone in exp_stone_list:
		if player.position.distance_to(exp_stone.position) < distance:
			attracted_exp_stone_list.append(exp_stone)
	for exp_stone in attracted_exp_stone_list:
		var offset = player.position - exp_stone.position
		exp_stone.position += offset.normalized() * speed
