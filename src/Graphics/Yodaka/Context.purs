module Graphics.Yodaka.Context
( add
, renderPP
, render
, uU
, sU
, uOsc
) where

import Prelude (Unit, bind, discard, pure, ($))
import Effect (Effect)
import Graphics.Three.Object3D (class Renderable, class Object3D, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Texture (TargetTexture)
import Graphics.Three.PostProcessing.PostEffect (class PostEffect)
import Graphics.Yodaka.Port (Port, globalPort, addTargetToPort, addEffectToPort)
import Graphics.Yodaka.PostEffectTarget as PT
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

renderPP :: forall e. PostEffect e => Effect e -> Boolean -> Effect Unit
renderPP effect renderToScreen = do
  eff <- effect
  addEffectToPort $ PT.createPETarget eff renderToScreen

uU :: forall r. Renderable r => String -> r -> Effect r
uU name target = OP.updateUniform name target

-- TODO :: need correct type for 'n' that will be used as newValue
sU :: forall n r. Renderable r => String -> n -> r -> Effect r
sU name newValue target = OP.setUniform name newValue target

-- set uniform by Osc
uOsc :: forall r. Renderable r => String -> String -> r -> Effect r
uOsc addr name target = OP.setUniformByOsc addr name target
