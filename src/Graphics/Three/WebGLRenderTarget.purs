module Graphics.Three.WebGLRenderTarget where

import Prelude (Unit)
import Effect (Effect)
import Graphics.Three.Util (ffi)
import Graphics.Three.Texture (class Texture)

foreign import data WebGLRenderTarget :: Type
foreign import data NearestFilter :: Type
foreign import data ClampToEdgeWrapping :: Type

instance textureWebGLRenderTarget :: Texture WebGLRenderTarget

createWeGLRenderer ::  forall opt. {|opt} -> Int -> Int -> Effect WebGLRenderTarget
createWeGLRenderer = ffi [ "param", "width", "height", "" ] "new THREE.WebGLRenderTarget(width, height, param)"

clampToEdgeWrapping :: Effect ClampToEdgeWrapping
clampToEdgeWrapping = ffi [ "" ] "THREE.ClampToEdgeWrapping"

nearestFilter :: Effect NearestFilter
nearestFilter = ffi [ "" ] "THREE.NearestFilter"
