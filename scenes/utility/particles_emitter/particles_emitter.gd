class_name ParticlesEmitter
extends Node2D



func _ready():
	$Timer.start($GPUParticles2D.lifetime)



func _on_timer_timeout():
	var MAIN = get_tree().get_first_node_in_group("main") as Main
	if MAIN.particles_emitter_array.has(self):
		MAIN.particles_emitter_array.erase(self)
	queue_free()
