module ThreeExtra.Common where

import Prelude (class Show, Unit, discard, bind, map, negate, pure, show, ($), (-), (/), (<>))
import Effect (Effect)
import Effect.Console (log)
import Data.Array
import Web.DOM.Node (Node)
import Data.Foreign.EasyFFI
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Scene as Scene
import Graphics.Three.Renderer as Renderer
import Graphics.Three.Material as Material
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Scene as Scene
import Graphics.Three.Camera as Camera
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Util
import Control.Monad.State.Trans

data Context
  = Context
    { renderer :: Renderer.Renderer
    , scene :: Scene.Scene
    , camera :: Camera.CameraInstance
    --TODO objects
    }

type Event
  = { x :: Number
    , y :: Number
    }

type Dimensions
  = { width :: Number
    , height :: Number
    }

context ::
  Renderer.Renderer ->
  Scene.Scene ->
  Camera.CameraInstance ->
  Context
context r s c =
  Context
    { renderer: r
    , scene: s
    , camera: c
    }

newtype Pos
  = Pos
  { x :: Number
  , y :: Number
  }

pos :: Number -> Number -> Pos
pos x y =
  Pos
    { x: x
    , y: y
    }

gridList :: forall a. Int -> Int -> (Int -> Int -> a) -> Array a
gridList n m f = concatMap (\i -> map (\j -> f i j) (0 .. (m - 1))) (0 .. (n - 1))

doAnimation :: Effect Unit -> Effect Unit
doAnimation animate = do
  animate
  requestAnimationFrame $ doAnimation animate

updateCamera :: Camera.CameraInstance -> Dimensions -> Effect Unit
updateCamera (Camera.PerspectiveInstance camera) dims = do
  Camera.setAspect camera $ dims.width / dims.height
  Camera.updateProjectionMatrix camera

updateCamera (Camera.OrthographicInstance camera) dims = do
  Camera.updateOrthographic camera (dims.width / (-2.0)) (dims.width / (2.0))
    (dims.height / 2.0)
    (dims.height / (-2.0)) --}
  Camera.updateProjectionMatrix camera

renderContext :: Context -> Effect Unit
renderContext (Context c) = do
  case c.camera of
    Camera.PerspectiveInstance camera -> Renderer.render c.renderer c.scene camera
    Camera.OrthographicInstance camera -> Renderer.render c.renderer c.scene camera

onResize :: Context -> Event -> Effect Unit
onResize (Context c) _ = do
  window <- getWindow
  dims <- nodeDimensions window
  updateCamera c.camera dims
  Renderer.setSize c.renderer dims.width dims.height

createCameraInsance :: Camera.CameraType -> Scene.Scene -> Dimensions -> Effect Camera.CameraInstance
createCameraInsance Camera.Perspective scene dims = do
  camera <- Camera.createPerspective 45.0 (dims.width / dims.height) 1.0 1000.0
  setupCamera scene camera
  pure $ Camera.PerspectiveInstance camera

createCameraInsance Camera.Orthographic scene dims = do
  camera <-
    Camera.createOrthographic (dims.width / (-2.0)) (dims.width / (2.0))
      (dims.height / 2.0)
      (dims.height / (-2.0))
      1.0
      1000.0
  setupCamera scene camera
  pure $ Camera.OrthographicInstance camera

setupCamera :: forall a. Object3D.Object3D a => Camera.Camera a => Scene.Scene -> a -> Effect Unit
setupCamera scene camera = do
  Scene.addObject scene camera
  Object3D.setPosition camera 0.0 0.0 500.0

initContext :: String -> Camera.CameraType -> Effect Context
initContext idName cameraType = do
  window <- getWindow
  dims <- nodeDimensions window
  renderer <- Renderer.createWebGL { antialias: true }
  scene <- Scene.create
  camera <- createCameraInsance cameraType scene dims
  let
    ctx = context renderer scene camera
  Renderer.setSize renderer dims.width dims.height
  Renderer.appendToDomByID renderer idName
  addEventListener window "resize" $ onResize ctx
  pure ctx

unsafePrint :: forall a. a -> Effect Unit
unsafePrint = fpi [ "a", "" ] "console.log(a)"

getWindow :: Effect Node
getWindow = ffi [ "" ] "window"

getElementsByTagName :: String -> Effect Node
getElementsByTagName = ffi [ "name", "" ] "document.getElementsByTagName(name)[0]"

nodeDimensions :: Node -> Effect Dimensions
nodeDimensions =
  ffi [ "node", "" ]
    """ { 
          width: node.innerWidth ? node.innerWidth : node.width, 
          height: node.innerHeight ? node.innerHeight : node.height
        }
    """

addEventListener :: Node -> String -> (Event -> Effect Unit) -> Effect Unit
addEventListener =
  fpi [ "node", "name", "callback", "" ]
    """ node.addEventListener(name, function(e) {
          callback(e)();
        })
    """

requestAnimationFrame :: Effect Unit -> Effect Unit
requestAnimationFrame = fpi [ "callback", "" ] "window.requestAnimationFrame(callback)"
