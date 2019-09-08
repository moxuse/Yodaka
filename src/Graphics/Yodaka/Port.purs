module Graphics.Yodaka.Port where

import Prelude (Unit)
import Effect
import Graphics.Three.Scene as Scene
import Graphics.Yodaka.RenderTarget as R

import Data.Foreign.EasyFFI (unsafeForeignFunction)


type Port =
  { scene :: Scene.Scene
  , targets :: Array R.RendererTarget
  }

globalPort :: Effect Port
globalPort = unsafeForeignFunction [""] "window.port"

setGlobalPort :: Port -> Effect Unit
setGlobalPort = unsafeForeignFunction ["port", ""] "window.port = port"

-- dispose :: Effect Unit
-- dispose = do
