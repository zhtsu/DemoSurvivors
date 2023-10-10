extends Control


@export_enum("Left", "Right") var direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 0:
		$Button.position.x = 0.0
		$Button.modulate = Color.DARK_SEA_GREEN
	else:
		$Button.position.x = size.x - $Button.size.x
		$Button.modulate = Color.SKY_BLUE
		$AbilityGrid.layout_direction = LAYOUT_DIRECTION_RTL

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
