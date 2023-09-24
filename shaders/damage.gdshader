shader_type canvas_item;
render_mode unshaded;

uniform vec3 color : source_color = vec3(1.0);
uniform bool active = false;

void fragment() {
	if (active && COLOR.a != 0.0)
	{
		COLOR = vec4(color, 1.0);
	}
}
