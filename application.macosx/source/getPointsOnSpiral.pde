PVector[] getPointsOnSpiral(int amountOfPoints, float radiansStep, float thetaStep) {
  float radians=0;
  float theta = 0;

  float radius = stepLength*radiusMult;

  PVector[] result = new PVector[amountOfPoints];
  for (int i = 0; i < amountOfPoints; i++) {
    PVector p = new PVector(radians*sin(theta), radians*cos(theta));
    result[i] = p;
    radians += stepLength;
    theta += thetaStep;
  }
  return result;
}