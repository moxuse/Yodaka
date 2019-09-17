// Generated by purs bundle 0.13.3
var PS = {};
(function(exports) {
  /* global exports */
  "use strict";

  exports.unsafeForeignProcedure = function(args) {
      return function (stmt) {
          return Function(wrap(args.slice()))();
          function wrap() {
              return !args.length ? stmt : 'return function (' + args.shift() + ') { ' + wrap() + ' };';
          }
      };
  };
})(PS["Data.Foreign.EasyFFI"] = PS["Data.Foreign.EasyFFI"] || {});
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Data.Foreign.EasyFFI"] = $PS["Data.Foreign.EasyFFI"] || {};
  var exports = $PS["Data.Foreign.EasyFFI"];
  var $foreign = $PS["Data.Foreign.EasyFFI"];
  var unsafeForeignFunction = function (args) {
      return function (expr) {
          return $foreign.unsafeForeignProcedure(args)("return " + (expr + ";"));
      };
  };
  exports["unsafeForeignFunction"] = unsafeForeignFunction;
  exports["unsafeForeignProcedure"] = $foreign.unsafeForeignProcedure;
})(PS);
(function(exports) {
  "use strict";

  exports.runFn2 = function (fn) {
    return function (a) {
      return function (b) {
        return fn(a, b);
      };
    };
  };
})(PS["Data.Function.Uncurried"] = PS["Data.Function.Uncurried"] || {});
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Data.Function.Uncurried"] = $PS["Data.Function.Uncurried"] || {};
  var exports = $PS["Data.Function.Uncurried"];
  var $foreign = $PS["Data.Function.Uncurried"];
  exports["runFn2"] = $foreign.runFn2;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Data.Symbol"] = $PS["Data.Symbol"] || {};
  var exports = $PS["Data.Symbol"];      
  var SProxy = (function () {
      function SProxy() {

      };
      SProxy.value = new SProxy();
      return SProxy;
  })();
  var IsSymbol = function (reflectSymbol) {
      this.reflectSymbol = reflectSymbol;
  };
  var reflectSymbol = function (dict) {
      return dict.reflectSymbol;
  };
  exports["IsSymbol"] = IsSymbol;
  exports["reflectSymbol"] = reflectSymbol;
  exports["SProxy"] = SProxy;
})(PS);
(function(exports) {
  "use strict";

  exports.log = function (s) {
    return function () {
      console.log(s);
      return {};
    };
  };
})(PS["Effect.Console"] = PS["Effect.Console"] || {});
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Effect.Console"] = $PS["Effect.Console"] || {};
  var exports = $PS["Effect.Console"];
  var $foreign = $PS["Effect.Console"];
  exports["log"] = $foreign.log;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Three.Util"] = $PS["Graphics.Three.Util"] || {};
  var exports = $PS["Graphics.Three.Util"];
  var Data_Foreign_EasyFFI = $PS["Data.Foreign.EasyFFI"];                
  var fpi = Data_Foreign_EasyFFI.unsafeForeignProcedure;
  var ffi = Data_Foreign_EasyFFI.unsafeForeignFunction;
  exports["ffi"] = ffi;
  exports["fpi"] = fpi;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Three.GeometryAddition"] = $PS["Graphics.Three.GeometryAddition"] || {};
  var exports = $PS["Graphics.Three.GeometryAddition"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];                
  var createTorusGeometry = Graphics_Three_Util.ffi([ "radius", "tube", "radialSegments", "tubularSegments", "" ])("new THREE.TorusGeometry(radius, tube, radialSegments, tubularSegments)");
  var createPlaneBufferGeometry = Graphics_Three_Util.ffi([ "width", "height", "widthSegments", "heightSegments", "" ])("new THREE.PlaneBufferGeometry(width, height, widthSegments, heightSegments)");
  exports["createTorusGeometry"] = createTorusGeometry;
  exports["createPlaneBufferGeometry"] = createPlaneBufferGeometry;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Three.Material"] = $PS["Graphics.Three.Material"] || {};
  var exports = $PS["Graphics.Three.Material"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];                                                
  var createShader = Graphics_Three_Util.ffi([ "param", "" ])("new THREE.ShaderMaterial(param)");
  exports["createShader"] = createShader;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Three.MaterialAddition"] = $PS["Graphics.Three.MaterialAddition"] || {};
  var exports = $PS["Graphics.Three.MaterialAddition"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];       
  var createMeshStandard = Graphics_Three_Util.ffi([ "param", "" ])("new THREE.MeshStandardMaterial(param)");
  exports["createMeshStandard"] = createMeshStandard;
})(PS);
(function(exports) {
  /* global exports */
  "use strict";

  // module Graphics.Three.Math.Vector

  exports.createVec3 = function(x) {
      return function(y) {
          return function(z) {
              return new THREE.Vector3(x, y, z);
          };
      };
  };
})(PS["Graphics.Three.Math.Vector"] = PS["Graphics.Three.Math.Vector"] || {});
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Three.Math.Vector"] = $PS["Graphics.Three.Math.Vector"] || {};
  var exports = $PS["Graphics.Three.Math.Vector"];
  var $foreign = $PS["Graphics.Three.Math.Vector"];
  exports["createVec3"] = $foreign.createVec3;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Three.Object3D"] = $PS["Graphics.Three.Object3D"] || {};
  var exports = $PS["Graphics.Three.Object3D"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];
  var createMesh = function (dictMaterial) {
      return Graphics_Three_Util.ffi([ "geometry", "material", "" ])("new THREE.Mesh(geometry, material)");
  };
  exports["createMesh"] = createMesh;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Three.Scene"] = $PS["Graphics.Three.Scene"] || {};
  var exports = $PS["Graphics.Three.Scene"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];                
  var create = Graphics_Three_Util.ffi([ "" ])("new THREE.Scene()");
  var addObject = function (dictObject3D) {
      return Graphics_Three_Util.fpi([ "scene", "a", "" ])("scene.add(a)");
  };
  exports["create"] = create;
  exports["addObject"] = addObject;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Three.WebGLRenderTarget"] = $PS["Graphics.Three.WebGLRenderTarget"] || {};
  var exports = $PS["Graphics.Three.WebGLRenderTarget"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];                      
  var createWeGLRenderer = Graphics_Three_Util.ffi([ "param", "width", "height", "" ])("new THREE.WebGLRenderTarget(width, height, param)");
  exports["createWeGLRenderer"] = createWeGLRenderer;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.Port"] = $PS["Graphics.Yodaka.Port"] || {};
  var exports = $PS["Graphics.Yodaka.Port"];
  var Data_Foreign_EasyFFI = $PS["Data.Foreign.EasyFFI"];                
  var globalPort = Data_Foreign_EasyFFI.unsafeForeignFunction([ "" ])("window.port");
  var addTargetToPort = Data_Foreign_EasyFFI.unsafeForeignFunction([ "target", "" ])("window.port.targets.push(target)");
  exports["globalPort"] = globalPort;
  exports["addTargetToPort"] = addTargetToPort;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.RenderTarget"] = $PS["Graphics.Yodaka.RenderTarget"] || {};
  var exports = $PS["Graphics.Yodaka.RenderTarget"];
  var Graphics_Three_Scene = $PS["Graphics.Three.Scene"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];
  var Graphics_Three_WebGLRenderTarget = $PS["Graphics.Three.WebGLRenderTarget"];
  var unsafeGetTexture = Graphics_Three_Util.ffi([ "target", "" ])("target.texture");
  var textureSize = 1024;           
  var getTexture = function (v) {
      return function __do() {
          var v1 = unsafeGetTexture(v.target)();
          return v1;
      };
  };
  var defaultRendererTarget = Graphics_Three_WebGLRenderTarget.createWeGLRenderer({})(textureSize)(textureSize);
  var createRenderTarget = function (t) {
      return function (s) {
          return {
              target: t,
              scene: s
          };
      };
  };
  var addObject = function (dictRenderable) {
      return Graphics_Three_Util.fpi([ "scene", "a", "" ])("scene.add(a)");
  };
  var renderTarget = function (dictRenderable) {
      return function (overlap) {
          return function __do() {
              var v = Graphics_Three_Scene.create();
              var v1 = defaultRendererTarget();
              addObject()(v)(overlap)();
              var target = createRenderTarget(v1)(v);
              return target;
          };
      };
  };
  exports["renderTarget"] = renderTarget;
  exports["getTexture"] = getTexture;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.Context"] = $PS["Graphics.Yodaka.Context"] || {};
  var exports = $PS["Graphics.Yodaka.Context"];
  var Graphics_Three_Scene = $PS["Graphics.Three.Scene"];
  var Graphics_Yodaka_Port = $PS["Graphics.Yodaka.Port"];
  var Graphics_Yodaka_RenderTarget = $PS["Graphics.Yodaka.RenderTarget"];
  var render = function (dictRenderable) {
      return function (obj) {
          return function __do() {
              var v = Graphics_Yodaka_Port.globalPort();
              var v1 = obj();
              var v2 = Graphics_Yodaka_RenderTarget.renderTarget()(v1)();
              Graphics_Yodaka_Port.addTargetToPort(v2)();
              var v3 = Graphics_Yodaka_RenderTarget.getTexture(v2)();
              return v3;
          };
      };
  };
  var add = function (dictObject3D) {
      return function (obj) {
          return function __do() {
              var v = Graphics_Yodaka_Port.globalPort();
              var v1 = obj();
              return Graphics_Three_Scene.addObject()(v.scene)(v1)();
          };
      };
  };
  exports["add"] = add;
  exports["render"] = render;
})(PS);
(function(exports) {
  "use strict";

  exports.copyRecord = function(rec) {
    var copy = {};
    for (var key in rec) {
      if ({}.hasOwnProperty.call(rec, key)) {
        copy[key] = rec[key];
      }
    }
    return copy;
  };

  exports.unsafeInsert = function(l) {
    return function(a) {
      return function(rec) {
        rec[l] = a;
        return rec;
      };
    };
  };
})(PS["Record.Builder"] = PS["Record.Builder"] || {});
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Record.Builder"] = $PS["Record.Builder"] || {};
  var exports = $PS["Record.Builder"];
  var $foreign = $PS["Record.Builder"];
  var Data_Symbol = $PS["Data.Symbol"];
  var insert = function (dictCons) {
      return function (dictLacks) {
          return function (dictIsSymbol) {
              return function (l) {
                  return function (a) {
                      return function (r1) {
                          return $foreign.unsafeInsert(Data_Symbol.reflectSymbol(dictIsSymbol)(l))(a)(r1);
                      };
                  };
              };
          };
      };
  };                                                
  var build = function (v) {
      return function (r1) {
          return v($foreign.copyRecord(r1));
      };
  };
  exports["build"] = build;
  exports["insert"] = insert;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.Renderable.Util"] = $PS["Graphics.Yodaka.Renderable.Util"] || {};
  var exports = $PS["Graphics.Yodaka.Renderable.Util"];
  var Record_Builder = $PS["Record.Builder"];
  var uniformVec3 = function (dictCons) {
      return function (dictLacks) {
          return function (dictIsSymbol) {
              return function (name) {
                  return function (value_) {
                      return function (rec) {
                          var uniformValue = {
                              value: value_
                          };
                          return Record_Builder.build(Record_Builder.insert(dictCons)(dictLacks)(dictIsSymbol)(name)(uniformValue))(rec);
                      };
                  };
              };
          };
      };
  };
  var uniformFloat = function (dictCons) {
      return function (dictLacks) {
          return function (dictIsSymbol) {
              return function (name) {
                  return function (value_) {
                      return function (rec) {
                          var uniformValue = {
                              value: value_
                          };
                          return Record_Builder.build(Record_Builder.insert(dictCons)(dictLacks)(dictIsSymbol)(name)(uniformValue))(rec);
                      };
                  };
              };
          };
      };
  };
  exports["uniformFloat"] = uniformFloat;
  exports["uniformVec3"] = uniformVec3;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.Renderable.Plane.Noise"] = $PS["Graphics.Yodaka.Renderable.Plane.Noise"] || {};
  var exports = $PS["Graphics.Yodaka.Renderable.Plane.Noise"];
  var Data_Symbol = $PS["Data.Symbol"];
  var Graphics_Three_GeometryAddition = $PS["Graphics.Three.GeometryAddition"];
  var Graphics_Three_Material = $PS["Graphics.Three.Material"];
  var Graphics_Three_Math_Vector = $PS["Graphics.Three.Math.Vector"];
  var Graphics_Three_Object3D = $PS["Graphics.Three.Object3D"];
  var Graphics_Yodaka_Renderable_Util = $PS["Graphics.Yodaka.Renderable.Util"];                
  var vertexShader = "\x0a  void main() {\x0a    gl_Position = modelMatrix * vec4(position, 1.0);\x0a  }\x0a";
  var resolution = 1024.0;
  var initUniforms = (function () {
      var u = {};
      var u1 = Graphics_Yodaka_Renderable_Util.uniformVec3()()(new Data_Symbol.IsSymbol(function () {
          return "resolution";
      }))(Data_Symbol.SProxy.value)(Graphics_Three_Math_Vector.createVec3(resolution)(resolution)(0.0))(u);
      return Graphics_Yodaka_Renderable_Util.uniformFloat()()(new Data_Symbol.IsSymbol(function () {
          return "time";
      }))(Data_Symbol.SProxy.value)(0.0)(u1);
  })();
  var fragmentalShader = "\x0a  uniform vec3 resolution;\x0a  uniform float time;\x0a\x0a  vec2 random(vec2 st) {\x0a    st = vec2( dot(st, vec2(127.1, 311.7)),\x0a              dot(st, vec2(269.5, 183.3)) );\x0a              \x0a    return 2.0 * fract(sin(st) * 43758.5453123) - 1.0;\x0a  }\x0a\x0a\x0a  float noise(vec2 st) {\x0a    vec2 i = floor(st);\x0a    vec2 f = fract(st);\x0a\x0a    vec2 u = f * f * (3.0 - 2.0 * f);\x0a\x0a    return mix( mix( dot( random(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ), \x0a                     dot( random(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),\x0a                mix( dot( random(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ), \x0a                     dot( random(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);\x0a  }\x0a\x0a  void main() {\x0a    vec2 st = gl_FragCoord.xy / resolution.xy;\x0a    vec3 color = vec3(0.0);\x0a    vec2 pos = vec2(st * 32.0 + sin(time * 0.0008) * 4.0);\x0a    color = vec3( noise(pos) * .5 + .5 );\x0a    if (st.x > 0.9875) {\x0a      color = (1.0 - st.x) * 80.0 * color;\x0a    }\x0a    if (st.x < 0.0125) {\x0a      color = st.x * 80.0 * color;\x0a    }\x0a    gl_FragColor = vec4(color, 1.0);\x0a  }\x0a";
  var noisePlane = function __do() {
      var v = Graphics_Three_GeometryAddition.createPlaneBufferGeometry(2.0)(2.0)(1)(1)();
      var v1 = Graphics_Three_Material.createShader({
          uniforms: initUniforms,
          vertexShader: vertexShader,
          fragmentShader: fragmentalShader
      })();
      return Graphics_Three_Object3D.createMesh()(v)(v1)();
  };
  exports["noisePlane"] = noisePlane;
})(PS);
(function(exports) {
  "use strict";

  exports.unsafeUnionFn = function(r1, r2) {
    var copy = {};
    for (var k1 in r2) {
      if ({}.hasOwnProperty.call(r2, k1)) {
        copy[k1] = r2[k1];
      }
    }
    for (var k2 in r1) {
      if ({}.hasOwnProperty.call(r1, k2)) {
        copy[k2] = r1[k2];
      }
    }
    return copy;
  };
})(PS["Record.Unsafe.Union"] = PS["Record.Unsafe.Union"] || {});
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Record.Unsafe.Union"] = $PS["Record.Unsafe.Union"] || {};
  var exports = $PS["Record.Unsafe.Union"];
  var $foreign = $PS["Record.Unsafe.Union"];
  var Data_Function_Uncurried = $PS["Data.Function.Uncurried"];                
  var unsafeUnion = Data_Function_Uncurried.runFn2($foreign.unsafeUnionFn);
  exports["unsafeUnion"] = unsafeUnion;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.Renderable.Torus"] = $PS["Graphics.Yodaka.Renderable.Torus"] || {};
  var exports = $PS["Graphics.Yodaka.Renderable.Torus"];
  var Graphics_Three_GeometryAddition = $PS["Graphics.Three.GeometryAddition"];
  var Graphics_Three_MaterialAddition = $PS["Graphics.Three.MaterialAddition"];
  var Graphics_Three_Object3D = $PS["Graphics.Three.Object3D"];
  var Record_Unsafe_Union = $PS["Record.Unsafe.Union"];                
  var torusDefaultOpt = {
      color: 2200782,
      roughness: 0.3
  };
  var torus = function (opt) {
      var u = Record_Unsafe_Union.unsafeUnion(opt)(torusDefaultOpt);
      return function __do() {
          var v = Graphics_Three_GeometryAddition.createTorusGeometry(1.0)(0.5)(128.0)(256.0)();
          var v1 = Graphics_Three_MaterialAddition.createMeshStandard(u)();
          return Graphics_Three_Object3D.createMesh()(v)(v1)();
      };
  };
  exports["torus"] = torus;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Main"] = $PS["Main"] || {};
  var exports = $PS["Main"];
  var Effect_Console = $PS["Effect.Console"];
  var Graphics_Yodaka_Context = $PS["Graphics.Yodaka.Context"];
  var Graphics_Yodaka_Renderable_Plane_Noise = $PS["Graphics.Yodaka.Renderable.Plane.Noise"];
  var Graphics_Yodaka_Renderable_Torus = $PS["Graphics.Yodaka.Renderable.Torus"];                
  var main = function __do() {
      Effect_Console.log("You Compiled Main module")();
      var v = Graphics_Yodaka_Context.render()(Graphics_Yodaka_Renderable_Plane_Noise.noisePlane)();
      return Graphics_Yodaka_Context.add()(Graphics_Yodaka_Renderable_Torus.torus({
          map: v
      }))();
  };
  exports["main"] = main;
})(PS);
PS["Main"].main();