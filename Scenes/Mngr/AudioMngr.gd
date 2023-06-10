extends Node


var Volume:float = 1.0


func Mute():
	$MainMenuBgm.stop()
	
	
func Sound():
	$MainMenuBgm.play()


func PlayMainMenuBgm():
	$MainMenuBgm.play()
	
	
func PlayButtonHover():
	$ButtonHover.play()
	
	
func PlayButtonDown():
	$ButtonDown.play()
