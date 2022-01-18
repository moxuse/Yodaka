module Graphics.Yodaka.Renderable.Plane.Fluid.Shader
( advectPlane
, divergencePlane
, jacobiPlane
, subtractGradientPlane
) where

import Prelude (bind, discard, (/))
import Effect
import Data.Symbol (SProxy(..))
import Graphics.Three.GeometryAddition (createPlaneBufferGeometry)
import Graphics.Three.Material (createShader)
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Texture (class Texture)
import Graphics.Yodaka.Renderable.Util (uniformInt, uniformVec3, uniformFloat, uniformSampler2D)
import Graphics.Yodaka.Renderable.Plane.Shader.Vert as VS
import Graphics.Yodaka.Renderable.Plane.Shader.Frag as FS
import Graphics.Yodaka.Renderable.Plane.Fluid.Frag as FF
import Graphics.Yodaka.Renderable.Plane.Shader as S

deltaT :: Number
deltaT = 1.0 / 50.0

density :: Number
density = 0.125

epsilon :: Number
epsilon = 1.5

advectPlane :: forall t. Texture t => t -> t -> Effect Mesh
advectPlane input velocity = do
  let u = uniformFloat (SProxy :: SProxy "deltaT") deltaT {}
  let u1 = uniformSampler2D (SProxy :: SProxy "base") input u
  let u2 = uniformSampler2D (SProxy :: SProxy "velocity") velocity u1
  S.makePlaneMesh FF.advectShader u2

divergencePlane :: forall t. Texture t => t -> Effect Mesh
divergencePlane velocity = do
  let u = uniformFloat (SProxy :: SProxy "deltaT") deltaT {}
  let u1 = uniformFloat (SProxy :: SProxy "rho") density u
  let u2 = uniformFloat (SProxy :: SProxy "epsilon") epsilon u1
  let u3 = uniformSampler2D (SProxy :: SProxy "velocity") velocity u2
  S.makePlaneMesh FF.divergenceShader u3

jacobiPlane :: forall t. Texture t => t -> t -> Effect Mesh
jacobiPlane divergence pressure = do
  let u = uniformFloat (SProxy :: SProxy "epsilon") epsilon {}
  let u1 = uniformSampler2D (SProxy :: SProxy "divergence") divergence u
  let u2 = uniformSampler2D (SProxy :: SProxy "pressure") pressure u1
  S.makePlaneMesh FF.jacobiShader u2

subtractGradientPlane :: forall t. Texture t => t -> t -> Effect Mesh
subtractGradientPlane velocity pressure = do
  let u = uniformFloat (SProxy :: SProxy "deltaT") deltaT {}
  let u1 = uniformFloat (SProxy :: SProxy "rho") density u
  let u2 = uniformFloat (SProxy :: SProxy "epsilon") epsilon u1
  let u3 = uniformSampler2D (SProxy :: SProxy "velocity") velocity u2
  let u4 = uniformSampler2D (SProxy :: SProxy "pressure") pressure u3
  S.makePlaneMesh FF.subtractGradientShader u3
