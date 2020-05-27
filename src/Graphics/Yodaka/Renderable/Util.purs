module Graphics.Yodaka.Renderable.Util
( uniformInt
, uniformFloat
, uniformVec3
, uniformSampler2D
) where

import Prelude (Unit, bind, discard)
import Effect (Effect)
import Record.Builder (build, insert)
import Control.Bind (class Bind)
import Data.Symbol (class IsSymbol, SProxy, reflectSymbol)
import Prim.Row as Row
import Graphics.Three.Object3D (class Renderable, Mesh, createMesh)
import Graphics.Three.Math.Vector as Vector
import Graphics.Three.Texture (class Texture, ScreenTexture)

class UniformValue u

type UniformValueInt =
  { value :: Int }

type UniformValueFloat =
  { value :: Number }

type UniformValueVector3 =
  { value :: Vector.Vector3 }

type UniformValueSampler2D =
  forall t. Texture t => { value :: t }

uniformInt name value rec = build (insert name uniformValue) rec
  where
    uniformValue :: UniformValueInt
    uniformValue = { value : value }

uniformFloat name value rec = build (insert name uniformValue) rec
  where
    uniformValue :: UniformValueFloat
    uniformValue = { value : value }

uniformVec3 name value rec = build (insert name uniformValue) rec
  where
    uniformValue :: UniformValueVector3
    uniformValue = { value : value }

uniformSampler2D name value rec = build (insert name { value : value }) rec


-- -- for uniform update functions
-- class UniformType u

-- data UniformTypeInt = Int

-- data UniformTypeFloat = Number

-- data UniformTypeVector3 = Vector3

-- instance uniformTypeInstanceInt :: UniformType UniformTypeInt
-- instance uniformTypeInstanceFloat :: UniformType UniformTypeFloat
-- instance uniformTypeInstanceVector3 :: UniformType UniformTypeVector3