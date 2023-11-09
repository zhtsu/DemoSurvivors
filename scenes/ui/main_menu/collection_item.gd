class_name CollectionItem
extends TextureButton


signal clicked(collection_item : CollectionItem)


var collection_item_name : String
var collection_item_type : String
var icon_texture : AtlasTexture

func init(in_name : String, icon_path : String, in_type : String):
	collection_item_name = in_name
	collection_item_type = in_type
	icon_texture = load(icon_path)
	$TextureRect.texture = icon_texture
	if in_name == "Electric Field":
		var flipped_icon = icon_texture.get_image()
		flipped_icon.flip_x()
		$TextureRect.texture = ImageTexture.create_from_image(flipped_icon)	
	
	
func _ready():
	hide_hover()
	# Center the texture
	var icon_size = icon_texture.get_region().size
	$TextureRect.position = Vector2(35, 35) - (icon_size / 2)


func _on_button_down():
	clicked.emit(self)
	
	
func hide_hover():
	$Hover.hide()
	
	
func show_hover():
	$Hover.show()
