extends Player


const sf_ninja_frog = preload("res://tress/sf_ninja_frog.tres")

func _ready():
	super._init_player()
	
	
func _process(_delta):
	super._update_player(_delta)
