extends Control


signal created


func _ready():
	$AnimationPlayer.play("Enter")
	await $AnimationPlayer.animation_finished
	created.emit()
	
	
func _play_button_down_sound():
	$SoundPlayer.stream = Assets.a_button_down
	$SoundPlayer.play()

	
func _play_button_hover_sound():
	$SoundPlayer.stream = Assets.a_button_hover
	$SoundPlayer.play()




func _on_button_down():
	_play_button_down_sound()


func _on_mouse_entered():
	_play_button_hover_sound()
	$AnimationPlayer.play("Hover")


func _on_mouse_exited():
	$AnimationPlayer.play_backwards("Hover")
