shader_type canvas_item;

uniform sampler2D screen_texture:hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D noise_texture:repeat_enable;
uniform float intensity;

void fragment() {
	vec3 noise_color = texture(noise_texture, SCREEN_UV + (TIME / 5.0)).rgb;
	vec3 color = texture(screen_texture, SCREEN_UV + (noise_color.b / intensity)).rgb; 
	COLOR.rgb = color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
