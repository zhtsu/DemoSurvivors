extends Enemy


func _ready():
	_init_enemy()
	

func _physics_process(delta):
	_track_player(delta)
