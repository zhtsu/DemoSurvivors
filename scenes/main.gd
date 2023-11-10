extends Node


func _ready():
	var main_menu = Assets.tscn_main_menu.instantiate()
	add_child(main_menu)
	# Make sure the function below called after modifying setting_dict 
	# Apply viewport effect
	$ViewportEffect.call("active_viewport_effect", Data.user_data_dict["Effect"])
	# Set default language from local user data
	Methods.translate(int(Data.user_data_dict["Language"]))
	
func get_music_player() -> AudioStreamPlayer:
	return $MusicPlayer


func set_bgm(bgm_name : String, db : float = 0, play : bool = true):
	var bgm_path = Assets.dir_music + bgm_name
	$MusicPlayer.stop()
	$MusicPlayer.stream = load(bgm_path)
	$MusicPlayer.volume_db = db
	if play:
		$MusicPlayer.play()
	
	
