module Graphics.Yodaka.Renderable.Plane.Map
( mapPlane
)  where

import Prelude (bind)
import Effect
import Data.Symbol (SProxy(..))
import Graphics.Three.GeometryAddition (createPlaneBufferGeometry)
import Graphics.Three.Material (createShader)
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Texture (class Texture)
import Graphics.Three.Math.Vector as Vector
import Graphics.Yodaka.Renderable.Util (uniformVec3, uniformSampler2D)

resolution :: Number
resolution = 512.0

vertexShader :: String
vertexShader = """
  varying vec2 vUv;
  void main() {
    vUv = uv;
    gl_Position = modelMatrix * vec4(position, 1.0);
  }
"""

fragmentalShader :: String
fragmentalShader = """
  uniform vec3 resolution;
  varying vec2 vUv;
  uniform sampler2D mapTexture;

  void main() {
    gl_FragColor = texture2D(mapTexture , vUv);
  }
"""

mapPlane :: forall t. Texture t => t -> Effect Mesh
mapPlane tex = do
  let u = {}
  let u1 = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) u
  let u2 = uniformSampler2D (SProxy :: SProxy "mapTexture") tex u1
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : u2
    , vertexShader : vertexShader
    , fragmentShader : fragmentalShader  }
  createMesh g m
