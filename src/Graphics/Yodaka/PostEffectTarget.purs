module Graphics.Yodaka.PostEffectTarget
( PostEffectTarget 
, createPETarget
) where

import Prelude (bind, discard, pure, (>>>), ($))
import Effect (Effect)
import Record.Builder (build, insert)
import Data.Symbol (SProxy(..))
import Graphics.Three.PostProcessing.PostEffect (class PostEffect)

type PostEffectTarget = forall e. (PostEffect e) => { effect :: e, renderToScreen :: Boolean }

effect_ =  SProxy :: SProxy "effect"
  
createPETarget :: forall e. (PostEffect e) => e ->  Boolean -> { renderToScreen :: Boolean , effect :: e }
createPETarget eff renderToScreen = build (insert effect_  eff) { renderToScreen : renderToScreen }
