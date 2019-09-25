module Graphics.Yodaka.Renderable.Plane.Shader.Frag
( normalShader 
, mapShader
-- , twoToneShader
, clampShader
, noiseShader
, rgbNoiseShader
, cGradShader
, disp2DShader
, kinderShader
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

-- twoToneShader :: String
-- twoToneShader = """
--   varying vec2 vUv;
--   uniform vec3 upColor;
--   uniform vec3 bottomColor;

--   void main() {
--     vec3 col = upColor.xyz;
--     if (vUv.y < 0.5) {
--       col = bottomColor.xyz;
--     }
--     gl_FragColor = vec4(col , 1.0);
    
--   }
-- """

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
    if (st.x > 0.9875) {
      color = (1.0 - st.x) * 80.0 * color;
    }
    if (st.x < 0.0125) {
      color = st.x * 80.0 * color;
    }
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

kinderShader :: String
kinderShader = """
  varying vec2 vUv;
  uniform float time;
  uniform vec3 resolution;
  
  uniform sampler2D base;
  uniform sampler2D target;

  vec2 hash2( float n ) { return fract(sin(vec2(n,n+1.0))*vec2(43758.5453123,22578.1459123)); }

  vec4 ssamp( vec2 uv, float oct )
  {
      return texture( base, uv/oct );
  }

  vec2 e = vec2(1./2.4, 0.);
  vec4 dx( vec2 uv, float oct ) { return (ssamp(uv+e.xy,oct) - ssamp(uv-e.xy,oct)) / (2.*e.x); }
  vec4 dy( vec2 uv, float oct ) { return (ssamp(uv+e.yx,oct) - ssamp(uv-e.yx,oct)) / (2.*e.x); }


  void main()
  {
    vec2 uv = vUv.xy;
    vec4 res = vec4(0.);
    
    // lookup offset
    vec2 off = 0.05* (vec2(4.0) / resolution.xy) * sin(time * 0.001);
    
    float oct = 4.0;
    vec2 curl1 = .1*vec2( dy(uv,oct).x, -dx(uv,oct).x )*oct;
    oct = 64.; float sp = 2.3;
    curl1 += .5*vec2( dy(uv + sp * sin(time * 0.0001), oct).x, -dx(uv + sp * cos(time * 0.0001), oct).x ) * oct;
    
    off += curl1;
    off *= .25;
    
    //off *= .4 + (length(texture(texture, uv).xyz));
    
    res += .999 * texture2D( target, uv - off );
    
    gl_FragColor = res;
  }
"""
