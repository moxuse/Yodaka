module Graphics.Yodaka.RenderTarget
( RendererTarget
, getScene
, renderTarget
, bufferTarget
, getId
, getTarget
, getTexture
, setSkip
, createHash
) where

import Prelude (Unit, unit, bind, discard, pure)
import Effect (Effect)
import Data.Newtype (unwrap)
import Graphics.Three.WebGLRenderTarget as W
import Graphics.Three.Object3D (class Renderable, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Texture (TargetTexture)
import Graphics.Three.Util (ffi, fpi)

newtype RendererTarget = RendererTarget
 { id :: String, target :: W.WebGLRenderTarget, scene :: Scene.Scene, skip :: Boolean }

getScene (RendererTarget target) = target.scene

textureSize :: Int
textureSize = 1024

addObject :: forall a. Renderable a => Scene.Scene -> a -> Effect Unit
addObject = fpi ["scene", "a", ""] "scene.add(a)"

renderTarget :: forall r. Renderable r => r -> Effect RendererTarget
renderTarget overlap = do
  s <- Scene.create
  t <- defaultRendererTarget
  addObject s overlap
  id <- createHash
  let target = createRenderTarget id t s
  pure target

bufferTarget :: Scene.Scene -> Effect RendererTarget
bufferTarget s = do
  t <- defaultRendererTarget
  id <- createHash
  let target = setSkip true (createRenderTarget id t s)
  pure target

getId :: RendererTarget -> String
getId (RendererTarget renderTarget) = renderTarget.id

getTarget :: RendererTarget -> W.WebGLRenderTarget
getTarget (RendererTarget renderTarget) = renderTarget.target

createRenderTarget :: String -> W.WebGLRenderTarget -> Scene.Scene -> RendererTarget
createRenderTarget id t s = RendererTarget { id: id, target : t, scene : s, skip : false }

createWebRenderTarget :: forall opt. { | opt } -> Effect W.WebGLRenderTarget
createWebRenderTarget opt = do
  target <- W.createWeGLRenderer opt textureSize textureSize
  pure target

defaultRendererTarget :: Effect W.WebGLRenderTarget
defaultRendererTarget = do
  W.createWeGLRenderer {} textureSize textureSize

getTexture :: RendererTarget -> Effect TargetTexture
getTexture (RendererTarget t) = do
  tex <- W.unsafeGetTexture t.target
  pure tex

setSkip :: Boolean -> RendererTarget -> RendererTarget 
setSkip skip_ (RendererTarget target) = RendererTarget target { skip = skip_ }

createHash :: Effect String
createHash = ffi [""] "require('crypto').createHash('md5').update(Math.random() + '').digest('hex');"
