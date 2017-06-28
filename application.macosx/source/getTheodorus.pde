PVector[] getTheodorus(int segments, int len) {
  PVector[] result = new PVector[segments];
  float radius = 0;
  float angle = 0;
  for (int i = 0; i < segments; i++) {
    radius = sqrt(i+1);
    angle += asin(1/radius);
    result[i] = new PVector(cos(angle) * radius*len, sin(angle) * radius*len);
  }
  return result;
}