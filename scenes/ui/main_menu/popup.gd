extends CanvasLayer


signal confirm
signal cancel

const Assets = preload("res://scenes/global/assets.gd")

@onready var sound_player = $SoundPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Enter")


func init_popup(message : String, confirm_callback : Callable, cancel_callback : Callable = _cancel):
	$RootPanel/VBoxContainer/MessageText.set_text(message)
	self.connect("confirm", confirm_callback)
	self.connect("cancel", cancel_callback)


func _on_confirm_button_button_down():
	_play_button_down_sound()
	await $SoundPlayer.finished
	emit_signal("confirm")


func _on_cancel_button_button_down():
	_play_button_down_sound()
	emit_signal("cancel")
	
	
func _cancel():
	$AnimationPlayer.play("Cancel")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Cancel":
		self.queue_free()
	
	
func _play_button_down_sound():
	sound_player.stream = Assets.a_button_down
	sound_player.play()
	
	
func _play_button_hover_sound():
	sound_player.stream = Assets.a_button_hover
	sound_player.play()


func _on_background_button_down():
	_play_button_down_sound()
	_cancel()
