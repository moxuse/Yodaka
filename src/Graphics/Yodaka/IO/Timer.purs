module Graphics.Yodaka.IO.Timer
( Timer
, createTimer
) where

import Prelude (Unit)
import Effect (Effect)
import Effect.Uncurried (EffectFn1)
import Graphics.Three.Util (ffi, fpi)

foreign import data Timer :: Type

-- type TimerCallback = Function a

-- createTimer :: forall a. (EffectFn1 a) -> Effect Timer
createTimer = fpi ["callback", ""] "d3.timer(callback)"
