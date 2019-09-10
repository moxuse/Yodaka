module Graphics.Yodaka.Node.NoisePlane
( noisePlane
) where

import Prelude (bind)
import Effect
import Data.Symbol (SProxy(..))
import Graphics.Three.GeometryAddition (createPlaneBufferGeometry)
import Graphics.Three.Material (createShader)
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Math.Vector as Vector
import Graphics.Yodaka.Shader (uniformVec3)

resolution = 512.0

initUniforms = uniformVec3 
  (SProxy :: SProxy "resolution")
  (Vector.createVec3 resolution resolution 0.0)
  {}

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
    vec2 pos = vec2(st * 30.0);
    color = vec3( noise(pos) * .5 + .5 );
    gl_FragColor = vec4(color, 1.0);
  }
"""

noisePlane :: Effect Mesh
noisePlane = do
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : initUniforms
    , vertexShader : vertexShader
    , fragmentShader : fragmentalShader  }
  createMesh g m
