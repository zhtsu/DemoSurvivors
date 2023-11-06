extends Node2D


@onready var parent = $".."

var pressed : bool = false
var max_length : float = 100
var deadzone : float = 5


func _ready():
	max_length *= parent.scale.x


func _process(delta):
	Input.action_release(parent.up_action)
	Input.action_release(parent.down_action)
	Input.action_release(parent.left_action)
	Input.action_release(parent.right_action)
	
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
		


func update_action():
	var angle = rad_to_deg(global_position.angle_to_point(parent.global_position))
	if angle < 0:
		angle = 360 - abs(angle) 
	if angle + 22.5 > 360:
		angle = angle + 22.5 - 360
	else:
		angle = angle + 22.5
		
	if angle > 0 and angle <= 45:
		Input.action_press(parent.left_action)
	if angle > 45 and angle <= 90:
		Input.action_press(parent.left_action)
		Input.action_press(parent.up_action)
	if angle > 90 and angle <= 135:
		Input.action_press(parent.up_action)
	if angle > 135 and angle <= 180:
		Input.action_press(parent.up_action)
		Input.action_press(parent.right_action)
	if angle > 180 and angle <= 225:
		Input.action_press(parent.right_action)
	if angle > 225 and angle <= 270:
		Input.action_press(parent.right_action)
		Input.action_press(parent.down_action)
	if angle > 270 and angle <= 315:
		Input.action_press(parent.down_action)
	if angle > 315 and angle <= 360:
		Input.action_press(parent.down_action)
		Input.action_press(parent.left_action)
		


func _on_touch_screen_button_pressed():
	pressed = true


func _on_touch_screen_button_released():
	pressed = false
