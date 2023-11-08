class_name CollectionItem
extends TextureButton


signal clicked(collection_item : CollectionItem)


var collection_item_name : String = "Collection Item"
var icon_texture : AtlasTexture

func init(in_collection_item_name : String, icon_path : String):
	collection_item_name = in_collection_item_name
	icon_texture = load(icon_path)
	$TextureRect.texture = icon_texture
	if in_collection_item_name == "Electric Field":
		var flipped_icon = icon_texture.get_image()
		flipped_icon.flip_x()
		$TextureRect.texture = ImageTexture.create_from_image(flipped_icon)	
	
	
func _ready():
	hide_hover()
	# Center the texture
	var icon_size = icon_texture.get_region().size
	$TextureRect.position = Vector2(35, 35) - (icon_size / 2)


func _on_button_down():
	$Hover.show()
	clicked.emit(self)
	
	
func hide_hover():
	$Hover.hide()
