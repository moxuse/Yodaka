module Graphics.Yodaka.Renderable.Plane.Shader.Frag
( normalShader 
, mapShader
, twoToneShader
, clampShader
, noiseShader
, rgbNoiseShader
, stripeShader
, cGradShader
, disp2DShader
) where

import Data.String

normalShader :: String
normalShader = """
  uniform vec3 resolution;

  void main() {
    vec2 col = gl_FragCoord.xy / resolution.xy;
    gl_FragColor = vec4(vec3(col, 1.0), 1.0);
  }
"""

mapShader :: String
mapShader = """
  uniform vec3 resolution;
  varying vec2 vUv;
  uniform sampler2D mapTexture;

  void main() {
    gl_FragColor = texture2D(mapTexture , vUv);
  }
"""

twoToneShader :: String
twoToneShader = """
  varying vec2 vUv;
  uniform vec3 upColor;
  uniform vec3 bottomColor;

  void main() {
    vec3 col = upColor.xyz;
    if (vUv.y < 0.45) {
      col = bottomColor.xyz;
    }
    gl_FragColor = vec4(col , 1.0);
    
  }
"""

clampShader :: String
clampShader = """
  varying vec2 vUv;
  uniform sampler2D input;
  void main() {
    gl_FragColor = clamp(texture2D(input, vUv), 0.0, 1.0);
  }
"""

noiseShader :: String
noiseShader = """
  uniform vec3 resolution;
  uniform float density;
  uniform float time;

  vec2 random(vec2 st) {
    st = vec2( dot(st, vec2(127.1, 311.7)),
              dot(st, vec2(269.5, 183.3)) );
              
    return 2.0 * fract(sin(st) * 43758.5453123) - 1.0;
  }


  float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix( mix( dot( random(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ), 
                      dot( random(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ), 
                      dot( random(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
  }

  void main() {
    vec2 st = gl_FragCoord.xy / resolution.xy;
    vec3 color = vec3(0.0);
    vec2 pos = vec2(st * 20.0 * density + sin(time * 0.0008) * 4.0);
    color = vec3( noise(pos) * .5 + .5 );
    gl_FragColor = vec4(color, 1.0);
  }
"""

rgbNoiseShader :: String
rgbNoiseShader = """
  uniform vec3 resolution;
  uniform float density;
  uniform float time;

  vec2 random(vec2 st) {
    st = vec2( dot(st, vec2(127.1, 311.7)),
              dot(st, vec2(269.5, 183.3)) );
              
    return 2.0 * fract(sin(st) * 43758.5453123) - 1.0;
  }


  float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix( mix( dot( random(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ), 
                      dot( random(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ), 
                      dot( random(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
  }

  void main() {
    vec2 st = gl_FragCoord.xy / resolution.xy;
    vec3 color = vec3(0.0);
    vec2 posX = vec2(st * 18.0 * density) + sin(time * 0.0008) * 4.0;
    vec2 posY = vec2(st * 8.0 * density) + sin(time * 0.0008) * 4.0;
    vec2 posZ = vec2(st * 12.0 * density) + sin(time * 0.0008) * 4.0;
    color = vec3( noise(posX) + .333, noise(posY) + .333, noise(posZ) + .333 );
    gl_FragColor = vec4(color, 1.0);
  }
"""

stripeShader :: String 
stripeShader = """
  uniform float width;
  varying vec2 vUv;

  float pi = 3.1415;

  void main () {
    
    gl_FragColor = vec4( vec3( step(0.0, cos( (vUv.x + vUv.y) * width * pi ) )) , 1.0 );
  }
"""

cGradShader :: String
cGradShader = """
  uniform sampler2D base;

  uniform vec3 offsetColor;
  uniform vec3 ampColor;
  uniform vec3 freqColor;
  // uniform vec3 phaseColor;
  uniform float phase;

  varying vec2 vUv;

  const float PI = 3.14159265;

  vec3 cosineGradient(vec3 a, vec3 b, vec3 c, vec3 d) {
    float rotPhase = sin(phase * 0.001) * 1.0;
    float twoPI = PI * 3.0;
    float er = a[0] + b[0] * cos(twoPI * (c[0] * rotPhase + d[0])) + rotPhase;
    float eg = a[1] + b[1] * cos(twoPI * (c[1] * rotPhase + d[1])) + rotPhase;
    float eb = a[2] + b[2] * cos(twoPI * (c[2] * rotPhase + d[2])) + rotPhase;
    return vec3(eb * 0.2, er * 0.1, eg * 0.4);
  }

  void main() {    
    vec3 phaseColor = texture2D(base, vUv).rgb;
    vec3 gradient = cosineGradient(offsetColor, ampColor, freqColor, phaseColor);

    gl_FragColor = vec4(gradient, 1.0);
  }
"""

disp2DShader :: String
disp2DShader = """
  uniform float intensity;
  uniform vec3 resolution;  
  uniform sampler2D base;
  uniform sampler2D target;

  varying vec2 vUv;

  void main() {    
    float modX = sin(float(texture2D(target, vUv).r)) * intensity;
    float modY = -cos(float(texture2D(target, vUv).g)) * intensity;

    vec2 modUv = (vUv) + vec2(modX, modY);

    gl_FragColor = texture2D(base, modUv);
  }
"""
