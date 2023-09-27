extends CanvasLayer


signal finished

const Enums = preload("res://scenes/mngr/enums.gd")

@export var type : Enums.ETransitionDirection = Enums.ETransitionDirection.Normal
@export var color : Color = Color.DARK_GRAY


func init(in_type : Enums.ETransitionDirection, in_color : Color):
	type = in_type
	color = in_color
	
func display():
	$ColorRect.material.set_shader_parameter("color", color)
	if type == Enums.ETransitionDirection.Normal:
		$AnimationPlayer.play("Enter")
	elif type == Enums.ETransitionDirection.Reverse:
		$AnimationPlayer.play("Exit")
	
func _ready():
	display()


func _on_animation_player_animation_finished(_anim_name):
	finished.emit()
