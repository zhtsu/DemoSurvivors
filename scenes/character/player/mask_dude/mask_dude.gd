extends Player

const sf_mask_dude = preload("res://tress/sf_mask_dude.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	super._init_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._update_player(delta)