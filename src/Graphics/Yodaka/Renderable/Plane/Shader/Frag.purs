module Graphics.Yodaka.Renderable.Plane.Shader.Frag
( normalShader 
, mapShader
, noiseShader
, rgbNoiseShader
, cGradShader
, disp2DShader
, kinderShader
, cfdShader
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
    float modX = sin(float(texture2D(target, vUv).r)) * sin(intensity * 0.00003);
    float modY = -cos(float(texture2D(target, vUv).g)) * sin(intensity * 0.00005);

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

cfdShader :: String
cfdShader = """
  // created by florian berger (flockaroo) - 2016
  // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

  // single pass CFD
  // ---------------
  // this is some "computational flockarooid dynamics" ;)
  // the self-advection is done purely rotational on all scales. 
  // therefore i dont need any divergence-free velocity field. 
  // with stochastic sampling i get the proper "mean values" of rotations 
  // over time for higher order scales.
  //
  // try changing "RotNum" for different accuracies of rotation calculation
  //
  // "angRnd" is the rotational randomness of the rotation-samples
  // "posRnd" is an additional error to the position of the samples (not really needed)
  // for higher numbers of "RotNum" "angRnd" can also be set to 0
  
  varying vec2 vUv;
  uniform int rotNum; // = 3
  uniform float angRnd; // = 1.0

  uniform vec3 resolution;
  
  uniform sampler2D base;
  uniform sampler2D target;

  const float posRnd = 0.0;
  
  float ang() { return 0.00025 * 3.1415926535 / float(rotNum); }
  mat2 m() { 
    float ang_ = ang();
    return mat2(cos(ang_), sin(ang_), -sin(ang_), cos(ang_)); 
  }

  float hash(float seed) {
    return fract(sin(seed) * 8934.5453 ); 
  }

  vec4 getRand4(float seed) {
    return vec4(hash(seed), hash(seed + 123.21), hash(seed + 234.32), hash(seed + 453.54)); 
  }
  
  vec4 randS(vec2 uv) {
      // return getRand4(uv.y + uv.x * 0.12567) - vec4(0.95);
      return texture2D(target, uv) - vec4(0.5);
  }

  float getRot(vec2 uv, float sc) {
      float ang2 = angRnd * randS(uv).x * ang();
      vec2 p = vec2(cos(ang2), sin(ang2));
      float rot = 0.0;
      for(int i = 0; i < rotNum; i++)
      {
          vec2 p2 = (p + posRnd * randS(uv + p*sc).xy) * sc;
          vec2 v = texture2D(base, fract(uv + p2)).xy - vec2(0.005);
          rot += cross(vec3(v, 0.0), vec3(p2, 0.0)).z / dot(p2, p2);
          p = m() * p;
      }
      rot /= float(rotNum);
      return rot;
  }

  void main() {
      vec2 uv = vUv.xy;
      vec2 scr = uv * 0.05 - vec2(1.0);
      
      float sc = 1.0 / 1.5;
      vec2 v = vec2(0);
      for (int level = 0;level < 20; level++)
      {
          if ( sc > 0.97 ) break;
          float ang2 = angRnd * ang() * randS(uv).y;
          vec2 p = vec2(cos(ang2), sin(ang2));
          for(int i = 0; i < rotNum; i++)
          {
              vec2 p2 = p * sc;
              float rot = getRot(uv + p2, sc);
              //v+=cross(vec3(0,0,rot),vec3(p2,0.0)).xy;
              v += p2.yx * rot * vec2(-1, 1); //maybe faster than above
              p = m() * p;
          }
          sc *= 1.25;
      }
      gl_FragColor = texture2D(base, fract(uv + v * 3.0));
      gl_FragColor.xy += (0.01 * scr.xy / (dot(scr, scr) / 0.1 + 0.3)); 
  }
"""