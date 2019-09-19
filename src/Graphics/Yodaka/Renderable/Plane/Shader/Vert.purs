module Graphics.Yodaka.Renderable.Plane.Shader.Vert
( vertexShader
) where

import Data.String

vertexShader :: String
vertexShader = """
  varying vec2 vUv;
  void main() {
    vUv = uv;
    gl_Position = modelMatrix * vec4(position, 1.0);
  }
"""