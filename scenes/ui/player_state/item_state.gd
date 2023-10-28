class_name ItemState
extends Panel


func set_item_state(item : Item):
	$TextureRect.texture = item.icon
	$TextureRect.modulate = item.color()
	$Level.text = String.num_int64(item.level)
	tooltip_text = item.item_name
	
