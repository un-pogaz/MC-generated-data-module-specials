#version 150

uniform sampler2D InSampler;

in vec2 texCoord;
in vec2 oneTexel;

uniform vec2 InSize;

uniform float Resolution;
uniform float MosaicSize;

out vec4 fragColor;

const float Saturation = 1.5;

void main() {
    vec2 mosaicInSize = InSize / MosaicSize;
    vec2 fractPix = fract(texCoord * mosaicInSize) / mosaicInSize;

    vec4 baseTexel = texture(InSampler, texCoord - fractPix);

    vec3 fractTexel = baseTexel.rgb - fract(baseTexel.rgb * Resolution) / Resolution;
    float luma = dot(fractTexel, vec3(0.3, 0.59, 0.11));
    vec3 chroma = (fractTexel - luma) * Saturation;
    baseTexel.rgb = luma + chroma;
    baseTexel.a = 1.0;

    fragColor = baseTexel;
}
