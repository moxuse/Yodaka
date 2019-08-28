import { YNode, Port } from "../Types";
import TorusMesh from "./Nodes/Mesh/TorusMsh";
import SphereMesh from "./Nodes/Mesh/SphereMesh";
import { Object3D } from "three";

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

  const torus = TorusMesh();
  const sphere = SphereMesh();

  return { remove, add, throughput, torus, sphere };
}
