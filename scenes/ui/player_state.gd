extends CanvasLayer


var player : Player

func init(in_player : Player):
	player = in_player
	player.connect("talk", _update_witticism)



func _update_witticism(talk_content : String):
	$Main/Body/Witticism.text = talk_content
