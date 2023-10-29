class_name OnceSound
extends AudioStreamPlayer


func init(in_stream : AudioStream, db : float = 0.0):
	stream = in_stream
	volume_db = db


func _ready():
	play()


func _on_finished():
	var MAIN = get_tree().get_first_node_in_group("main") as Main
	if MAIN.enemy_death_sound_pool.has(self):
		MAIN.enemy_death_sound_pool.erase(self)
	queue_free()
