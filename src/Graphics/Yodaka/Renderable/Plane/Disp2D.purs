module Graphics.Yodaka.Renderable.Plane.Disp2D
( disp2DPlane
)  where

import Prelude (bind)
import Effect
import Data.Symbol (SProxy(..))
import Graphics.Three.GeometryAddition (createPlaneBufferGeometry)
import Graphics.Three.Material (createShader)
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Texture (class Texture)
import Graphics.Three.Math.Vector as Vector
import Graphics.Yodaka.Renderable.Util (uniformVec3, uniformFloat, uniformSampler2D)

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
  uniform float intensity;
  uniform vec3 resolution;  
  uniform sampler2D base;
  uniform sampler2D target;

  varying vec2 vUv;

  void main() {    
    float modX = sin(float(texture2D(target, vUv).r)) * sin(intensity * 0.00003) + 0.03;
    float modY = -cos(float(texture2D(target, vUv).g)) * sin(intensity * 0.00005) - 0.05;

    vec2 modUv = (vUv) + vec2(modX, modY);

    gl_FragColor = texture2D(base, modUv);
  }
"""

disp2DPlane :: forall t. Texture t => t -> t -> Effect Mesh
disp2DPlane base target = do
  let u = {}
  let u1 = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) u
  let u2 = uniformFloat(SProxy :: SProxy "intensity") 0.125 u1
  let u3 = uniformSampler2D (SProxy :: SProxy "base") base u2
  let u4 = uniformSampler2D (SProxy :: SProxy "target") target u3
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : u4
    , vertexShader : vertexShader
    , fragmentShader : fragmentalShader  }
  createMesh g m
