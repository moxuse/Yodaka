module Graphics.Yodaka.Context
( add
, add'
, add''
, renderPE
, render
, fbRender
, envSphereCubeCamera
, envRender
) where

import Data.Show (show)
import Prelude (Unit, unit, bind, discard, pure, void, ($), (<$>), (=<<))
import Effect (Effect)
import Effect.Ref as R
import Effect.Uncurried (EffectFn1, mkEffectFn1, mkEffectFn2)
import Graphics.Three.Object3D (class Renderable, class Object3D, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Texture (class Texture, TargetTexture)
import Graphics.Three.PostProcessing.PostEffect (class PostEffect)
import Graphics.Three.CubeCamera as CC
import Graphics.Yodaka.Port as P
import Graphics.Yodaka.Renderable.Plane.Shader (mapPlane, twoTonePlane)
import Graphics.Yodaka.Renderable.Sphere (envSphere)
import Graphics.Yodaka.PostEffectTarget as PT
import Graphics.Yodaka.RenderTarget as RT
import Graphics.Yodaka.IO.Operator as OP

add :: forall o. Object3D o => Effect o -> Effect Unit
add obj = do
  p <- P.globalPort
  o <- obj
  Scene.addObject p.scene o

add' :: forall o. Object3D o => Effect o -> Effect o
add' obj = do
  p <- P.globalPort
  o <- obj
  Scene.addObject p.scene o
  pure o

add'' :: forall o. Object3D o => o -> Effect o
add'' obj = do
  p <- P.globalPort
  Scene.addObject p.scene obj
  pure obj

render :: forall r. Renderable r => Effect r -> Effect TargetTexture
render obj = do
  o <- obj
  target <- RT.renderTarget o
  P.addTargetToPort target
  tex <- RT.getTexture target
  pure tex

-- make feedback render target. swap two targets at each frame
fbRender :: forall r. Renderable r => String -> Effect r -> Effect TargetTexture
fbRender uniformName obj = do
  o1 <- obj
  rt <- RT.renderTarget o1               -- current
  bt <- RT.bufferTarget (RT.getScene rt) -- next
  P.addTargetToPort rt
  P.addTargetToPort bt
  let cId = RT.getId rt
  let nId = RT.getId bt
  let paire = { currentId: cId, nextId: nId }
  P.addOnRenderCallback1 $ mkEffectFn1 (\_-> swapOnRender paire o1 uniformName)
  tCurrent <- RT.getTexture bt
  pure tCurrent
    where
      swapOnRender paire_ targetPlane uniformName_ = do
        P.swapTargets paire_
        next <- P.getTargetById paire_.nextId
        tex <- RT.getTexture next
        _ <- OP.setUniform uniformName_ tex targetPlane
        pure unit

-- make enviroment reflection by cube cameta
envSphereCubeCamera :: Effect CC.CubeCamera
envSphereCubeCamera = do
  tone <- render twoTonePlane
  sp <- envSphere { color: 0xffffff, map: tone, side: 1 }
  _ <- add'' sp
  camera <- CC.cubeCamera 0.01 50.0 1024 
  pure camera

envRender :: forall r. Renderable r => Effect r -> CC.CubeCamera -> Effect Unit
envRender target camera = do
  t_ <- target
  cc <- add'' camera
  P.addOnRenderCallback2 $ mkEffectFn2 (\rendere scene -> CC.updadeCamera cc t_ rendere scene)
  pure unit

-- render post effect
renderPE :: forall e. PostEffect e => Boolean -> Effect e -> Effect Unit
renderPE renderToScreen effect = do
  eff <- effect
  P.addEffectToPort $ PT.createPETarget eff renderToScreen
