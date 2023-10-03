extends TileMap

class_name Map

@export var as_background : bool = false

@onready var anim_camera := $EffectCamera

# Called when the node enters the scene tree for the first time.
func _ready():
	if as_background == false:
		anim_camera.enabled = false


