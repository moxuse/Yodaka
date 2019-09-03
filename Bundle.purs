module Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log)
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.MaterialAddition as MaterialAddition
import Graphics.Three.Object3D as Object3D
import Graphics.Three.Scene as Scene
import Graphics.Three.Group as Group
import Graphics.Three.Util (ffi)
import Graphics.Yodaka.Common
import Graphics.Yodaka.Port
import Graphics.Yodaka.Port
import Graphics.Yodaka.Node.Torus
import Graphics.Yodaka.Node.Sphere
import Graphics.Yodaka.Context (add)

main :: Effect Unit
main = do
  log "You Compiled Main module"