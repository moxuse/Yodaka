module Graphics.Yodaka.IO.Operator
( unifromUpdate
) where

import Prelude (Unit, pure, bind, ($), discard)
import Effect (Effect)
import Effect.Console (log)
import Effect.Uncurried (EffectFn1, mkEffectFn1)
import Data.Number.Format (precision, toStringWith)
import Graphics.Three.Object3D (class Renderable)
import Graphics.Yodaka.IO.Timer (Timer, createTimer)
import Graphics.Yodaka.Shader (updateUniform)

unifromUpdate :: forall r. Renderable r => String -> r -> Effect r
unifromUpdate name target = do  
  _ <- createTimer $ mkEffectFn1 (\elapse -> updateUniform target name elapse)
  (log "run : unifromUpdate")        
  pure target