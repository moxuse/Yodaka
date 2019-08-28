import { Mesh, SphereGeometry, MeshStandardMaterial } from "three";

export default function(): Mesh {
  const geom = new SphereGeometry(1, 28, 28);
  const material = new MeshStandardMaterial({ color: 0x2194ce });
  return new Mesh(geom, material);
}
