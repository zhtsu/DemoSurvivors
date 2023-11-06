extends TextureButton


var collection_item_name : String = "Collection Item"

func init(in_collection_item_name : String, icon_path : String):
	collection_item_name = in_collection_item_name
	$TextureRect.texture = load(icon_path)
	if in_collection_item_name == "Electric Field":
		var flipped_icon = $TextureRect.texture.get_image()
		flipped_icon.flip_x()
		$TextureRect.texture = ImageTexture.create_from_image(flipped_icon)
