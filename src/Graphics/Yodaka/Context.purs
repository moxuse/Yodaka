module Graphics.Yodaka.Context
( add
, render
, uU
, sU
) where

import Prelude (Unit, bind, discard, pure, ($))
import Effect (Effect)
import Data.Array (snoc)
import Graphics.Three.Object3D (class Renderable, class Object3D, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Texture (TargetTexture)
import Graphics.Yodaka.Port (Port, globalPort, addTargetToPort)
import Graphics.Yodaka.RenderTarget as RT
import Graphics.Yodaka.IO.Operator as OP

add :: forall o. Object3D o => Effect o -> Effect Unit
add obj = do
  p <- globalPort
  o <- obj
  Scene.addObject p.scene o

render :: forall r. Renderable r => Effect r -> Effect TargetTexture
render obj = do
  p <- globalPort
  o <- obj
  target <- RT.renderTarget o
  addTargetToPort target
  tex <- RT.getTexture target
  pure tex

uU name target = OP.uniformUpdate name target

sU name newValue target = OP.setUniform name newValue target
