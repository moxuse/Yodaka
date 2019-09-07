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

gloabalPort :: Effect Port
gloabalPort = unsafeForeignFunction [""] "window.port"

setGloalPort :: Port -> Effect Unit
setGloalPort = unsafeForeignFunction ["port", ""] "window.port = port"
