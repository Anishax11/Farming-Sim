shader_type canvas_item;

// UI-friendly sliders & color picker
uniform float glow_strength : hint_range(0.0, 3.0) = 1.5;
uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 0.5, 1.0);

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    COLOR = tex + tex * glow_color * glow_strength;
}