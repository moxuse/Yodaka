# Yodaka

Yodaka is the library for to compose 3D graphics writen in [PureScript](http://purescript.org/). It expected that used in [Kusabi](https://github.com/moxuse/Kusabi) editor which provides environment that compile code and execute it.

Yodaka is a subset of [purescript-three](https://github.com/aqui18/purescript-three). It follows structures of `Object3D` / `Renderable` class and other interfaces.

## Functions

Functions which Yodaka provides. (This is a proposal that could be changed in the future..)

#### add

```
add :: forall o. Object3D o => Effect o -> Effect Unit
```

Takes `Object3D` and add to main scene.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/Context.purs#L15)

#### render

```
render :: forall r. Renderable r => Effect r -> Effect TargetTexture
```

Takes `Renderable` and add to sub scene and render as a texture.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/Context.purs#L21)

#### sphere

```
sphere :: forall opt. { | opt } -> Effect Mesh
```

Takes option record and make sphere. Options are match to [THREE.MeshStandardMaterial](https://threejs.org/docs/#api/en/materials/MeshStandardMaterial) now.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/Renderable/Sphere.purs#L15)

#### torus

```
torus :: forall opt. { | opt } -> Effect Mesh
```

As the same as sphere function but provides torus.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/Renderable/Torus.purs#L14)

## Types / Classes

### Rendarable

```
class Renderable a
```

This is declared not in Yodaka but purescript-three.

In Three.js's context, it's similer to `THREE.Mesh`. It has material and geometry.

[Source](https://github.com/aqui18/purescript-three/blob/master/src/Graphics/Three/Object3D.purs#L20)

### RenderTarget

```
newtype RendererTarget = RendererTarget
 { target :: WebGLRenderTarget, scene :: Scene }
```

Structure of WebGLRenderTarget and its scene. ([See this great article](https://threejsfundamentals.org/threejs/lessons/threejs-rendertargets.html)). Yodaka's `render` function will compose it and add to `Port` which share context with rendering view on Kusabi editor.

[Source](https://github.com/moxuse/Yodaka/blob/master/src/Graphics/Yodaka/RenderTarget.purs#L15)

This list don't discribe whole of library. Just collected what seems important.

Next step..., [Tutorial](https://github.com/moxuse/Kusabi/wiki/Tutorial) will coming up soon.
