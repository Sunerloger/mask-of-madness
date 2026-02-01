shader_type canvas_item;
uniform float strength = 0.0;
uniform vec4 color : source_color = vec4(1.0);

void fragment() {
	vec4 orig_color = texture(TEXTURE,UV);
	COLOR.a = orig_color.a;
	COLOR.rgb = mix(orig_color.rgb,color.rgb,strength);
}
