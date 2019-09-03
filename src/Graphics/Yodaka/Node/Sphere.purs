module Graphics.Yodaka.Node.Sphere where

import Prelude (bind)
import Effect
import Graphics.Three.GeometryAddition (createSphereGeometry)
import Graphics.Three.MaterialAddition (createMeshStandard)
import Graphics.Three.Object3D (Mesh, createMesh)

sphere :: Effect Mesh
sphere = do
  g <- createSphereGeometry 1.0 28.0 28.0
  m <- createMeshStandard { color: 0x2194ce }
  createMesh g m
