extends TextureButton


func _in_triangle(p : Vector2, a : Vector2, b : Vector2, c : Vector2) -> bool:
	var v0 : Vector2 = c - a
	var v1 : Vector2 = b - a
	var v2 : Vector2 = p - a
	
	var dot00 : float = v0.dot(v0) ;
	var dot01 : float = v0.dot(v1) ;
	var dot02 : float = v0.dot(v2) ;
	var dot11 : float = v1.dot(v1) ;
	var dot12 : float = v1.dot(v2) ;

	var inverDeno : float = 1 / (dot00 * dot11 - dot01 * dot01)

	var u : float = (dot11 * dot02 - dot01 * dot12) * inverDeno
	if u < 0.0 or u > 1.0:
		return false

	var v : float = (dot00 * dot12 - dot01 * dot02) * inverDeno
	if v < 0.0 or v > 1.0:
		return false

	return u + v <= 1.0;


func _gui_input(event):
	var p : Vector2 = get_local_mouse_position()
	var a : Vector2 = Vector2(0.0, 0.0)
	var b : Vector2 = Vector2(80.0, 0.0)
	var c : Vector2 = Vector2(80.0, 80.0)
	if not _in_triangle(p, a, b, c):
		self.disabled = true
	else:
		self.disabled = false


func _on_button_down():
	OS.shell_open("https://github.com/zhtsu/DemoSurvivors")
