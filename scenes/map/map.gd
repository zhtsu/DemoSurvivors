extends TileMap

class_name Map

@export var as_background : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if as_background == false:
		$AnimCamera2D.enabled = false
	else:
		$AnimationPlayer.play("Visit")


