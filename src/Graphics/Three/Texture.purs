module Graphics.Three.Texture
( class Texture
, TargetTexture
, MapTexture
, createTexture
) where

import Prelude (Unit)
import Effect (Effect)
import Graphics.Three.Util (ffi)

foreign import data MapTexture :: Type

class Texture t

data TargetTexture

instance targetTexture :: Texture TargetTexture
instance mapTexture :: Texture MapTexture

createTexture :: Effect MapTexture
createTexture = ffi [ "" ] "new THREE.Texture()"