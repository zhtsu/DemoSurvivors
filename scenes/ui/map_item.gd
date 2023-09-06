extends Button

const MapEnum = preload("res://scenes/mngr/map_enum.gd")

signal clicked(map_type : MapEnum.EMap)

var type : MapEnum.EMap = MapEnum.EMap.Forest

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
