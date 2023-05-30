extends Player

func _ready():
	InitPlayer()
	
	
func _process(delta):
	UpdatePlayer(delta)
