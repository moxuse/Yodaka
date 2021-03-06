module Graphics.Yodaka.Renderable.Torus
( torus
) where

import Prelude (bind)
import Effect
import Record.Unsafe.Union (unsafeUnion)
import Graphics.Three.GeometryAddition (createTorusGeometry)
import Graphics.Three.MaterialAddition (createMeshStandard)
import Graphics.Three.Object3D (Mesh, createMesh)

torusDefaultOpt = { color : 0x2194ce, roughness: 0.3 }

torus :: forall opt. { | opt } -> Effect Mesh
torus opt = do
  let u = unsafeUnion opt torusDefaultOpt
  g <- createTorusGeometry 1.0 0.5 128.0 256.0
  m <- createMeshStandard u
  createMesh g m
