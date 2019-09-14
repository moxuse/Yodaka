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
  uniform float intensity;
  uniform vec3 resolution;  
  uniform sampler2D texture;

  uniform vec3 offsetColor;
  uniform vec3 ampColor;
  uniform vec3 freqColor;
  uniform vec3 phaseColor;
  uniform float freq;

  varying vec2 vUv;

  const float PI = 3.14159265;

  vec3 cosineGradient(vec3 a, vec3 b, vec3 c, vec3 d) {
    float twoPI = PI * 3.0 * freq;
    float er = a[0] + b[0] * cos(twoPI * (c[0] + d[0]));
    float eg = a[1] + b[1] * cos(twoPI * (c[1] + d[1]));
    float eb = a[2] + b[2] * cos(twoPI * (c[2] + d[2]));
    return vec3(eb * 0.2, er * 0.1, eg * 0.4);
  }

  void main() {    
    vec4 color target = (texture2D(texture, vUv);

    vec3 gradient = cosineGradient(offsetColor, ampColor, freqColor, phasesolor);

    gl_FragColor = texture2D(base, modUv);
  }
"""

cGradPlane :: forall t. Texture t => t -> t -> Effect Mesh
cGradPlane base target = do
  let u = {}
  let u1 = uniformVec3 (SProxy :: SProxy "amp") (Vector.createVec3 resolution resolution 0.0) u
  let u2 = uniformVec3 (SProxy :: SProxy "freq") (Vector.createVec3 resolution resolution 0.0) u1
  let u2 = uniformFloat(SProxy :: SProxy "phase") 0.125 u1
  let u3 = uniformSampler2D (SProxy :: SProxy "base") base u2
  
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : u3
    , vertexShader : vertexShader
    , fragmentShader : fragmentalShader  }
  createMesh g m
