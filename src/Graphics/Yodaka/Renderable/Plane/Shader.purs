module Graphics.Yodaka.Renderable.Plane.Shader
( normalPlane
, noisePlane
, mapPlane
, grayTestPlane
, alphaMaskPlane
, twoTonePlane
, clampPlane
, rgbNoisePlane
, stripePlane
, cGradPlane
, disp2DPlane
, voronoiPlane
, makePlaneMesh
)  where

import Prelude (bind, discard, (*))
import Effect
import Data.Symbol (SProxy(..))
import Graphics.Three.GeometryAddition (createPlaneBufferGeometry)
import Graphics.Three.Material (createShader)
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Texture (class Texture)
import Graphics.Three.Math.Vector as Vector
import Graphics.Yodaka.Renderable.Util (uniformInt, uniformVec3, uniformFloat, uniformSampler2D)
import Graphics.Yodaka.Renderable.Plane.Shader.Vert as VS
import Graphics.Yodaka.Renderable.Plane.Shader.Frag as FS

resolution :: Number
resolution = 1024.0

planeSize :: Number
planeSize = 2.0

planeSegmentNum :: Int
planeSegmentNum = 1

makePlaneMesh frag u = do
  g <- createPlaneBufferGeometry planeSize planeSize planeSegmentNum planeSegmentNum
  m <- createShader
    { uniforms : u
    , vertexShader : VS.vertexShader
    , fragmentShader : frag }
  createMesh g m

resolutionUniform rec = uniformVec3 (SProxy :: SProxy "resolution") (Vector.createVec3 resolution resolution 0.0) rec

normalPlane :: Effect Mesh
normalPlane = do
  let u = resolutionUniform {}
  makePlaneMesh FS.normalShader u

mapPlane :: forall t. Texture t => t -> Effect Mesh
mapPlane tex = do
  let u = {}
  let u1 = resolutionUniform u
  let u2 = uniformSampler2D (SProxy :: SProxy "mapTexture") tex u1
  makePlaneMesh  FS.mapShader u2

grayTestPlane :: forall t. Texture t => t -> t -> Effect Mesh
grayTestPlane base target = do
  let u = {}
  let u1 = uniformFloat (SProxy :: SProxy "threshold") 0.5 u
  let u2 = uniformSampler2D (SProxy :: SProxy "base") base u1
  let u3 = uniformSampler2D (SProxy :: SProxy "target") target u2
  makePlaneMesh  FS.grayTestShader u3

alphaMaskPlane :: forall t. Texture t => t -> t -> Effect Mesh
alphaMaskPlane base target = do
  let u = {}
  let u1 = uniformSampler2D (SProxy :: SProxy "base") base u
  let u2 = uniformSampler2D (SProxy :: SProxy "target") target u1
  makePlaneMesh  FS.alphaMaskShader u2

twoTonePlane :: Effect Mesh
twoTonePlane = do
  let u = {}
  let u1 = uniformVec3 (SProxy :: SProxy "upColor") (Vector.createVec3 0.4 0.3 0.6) u
  let u2 = uniformVec3 (SProxy :: SProxy "bottomColor") (Vector.createVec3 0.0 1.0 0.8) u1
  makePlaneMesh  FS.twoToneShader u2

clampPlane ::  forall t. Texture t => t -> Effect Mesh
clampPlane input = do
  let u = uniformSampler2D (SProxy :: SProxy "input") input {}
  makePlaneMesh FS.clampShader u

noisePlane :: Effect Mesh
noisePlane = do
  let u = {}
  let u1 = resolutionUniform u
  let u2 = uniformFloat (SProxy :: SProxy "density") 1.0 u1
  let u3 = uniformFloat (SProxy :: SProxy "time") 0.0 u2
  makePlaneMesh FS.noiseShader u3

rgbNoisePlane :: Effect Mesh
rgbNoisePlane = do
  let u = {}
  let u1 = resolutionUniform u
  let u2 = uniformFloat (SProxy :: SProxy "density") 1.0 u1
  let u3 = uniformFloat (SProxy :: SProxy "time") 0.0 u2
  makePlaneMesh FS.rgbNoiseShader u3

stripePlane :: Effect Mesh
stripePlane = do
  let u = uniformFloat (SProxy :: SProxy "width") 8.0 {}
  makePlaneMesh FS.stripeShader u

cGradPlane :: forall t. Texture t => t -> Effect Mesh
cGradPlane base = do
  let u = {}
  let u1 = uniformSampler2D (SProxy :: SProxy "base") base u
  let u2 = uniformVec3 (SProxy :: SProxy "offsetColor") (Vector.createVec3 1.2 0.25 2.2) u1
  let u3 = uniformVec3 (SProxy :: SProxy "ampColor") (Vector.createVec3 0.8 0.25 1.1) u2
  let u4 = uniformVec3 (SProxy :: SProxy "freqColor") (Vector.createVec3 0.9 1.25 0.9) u3
  let u5 = uniformFloat(SProxy :: SProxy "phase") 0.0 u4
  makePlaneMesh FS.cGradShader u5

disp2DPlane :: forall t. Texture t => t -> t -> Effect Mesh
disp2DPlane base target = do
  let u = {}
  let u1 = resolutionUniform u
  let u2 = uniformFloat(SProxy :: SProxy "intensity") 0.125 u1
  let u3 = uniformSampler2D (SProxy :: SProxy "base") base u2
  let u4 = uniformSampler2D (SProxy :: SProxy "target") target u3
  makePlaneMesh FS.disp2DShader u4

voronoiPlane :: forall t. Texture t => t -> Effect Mesh
voronoiPlane base = do
  let u = {}
  let u1 = resolutionUniform u
  let u2 = uniformSampler2D (SProxy :: SProxy "base") base u1
  let u3 = uniformFloat(SProxy :: SProxy "scale") 5.0 u2
  let u4 = uniformFloat(SProxy :: SProxy "time") 0.0 u3
  makePlaneMesh FS.voronoiShader u4
