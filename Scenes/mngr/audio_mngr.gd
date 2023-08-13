extends Node


var volume:float = 1.0


func mute():
	$MainMenuBgm.stop()
	
	
func loud():
	$MainMenuBgm.play()


func play_main_menu_bgm():
	$MainMenuBgm.play()
	
	
func play_button_hover():
	$ButtonHover.play()
	
	
func play_button_down():
	$ButtonDown.play()
