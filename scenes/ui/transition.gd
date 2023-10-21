class_name Transition
extends CanvasLayer


signal finished


@export var reverse := false
@export var color : Color = Color.DARK_GRAY


func init(in_color : Color, in_reverse : bool):
	reverse = in_reverse
	color = in_color
	
	
func display():
	$ColorRect.material.set_shader_parameter("color", color)
	if reverse:
		$AnimationPlayer.play("Exit")
	else:
		$AnimationPlayer.play("Enter")
		
	await $AnimationPlayer.animation_finished
	finished.emit()
	queue_free()
	
	
func _ready():
	display()

