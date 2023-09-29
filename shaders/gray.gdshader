shader_type canvas_item;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment()
{
	// Weights
	float wr = 0.3;
	float wg = 0.59;
	float wb = 0.11;
	
	vec3 tex_color = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	vec3 col = vec3(tex_color.r * wr + tex_color.g * wg + tex_color.b * wb);
	
	COLOR = vec4(col, COLOR.a);
}
