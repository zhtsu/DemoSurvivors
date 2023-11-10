extends CanvasLayer


const ViewportEffectType = Enums.EViewportEffect


func active_viewport_effect(viewport_effect_type : int):
	self.show()
	viewport_effect_type = viewport_effect_type as ViewportEffectType
	if viewport_effect_type == ViewportEffectType.Normal:
		self.hide()
	elif viewport_effect_type == ViewportEffectType.CRT:
		$Texture.material = Assets.tres_sm_effect_crt
	elif viewport_effect_type == ViewportEffectType.Gray:
		$Texture.material = Assets.tres_sm_effect_gray
	
