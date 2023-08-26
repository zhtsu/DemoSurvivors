extends Button

signal clicked(type : EMap)

enum EMap
{
	Forest
}

var type : EMap = EMap.Forest

func init_map_item(in_text : String, in_icon : CompressedTexture2D):
	text = in_text
	icon = in_icon
	

func hide_selected_mask():
	$SelectedMask.hide()
	$AnimationPlayer.stop()
	

func _show_seleted_mask():
	$SelectedMask.show()
	$AnimationPlayer.play("Blink")


func _on_pressed():
	clicked.emit(type)
	_show_seleted_mask()
	print_debug(type)
