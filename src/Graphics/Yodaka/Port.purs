module Graphics.Yodaka.Port where

import Prelude (Unit, discard, bind)
import Data.Functor (map)
import Effect
import Graphics.Three.Scene as Scene
import Graphics.Yodaka.RenderTarget as R
import Data.Traversable (traverse_)

import Data.Foreign.EasyFFI (unsafeForeignFunction, unsafeForeignProcedure)


type Port =
  { scene :: Scene.Scene
  , targets :: Array R.RendererTarget
  }

globalPort :: Effect Port
globalPort = unsafeForeignFunction [""] "window.port"

addTargetToPort :: R.RendererTarget -> Effect Unit
addTargetToPort = unsafeForeignFunction ["target", ""] "window.port.targets.push(target)"

-- setGlobalPort :: Port -> Effect Unit
-- setGlobalPort = unsafeForeignProcedure ["port", ""] "window.port = port"
