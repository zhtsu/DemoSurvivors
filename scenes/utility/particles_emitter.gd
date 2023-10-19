extends Node2D



func _ready():
	$Timer.start($GPUParticles2D.lifetime)



func _on_timer_timeout():
	queue_free()
