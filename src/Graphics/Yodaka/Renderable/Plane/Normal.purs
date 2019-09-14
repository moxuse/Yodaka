module Graphics.Yodaka.Renderable.Plane.Normal
( normalPlane
)  where

import Prelude (bind, (>>>))
import Effect
import Record.Builder (build, insert)
import Data.Symbol (SProxy(..))
import Graphics.Three.GeometryAddition (createPlaneBufferGeometry)
import Graphics.Three.Material (createShader)
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Math.Vector as Vector
import Graphics.Yodaka.Renderable.Util (uniformVec3)

resolution = 1024.0

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
