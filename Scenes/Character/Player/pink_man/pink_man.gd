extends Player


# Called when the node enters the scene tree for the first time.
func _ready():
	init_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_player(delta)
