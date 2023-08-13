extends Player

func _ready():
	init_player()
	
	
func _process(delta):
	update_player(delta)
