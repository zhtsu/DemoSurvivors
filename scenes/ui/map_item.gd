extends Button

const Enums = preload("res://scenes/common/enums.gd")

signal clicked(map_type : Enums.EMap)

var type : Enums.EMap = Enums.EMap.Forest

func init_map_item(in_text : String, in_icon : CompressedTexture2D):
	$Title.text = in_text
	icon = in_icon

func hide_selected_mask():
	$SelectedMask.hide()
	$AnimationPlayer.stop()
	

func show_seleted_mask():
	$SelectedMask.show()
	$AnimationPlayer.play("Blink")


func _on_pressed():
	clicked.emit(type)
	show_seleted_mask()
