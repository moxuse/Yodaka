module Graphics.Yodaka.Renderable.Plane.CosGradient
( cGradPlane
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
resolution = 1024.0

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

cGradPlane :: forall t. Texture t => t -> Effect Mesh
cGradPlane base = do
  let u = {}
  let u1 = uniformSampler2D (SProxy :: SProxy "base") base u
  let u2 = uniformVec3 (SProxy :: SProxy "offsetColor") (Vector.createVec3 1.2 0.25 2.2) u1
  let u3 = uniformVec3 (SProxy :: SProxy "ampColor") (Vector.createVec3 0.8 0.25 1.1) u2
  let u4 = uniformVec3 (SProxy :: SProxy "freqColor") (Vector.createVec3 0.9 1.25 0.9) u3
  let u5 = uniformFloat(SProxy :: SProxy "phase") 0.25 u4
  
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : u5
    , vertexShader : vertexShader
    , fragmentShader : fragmentalShader  }
  createMesh g m
