module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Data.Number.Format (precision, toString, toStringWith)
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.MaterialAddition as MaterialAddition
import Graphics.Three.Object3D (class Object3D, Mesh)
import Graphics.Three.Scene as Scene
import Graphics.Three.Group as Group
import Graphics.Three.Util (ffi)
import Graphics.Yodaka.Port
import Graphics.Yodaka.Renderable.Torus
import Graphics.Yodaka.Renderable.Sphere
import Graphics.Yodaka.Renderable.Plane.Map
import Graphics.Yodaka.Renderable.Plane.Noise
import Graphics.Yodaka.Renderable.Plane.Normal
import Graphics.Yodaka.Renderable.Plane.RGBNoise
import Graphics.Yodaka.Renderable.Util
import Graphics.Yodaka.IO.Timer
import Graphics.Yodaka.IO.Operator
import Graphics.Three.WebGLRenderTarget
import Graphics.Yodaka.Context (add, render)

main :: Effect Unit
main = do
  log "You Compiled Main module"