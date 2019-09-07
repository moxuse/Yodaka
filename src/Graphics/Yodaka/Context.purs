module Graphics.Yodaka.Context where

import Prelude (Unit, bind, discard, pure, ($))
import Effect
import Effect.Unsafe (unsafePerformEffect)
import Data.Array (snoc)
import Graphics.Three.Object3D (class Object3D, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Texture
import Graphics.Yodaka.Port
import Graphics.Yodaka.RenderTarget as RT

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
