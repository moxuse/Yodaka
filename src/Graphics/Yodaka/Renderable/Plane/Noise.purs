module Graphics.Yodaka.Renderable.Plane.Noise
( noisePlane
) where

import Prelude (bind, discard, pure)
import Effect
import Data.Symbol (SProxy(..))
import Graphics.Three.GeometryAddition (createPlaneBufferGeometry)
import Graphics.Three.Material (createShader)
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Math.Vector as Vector
import Graphics.Yodaka.Renderable.Util (uniformVec3, uniformFloat)

resolution = 1024.0

initUniforms = do
  let u = {}
  let u1 = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) u
  let u2 = uniformFloat (SProxy :: SProxy "density") 1.0 u1
  uniformFloat (SProxy :: SProxy "time") 0.0 u2

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
    vec2 pos = vec2(st * 32.0 * density + sin(time * 0.0008) * 4.0);
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

noisePlane :: Effect Mesh
noisePlane = do
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : initUniforms
    , vertexShader : vertexShader
    , fragmentShader : fragmentalShader  }
  createMesh g m
