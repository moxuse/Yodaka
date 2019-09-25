module Graphics.Three.PostProcessing.PostEffect
( class PostEffect
, Bloom
, Noise
, Bokeh
, Depth
, bloomEffect
, noiseEffect
, bokehEffect
, depthEffect
) where

import Prelude (Unit)
import Effect
import Graphics.Three.Util (ffi, fpi)

foreign import data Bloom :: Type
foreign import data Noise :: Type
foreign import data Bokeh :: Type
foreign import data Depth :: Type

class PostEffect e

instance instancePostEffectBloom :: PostEffect Bloom
instance instancePostEffectNoise :: PostEffect Noise
instance instancePostEffectBokeh :: PostEffect Bokeh
instance instancePostEffectDepth :: PostEffect Depth

bloomEffect :: Effect Bloom
bloomEffect = ffi [ "" ] "new THREE.BloomEffect({ luminanceThreshold: 0.5 })"

noiseEffect :: Effect Noise
noiseEffect = ffi [ "" ] "new THREE.NoiseEffect()"

bokehEffect :: Effect Bokeh
bokehEffect = ffi [ "" ] "new THREE.BokehEffect({ focus : 0.9, dof : 0.07, aperture : 0.3 })"

depthEffect :: Effect Depth
depthEffect = ffi [ "" ] "new THREE.DepthEffect()"