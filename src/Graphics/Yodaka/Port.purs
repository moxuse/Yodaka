module Graphics.Yodaka.Port where

import Effect
import Graphics.Three.Scene as Scene

import Data.Foreign.EasyFFI (unsafeForeignFunction)


-- data TargetRenderer = TargetRenderer
--  {target:: WebGLRenderTarget, scene :: Scene }
  
type Port =
  { scene :: Scene.Scene
  -- , renderers :: Array TargetRenderer
  }

gloabalPort :: Effect Port
gloabalPort = unsafeForeignFunction [""] "window.port"
