class_name OnceSound
extends AudioStreamPlayer


func init(in_stream : AudioStream, db : float = 0.0):
	stream = in_stream
	volume_db = db


func _ready():
	play()


func _on_finished():
	var MAIN = get_tree().get_first_node_in_group("main") as Main
	if MAIN.enemy_death_sound_array.has(self):
		MAIN.enemy_death_sound_array.erase(self)
	if MAIN.player_damage_sound_array.has(self):
		MAIN.player_damage_sound_array.erase(self)
	queue_free()
