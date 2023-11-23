class_name EffectCamera
extends Camera2D


signal close_to_map_edge


const normal_zoom = Vector2(2.8, 2.8)


	
func play_camera_effect(camera_effect_type : Enums.ECameraEffect):
	var anim_name = Enums.ECameraEffect.get(camera_effect_type)
	$AnimationPlayer.play(anim_name)
	
