module Graphics.Yodaka.Shader
( uniformInt
, uniformFloat
, uniformVec3
) where

import Prelude (Unit)
import Data.Symbol (SProxy(..))
import Record.Builder (build, insert)
import Type.Proxy (Proxy(..))
import Graphics.Three.Object3D (Mesh, createMesh)
import Graphics.Three.Math.Vector as Vector
import Mochi

type UniformValueInt =
  { "type" :: String
  , value :: Int
  }

type UniformValueFloat =
  { "type" :: String
  , value :: Number
  }

type UniformValueVector3 =
  { "type" :: String
  , value :: Vector.Vector3
  }

mkUniformInt :: String -> Int -> UniformValueInt
mkUniformInt = constructRecord (Proxy :: Proxy UniformValueInt)

mkUniformFloat :: String -> Number -> UniformValueFloat
mkUniformFloat = constructRecord (Proxy :: Proxy UniformValueFloat)

mkUniformVector3 :: String -> Vector.Vector3 -> UniformValueVector3
mkUniformVector3 = constructRecord (Proxy :: Proxy UniformValueVector3)

uniformInt name value rec = build (insert name uniformValue) rec
  where
    uniformValue = mkUniformInt "i" value

uniformFloat name value rec = build (insert name uniformValue) rec
  where
    uniformValue = mkUniformFloat "f" value

uniformVec3 name value rec = build (insert name uniformValue) rec
  where
    uniformValue = mkUniformVector3 "v3" value

