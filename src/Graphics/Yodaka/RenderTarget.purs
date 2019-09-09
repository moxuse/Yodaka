module Graphics.Yodaka.RenderTarget where

import Prelude (Unit, bind, discard, pure)
import Effect (Effect)
import Graphics.Three.WebGLRenderTarget as W
import Graphics.Three.Object3D (Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Texture (TargetTexture)
import Graphics.Three.Util (ffi)

newtype RendererTarget = RendererTarget
 { target :: W.WebGLRenderTarget, scene :: Scene.Scene }

textureSize = 512

renderTarget :: Mesh -> Effect RendererTarget
renderTarget overlap = do
  s <- Scene.create
  t <- defaultRendererTarget
  Scene.addObject s overlap
  let target = createRenderTarget t s
  pure target

createRenderTarget :: W.WebGLRenderTarget -> Scene.Scene -> RendererTarget
createRenderTarget t s = RendererTarget { target : t, scene : s }

createWebRenderTarget ::
  forall opt. { | opt } -> Effect W.WebGLRenderTarget
createWebRenderTarget opt = do
  target <- W.createWeGLRenderer opt textureSize textureSize
  pure target

defaultRendererTarget :: Effect W.WebGLRenderTarget
defaultRendererTarget = do
  W.createWeGLRenderer {} textureSize textureSize


getTexture :: RendererTarget -> Effect TargetTexture
getTexture (RendererTarget t) = do
  tex <- unsafeGetTexture t.target
  pure tex

unsafeGetTexture ::  W.WebGLRenderTarget -> Effect TargetTexture
unsafeGetTexture = ffi [ "target", "" ] "target.texture"
       