module Graphics.Yodaka.Port
( Port
, globalPort
, addTargetToPort
, addEffectToPort
, addOnRenderCallback
) where

import Prelude (Unit, discard, bind)
import Data.Functor (map)
import Effect (Effect)
import Effect.Uncurried (EffectFn1)
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
