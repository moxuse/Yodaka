module Graphics.Yodaka.Context where

import Prelude (Unit, bind, discard, pure)
import Effect (Effect)
import Data.Array (snoc)
import Graphics.Three.Object3D (class Object3D, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Texture (TargetTexture)
import Graphics.Yodaka.Port (Port, gloabalPort, setGloalPort)
import Graphics.Yodaka.RenderTarget as RT

add :: forall o. Object3D o => Effect o -> Effect Unit
add obj = do
  p <- gloabalPort
  o <- obj
  Scene.addObject p.scene o

render :: Effect Mesh -> Effect TargetTexture
render obj = do
  p <- gloabalPort
  o <- obj
  target <- RT.renderTarget o
  let d = p.targets `snoc` target
  let newPort = setTargets d p
  setGloalPort newPort
  tex <- RT.getTexture target
  pure tex
    where 
      setTargets :: Array RT.RendererTarget -> Port -> Port
      setTargets tr p = p { targets = tr }      
