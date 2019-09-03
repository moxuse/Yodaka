module Graphics.Yodaka.Context where

import Prelude (Unit, bind, pure)
import Effect
import Graphics.Three.Object3D (Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Yodaka.Port

add obj = do
  p <- gloabalPort
  o <- obj
  Scene.addObject p.scene o
