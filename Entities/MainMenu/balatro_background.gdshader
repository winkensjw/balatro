shader_type canvas_item;

// =============================================================================
// balatro_background.gdshader
// =============================================================================
// This shader creates a visually appealing, dynamic background inspired by
// the game Balatro. It uses a combination of sine waves, trigonometric
// functions, and color manipulation to achieve a swirling, textured effect.
//
// Original shader code was taken directly from Balatro source code.
// Buy Balatro now: https://www.playbalatro.com
//
// @author [Your Name or Original Author]
// @version 1.0
// =============================================================================

// =============================================================================
// Uniforms
// These values can be adjusted in the Godot editor to modify the shader's
// appearance.
// =============================================================================

// Speed of the spin rotation.
uniform highp float spin_rotation_speed = 2.0;

// Speed of the movement/wave effect.
uniform highp float move_speed = 7.0;

// Offset for the UV coordinates.
uniform highp vec2 offset = vec2(0., 0.);

// Primary color of the effect.  Linked to a source color for ease of use.
uniform highp vec4 colour_1 : source_color = vec4(0.871, 0.267, 0.231, 1.0);

// Secondary color of the effect.  Linked to a source color for ease of use.
uniform highp vec4 colour_2 : source_color = vec4(0.0, 0.42, 0.706, 1.0);

// Tertiary color of the effect.  Linked to a source color for ease of use.
uniform highp vec4 colour_3 : source_color = vec4(0.086, 0.137, 0.145, 1.0);

// Contrast of the effect.  Higher values increase the difference between colors.
uniform highp float contrast = 3.5;

// Lighting level of the effect.
uniform highp float lighting = 0.4;

// Amount of spin applied.
uniform highp float spin_amount = 0.25;

// Pixelation filter value.  Lower values result in larger pixels.
uniform highp float pixel_filter = 740.;

// Whether the effect is rotating or not.
uniform bool is_rotating = false;

// Define constant for easing.
#define SPIN_EASE 1.0


// =============================================================================
// effect
// =============================================================================
// This function calculates the color for each pixel based on the defined uniforms
// and various mathematical operations.
//
// @param screenSize The size of the screen.
// @param screen_coords The screen coordinates of the current pixel.
// @return The calculated color for the current pixel.
// =============================================================================
vec4 effect(vec2 screenSize, vec2 screen_coords){

	// Calculate the size of each pixel.
	highp float pixel_size = length(screenSize.xy) / pixel_filter;

	// Calculate the UV coordinates.
    highp vec2 uv = (floor(screen_coords.xy*(1./pixel_size))*pixel_size - 0.5*screenSize.xy)/length(screenSize.xy) - offset;
    highp float uv_len = length(uv);

    // Calculate the speed of the effect.
    highp float speed = (spin_rotation_speed*SPIN_EASE*0.2);
	if(is_rotating){
		speed = TIME * speed;
	}
	speed += 302.2;

    // Calculate the new pixel angle.
    highp float new_pixel_angle = (atan(uv.y, uv.x)) + speed - SPIN_EASE*20.*(1.*spin_amount*uv_len + (1. - 1.*spin_amount));

    // Calculate the mid point.
    highp vec2 mid = (screenSize.xy/length(screenSize.xy))/2.;

    // Calculate the UV coordinates.
    uv = (vec2((uv_len * cos(new_pixel_angle) + mid.x), (uv_len * sin(new_pixel_angle) + mid.y)) - mid);

    // Multiply the UV coordinates.
    uv *= 30.;

    // Calculate the speed of the effect.
    speed = TIME*(move_speed);

    // Calculate the UV coordinates.
	highp vec2 uv2 = vec2(uv.x+uv.y);

    // Loop through the iterations.
	for(int i=0; i < 5; i++) {
		uv2 += sin(max(uv.x, uv.y)) + uv;
		uv  += 0.5*vec2(cos(5.1123314 + 0.353*uv2.y + speed*0.131121),sin(uv2.x - 0.113*speed));
		uv  -= 1.0*cos(uv.x + uv.y) - 1.0*sin(uv.x*0.711 - uv.y);
	}

    // Calculate the contrast modifier.
    highp float contrast_mod = (0.25*contrast + 0.5*spin_amount + 1.2);

    // Calculate the paint resolution.
	highp float paint_res = min(2., max(0.,length(uv)*(0.035)*contrast_mod));

    // Calculate the color components.
    highp float c1p = max(0.,1. - contrast_mod*abs(1.-paint_res));
    highp float c2p = max(0.,1. - contrast_mod*abs(paint_res));
    highp float c3p = 1. - min(1., c1p + c2p);

    // Calculate the lighting.
	highp float ligth = (lighting - 0.2) * max(c1p*5. - 4., 0.) + lighting * max(c2p*5. - 4., 0.);

    // Calculate the return color.
	highp vec4 ret_col = (0.3/contrast)*colour_1 + (1. - 0.3/contrast)*(colour_1*c1p + colour_2*c2p + vec4(c3p*colour_3.rgb, c3p*colour_1.a)) + ligth;

    // Return the color.
	return ret_col;
}

// =============================================================================
// fragment
// =============================================================================
// This is the main function of the fragment shader.  It's run for each pixel.
// =============================================================================
void fragment() {
    // Get the UV coordinates.
    vec2 uv = UV;

    // Set the color.
	COLOR *= effect(TEXTURE_PIXEL_SIZE, uv);
}