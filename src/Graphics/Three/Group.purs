module Graphics.Three.Group where

import Prelude (Unit)
import Data.Int
import Effect (Effect)
import Graphics.Three.Util (ffi, fpi)
import Graphics.Three.Object3D (class Object3D)

foreign import data Object3DGroup :: Type

class Group g

instance object3DGroup :: Object3D Object3DGroup

create :: Effect Object3DGroup
create = ffi [ "" ] "new THREE.Group()"

addObject :: forall a. Object3D a => Object3DGroup -> a -> Effect Unit
addObject = fpi [ "group", "a", "" ] "group.add(a)"

rotateIncrement :: forall a. Object3DGroup -> Number -> Number -> Number -> Effect Unit
rotateIncrement =
  fpi [ "group", "x", "y", "z", "" ]
    "group.rotation.x += x; group.rotation.y += y; group.rotation.z += z;"
