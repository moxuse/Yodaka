module Graphics.Yodaka.Util where

import Prelude (Unit, discard, bind, pure)
import Data.Show (show)
import Effect (Effect)
import Effect.Aff (Aff, Canceler)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Graphics.Three.Group as Group

foreign import onReadyThreeContextImpl :: EffectFnAff Unit

loadCuntextThree :: Aff Unit
loadCuntextThree = fromEffectFnAff onReadyThreeContextImpl
