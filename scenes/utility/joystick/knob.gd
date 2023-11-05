extends Node2D


@onready var parent = $".."

var pressed : bool = false
var max_length : float = 100
var deadzone : float = 5
var velocity : Vector2 = Vector2.ZERO


func _ready():
	max_length *= parent.scale.x


func _process(delta):
	if pressed:
		var mouse_position = get_global_mouse_position()
		if mouse_position.distance_to(parent.global_position) <= max_length:
			global_position = mouse_position
		else:
			var angle = parent.global_position.angle_to_point(mouse_position)
			global_position.x = parent.global_position.x + cos(angle) * max_length
			global_position.y = parent.global_position.y + sin(angle) * max_length
		update_action()
	else:
		global_position = lerp(global_position, parent.global_position, delta * 10)
		velocity = Vector2(0.0, 0.0)
		


func update_action():
	var angle = rad_to_deg(global_position.angle_to_point(parent.global_position))
	print_debug(angle)
	if angle == 0:
		velocity = Vector2.ZERO
		return
		
	if angle > 90 and angle <= 180 or angle > -90 and angle <= 0:
		Input.action_press(parent.down_action)
	else:
		Input.action_press(parent.up_action)
		
	if angle > -180 and angle <= 0:
		Input.action_press(parent.down_action)
	else:
		Input.action_press(parent.up_action)


func _on_touch_screen_button_pressed():
	pressed = true


func _on_touch_screen_button_released():
	pressed = false
