import { Mesh, PlaneGeometry, MeshStandardMaterial, DoubleSide } from "three";

export default function(): Mesh {
  const geom = new PlaneGeometry(1, 1, 1, 1);
  const material = new MeshStandardMaterial({
    color: 0x2194ce,
    side: DoubleSide
  });
  return new Mesh(geom, material);
}
