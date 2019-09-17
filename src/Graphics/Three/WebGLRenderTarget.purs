module Graphics.Three.WebGLRenderTarget
( WebGLRenderTarget
, NearestFilter
, ClampToEdgeWrapping
, createWeGLRenderer
, unsafeGetTexture
) where

import Prelude (Unit)
import Effect (Effect)
import Graphics.Three.Util (ffi, fpi)
import Graphics.Three.Texture (class Texture, TargetTexture)

foreign import data WebGLRenderTarget :: Type
foreign import data NearestFilter :: Type
foreign import data ClampToEdgeWrapping :: Type

-- instance textureWebGLRenderTarget :: Texture WebGLRenderTarget

createWeGLRenderer ::  forall opt. {|opt} -> Int -> Int -> Effect WebGLRenderTarget
createWeGLRenderer = ffi [ "param", "width", "height", "" ] "new THREE.WebGLRenderTarget(width, height, param)"

unsafeGetTexture ::  WebGLRenderTarget -> Effect TargetTexture
unsafeGetTexture = ffi [ "target", "" ] "target.texture"
