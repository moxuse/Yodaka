import { YNode, Port } from "../../../Types";

import TorusMesh from "./Nodes/Mesh/TorusMsh";
import SphereMesh from "./Nodes/Mesh/SphereMesh";
import PlaneMesh from "./Nodes/Mesh/PlaneMesh";

import RenderTarget from "./Nodes/RenderTarget";

import { Object3D, Texture } from "three";

import prelude from "prelude-ls";
import { DEFAULT_ENCODING } from "crypto";

export default function(port: Port) {
  //   const defaultImg: HTMLImageElement = document.getElementById(
  //     "default_texture"
  //   ) as HTMLImageElement;
  //   let defaultTexture;
  //   defaultImg.onload = () => {
  //     defaultTexture = new Texture(defaultImg);
  //   };

  const throughput = (input: string) => {
    console.log("context is:", port);
  };

  /*
    Add function
  */
  const add = (input: YNode) => {
    switch (input.type) {
      case "Mesh":
        port.scene.add(input);
        break;
      default:
        break;
    }
  };

  const remove = () => {
    for (let child: Object3D of port.scene.children) {
      if (child.tag != "light") {
        port.scene.remove(child);
      }
    }
  };

  const render = (input: Texture, inserttion: Object3D) => {
    RenderTarget(input, port, inserttion);
  };

  const torus = TorusMesh();
  const sphere = SphereMesh();
  const plane = PlaneMesh();

  return { remove, add, throughput, torus, sphere, plane, render };
}
