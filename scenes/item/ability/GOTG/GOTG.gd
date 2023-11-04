extends Ability


var player : Player


func _ready():
	player = get_tree().get_first_node_in_group("player") as Player
	player.level_up.connect(_gift_of_the_gods)
	
	
func _gift_of_the_gods(_current_level : int):
	if player.state == Enums.EState.Disappearing:
		return
		
	var ui_pick_item = Assets.tscn_pick_item.instantiate()
	var level_node = get_tree().get_first_node_in_group("level")
	level_node.add_child(ui_pick_item)
