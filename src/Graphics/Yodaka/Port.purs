module Graphics.Yodaka.Port
( Port
, globalPort
, addTargetToPort
, addEffectToPort
) where

import Prelude (Unit, discard, bind)
import Data.Functor (map)
import Effect
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
  }

globalPort :: Effect Port
globalPort = unsafeForeignFunction [""] "window.port"

addTargetToPort :: R.RendererTarget -> Effect Unit
addTargetToPort = unsafeForeignFunction ["target", ""] "window.port.targets.push(target)"

addEffectToPort :: forall e. { renderToScreen :: Boolean | e } -> Effect Unit
addEffectToPort = unsafeForeignFunction ["target", ""] "window.port.postEffects.push(target)"
