extends CanvasLayer


const Assets = preload("res://scenes/global/assets.gd")
var player_state_anim_player : AnimationPlayer

func _ready():
	get_tree().paused = true
	player_state_anim_player = get_tree().get_first_node_in_group("player_state_anim_player")
	player_state_anim_player.play("ExpBarGradualColor")
	$AnimationPlayer.play("Enter")


func _play_button_down_sound():
	$SoundPlayer.stream = Assets.a_button_down
	$SoundPlayer.play()

	
func _play_button_hover_sound():
	$SoundPlayer.stream = Assets.a_button_hover
	$SoundPlayer.play()


func _on_reroll_button_button_down():
	_play_button_down_sound()


func _on_skip_button_button_down():
	_play_button_down_sound()
	player_state_anim_player.play("RESET")
	$AnimationPlayer.play_backwards("Enter")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	queue_free()


func _on_reroll_button_mouse_entered():
	_play_button_hover_sound()


func _on_skip_button_mouse_entered():
	_play_button_hover_sound()
