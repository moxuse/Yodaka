module Graphics.Three.GeometryAddition where

import Prelude (Unit)
import Effect
import Graphics.Three.Util (ffi)
import Graphics.Three.Geometry as G

foreign import data Torus :: Type

createTorusGeometry :: Number -> Number -> Number -> Number -> Effect G.Geometry
createTorusGeometry = ffi [ "radius", "tube", "radialSegments", "tubularSegments", "" ] "new THREE.TorusGeometry(radius, tube, radialSegments, tubularSegments)"


createSphereGeometry :: Number -> Number -> Number -> Effect G.Geometry
createSphereGeometry = ffi ["radius", "widthSegments", "heightSegments", ""] "new THREE.SphereGeometry(radius, widthSegments, heightSegments)"