extends Character

# Called when the node enters the scene tree for the first time.
func _ready():
	LoadAndInitKeyMap()
	InitCharacter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ListenForMove(delta)
	UpdateAnimation()
	UpdateDirection()
