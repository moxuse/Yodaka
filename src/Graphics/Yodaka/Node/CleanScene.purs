module Graphics.Yodaka.CleanScene where

import Prelude (Unit)
import Effect (Effect)
import Graphics.Three.Scene as Scene

import Data.Foreign.EasyFFI (unsafeForeignProcedure)

-- TODO: Want to replace to PureScript code. This is temporaly

cleanScene :: Scene.Scene -> Effect Unit
cleanScene = unsafeForeignProcedure ["scene", ""] 
  """
    console.log('removing..',scene.children);
    if (!scene) {
      return;
    };
    for (var i = 0 ; i<scene.children.lenfgth; i++) {
      if ("light" != scene.children[i].tag) {
        if (scene.children[i].material.map) {
          scene.children[i].material.map.dispodse();
          scene.children[i].material.dispodse();
        }
        scene.children[i].geometry.dispose();
        scene.remove(scene.children[i]);
      }
    }
  """
