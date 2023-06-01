extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Title/TitleAnimationPlayer.play("TitleAnim")
	$PlayerShow/VirtualBoyGuy.play("Idle")
	$PlayerShow/MaskDudeIdle.play("Idle")
	$PlayerShow/PinkManIdle.play("Idle")
	$PlayerShow/NinjaFrogIdle.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	get_tree().quit()
