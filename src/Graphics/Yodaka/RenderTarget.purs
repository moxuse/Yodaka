module Graphics.Yodaka.RenderTarget where

import Prelude
import Effect (Effect)
import Graphics.Three.WebGLRenderTarget as W
import Graphics.Three.Camera as Camera
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Scene as Scene
import Graphics.Three.Geometry

newtype RendererTarget = RendererTarget
 { target :: W.WebGLRenderTarget, scene :: Scene.Scene }

createRenderTarget :: Effect RendererTarget
createRenderTarget = do
  s <- Scene.create
  t <- defaultRendererTarget
  pure $ RendererTarget { target : t, scene : s }
  

createRendererTarget' ::
  forall opt. {|opt} ->
  Effect W.WebGLRenderTarget
createRendererTarget' opt = do
  target <- W.createWeGLRenderer opt
  pure target

defaultRendererTarget :: Effect W.WebGLRenderTarget
defaultRendererTarget = do
  c <- W.clampToEdgeWrapping
  n <- W.nearestFilter
  W.createWeGLRenderer {
    depthBuffer: false :: Boolean,
    stencilBuffer: false :: Boolean,
    magFilter: c :: W.ClampToEdgeWrapping,
    minFilter: c :: W.ClampToEdgeWrapping,
    wrapS: n :: W.NearestFilter,
    wrapT: n :: W.NearestFilter}
