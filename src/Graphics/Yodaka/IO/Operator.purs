module Graphics.Yodaka.IO.Operator
( updateUniform
, setUniform
, setUniformByOsc
) where

import Prelude (Unit, pure, bind, (<$>), (<), ($), (<>), discard)
import Effect (Effect)
import Effect.Exception (Error, throwException, error)
import Data.Either (Either (..))
import Effect.Console (log)
import Effect.Uncurried (EffectFn1, mkEffectFn1)
import Data.Number.Format (precision, toStringWith)
import Graphics.Three.Object3D (class Renderable, getMaterial)
import Graphics.Three.Material as MT
import Graphics.Three.MaterialAddition (updateMaterial, indexOfUniform)
import Graphics.Yodaka.IO.Timer (Timer, createTimer)
import Graphics.Yodaka.IO.Osc (addListener)
import Graphics.Three.Util (ffi)

validateUniform :: forall r. Renderable r =>  r -> String -> (Effect Unit) -> Effect r
validateUniform target name onValid = do
  mat <- getMaterial target
  index <- indexOfUniform mat name
  if index < 0
    then
      throwException $ error ("Unknown Uniform : " <> name)
    else do
      _ <- onValid
      pure target

updateUniform :: forall r. Renderable r => String -> r -> Effect r
updateUniform name target = do
  let onValid = createTimer $ mkEffectFn1 (\elapse -> setUniform name elapse target)
  validateUniform target name onValid

setUniform :: forall a r. Renderable r => String -> a -> r -> Effect r
setUniform name newValue target = do
  mat <- getMaterial target
  MT.setUniform mat name newValue
  updateMaterial mat
  pure target

setUniformByOsc :: forall r. Renderable r => String -> String -> r -> Effect r
setUniformByOsc addr name target = do
  let onValid = addListener addr (mkEffectFn1 (\msg -> setUniform name msg target))
  validateUniform target name onValid
