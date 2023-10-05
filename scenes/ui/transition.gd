extends CanvasLayer


signal finished


@export var reverse := false
@export var color : Color = Color.DARK_GRAY


func init(in_reverse : bool, in_color : Color):
	reverse = in_reverse
	color = in_color
	
func display():
	$ColorRect.material.set_shader_parameter("color", color)
	if reverse:
		$AnimationPlayer.play("Exit")
	else:
		$AnimationPlayer.play("Enter")
		
	
func _ready():
	display()


func _on_animation_player_animation_finished(_anim_name):
	finished.emit()
