shader_type canvas_item;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment()
{
	float uvy = 0.95 + 0.05 * cos(3.14 * (UV.y + 0.008 * TIME) * 240.0 * 1.0);
	float scanline = clamp(uvy, 0.0, 1.0);
	float uvx = 1.5 * cos(3.14 * UV.x * 640.0 * 1.0);
    float grille = 0.85 + 0.15 * clamp(uvx, 0.0, 1.0);
	
	vec3 col = texture(SCREEN_TEXTURE, SCREEN_UV).rgb * scanline * grille;
	
	vec2 uv = (UV - 0.5);
	float vignetting = clamp(pow(cos(uv.x * PI), 1.2) * pow(cos(uv.y * PI), 1.2) * 50.0, 0.0, 1.0);
	col *= vignetting;
	
    COLOR = vec4(col, COLOR.a);
}
