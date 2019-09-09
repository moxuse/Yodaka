 
module Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log)
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.MaterialAddition as MaterialAddition
import Graphics.Three.Object3D (class Object3D, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Group as Group
import Graphics.Three.Util (ffi)
import Graphics.Yodaka.Port
import Graphics.Yodaka.Node.Torus
import Graphics.Yodaka.Node.Sphere
import Graphics.Yodaka.Node.NoisePlane
import Graphics.Yodaka.Node.NormalPlane
import Graphics.Yodaka.Node.RGBNoisePlane
import Graphics.Three.WebGLRenderTarget
import Graphics.Yodaka.Context (add, render)

main :: Effect Unit
main = do
  log "You Compiled Main module"