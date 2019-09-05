module Graphics.Three.WebGLRenderTarget where

import Prelude (Unit)
import Effect (Effect)
import Graphics.Three.Util (ffi)

foreign import data WebGLRenderTarget :: Type
foreign import data NearestFilter :: Type
foreign import data ClampToEdgeWrapping :: Type

class Texture t

instance textureWebGLRenderTarget :: Texture WebGLRenderTarget

createWeGLRenderer ::  forall opt. {|opt} -> Effect WebGLRenderTarget
createWeGLRenderer = ffi [ "param", "" ] "new THREE.WebGLRenderTarget(param)"

clampToEdgeWrapping :: Effect ClampToEdgeWrapping
clampToEdgeWrapping = ffi [ "" ] "THREE.ClampToEdgeWrapping"

nearestFilter :: Effect NearestFilter
nearestFilter = ffi [ "" ] "THREE.NearestFilter"
