module Graphics.Three.Texture
( class Texture
, TargetTexture
, ScreenTexture
, createTexture
) where

import Prelude (Unit)
import Effect (Effect)
import Graphics.Three.Util (ffi)

foreign import data ScreenTexture :: Type

class Texture t

data TargetTexture

instance targetTexture :: Texture TargetTexture
instance screenTexture :: Texture ScreenTexture

createTexture :: Effect ScreenTexture
createTexture = ffi [ "" ] "new THREE.Texture()"
