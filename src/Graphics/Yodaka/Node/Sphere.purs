module Graphics.Yodaka.Node.Sphere where

import Prelude (bind)
import Effect
import Record.Unsafe.Union (unsafeUnion)
import Graphics.Three.GeometryAddition (createSphereGeometry)
import Graphics.Three.MaterialAddition (createMeshStandard)
import Graphics.Three.Object3D (Mesh, createMesh)


torusDefaultOpt = { color : 0x2194ce }

sphere :: forall opt. { | opt } -> Effect Mesh
sphere opt = do
  let u = unsafeUnion opt torusDefaultOpt
  g <- createSphereGeometry 1.0 128.0 128.0
  m <- createMeshStandard u
  createMesh g m
