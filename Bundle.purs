module Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log)
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.MaterialAddition as MaterialAddition
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Scene as Scene
import Graphics.Three.Group as Group
import Graphics.Three.Util (ffi)
import Graphics.Yodaka.Common
import Graphics.Yodaka.Port

main :: Effect Unit
main = do
  port <- gloabalPort
  log "🍝"
  log "You should add some tests."
  m <- MaterialAddition.createMeshStandard {}
  g <- Geometry.createBox 0.5 0.5 0.5
  obj <- Object3D.createMesh g m
  Scene.addObject port.scene obj

-- module Main where

-- import Prelude (Unit, discard, bind, ($), (==), (>>=), (=<<), (<<<), (<$>), pure)
-- import Control.Monad.Error.Class (throwError, catchError)
-- import Data.Show (class Show, show)
-- import Data.Either
-- import Effect (Effect)
-- import Effect.Uncurried (mkEffectFn1)
-- import Effect.Console (error, log)
-- import Effect.Exception (Error, message)
-- import Effect.Aff (Aff, Fiber, effectCanceler, try, runAff, launchAff, forkAff, killFiber, joinFiber, bracket)
-- import Effect.Class (class MonadEffect, liftEffect)
-- import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
-- import Graphics.Three.Camera as Camera
-- import Graphics.Three.Geometry as Geometry
-- import Graphics.Three.Material as Material
-- import Graphics.Three.MaterialAddition as MaterialAddition
-- import Graphics.Three.Object3D as Object3D
-- import Graphics.Three.Scene as Scene
-- import Graphics.Three.Group as Group
-- import Graphics.Three.Util (ffi)
-- import Graphics.Yodaka.Util (loadCuntextThree)
-- import Graphics.Yodaka.Common

-- loadContext :: forall a. Effect a -> Effect (Fiber a)
-- loadContext onSuceed = do
--   launchAff do
--     loadCuntextThree
--     liftEffect do
--       g <- onSuceed
--       pure g

-- rotateGroup :: MainContext -> Group.Object3DGroup -> Number -> Effect Unit
-- rotateGroup context group n = do
--   Group.rotateIncrement group 0.02 n 0.01
--   renderContext context

-- onLoad :: Effect Group.Object3DGroup
-- onLoad = do
--   ctx@(MainContext c) <- initContext "container" Camera.Perspective
--   material <- MaterialAddition.createMeshStandard { color: "#f343c2" }
--   group <- Group.create
--   initLights ctx
--   Scene.addObject c.scene group
--   doAnimation $ rotateGroup ctx group 0.01
--   pure group
  

-- onLoaded :: Group.Object3DGroup -> Effect Unit
-- onLoaded group = do
--   m <- MaterialAddition.createMeshStandard {}
--   g <- Geometry.createBox 0.5 0.5 0.5
--   obj <- Object3D.createMesh g m
--   Group.addObject group obj

-- makeContext :: Aff Unit
-- makeContext = do
--   k <- liftEffect (loadContext onLoad) 
--   result <- try (joinFiber k)
--   -- forkAff do
--   case result of
--     Left _ -> liftEffect (log "foo are you")
--     Right g -> liftEffect (onLoaded g)

-- main :: Effect Unit
-- main = do
--   log "🍝"
--   log "You should add some tests."