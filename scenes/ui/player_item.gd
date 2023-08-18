extends Button


signal item_clicked(player_type)

var saved_player_type : int = -1

func init_player_item(in_sprite_frames : SpriteFrames, in_player_type : int):
	$Sprite2D.sprite_frames = in_sprite_frames
	saved_player_type = in_player_type

func play_anim(anim_name : String):
	$Sprite2D.play(anim_name)
	
	
func get_player_sprite_frames() -> SpriteFrames:
	return $Sprite2D.sprite_frames


func _on_pressed():
	item_clicked.emit(saved_player_type)
	
	
func reset():
	release_focus()
	$Sprite2D.play("Idle")
	$Sprite2D.stop()
