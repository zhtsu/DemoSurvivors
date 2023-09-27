shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform vec3 color : source_color = vec3(1.0);

void fragment() {
	float alpha = 1.0;
	
	if (UV.y < 0.5 && UV.x > progress)
	{
		alpha = 0.0;
	}
	
	if (UV.y > 0.5 && 1.0 - UV.x > progress)
	{
		alpha = 0.0;
	}
	
	COLOR = vec4(color, alpha);
}
