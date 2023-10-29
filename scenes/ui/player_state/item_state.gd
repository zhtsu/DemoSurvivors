class_name ItemState
extends Panel


func set_item_state(item : Item):
	$TextureRect.texture = item.icon
	if item.item_name == "Electric Field":
		var flipped_icon = item.icon.get_image()
		flipped_icon.flip_x()
		$TextureRect.texture = ImageTexture.create_from_image(flipped_icon)
	
	$TextureRect.modulate = item.color()
	$Level.text = String.num_int64(item.level)
	tooltip_text = item.item_name
	
