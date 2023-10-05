extends Button


signal clicked(map_name : String)
signal hovered(map_name : String)

var map_name := "Grass"

enum EMapItemState
{
	Normal,
	Selected
}

var current_sate = EMapItemState.Normal

func init_map_item(in_text : String, in_color : Color):
	$Title.text = in_text
	$ColorRect.color = in_color


func _ready():
	hide_selected_mask()

	
func hide_selected_mask():
	$SelectedMask.hide()
	$Border.hide()
	$AnimationPlayer.stop()
	current_sate = EMapItemState.Normal
	

func show_seleted_mask():
	$SelectedMask.show()
	$Border.show()
	$AnimationPlayer.play("Blink")
	current_sate = EMapItemState.Selected


func _on_pressed():
	clicked.emit(map_name)
	show_seleted_mask()
	

func _on_mouse_entered():
	hovered.emit(map_name)
	$Border.show()
	

func _on_mouse_exited():
	if not current_sate == EMapItemState.Selected:
		$Border.hide()
