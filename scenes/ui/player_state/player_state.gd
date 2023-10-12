extends CanvasLayer


const Assets = preload("res://scenes/global/assets.gd")

var player : Player
var game_time_secs := 0

func init(in_player : Player):
	player = in_player
	$Main/Body/TalkButton.icon = player.icon
	player.connect("talk", _update_witticism)


func _ready():
	$Timer.start(1.0)
	


func _update_witticism(talk_content : String):
	$Main/Body/Witticism.text = talk_content


func _on_timer_timeout():
	game_time_secs += 1
	var mins = float(game_time_secs) / 60
	var secs = game_time_secs % 60
	$Main/Body/Time.text = "%02d : %02d " % [mins, secs]


func _on_talk_button_button_down():
	_play_button_down_sound()
	player.emit_signal("talk", player.get_rand_witticism())


func _on_pause_button_button_down():
	_play_button_down_sound()
	await $SoundPlayer2D.finished
	var pause_menu = Assets.tscn_pause_menu.instantiate()
	get_tree().get_first_node_in_group("main").add_child(pause_menu)
	
	
func _play_button_down_sound():
	$SoundPlayer2D.stream = Assets.a_button_down
	$SoundPlayer2D.play()
	
	
func _play_button_hover_sound():
	$SoundPlayer2D.stream = Assets.a_button_hover
	$SoundPlayer2D.play()
