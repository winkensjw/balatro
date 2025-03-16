shader_type canvas_item;

// =============================================================================
// crt_filter.gdshader
// =============================================================================
// This shader simulates a CRT (Cathode Ray Tube) display effect, adding scanlines,
// warping, vignette, grille, and brightness boost to the rendered output.
// It is designed to be applied to a viewport or texture to give it a retro look.
//
// @author pxlforge
// @version 1.0
// =============================================================================

// =============================================================================
// Uniforms
// These values can be adjusted in the Godot editor to modify the shader's
// appearance.
// =============================================================================

// The texture of the screen to apply the CRT effect to.  Automatically provided
// when applied to a Sprite using SCREEN_TEXTURE.
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

// The resolution of the screen that the shader is applied to.  Used to
// calculate scanline and grille effects.
uniform vec2 resolution = vec2(320.0, 180.0);

// Amount of scanlines to apply to the screen.  Higher values result in
// more visible scanlines.  (Range: 0.0 to 1.0)
uniform float scan_line_amount : hint_range(0.0, 1.0) = 0.5;

// Amount of warp (curvature) to apply to the screen. Higher values warp the
// image more. (Range: 0.0 to 1.0)
uniform float warp_amount : hint_range(0.0, 1.0) = 0.05;

// Amount of vignette (darkening of the edges) to apply to the screen.
// Higher values result in more vignetting. (Range: 0.0 to 1.0)
uniform float vignette_amount : hint_range(0.0, 1.0) = 0.5;

// Intensity of the vignette effect.  Adjusts how quickly the vignette effect
// darkens the edges. (Range: 0.0 to 1.0)
uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.3;

// Amount of grille (shadow mask) effect to apply to the screen. Higher values
// result in a more pronounced grille effect. (Range: 0.0 to 1.0)
uniform float grille_amount : hint_range(0.0, 1.0) = 0.05;

// Amount to boost the overall brightness of the screen.  Values greater than
// 1.0 will make the image brighter. (Range: 1.0 to 2.0)
uniform float brightness_boost : hint_range(1.0, 2.0) = 1.2;


// =============================================================================
// fragment
// =============================================================================
// This is the main function of the fragment shader. It's run for each pixel.
// =============================================================================
void fragment() {
    // Get the UV coordinates (normalized position of the pixel).
    vec2 uv = SCREEN_UV;

    // Calculate warp factor based on the distance from the center.
    vec2 delta = uv - 0.5;
    float warp_factor = dot(delta, delta) * warp_amount;
    uv += delta * warp_factor; // Apply the warp effect

    // Calculate scanline effect.  Uses a sine wave to create alternating light and
    // dark lines.  Reduced the impact by multiplying with scan_line_amount * 0.5
    // to give users more control.
    float scanline = sin(uv.y * resolution.y * PI) * 0.5 + 0.5;
    scanline = mix(1.0, scanline, scan_line_amount * 0.5);

    // Calculate grille effect. Simulates the shadow mask of a CRT by alternating
    // brightness based on the x position. Reduced the impact by multiplying with
    // grille_amount * 0.5 to give users more control.
    float grille = mod(uv.x * resolution.x, 3.0) < 1.5 ? 0.95 : 1.05;
    grille = mix(1.0, grille, grille_amount * 0.5);

    // Sample the screen texture and apply scanline and grille effects.
    vec3 color = texture(SCREEN_TEXTURE, uv).rgb * scanline * grille;

    // Calculate vignette effect.  Darkens the edges of the screen.
    vec2 v_uv = uv * (1.0 - uv.xy);
    float vignette = v_uv.x * v_uv.y * 15.0;
    vignette = mix(1.0, vignette, vignette_amount * 0.7);

    // Apply vignette and brightness boost.
    color *= vignette * brightness_boost;

    // Set the final color of the pixel.
    COLOR.rgb = color;
    COLOR.a = 1.0; // Ensure alpha is fully opaque.
}