extends Control


signal confirm
signal cancel

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Enter")


func init_popup(message : String, confirm_callback : Callable, cancel_callback : Callable = _cancel):
	$Background/ColorRect/VBoxContainer/MessageText.set_text(message)
	self.connect("confirm", confirm_callback)
	self.connect("cancel", cancel_callback)


func _on_confirm_button_button_down():
	_play_button_down_sound()
	emit_signal("confirm")


func _on_cancel_button_button_down():
	_play_button_down_sound()
	emit_signal("cancel")
	
	
func _cancel():
	$AnimationPlayer.play("Cancel")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Cancel":
		self.queue_free()


func _on_confirm_button_mouse_entered():
	_play_button_hover_sound()
	pass # Replace with function body.


func _on_cancel_button_mouse_entered():
	_play_button_hover_sound()
	pass # Replace with function body.
	
	
func _play_button_down_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_down")
	
	
func _play_button_hover_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_hover")


func _on_background_button_down():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_down")
	_cancel()
