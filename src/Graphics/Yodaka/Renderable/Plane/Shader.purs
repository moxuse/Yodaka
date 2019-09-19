module Graphics.Yodaka.Renderable.Plane.Shader
( normalPlane
, noisePlane
, mapPlane
, rgbNoisePlane
, cGradPlane
, disp2DPlane
, kinderPlane
, cfdPlane
)  where

import Prelude (bind, discard)
import Effect
import Data.Symbol (SProxy(..))
import Graphics.Three.GeometryAddition (createPlaneBufferGeometry)
import Graphics.Three.Material (createShader)
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Texture (class Texture)
import Graphics.Three.Math.Vector as Vector
import Graphics.Yodaka.Renderable.Util (uniformInt, uniformVec3, uniformFloat, uniformSampler2D)
import Graphics.Yodaka.Renderable.Plane.Shader.Vert as VS
import  Graphics.Yodaka.Renderable.Plane.Shader.Frag as FS

resolution :: Number
resolution = 1024.0

normalPlane :: Effect Mesh
normalPlane = do
  let u = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) {}
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader
    { uniforms : u
    , vertexShader : VS.vertexShader
    , fragmentShader : FS.normalShader }
  createMesh g m

mapPlane :: forall t. Texture t => t -> Effect Mesh
mapPlane tex = do
  let u = {}
  let u1 = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) u
  let u2 = uniformSampler2D (SProxy :: SProxy "mapTexture") tex u1
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : u2
    , vertexShader : VS.vertexShader
    , fragmentShader : FS.mapShader }
  createMesh g m

noisePlane :: Effect Mesh
noisePlane = do
  let u = {}
  let u1 = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) u
  let u2 = uniformFloat (SProxy :: SProxy "density") 1.0 u1
  let u3 = uniformFloat (SProxy :: SProxy "time") 0.0 u2
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : u3
    , vertexShader : VS.vertexShader
    , fragmentShader : FS.noiseShader }
  createMesh g m

rgbNoisePlane :: Effect Mesh
rgbNoisePlane = do
  let u = {}
  let u1 = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) u
  let u2 = uniformFloat (SProxy :: SProxy "density") 1.0 u1
  let u3 = uniformFloat (SProxy :: SProxy "time") 0.0 u2
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader
    { uniforms : u3
    , vertexShader : VS.vertexShader
    , fragmentShader : FS.rgbNoiseShader }
  createMesh g m

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
    , vertexShader : VS.vertexShader
    , fragmentShader : FS.cGradShader }
  createMesh g m

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
    , vertexShader : VS.vertexShader
    , fragmentShader : FS.disp2DShader }
  createMesh g m
  
kinderPlane :: forall t. Texture t => t -> t -> Effect Mesh
kinderPlane base target = do
  let u = {}
  let u1 = uniformInt (SProxy :: SProxy "time") 4 u
  let u2 = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) u1
  let u3 = uniformSampler2D (SProxy :: SProxy "base") base u2
  let u4 = uniformSampler2D (SProxy :: SProxy "target") target u3
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : u4
    , vertexShader : VS.vertexShader
    , fragmentShader : FS.kinderShader }
  createMesh g m

cfdPlane :: forall t. Texture t => t -> t -> Effect Mesh
cfdPlane base target = do
  let u = {}
  let u1 = uniformInt (SProxy :: SProxy "rotNum") 4 u
  let u2 = uniformFloat (SProxy :: SProxy "angRnd") 0.05 u1
  let u3 = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) u2
  let u4 = uniformSampler2D (SProxy :: SProxy "base") base u3
  let u5 = uniformSampler2D (SProxy :: SProxy "target") target u4
  g <- createPlaneBufferGeometry 2.0 2.0 1 1
  m <- createShader 
    { uniforms : u5
    , vertexShader : VS.vertexShader
    , fragmentShader : FS.cfdShader }
  createMesh g m
