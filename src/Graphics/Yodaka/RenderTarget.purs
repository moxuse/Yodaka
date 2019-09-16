module Graphics.Yodaka.RenderTarget
( RendererTarget
, renderTarget
, getTexture
) where

import Prelude (Unit, bind, discard, pure)
import Effect (Effect)
import Graphics.Three.WebGLRenderTarget as W
import Graphics.Three.Object3D (class Renderable, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Texture (TargetTexture)
import Graphics.Three.Util (ffi, fpi)

newtype RendererTarget = RendererTarget
 { target :: W.WebGLRenderTarget, scene :: Scene.Scene }

textureSize :: Int
textureSize = 1024

postProcessTextureSize :: Int
postProcessTextureSize = 1280

addObject :: forall a. Renderable a => Scene.Scene -> a -> Effect Unit
addObject = fpi ["scene", "a", ""] "scene.add(a)"

renderTarget :: forall r. Renderable r => r -> Effect RendererTarget
renderTarget overlap = do
  s <- Scene.create
  t <- defaultRendererTarget
  addObject s overlap
  let target = createRenderTarget t s
  pure target

-- postProcessTarget :: forall r. Renderable r => r -> Effect RendererTarget
-- postProcessTarget overlap = do
--   s <- Scene.create
--   t <- defaultRendererTarget
--   addObject s overlap
--   let target = createRenderTarget t s
--   pure target

createRenderTarget :: W.WebGLRenderTarget -> Scene.Scene -> RendererTarget
createRenderTarget t s = RendererTarget { target : t, scene : s }

createWebRenderTarget ::
  forall opt. { | opt } -> Effect W.WebGLRenderTarget
createWebRenderTarget opt = do
  target <- W.createWeGLRenderer opt textureSize textureSize
  pure target

-- createPostProcessWebRenderTarget ::
--   forall opt. { | opt } -> Effect W.WebGLRenderTarget
--   createPostProcessWebRenderTarget opt = do
--   target <- W.createWeGLRenderer opt postProcessTextureSize postProcessTextureSize
--   pure target

defaultRendererTarget :: Effect W.WebGLRenderTarget
defaultRendererTarget = do
  W.createWeGLRenderer {} textureSize textureSize

getTexture :: RendererTarget -> Effect TargetTexture
getTexture (RendererTarget t) = do
  tex <- unsafeGetTexture t.target
  pure tex

unsafeGetTexture ::  W.WebGLRenderTarget -> Effect TargetTexture
unsafeGetTexture = ffi [ "target", "" ] "target.texture"
       