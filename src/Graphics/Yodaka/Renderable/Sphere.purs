module Graphics.Yodaka.Renderable.Sphere
( sphere
) where

import Prelude (bind)
import Data.Maybe (Maybe(..))
import Effect
import Record.Unsafe.Union (unsafeUnion)
import Graphics.Three.GeometryAddition (createSphereGeometry)
import Graphics.Three.MaterialAddition (createMeshStandard)
import Graphics.Three.Object3D (Mesh, createMesh)

sphereDefaultOpt = { color : 0x2194ce, roughness: 0.3 }

sphere :: forall opt. { | opt } -> Effect Mesh
sphere opt = do
  let u = unsafeUnion opt sphereDefaultOpt
  g <- createSphereGeometry 1.5 512.0 512.0
  m <- createMeshStandard u
  createMesh g m
