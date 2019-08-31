module Graphics.Three.Light where

import Prelude (Unit)
import Data.Int
import Effect (Effect)
import Graphics.Three.Util (ffi)
import Graphics.Three.Material (class Material)
import Graphics.Three.Object3D (class Object3D)

foreign import data AmbientLight :: Type

foreign import data PointLight :: Type

foreign import data DirectionalLight :: Type

class Light a

instance lightAmbibent :: Light AmbientLight

instance lightPoint :: Light PointLight

instance lightDirectional :: Light DirectionalLight

instance objectAmbibentLight :: Object3D AmbientLight

instance objectlightPointLight :: Object3D PointLight

instance objectDirectionalLight :: Object3D DirectionalLight

createAmbientLight :: Int -> Effect AmbientLight
createAmbientLight = ffi [ "color", "" ] "new THREE.AmbientLight(color)"

createPointLight :: Int -> Effect AmbientLight
createPointLight = ffi [ "color", "" ] "new THREE.PointLight(color)"

createDirectionalLight :: Int -> Effect DirectionalLight
createDirectionalLight = ffi [ "color", "" ] "new THREE.DirectionalLight(color)"
