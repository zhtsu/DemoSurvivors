extends CanvasLayer


const Enums = preload("res://scenes/mngr/enums.gd")
const ViewportEffectType = Enums.EViewportEffect
#
const tres_sm_effect_crt = preload("res://tress/sm_effect_crt.tres")
const tres_sm_effect_gray = preload("res://tress/sm_effect_gray.tres")


func active_viewport_effect(viewport_effect_type : int):
	self.show()
	viewport_effect_type = viewport_effect_type as ViewportEffectType
	if viewport_effect_type == ViewportEffectType.Normal:
		self.hide()
	elif viewport_effect_type == ViewportEffectType.CRT:
		$Texture.material = tres_sm_effect_crt
	elif viewport_effect_type == ViewportEffectType.Gray:
		$Texture.material = tres_sm_effect_gray
	
