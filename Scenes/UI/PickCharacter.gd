extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Enter")
	$Background/VBoxContainer/CharacterList/NinjaFrogButton.grab_focus()
	$Background/VBoxContainer/CharacterList/NinjaFrogButton/NinjaFrogIdle.play("Idle")
	$Background/VBoxContainer/HBoxContainer/ColorRect/CharacterAnim.play("Walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
