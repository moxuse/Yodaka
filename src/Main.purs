module Main where

import ThreeExtra.Common
import Prelude (Unit, discard, bind, ($))
import Effect (Effect)
import Effect.Console (log)
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Scene as Scene
import Halogen.HTML.Elements.Keyed (colgroup)

rotateCube :: Context -> Object3D.Mesh -> Number -> Effect Unit
rotateCube context mesh n = do
  Object3D.rotateIncrement mesh 0.05 n 0.04
  renderContext context

main :: Effect Unit
main = do
  ctx@(Context c) <- initContext "container" Camera.Perspective
  material <- Material.createMeshBasic { color: "#f343c2" }
  box <- Geometry.createBox 10.0 10.0 100.0
  cube <- Object3D.createMesh box material
  Scene.addObject c.scene cube
  doAnimation $ rotateCube ctx cube 0.01
