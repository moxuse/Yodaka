module Graphics.Three.Texture where

import Prelude (Unit)
import Effect (Effect)
import Graphics.Three.Util (ffi)

class Texture t

data TargetTexture

instance targetTexture :: Texture TargetTexture

-- TODO: foreign Texture data
-- foreign import data Texture :: Type

-- createTexture :: Effect Texture
-- createTexture = ffi [ "" ] "new THREE.Texture()"