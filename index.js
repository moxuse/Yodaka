// Generated by purs bundle 0.13.8
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
  // Generated by purs version 0.13.8
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
(function($PS) {
  // Generated by purs version 0.13.8
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
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Effect.Console"] = $PS["Effect.Console"] || {};
  var exports = $PS["Effect.Console"];
  var $foreign = $PS["Effect.Console"];
  exports["log"] = $foreign.log;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
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
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Three.GeometryAddition"] = $PS["Graphics.Three.GeometryAddition"] || {};
  var exports = $PS["Graphics.Three.GeometryAddition"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];                                                                                                                      
  var createPlaneBufferGeometry = Graphics_Three_Util.ffi([ "width", "height", "widthSegments", "heightSegments", "" ])("new THREE.PlaneBufferGeometry(width, height, widthSegments, heightSegments)");
  exports["createPlaneBufferGeometry"] = createPlaneBufferGeometry;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Three.Material"] = $PS["Graphics.Three.Material"] || {};
  var exports = $PS["Graphics.Three.Material"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];                                                
  var createShader = Graphics_Three_Util.ffi([ "param", "" ])("new THREE.ShaderMaterial(param)");
  exports["createShader"] = createShader;
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
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Three.Math.Vector"] = $PS["Graphics.Three.Math.Vector"] || {};
  var exports = $PS["Graphics.Three.Math.Vector"];
  var $foreign = $PS["Graphics.Three.Math.Vector"];
  exports["createVec3"] = $foreign.createVec3;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
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
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Three.Scene"] = $PS["Graphics.Three.Scene"] || {};
  var exports = $PS["Graphics.Three.Scene"];
  var Graphics_Three_Util = $PS["Graphics.Three.Util"];             
  var addObject = function (dictObject3D) {
      return Graphics_Three_Util.fpi([ "scene", "a", "" ])("scene.add(a)");
  };
  exports["addObject"] = addObject;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Yodaka.Port"] = $PS["Graphics.Yodaka.Port"] || {};
  var exports = $PS["Graphics.Yodaka.Port"];
  var Data_Foreign_EasyFFI = $PS["Data.Foreign.EasyFFI"];                                                                
  var globalPort = Data_Foreign_EasyFFI.unsafeForeignFunction([ "" ])("window.port");
  exports["globalPort"] = globalPort;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Yodaka.Context"] = $PS["Graphics.Yodaka.Context"] || {};
  var exports = $PS["Graphics.Yodaka.Context"];
  var Graphics_Three_Scene = $PS["Graphics.Three.Scene"];
  var Graphics_Yodaka_Port = $PS["Graphics.Yodaka.Port"];
  var add = function (dictObject3D) {
      return function (obj) {
          return function __do() {
              var p = Graphics_Yodaka_Port.globalPort();
              var o = obj();
              return Graphics_Three_Scene.addObject()(p.scene)(o)();
          };
      };
  };
  exports["add"] = add;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Yodaka.Renderable.Plane.Shader.Frag"] = $PS["Graphics.Yodaka.Renderable.Plane.Shader.Frag"] || {};
  var exports = $PS["Graphics.Yodaka.Renderable.Plane.Shader.Frag"];                                                                                                                        
  var noiseShader = "\x0a  uniform vec3 resolution;\x0a  uniform float density;\x0a  uniform float time;\x0a\x0a  vec2 random(vec2 st) {\x0a    st = vec2( dot(st, vec2(127.1, 311.7)),\x0a              dot(st, vec2(269.5, 183.3)) );\x0a              \x0a    return 2.0 * fract(sin(st) * 43758.5453123) - 1.0;\x0a  }\x0a\x0a\x0a  float noise(vec2 st) {\x0a    vec2 i = floor(st);\x0a    vec2 f = fract(st);\x0a\x0a    vec2 u = f * f * (3.0 - 2.0 * f);\x0a\x0a    return mix( mix( dot( random(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ), \x0a                      dot( random(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),\x0a                mix( dot( random(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ), \x0a                      dot( random(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);\x0a  }\x0a\x0a  void main() {\x0a    vec2 st = gl_FragCoord.xy / resolution.xy;\x0a    vec3 color = vec3(0.0);\x0a    vec2 pos = vec2(st * 20.0 * density + sin(time * 0.0008) * 4.0);\x0a    color = vec3( noise(pos) * .5 + .5 );\x0a    gl_FragColor = vec4(color, 1.0);\x0a  }\x0a";
  exports["noiseShader"] = noiseShader;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Yodaka.Renderable.Plane.Shader.Vert"] = $PS["Graphics.Yodaka.Renderable.Plane.Shader.Vert"] || {};
  var exports = $PS["Graphics.Yodaka.Renderable.Plane.Shader.Vert"];
  var vertexShader = "\x0a  varying vec2 vUv;\x0a  void main() {\x0a    vUv = uv;\x0a    gl_Position = modelMatrix * vec4(position, 1.0);\x0a  }\x0a";
  exports["vertexShader"] = vertexShader;
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
  // Generated by purs version 0.13.8
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
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Yodaka.Renderable.Util"] = $PS["Graphics.Yodaka.Renderable.Util"] || {};
  var exports = $PS["Graphics.Yodaka.Renderable.Util"];
  var Record_Builder = $PS["Record.Builder"];
  var uniformVec3 = function (dictCons) {
      return function (dictLacks) {
          return function (dictIsSymbol) {
              return function (name) {
                  return function (value) {
                      return function (rec) {
                          var uniformValue = {
                              value: value
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
                  return function (value) {
                      return function (rec) {
                          var uniformValue = {
                              value: value
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
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Graphics.Yodaka.Renderable.Plane.Shader"] = $PS["Graphics.Yodaka.Renderable.Plane.Shader"] || {};
  var exports = $PS["Graphics.Yodaka.Renderable.Plane.Shader"];
  var Data_Symbol = $PS["Data.Symbol"];
  var Graphics_Three_GeometryAddition = $PS["Graphics.Three.GeometryAddition"];
  var Graphics_Three_Material = $PS["Graphics.Three.Material"];
  var Graphics_Three_Math_Vector = $PS["Graphics.Three.Math.Vector"];
  var Graphics_Three_Object3D = $PS["Graphics.Three.Object3D"];
  var Graphics_Yodaka_Renderable_Plane_Shader_Frag = $PS["Graphics.Yodaka.Renderable.Plane.Shader.Frag"];
  var Graphics_Yodaka_Renderable_Plane_Shader_Vert = $PS["Graphics.Yodaka.Renderable.Plane.Shader.Vert"];
  var Graphics_Yodaka_Renderable_Util = $PS["Graphics.Yodaka.Renderable.Util"];                
  var resolution = 1024.0;
  var resolutionUniform = function (dictLacks) {
      return function (rec) {
          return Graphics_Yodaka_Renderable_Util.uniformVec3()(dictLacks)(new Data_Symbol.IsSymbol(function () {
              return "resolution";
          }))(Data_Symbol.SProxy.value)(Graphics_Three_Math_Vector.createVec3(resolution)(resolution)(0.0))(rec);
      };
  };
  var planeSize = 2.0;
  var planeSegmentNum = 1;
  var makePlameMesh = function (frag) {
      return function (u) {
          return function __do() {
              var g = Graphics_Three_GeometryAddition.createPlaneBufferGeometry(planeSize)(planeSize)(planeSegmentNum)(planeSegmentNum)();
              var m = Graphics_Three_Material.createShader({
                  uniforms: u,
                  vertexShader: Graphics_Yodaka_Renderable_Plane_Shader_Vert.vertexShader,
                  fragmentShader: frag
              })();
              return Graphics_Three_Object3D.createMesh()(g)(m)();
          };
      };
  };
  var noisePlane = (function () {
      var u = {};
      var u1 = resolutionUniform()(u);
      var u2 = Graphics_Yodaka_Renderable_Util.uniformFloat()()(new Data_Symbol.IsSymbol(function () {
          return "density";
      }))(Data_Symbol.SProxy.value)(1.0)(u1);
      var u3 = Graphics_Yodaka_Renderable_Util.uniformFloat()()(new Data_Symbol.IsSymbol(function () {
          return "time";
      }))(Data_Symbol.SProxy.value)(0.0)(u2);
      return makePlameMesh(Graphics_Yodaka_Renderable_Plane_Shader_Frag.noiseShader)(u3);
  })();
  exports["noisePlane"] = noisePlane;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.8
  "use strict";
  $PS["Main"] = $PS["Main"] || {};
  var exports = $PS["Main"];
  var Effect_Console = $PS["Effect.Console"];
  var Graphics_Yodaka_Context = $PS["Graphics.Yodaka.Context"];
  var Graphics_Yodaka_Renderable_Plane_Shader = $PS["Graphics.Yodaka.Renderable.Plane.Shader"];                
  var main = function __do() {
      Effect_Console.log("You Compiled Main module")();
      return Graphics_Yodaka_Context.add()(Graphics_Yodaka_Renderable_Plane_Shader.noisePlane)();
  };
  exports["main"] = main;
})(PS);
PS["Main"].main();