module Graphics.Three.CubeCamera
( CubeCamera
, cubeCamera
, getCubeCameraTexture
, updadeCamera
) where

import Prelude (Unit)
import Effect
import Graphics.Three.Util (ffi, fpi)
import Graphics.Three.Texture (class Texture, TargetTexture)
import Graphics.Three.Object3D (class Renderable, class Object3D)


foreign import data CubeCamera :: Type

instance object3DCubeCamera :: Object3D CubeCamera

cubeCamera :: Number -> Number -> Int -> Effect CubeCamera
cubeCamera = ffi ["near", "far", "resolution", ""] "new THREE.CubeCamera(near, far, resolution)"

getCubeCameraTexture :: CubeCamera -> Effect TargetTexture
getCubeCameraTexture = ffi ["camera", ""] "camera.renderTarget.texture"

updadeCamera :: forall a b r. Renderable r => CubeCamera -> r -> a -> b -> Effect Unit
updadeCamera = fpi ["camera", "target", "renderer", "scene", ""] 
  """
    target.visible = false;
    camera.update(renderer, scene);
    target.visible = true;
  """
