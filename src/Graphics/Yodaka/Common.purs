module Graphics.Yodaka.Common where

import Prelude (Unit, bind, discard, negate, pure, ($), (/), (-))
import Effect (Effect)
import Web.DOM.Node (Node)
import Web.HTML (HTMLCanvasElement)
import Graphics.Three.Scene as Scene
import Graphics.Three.Renderer as Renderer
import Graphics.Three.Camera as Camera
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Light as Light
import Graphics.Three.Util (ffi, fpi)

foreign import data WebGL2RenderingContext :: Type

data MainContext
  = MainContext
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
  MainContext
context r s c =
  MainContext
    { renderer: r
    , scene: s
    , camera: c
    }

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

renderContext :: MainContext -> Effect Unit
renderContext (MainContext c) = do
  case c.camera of
    Camera.PerspectiveInstance camera -> Renderer.render c.renderer c.scene camera
    Camera.OrthographicInstance camera -> Renderer.render c.renderer c.scene camera

onResize :: MainContext -> Event -> Effect Unit
onResize (MainContext c) _ = do
  window <- getWindow
  dims <- nodeDimensions window
  updateCamera c.camera dims
  Renderer.setSize c.renderer dims.width dims.height

createCameraInsance :: Camera.CameraType -> Scene.Scene -> Dimensions -> Effect Camera.CameraInstance
createCameraInsance Camera.Perspective scene dims = do
  camera <- Camera.createPerspective 45.0 (dims.width / dims.height) 0.1 1000.0
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
  Object3D.setPosition camera 0.0 0.0 10.0

initLights :: MainContext -> Effect Unit
initLights (MainContext c) = do
  ambiLight <- Light.createAmbientLight 0x2e9992
  Scene.addObject c.scene ambiLight
  pointLightA <- Light.createPointLight 0xffffff
  pointLightB <- Light.createPointLight 0xffffff
  pointLightC <- Light.createPointLight 0xffffff
  Object3D.setPosition pointLightA 0.0 200.0 0.0
  Object3D.setPosition pointLightB 100.0 200.0 100.0
  Object3D.setPosition pointLightC (-100.0) 200.0 (-100.0)
  Scene.addObject c.scene pointLightA
  Scene.addObject c.scene pointLightB
  Scene.addObject c.scene pointLightC

initContext :: String -> Camera.CameraType -> Effect MainContext
initContext idName cameraType = do
  window <- getWindow
  dims <- nodeDimensions window
  ccanvas <- createCanvas
  contextGL2 <- getWebGL2Context ccanvas
  renderer <- Renderer.createWebGL { antialias: true, canvas: ccanvas, context: contextGL2 }
  scene <- Scene.create
  camera <- createCameraInsance cameraType scene dims
  let
    ctx = context renderer scene camera
  Renderer.setSize renderer dims.width dims.height
  Renderer.appendToDomByID renderer idName
  addEventListener window "resize" $ onResize ctx
  pure ctx

--  Supprot functions
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

createCanvas :: Effect HTMLCanvasElement
createCanvas = ffi [ "" ] "document.createElement('canvas')"

getWebGL2Context :: HTMLCanvasElement -> Effect WebGL2RenderingContext
getWebGL2Context = ffi [ "canvas", "" ] "canvas.getContext('webgl2')"
