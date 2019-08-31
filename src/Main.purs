module Main where

import Prelude (Unit, discard, bind, ($))
import Effect (Effect)
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Scene as Scene
import Graphics.Three.Util (ffi)
import Graphics.Yodaka.Common

-- TODO: We want to load THREE global onject correctly...
makeCuntextThree :: Effect Unit -> Effect Unit
makeCuntextThree =
  ffi [ "callback", "" ]
    """ (function() {
      var script = document.createElement("script")
      script.type = "text/javascript";

      if (script.readyState){
          script.onreadystatechange = function(){
              if (script.readyState == "loaded" ||
                      script.readyState == "complete"){
                  script.onreadystatechange = null;
              }
          };
      } else {
          script.onload = function(){
              console.log("suceeed load three!");
              callback();
          };
      }

      script.src = "https://cdnjs.cloudflare.com/ajax/libs/three.js/107/three.min.js";
      document.getElementsByTagName("head")[0].appendChild(script);
      var container = document.createElement("div");
      container.id = "container";
      document.body.appendChild(container);
      }())
    """

rotateCube :: Context -> Object3D.Mesh -> Number -> Effect Unit
rotateCube context mesh n = do
  Object3D.rotateIncrement mesh 0.05 n 0.04
  renderContext context

onLoad :: Effect Unit
onLoad = do
  ctx@(Context c) <- initContext "container" Camera.Perspective
  material <- Material.createMeshBasic { color: "#f343c2" }
  box <- Geometry.createBox 10.0 10.0 100.0
  cube <- Object3D.createMesh box material
  Scene.addObject c.scene cube
  doAnimation $ rotateCube ctx cube 0.01

main :: Effect Unit
main = do
  makeCuntextThree onLoad
