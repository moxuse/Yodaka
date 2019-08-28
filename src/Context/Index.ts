import { YNode, Port } from "../../../Types";

import TorusMesh from "./Nodes/Mesh/TorusMsh";
import SphereMesh from "./Nodes/Mesh/SphereMesh";
import PlaneMesh from "./Nodes/Mesh/PlaneMesh";
import { Object3D, Mesh, Texture, WebGLRenderTarget } from "three";

export default function(port: Port) {
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

  const render = (input: Texture): Texture => {
    const renderTarget = new WebGLRenderTarget(512, 512, {});
    return renderTarget;
  };

  const torus = TorusMesh();
  const sphere = SphereMesh();
  const plane = PlaneMesh();

  return { remove, add, throughput, torus, sphere, plane, render };
}
