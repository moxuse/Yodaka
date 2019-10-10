module Graphics.Yodaka.Port
( Port
, globalPort
, addTargetToPort
, addEffectToPort
, addOnRenderCallback
, getTargetById
, swapTargets
) where

import Prelude (Unit, pure, unit, discard, bind, (=<<))
import Data.Eq ((==))
import Data.Functor (map)
import Effect.Ref as RE
import Effect (Effect)
import Effect.Uncurried (EffectFn1)
import Graphics.Three.WebGLRenderTarget as W
import Graphics.Three.Util (ffi, fpi)
import Graphics.Three.Scene as Scene
import Graphics.Yodaka.RenderTarget as R
import Graphics.Three.PostProcessing.PostEffect (class PostEffect)
import Graphics.Yodaka.PostEffectTarget as P
import Data.Traversable (traverse_)

import Data.Foreign.EasyFFI (unsafeForeignFunction, unsafeForeignProcedure)

type Port =
  { scene :: Scene.Scene
  , targets :: Array R.RendererTarget
  , postEffects :: Array (forall e. PostEffect e => { renderToScreen :: Boolean, effect :: e })
  , onRender :: Array (Effect Unit)
  }

globalPort :: Effect Port
globalPort = unsafeForeignFunction [""] "window.port"

addTargetToPort :: R.RendererTarget -> Effect Unit
addTargetToPort = unsafeForeignFunction ["target", ""] "window.port.targets.push(target)"

addEffectToPort :: forall e. { renderToScreen :: Boolean | e } -> Effect Unit
addEffectToPort = unsafeForeignFunction ["target", ""] "window.port.postEffects.push(target)"

addOnRenderCallback :: forall a b. EffectFn1 a b -> Effect Unit
addOnRenderCallback = unsafeForeignFunction ["callack", ""] "window.port.onRender.push(callack)"

getTargetById :: String -> Effect R.RendererTarget
getTargetById id = do
  let foreign_ = unsafeForeignFunction ["callback", ""] "window.port.targets.filter(callback)[0]"
  let callback = \t -> (t.id == id)
  foreign_ callback

getTargetIndexById :: R.RendererTarget -> Effect Int
getTargetIndexById = unsafeForeignFunction ["target", ""] "window.port.targets.indexOf(target)"
  
setTarget :: Int -> W.WebGLRenderTarget -> Effect Unit
setTarget = fpi ["index", "newTarget", ""] "window.port.targets[index].target = newTarget"

swapTargets :: { currentId :: String,  nextId :: String } -> Effect Unit
swapTargets paire = do
  t1 <- getTargetById paire.currentId
  t2 <- getTargetById paire.nextId
  let t1Target = R.getTarget t1
  let t2Target = R.getTarget t2
  index1 <- getTargetIndexById t1
  index2 <- getTargetIndexById t2
  temp <- RE.new t1Target
  _ <- setTarget index1 t2Target
  temp_ <- RE.read temp
  _ <- setTarget index2 temp_
  pure unit
