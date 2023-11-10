class_name ParticlesEmitter
extends Node2D



func _ready():
	$Timer.start($GPUParticles2D.lifetime)



func _on_timer_timeout():
	if Data.particles_emitter_array.has(self):
		Data.particles_emitter_array.erase(self)
	queue_free()
