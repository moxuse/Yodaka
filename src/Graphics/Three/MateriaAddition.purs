module Graphics.Three.MaterialAddition where

import Prelude (Unit)
import Effect (Effect)
import Graphics.Three.Util (ffi)
import Graphics.Three.Material (class Material)

foreign import data MeshStandard :: Type

instance materialMeshStandard :: Material MeshStandard

createMeshStandard :: forall opt. { | opt } -> Effect MeshStandard
createMeshStandard = ffi [ "param", "" ] "new THREE.MeshStandardMaterial(param)"
