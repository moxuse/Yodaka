module Graphics.Yodaka.Node.RGBNoisePlane where

import Prelude (bind)
import Effect
import Graphics.Three.GeometryAddition (createPlaneBufferGeometry)
import Graphics.Three.Material (createShader)
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Math.Vector as Vector

resolution = 512.0

initUniforms :: { resolution :: { "type" :: String, value :: Vector.Vector3 } }
initUniforms = {
  resolution : {
    "type" : "v3"
    , value : Vector.createVec3 resolution resolution 0.0 }
  }

vertexShader :: String
vertexShader = """
  void main() {
    gl_Position = modelMatrix * vec4(position, 1.0);
  }
"""

-- This shader from : https://nogson2.hatenablog.com/entry/2017/11/18/150645
fragmentalShader :: String
fragmentalShader = """
  uniform vec3 resolution;

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
    vec2 posX= vec2(st * 10.0);
    vec2 posY = vec2(st * 20.0);
    vec2 posZ = vec2(st * 30.0);
    color = vec3( noise(posX) * .85 + .15, noise(posY) * .85 + .15, noise(posZ) * .85 + .15 );
    gl_FragColor = vec4(color, 1.0);
  }
"""

rgbNoisePlane :: Effect Mesh
rgbNoisePlane = do
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : initUniforms
    , vertexShader : vertexShader
    , fragmentShader : fragmentalShader  }
  createMesh g m
