module Graphics.Yodaka.IO.Operator
( uniformUpdate
, setUniform  
) where

import Prelude (Unit, pure, bind, ($), discard)
import Effect (Effect)
import Effect.Console (log)
import Effect.Uncurried (EffectFn1, mkEffectFn1)
import Data.Number.Format (precision, toStringWith)
import Graphics.Three.Object3D (class Renderable, getMaterial)
import Graphics.Three.Material as MT
import Graphics.Three.MaterialAddition (updateMaterial)
import Graphics.Yodaka.IO.Timer (Timer, createTimer)

uniformUpdate :: forall r. Renderable r => String -> r -> Effect r
uniformUpdate name target = do  
  _ <- createTimer $ mkEffectFn1 (\elapse -> setUniform target name elapse)
  pure target

setUniform :: forall a r. Renderable r => String -> a -> r -> Effect r
setUniform name newValue target = do
  mat <- getMaterial target
  MT.setUniform mat name newValue
  updateMaterial mat
  pure target