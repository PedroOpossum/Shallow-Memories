shader_type canvas_item;

uniform vec4 top_color : source_color = vec4(0.94, 0.89, 0.84, 1.0);
uniform vec4 bottom_color : source_color = vec4(0.78, 0.67, 0.56, 1.0);
uniform float edge_darkness = 0.45;

void fragment() {
    // vertical gradient (your original)
    float shade = smoothstep(0.0, 1.0, UV.y);
    vec3 col = mix(top_color.rgb, bottom_color.rgb, shade);

    // vignette (darken edges)
    vec2 center = UV - vec2(0.5);
    float dist = length(center) * 1.414;

    float vignette = smoothstep(0.2, 1.0, dist);

    col *= (1.0 - vignette * edge_darkness);

    COLOR = vec4(col, 1.0);
}