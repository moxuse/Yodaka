module Graphics.Yodaka.Node.NormalPlane where

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
    gl_Position = vec4(position, 1.0);
  }
"""

-- This shader from : https://nogson2.hatenablog.com/entry/2017/11/18/150645
fragmentalShader :: String
fragmentalShader = """

  uniform vec3 resolution;

  void main() {
    vec2 col = gl_FragCoord.xy / resolution.xy / 4.0;
    gl_FragColor = vec4(vec3(col, 1.0), 1.0);
  }
"""

normalPlane :: Effect Mesh
normalPlane = do
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : initUniforms
    , vertexShader : vertexShader
    , fragmentShader : fragmentalShader  }
  createMesh g m
