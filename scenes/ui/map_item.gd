extends Button

const Enums = preload("res://scenes/mngr/enums.gd")

signal clicked(map_icon : CompressedTexture2D, map_type : Enums.EMap)

var type : Enums.EMap = Enums.EMap.Forest
var saved_icon : CompressedTexture2D = null

func init_map_item(in_text : String, in_icon : CompressedTexture2D):
	$Title.text = in_text
	icon = in_icon
	saved_icon = in_icon
	Material

func hide_selected_mask():
	$SelectedMask.hide()
	$AnimationPlayer.stop()
	

func show_seleted_mask():
	$SelectedMask.show()
	$AnimationPlayer.play("Blink")


func _on_pressed():
	clicked.emit(saved_icon, type)
	show_seleted_mask()
