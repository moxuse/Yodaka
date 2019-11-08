module Graphics.Yodaka.IO.Operator
( setPos
, setRot
, update
, updateByElapse
, setUniform
, setUniformByOsc
, applyOperator
, (|>)
, combineOperators
, (|+|)
) where

import Prelude (Unit, pure, bind, flip, (<$>), (<*>), (>=>), (<), ($), (<>), discard)
import Effect (Effect)
import Effect.Exception (Error, throwException, error)
import Data.Either (Either (..))
import Effect.Console (log)
import Effect.Uncurried (EffectFn1, mkEffectFn1)
import Data.Number.Format (precision, toStringWith)
import Graphics.Three.Object3D (class Object3D, class Renderable, getMaterial, setPosition, setRotationEuler)
import Graphics.Three.Material as MT
import Graphics.Three.MaterialAddition (updateMaterial, indexOfUniform)
import Graphics.Yodaka.IO.Timer (Timer, createTimer)
import Graphics.Yodaka.IO.Osc (addListener)

setPos :: forall a. Object3D a => Number -> Number -> Number -> a -> Effect a
setPos x y z target = do
  setPosition target x y x
  pure target

setRot :: forall a. Object3D a => Number -> Number -> Number -> a -> Effect a
setRot x y z target = do
  setRotationEuler target x y x
  pure target

update :: forall a c. Object3D a => (a -> Number -> Effect a) -> a -> Effect a
update func target = do
  _ <- createTimer $ mkEffectFn1 (\elapse -> (func target elapse))
  pure target

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

-- updateUniform :: forall r. Renderable r => (a -> Number -> Effect a) -> String -> r -> Effect r
-- updateUniform func name target = do
--   let onValid = createTimer $ mkEffectFn1 (\elapse -> func target name elapse)
--   validateUniform target name onValid

updateByElapse :: forall r. Renderable r => String -> r -> Effect r
updateByElapse name target = do
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

-- oprators and shorthand
applyOperator x y = y <$> x

infixr 1 applyOperator as |>

combineOperators x y = (>=>) x y

infixr 1 combineOperators as |+|
