class_name OnceSound
extends AudioStreamPlayer


func init(in_stream : AudioStream, db : float = 0.0):
	stream = in_stream
	volume_db = db


func _ready():
	play()


func _on_finished():
	if Data.enemy_death_sound_array.has(self):
		Data.enemy_death_sound_array.erase(self)
	if Data.player_damage_sound_array.has(self):
		Data.player_damage_sound_array.erase(self)
	queue_free()
