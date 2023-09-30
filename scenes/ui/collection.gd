extends CanvasLayer


func _ready():
	$AnimationPlayer.play("Enter")


func _on_background_button_down():
	$SoundPlayer2D.play()
	$AnimationPlayer.play("Exit")
	await $AnimationPlayer.animation_finished
	self.queue_free()
