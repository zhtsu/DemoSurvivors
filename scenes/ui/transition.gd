extends CanvasLayer


signal finished

const Enums = preload("res://scenes/mngr/enums.gd")

@export var type : Enums.ETransitionDirection = Enums.ETransitionDirection.Normal


func init(in_type : Enums.ETransitionDirection):
	type = in_type
	
	
func display():
	if type == Enums.ETransitionDirection.Normal:
		$AnimationPlayer.play("Enter")
	elif type == Enums.ETransitionDirection.Reverse:
		$AnimationPlayer.play("Exit")
	
func _ready():
	display()


func _on_animation_player_animation_finished(_anim_name):
	finished.emit()
