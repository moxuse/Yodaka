module Graphics.Three.MaterialAddition
( MeshStandard
, createMeshStandard
) where

import Prelude (Unit)
import Effect (Effect)
import Graphics.Three.Util (ffi, fpi)
import Graphics.Three.Material (class Material)

foreign import data MeshStandard :: Type

instance materialMeshStandard :: Material MeshStandard

createMeshStandard :: forall opt. { | opt } -> Effect MeshStandard
createMeshStandard = ffi [ "param", "" ] "new THREE.MeshStandardMaterial(param)"
