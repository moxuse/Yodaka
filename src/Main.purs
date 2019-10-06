 
  
  

module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Data.Number.Format (precision, toString, toStringWith)
import Graphics.Three.Math.Euler
import Graphics.Three.Math.Vector
import Graphics.Three.Camera as Camera
import Graphics.Three.Geometry as Geometry
import Graphics.Three.Material as Material
import Graphics.Three.MaterialAddition as MaterialAddition
import Graphics.Three.Object3D (class Object3D, Mesh, createMesh, createLine, getPosition, setPosition, getRotationEuler, setRotationEuler, getGeometry, getMaterial)
import Graphics.Three.Scene as Scene
import Graphics.Three.Group as Group
import Graphics.Three.PostProcessing.PostEffect (bloomEffect, noiseEffect, bokehEffect, depthEffect)
import Graphics.Three.Util (ffi, fpi)
import Graphics.Yodaka.Port
import Graphics.Yodaka.Renderable.Torus
import Graphics.Yodaka.Renderable.Sphere
import Graphics.Yodaka.Renderable.Plane.Shader
import Graphics.Yodaka.Renderable.Plane.Fluid.Shader
import Graphics.Yodaka.Renderable.Util
import Graphics.Yodaka.IO.Timer
import Graphics.Yodaka.IO.Operator
import Graphics.Three.WebGLRenderTarget
import Graphics.Yodaka.Context (add, renderPP, render, fbRender, uU, sU, uOsc)

main :: Effect Unit
main = do
  log "You Compiled Main module" 