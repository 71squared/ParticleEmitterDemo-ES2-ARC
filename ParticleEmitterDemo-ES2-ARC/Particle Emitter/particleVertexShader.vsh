
/**** Attributes ****/
// The position of the vertex being processed
attribute          vec4         inPosition;
// The color of the vertex being processes
attribute          vec4         inColor;
// Texture coordinate
attribute          vec2         inTexCoord;

/**** Varying ****/
#ifdef GL_ES
// The color to be passed to the fragment shader
varying        lowp vec4        varInColor;
// Texture coordinate to the fragment shader
varying     mediump vec2        varTexCoord;
#else
// The color to be passed to the fragment shader
varying             vec4        varInColor;
// Texture coordinate to the fragment shader
varying             vec2        varTexCoord;
#endif

/**** Uniforms ****/
// The projection matrix
uniform             mat4        MPMatrix;

/**** Program ****/
void main() {
    
    // Pass on the vertex color
    varInColor = inColor;

    // Pass on the texture coordinate
    varTexCoord = inTexCoord;
    
    // Calculate the final position of the vertex using the projection matrix
    gl_Position = MPMatrix * inPosition;
    
}