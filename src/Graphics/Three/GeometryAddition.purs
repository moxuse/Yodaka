module Graphics.Three.GeometryAddition where

import Prelude (Unit)
import Effect
import Graphics.Three.Util (ffi, fpi)
import Graphics.Three.Geometry as G


createTorusGeometry :: Number -> Number -> Number -> Number -> Effect G.Geometry
createTorusGeometry = ffi [ "radius", "tube", "radialSegments", "tubularSegments", "" ] "new THREE.TorusGeometry(radius, tube, radialSegments, tubularSegments)"

createSphereGeometry :: Number -> Number -> Number -> Effect G.Geometry
createSphereGeometry = ffi [ "radius", "widthSegments", "heightSegments", "" ] "new THREE.SphereGeometry(radius, widthSegments, heightSegments)"

createPlaneBufferGeometry :: Number -> Number -> Int -> Int -> Effect G.Geometry
createPlaneBufferGeometry = ffi [ "width", "height", "widthSegments", "heightSegments", "" ] "new THREE.PlaneBufferGeometry(width, height, widthSegments, heightSegments)"
