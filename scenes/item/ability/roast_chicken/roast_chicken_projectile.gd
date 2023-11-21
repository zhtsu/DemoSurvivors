extends Projectile


var reverse_rotation := false
var velocity : Vector2 = Vector2(2.0, 2.0)


func _ready():
	$AnimationPlayer.play("Rotate")
	

func _physics_process(delta):
	position += velocity
	


func _on_hit_box_body_entered(body):
	if body.is_in_group("camera_boundary"):
		velocity = velocity.bounce(velocity.normalized())
		
		reverse_rotation = not reverse_rotation
		if reverse_rotation:
			$AnimationPlayer.play_backwards("Rotate")
		else:
			$AnimationPlayer.play("Rotate")
