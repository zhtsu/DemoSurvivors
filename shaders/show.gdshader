shader_type canvas_item;
render_mode unshaded;

uniform vec3 color_1 : source_color = vec3(0.96, 0.57, 0.15);
uniform vec3 color_2 : source_color = vec3(1.0, 0.89, 0.41);
uniform int count : hint_range(1, 20) = 10;
uniform float speed : hint_range(1.0, 10.0) = 6.0;

void fragment()
{
	vec2 uv = UV - 0.5;
	float angle = atan(uv.x, uv.y);
	float value = smoothstep(-0.1, 0.1, sin(angle * float(count) + TIME * speed));
	
	vec3 col = mix(color_1, color_2, value);
	
	COLOR = vec4(col, COLOR.a);
}
