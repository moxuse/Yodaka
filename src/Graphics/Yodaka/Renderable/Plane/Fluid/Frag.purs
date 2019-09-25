module Graphics.Yodaka.Renderable.Plane.Fluid.Frag
( advectShader
, divergenceShader
, jacobiShader
, subtractGradientShader
) where

import Data.String

-- from this blog article https://github.com/jlfwong/blog/blob/master/static/javascripts/fluid-sim.js
advectShader :: String
advectShader = """
  uniform float deltaT;
  uniform sampler2D inputTexture;
  uniform sampler2D velocity;
  varying vec2 vUv;

  void main() {
    vec2 u = texture2D(velocity, vUv).xy;

    vec2 pastCoord = fract(vUv - (0.5 * deltaT * u));
    gl_FragColor = texture2D(inputTexture, pastCoord);
  }
"""

divergenceShader :: String
divergenceShader = """
  uniform float deltaT;         // Time between steps \n
  uniform float rho;            // Density \n
  uniform float epsilon;        // Distance between grid units \n
  uniform sampler2D velocity;   // Advected velocity field, u_a \n
  varying vec2 vUv;

  vec2 u(vec2 coord) {
    return texture2D(velocity, fract(coord)).xy;
  }

  void main() {
    gl_FragColor = vec4((-2.0 * epsilon * rho / deltaT) * (
      (u(vUv + vec2(epsilon, 0)).x -
       u(vUv - vec2(epsilon, 0)).x)
      +
      (u(vUv + vec2(0, epsilon)).y -
       u(vUv - vec2(0, epsilon)).y)
    ), 0.0, 0.0, 1.0);
  }
"""

jacobiShader :: String
jacobiShader = """
  uniform float epsilon;        // Distance between grid units \n
  uniform sampler2D divergence; // Divergence field of advected velocity, d \n
  uniform sampler2D pressure;   // Pressure field from previous iteration, p^(k-1) \n
  varying vec2 vUv;

  float d(vec2 coord) {
    return texture2D(divergence, fract(coord)).x;
  }

  float p(vec2 coord) {
    return texture2D(pressure, fract(coord)).x;
  }

  void main() {
    gl_FragColor = vec4(0.25 * (
      d(vUv)
      + p(vUv + vec2(2.0 * epsilon, 0.0))
      + p(vUv - vec2(2.0 * epsilon, 0.0))
      + p(vUv + vec2(0.0, 2.0 * epsilon))
      + p(vUv - vec2(0.0, 2.0 * epsilon))
    ), 0.0, 0.0, 1.0);
  }
"""

subtractGradientShader :: String
subtractGradientShader = """
  uniform float deltaT;         // Time between steps \n
  uniform float rho;            // Density \n
  uniform float epsilon;        // Distance between grid units \n
  uniform sampler2D velocity;   // Advected velocity field, u_a \n
  uniform sampler2D pressure;   // Solved pressure field \n
  varying vec2 vUv;

  float p(vec2 coord) {
    return texture2D(pressure, fract(coord)).x;
  }

  void main() {
    vec2 u_a = texture2D(velocity, vUv).xy;

    float diff_p_x = (p(vUv + vec2(epsilon, 0.0)) -
                      p(vUv - vec2(epsilon, 0.0)));
    float u_x = u_a.x - deltaT/(2.0 * rho * epsilon) * diff_p_x;
    
    float diff_p_y = (p(vUv + vec2(0.0, epsilon)) -
                      p(vUv - vec2(0.0, epsilon)));
    float u_y = u_a.y - deltaT/(2.0 * rho * epsilon) * diff_p_y;
    
    gl_FragColor = vec4(u_x, u_y, 0.0, 0.0);
  }
"""
