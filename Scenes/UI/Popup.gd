extends Control


signal confirm
signal cancel

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Enter")




func InitPopup(Message:String, ConfirmCallback:Callable, CancelCallback:Callable = Cancel):
	$Background/ColorRect/VBoxContainer/MessageText.set_text(Message)
	self.connect("confirm", ConfirmCallback)
	self.connect("cancel", CancelCallback)


func _on_confirm_button_button_down():
	PlayButtonDownSound()
	emit_signal("confirm")


func _on_cancel_button_button_down():
	PlayButtonDownSound()
	emit_signal("cancel")
	
	
func Cancel():
	$AnimationPlayer.play("Cancel")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Cancel":
		self.queue_free()


func _on_confirm_button_mouse_entered():
	PlayButtonHoverSound()
	pass # Replace with function body.


func _on_cancel_button_mouse_entered():
	PlayButtonHoverSound()
	pass # Replace with function body.
	
	
func PlayButtonDownSound():
	get_tree().get_first_node_in_group("audio_mngr").call("PlayButtonDown")
	
	
func PlayButtonHoverSound():
	get_tree().get_first_node_in_group("audio_mngr").call("PlayButtonHover")

