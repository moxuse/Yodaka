module Graphics.Three.PostProcessing.PostEffect
( class PostEffect
, Bloom
, Noise
, Bokeh
, Depth
, bloomEffect
, bloomEffect'
, noiseEffect
, noiseEffect'
, bokehEffect
, bokehEffect'
, depthEffect
, depthEffect'
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

bloomEffect' :: forall opt. { | opt } -> Effect Bloom
bloomEffect' = ffi [ "option", "" ] "new THREE.BloomEffect(option)"

noiseEffect :: Effect Noise
noiseEffect = ffi [ "" ] "new THREE.NoiseEffect()"

noiseEffect' :: forall opt. { | opt } -> Effect Noise
noiseEffect' = ffi [ "option", "" ] "new THREE.NoiseEffect(option)"

bokehEffect :: Effect Bokeh
bokehEffect = ffi [ "" ] "new THREE.BokehEffect({ focus : 0.9, dof : 0.07, aperture : 0.3 })"

bokehEffect' :: forall opt. { | opt } -> Effect Bokeh
bokehEffect' = ffi [ "option", "" ] "new THREE.BokehEffect(option)"

depthEffect :: Effect Depth
depthEffect = ffi [ "" ] "new THREE.DepthEffect()"

depthEffect' :: forall opt. { | opt } -> Effect Depth
depthEffect' = ffi [ "option", "" ] "new THREE.DepthEffect(option)"
