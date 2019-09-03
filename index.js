// Generated by purs bundle 0.13.3
var PS = {};
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Control.Apply"] = $PS["Control.Apply"] || {};
  var exports = $PS["Control.Apply"];                    
  var Apply = function (Functor0, apply) {
      this.Functor0 = Functor0;
      this.apply = apply;
  };                      
  var apply = function (dict) {
      return dict.apply;
  };
  exports["Apply"] = Apply;
  exports["apply"] = apply;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Control.Applicative"] = $PS["Control.Applicative"] || {};
  var exports = $PS["Control.Applicative"];
  var Control_Apply = $PS["Control.Apply"];        
  var Applicative = function (Apply0, pure) {
      this.Apply0 = Apply0;
      this.pure = pure;
  };
  var pure = function (dict) {
      return dict.pure;
  };
  var liftA1 = function (dictApplicative) {
      return function (f) {
          return function (a) {
              return Control_Apply.apply(dictApplicative.Apply0())(pure(dictApplicative)(f))(a);
          };
      };
  };
  exports["Applicative"] = Applicative;
  exports["pure"] = pure;
  exports["liftA1"] = liftA1;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Control.Bind"] = $PS["Control.Bind"] || {};
  var exports = $PS["Control.Bind"];
  var Bind = function (Apply0, bind) {
      this.Apply0 = Apply0;
      this.bind = bind;
  };                     
  var bind = function (dict) {
      return dict.bind;
  };
  exports["Bind"] = Bind;
  exports["bind"] = bind;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Control.Semigroupoid"] = $PS["Control.Semigroupoid"] || {};
  var exports = $PS["Control.Semigroupoid"];
  var Semigroupoid = function (compose) {
      this.compose = compose;
  };
  var semigroupoidFn = new Semigroupoid(function (f) {
      return function (g) {
          return function (x) {
              return f(g(x));
          };
      };
  });
  exports["semigroupoidFn"] = semigroupoidFn;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Control.Category"] = $PS["Control.Category"] || {};
  var exports = $PS["Control.Category"];
  var Control_Semigroupoid = $PS["Control.Semigroupoid"];                
  var Category = function (Semigroupoid0, identity) {
      this.Semigroupoid0 = Semigroupoid0;
      this.identity = identity;
  };
  var identity = function (dict) {
      return dict.identity;
  };
  var categoryFn = new Category(function () {
      return Control_Semigroupoid.semigroupoidFn;
  }, function (x) {
      return x;
  });
  exports["identity"] = identity;
  exports["categoryFn"] = categoryFn;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Control.Monad"] = $PS["Control.Monad"] || {};
  var exports = $PS["Control.Monad"];
  var Control_Applicative = $PS["Control.Applicative"];
  var Control_Bind = $PS["Control.Bind"];                
  var Monad = function (Applicative0, Bind1) {
      this.Applicative0 = Applicative0;
      this.Bind1 = Bind1;
  };
  var ap = function (dictMonad) {
      return function (f) {
          return function (a) {
              return Control_Bind.bind(dictMonad.Bind1())(f)(function (v) {
                  return Control_Bind.bind(dictMonad.Bind1())(a)(function (v1) {
                      return Control_Applicative.pure(dictMonad.Applicative0())(v(v1));
                  });
              });
          };
      };
  };
  exports["Monad"] = Monad;
  exports["ap"] = ap;
})(PS);
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
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Data.Functor"] = $PS["Data.Functor"] || {};
  var exports = $PS["Data.Functor"];               
  var Functor = function (map) {
      this.map = map;
  };
  exports["Functor"] = Functor;
})(PS);
(function(exports) {
  "use strict";

  exports.pureE = function (a) {
    return function () {
      return a;
    };
  };

  exports.bindE = function (a) {
    return function (f) {
      return function () {
        return f(a())();
      };
    };
  };
})(PS["Effect"] = PS["Effect"] || {});
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Effect"] = $PS["Effect"] || {};
  var exports = $PS["Effect"];
  var $foreign = $PS["Effect"];
  var Control_Applicative = $PS["Control.Applicative"];
  var Control_Apply = $PS["Control.Apply"];
  var Control_Bind = $PS["Control.Bind"];
  var Control_Monad = $PS["Control.Monad"];
  var Data_Functor = $PS["Data.Functor"];                    
  var monadEffect = new Control_Monad.Monad(function () {
      return applicativeEffect;
  }, function () {
      return bindEffect;
  });
  var bindEffect = new Control_Bind.Bind(function () {
      return applyEffect;
  }, $foreign.bindE);
  var applyEffect = new Control_Apply.Apply(function () {
      return functorEffect;
  }, Control_Monad.ap(monadEffect));
  var applicativeEffect = new Control_Applicative.Applicative(function () {
      return applyEffect;
  }, $foreign.pureE);
  var functorEffect = new Data_Functor.Functor(Control_Applicative.liftA1(applicativeEffect));
  exports["monadEffect"] = monadEffect;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Effect.Class"] = $PS["Effect.Class"] || {};
  var exports = $PS["Effect.Class"];
  var Control_Category = $PS["Control.Category"];
  var Effect = $PS["Effect"];                
  var MonadEffect = function (Monad0, liftEffect) {
      this.Monad0 = Monad0;
      this.liftEffect = liftEffect;
  };
  var monadEffectEffect = new MonadEffect(function () {
      return Effect.monadEffect;
  }, Control_Category.identity(Control_Category.categoryFn));
  var liftEffect = function (dict) {
      return dict.liftEffect;
  };
  exports["liftEffect"] = liftEffect;
  exports["monadEffectEffect"] = monadEffectEffect;
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
  $PS["Effect.Class.Console"] = $PS["Effect.Class.Console"] || {};
  var exports = $PS["Effect.Class.Console"];
  var Effect_Class = $PS["Effect.Class"];
  var Effect_Console = $PS["Effect.Console"];
  var log = function (dictMonadEffect) {
      var $26 = Effect_Class.liftEffect(dictMonadEffect);
      return function ($27) {
          return $26(Effect_Console.log($27));
      };
  };
  exports["log"] = log;
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
  var createSphereGeometry = Graphics_Three_Util.ffi([ "radius", "widthSegments", "heightSegments", "" ])("new THREE.SphereGeometry(radius, widthSegments, heightSegments)");
  exports["createTorusGeometry"] = createTorusGeometry;
  exports["createSphereGeometry"] = createSphereGeometry;
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
  var addObject = function (dictObject3D) {
      return Graphics_Three_Util.fpi([ "scene", "a", "" ])("scene.add(a)");
  };
  exports["addObject"] = addObject;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.Port"] = $PS["Graphics.Yodaka.Port"] || {};
  var exports = $PS["Graphics.Yodaka.Port"];
  var Data_Foreign_EasyFFI = $PS["Data.Foreign.EasyFFI"];                
  var gloabalPort = Data_Foreign_EasyFFI.unsafeForeignFunction([ "" ])("window.port");
  exports["gloabalPort"] = gloabalPort;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.Context"] = $PS["Graphics.Yodaka.Context"] || {};
  var exports = $PS["Graphics.Yodaka.Context"];
  var Graphics_Three_Scene = $PS["Graphics.Three.Scene"];
  var Graphics_Yodaka_Port = $PS["Graphics.Yodaka.Port"];                
  var add = function (dictObject3D) {
      return function (obj) {
          return function __do() {
              var v = Graphics_Yodaka_Port.gloabalPort();
              var v1 = obj();
              return Graphics_Three_Scene.addObject(dictObject3D)(v.scene)(v1)();
          };
      };
  };
  exports["add"] = add;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.Node.Sphere"] = $PS["Graphics.Yodaka.Node.Sphere"] || {};
  var exports = $PS["Graphics.Yodaka.Node.Sphere"];
  var Graphics_Three_GeometryAddition = $PS["Graphics.Three.GeometryAddition"];
  var Graphics_Three_MaterialAddition = $PS["Graphics.Three.MaterialAddition"];
  var Graphics_Three_Object3D = $PS["Graphics.Three.Object3D"];                
  var sphere = function __do() {
      var v = Graphics_Three_GeometryAddition.createSphereGeometry(1.0)(28.0)(28.0)();
      var v1 = Graphics_Three_MaterialAddition.createMeshStandard({
          color: 2200782
      })();
      return Graphics_Three_Object3D.createMesh()(v)(v1)();
  };
  exports["sphere"] = sphere;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Graphics.Yodaka.Node.Torus"] = $PS["Graphics.Yodaka.Node.Torus"] || {};
  var exports = $PS["Graphics.Yodaka.Node.Torus"];
  var Graphics_Three_GeometryAddition = $PS["Graphics.Three.GeometryAddition"];
  var Graphics_Three_MaterialAddition = $PS["Graphics.Three.MaterialAddition"];
  var Graphics_Three_Object3D = $PS["Graphics.Three.Object3D"];                
  var torus = function __do() {
      var v = Graphics_Three_GeometryAddition.createTorusGeometry(1.0)(0.5)(16.0)(100.0)();
      var v1 = Graphics_Three_MaterialAddition.createMeshStandard({
          color: 2200782
      })();
      return Graphics_Three_Object3D.createMesh()(v)(v1)();
  };
  exports["torus"] = torus;
})(PS);
(function($PS) {
  // Generated by purs version 0.13.3
  "use strict";
  $PS["Main"] = $PS["Main"] || {};
  var exports = $PS["Main"];
  var Effect_Class = $PS["Effect.Class"];
  var Effect_Class_Console = $PS["Effect.Class.Console"];
  var Graphics_Yodaka_Context = $PS["Graphics.Yodaka.Context"];
  var Graphics_Yodaka_Node_Sphere = $PS["Graphics.Yodaka.Node.Sphere"];
  var Graphics_Yodaka_Node_Torus = $PS["Graphics.Yodaka.Node.Torus"];                
  var main = function __do() {
      Effect_Class_Console.log(Effect_Class.monadEffectEffect)("You Compiled Main module")();
      Graphics_Yodaka_Context.add()(Graphics_Yodaka_Node_Torus.torus)();
      return Graphics_Yodaka_Context.add()(Graphics_Yodaka_Node_Sphere.sphere)();
  };
  exports["main"] = main;
})(PS);
PS["Main"].main();