module Graphics.Yodaka.IO.Osc
( addListener
) where

import Prelude (Unit)
import Effect (Effect)
import Effect.Uncurried (EffectFn1)
import Graphics.Three.Util (ffi, fpi)

addListener = fpi ["addr", "callback", ""] "window.port.osc.on(addr, callback)"
