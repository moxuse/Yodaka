module Graphics.Yodaka.Node.Torus where

import Prelude (bind)
import Effect
import Graphics.Three.GeometryAddition (createTorusGeometry)
import Graphics.Three.MaterialAddition (createMeshStandard)
import Graphics.Three.Object3D (Mesh, createMesh)

torus :: Effect Mesh
torus = do
  g <- createTorusGeometry 1.0 0.5 16.0 100.0
  m <- createMeshStandard { color: 0x2194ce }
  createMesh g m
