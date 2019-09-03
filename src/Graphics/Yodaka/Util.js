"use strict";
exports.onReadyThreeContextImpl = function(onError, onSucceed) {
  var script = document.createElement("script");
  script.type = "text/javascript";

  if (script.readyState) {
    script.onreadystatechange = function() {
      if (script.readyState == "loaded" || script.readyState == "complete") {
        script.onreadystatechange = null;
      }
    };
  } else {
    script.onload = function() {
      console.log("suceeed load three!");
      onSucceed();
    };
  }
  script.onerror = function(error) {
    console.log(error);
    onError(error);
  };
  script.src =
    "https://cdnjs.cloudflare.com/ajax/libs/three.js/107/three.min.js";
  document.getElementsByTagName("head")[0].appendChild(script);
  var container = document.createElement("div");
  container.id = "container";
  document.body.appendChild(container);
  console.log("end of onReadyThreeContextImpl..");
};
