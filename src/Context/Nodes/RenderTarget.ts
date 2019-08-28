import { Port } from "../../../../Types";
import {
  Texture,
  WebGLRenderTarget,
  Scene,
  Mesh,
  MeshBasicMaterial,
  PlaneBufferGeometry,
  NearestFilter,
  ClampToEdgeWrapping,
  Object3D
} from "three";

export default function(
  input: Texture,
  port: Port,
  insertion: Object3D
): WebGLRenderTarget {
  const scene = new Scene();
  let mat;
  const geom = new PlaneBufferGeometry(2, 2, 1, 1);
  if (input) {
    mat = new MeshBasicMaterial({
      map: input
    });
  }
  const mesh = new Mesh(geom, mat);
  mesh.position.set(0, 0, 0);
  scene.add(mesh);
  if (insertion) {
    scene.add(insertion);
  }
  const renderTarget = new WebGLRenderTarget(512, 512, {
    depthBuffer: false, // consider this setting
    stencilBuffer: false, // consider this setting
    magFilter: NearestFilter,
    minFilter: NearestFilter,
    wrapS: ClampToEdgeWrapping,
    wrapT: ClampToEdgeWrapping
  });

  port.renderers.push({ scene: scene, target: renderTarget });
  return renderTarget;
}
