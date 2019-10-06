module Graphics.Yodaka.Context
( add
, renderPP
, render
, fbRender
, uU
, sU
, uOsc
) where

import Data.Show (show)
import Prelude (Unit, unit, bind, discard, pure, void, ($))
import Effect (Effect)
import Effect.Ref as R
import Effect.Uncurried (EffectFn1, mkEffectFn1)
import Graphics.Three.Object3D (class Renderable, class Object3D, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Texture (class Texture, TargetTexture)
import Graphics.Three.PostProcessing.PostEffect (class PostEffect)
import Graphics.Yodaka.Port as P
import Graphics.Yodaka.Renderable.Plane.Shader (mapPlane)
import Graphics.Yodaka.PostEffectTarget as PT
import Graphics.Yodaka.RenderTarget as RT
import Graphics.Yodaka.IO.Operator as OP

add :: forall o. Object3D o => Effect o -> Effect Unit
add obj = do
  p <- P.globalPort
  o <- obj
  Scene.addObject p.scene o

render :: forall r. Renderable r => Effect r -> Effect TargetTexture
render obj = do
  o <- obj
  target <- RT.renderTarget o
  P.addTargetToPort target
  tex <- RT.getTexture target
  pure tex

-- make feedback render target. swap two targets at each frame
-- under construction..
fbRender :: forall r t. Renderable r => Texture t => Effect r -> t -> Effect TargetTexture
fbRender karnel bufferT = do
  o1 <- karnel
  o2 <- mapPlane bufferT
  ct <- RT.renderTarget o1
  nt <- RT.renderTarget o2
  paire <- R.new { current : ct, next : nt }
  P.addOnRenderCallback $ mkEffectFn1 (\_-> swapOnRender paire o2)
  swaped <- R.read paire
  nTex <- RT.getTexture swaped.next
  pure nTex
  where
    swapOnRender paire_ targetPlane = do
      _ <- R.modify RT.swapTargets paire_
      swaped <- R.read paire_
      tex <- RT.getTexture swaped.current
      _ <- OP.setUniform "mapTexture" tex targetPlane
      pure unit

renderPP :: forall e. PostEffect e => Effect e -> Boolean -> Effect Unit
renderPP effect renderToScreen = do
  eff <- effect
  P.addEffectToPort $ PT.createPETarget eff renderToScreen

uU :: forall r. Renderable r => String -> r -> Effect r
uU name target = OP.updateUniform name target

-- TODO :: need correct type for 'n' that will be used as newValue
sU :: forall n r. Renderable r => String -> n -> r -> Effect r
sU name newValue target = OP.setUniform name newValue target

-- set uniform by Osc
uOsc :: forall r. Renderable r => String -> String -> r -> Effect r
uOsc addr name target = OP.setUniformByOsc addr name target
