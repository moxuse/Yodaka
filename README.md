# Yodaka

Yodaka is the library for to compose 3D graphics writen in [PureScript](http://purescript.org/). It expected that used in [Kusabi](https://github.com/moxuse/Kusabi) editor which provides environment that compile code and execute it.

Yodaka is a subset of [purescript-three](https://github.com/aqui18/purescript-three). It follows structures of `Object3D` / `Renderable` class and other interfaces.

## Functions

Functions which Yodaka provides. (This is a proposal that could be changed in the future..)

#### add

``` purescript
add :: forall o. Object3D o => Effect o -> Effect Unit
```

Takes `Object3D` instance and add to main scene.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/Context.purs#L20)

#### render

``` purescript
render :: forall r. Renderable r => Effect r -> Effect TargetTexture
```

Takes `Renderable` instance and add to sub scene. It will be rendered offscreen texture.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/Context.purs#L26)

#### sphere

``` purescript
sphere :: forall opt. { | opt } -> Effect Mesh
```

Takes option record and make sphere. Options are match to [THREE.MeshStandardMaterial](https://threejs.org/docs/#api/en/materials/MeshStandardMaterial) now.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/Renderable/Sphere.purs#L15)

#### torus

``` purescript
torus :: forall opt. { | opt } -> Effect Mesh
```

As the same as `sphere` function but provides torus.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/Renderable/Torus.purs#L14)

#### setUniform

``` purescript
setUniform :: forall a r. Renderable r => String -> a -> r -> Effect r
```

Takes uniform's value name newValue and `Renderable` instance. Set uniform of material of Rendarable. `sU` is syntax-sugar of this function.

[Source](https://github.com/moxuse/Yodaka/blob/603e99ae43b1c77072c39c0024a787fb0796a078/src/Graphics/Yodaka/IO/Operator.purs#L14)

#### uniformUpdate

``` purescript
uniformUpdate :: forall r. Renderable r => String -> r -> Effect r
```

Takes uniform's value name and `Renderable` instance. Updating shader uniform of material of Rendarable.
once it added, timer will apply for to update uniform's value each frame. `uU` is syntax-sugar of this function.

[Source](https://github.com/moxuse/Yodaka/blob/603e99ae43b1c77072c39c0024a787fb0796a078/src/Graphics/Yodaka/IO/Operator.purs#L14)

## Types / Classes

### Rendarable

``` purescript
class Renderable a
```

This is declared not in Yodaka but purescript-three.
In Three.js's context, it's similer to `THREE.Mesh`. It has material and geometry.

[Source](https://github.com/aqui18/purescript-three/blob/master/src/Graphics/Three/Object3D.purs#L20)

### RenderTarget

``` purescript
newtype RendererTarget = RendererTarget
 { target :: WebGLRenderTarget, scene :: Scene }
```

Structure of WebGLRenderTarget and its scene. (about WebGLRenderTarget, [See this great article](https://threejsfundamentals.org/threejs/lessons/threejs-rendertargets.html)) Yodaka's `render` function will compose it and add to `Port` that shares the context with rendering view on Kusabi editor.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/RenderTarget.purs#L15)

This list don't discribe whole of Yodaka functions. Just collected what seems important.

Next step..., [Tutorial](https://github.com/moxuse/Kusabi/wiki/Tutorial) will coming soon.
