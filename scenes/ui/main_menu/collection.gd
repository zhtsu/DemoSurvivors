extends CanvasLayer

signal closed


func _ready():
	$AnimationPlayer.play("Enter")


func _on_background_button_down():
	closed.emit()
	$SoundPlayer.play()
	$AnimationPlayer.play_backwards("Enter")
	await $AnimationPlayer.animation_finished
	self.queue_free()
