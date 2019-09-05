module Graphics.Yodaka.Port where

import Effect
import Graphics.Three.Scene as Scene
import Graphics.Yodaka.RenderTarget as R

import Data.Foreign.EasyFFI (unsafeForeignFunction)


type Port =
  { scene :: Scene.Scene
  , renderers :: Array R.RendererTarget
  }

gloabalPort :: Effect Port
gloabalPort = unsafeForeignFunction [""] "window.port"
