void drawShapesOnPoints(PVector[] points, float innerBoundary, float outerBoundary, float radiusMult) {
  int shapeCounter = 0;
  color c1 = color(255, 255, 255);
  color c2 = color(100, 100, 100);
  color c3 = color (0, 0, 0);
  color c4 = color(100, 0, 0);
  for (int i = 0; i < amountOfPoints; i++) {
    PVector pos = new PVector(points[i].x, points[i].y);
    float distanceToCenter = abs(dist(pos.x, pos.y, 0, 0));
    // adjust size to innerBoundary
    float radius = stepLength*radiusMult;
    if (abs(distanceToCenter) < innerBoundary/2)
      continue;
    if (distanceToCenter-innerBoundary/2 < radius/2) {
      radius = 2*(distanceToCenter-innerBoundary/2);
    }
    if (abs(distanceToCenter-outerBoundary/2) < radius/2) {
      radius = 2*(outerBoundary/2-distanceToCenter);
    } 
    if (abs(distanceToCenter) > outerBoundary/2)
      break;
    else
      radius = radius;
    if (radius >0) {
      //ellipse(pos.x, pos.y, radius, radius);
      RShape s = RShape.createEllipse(pos.x, pos.y, radius, radius);

      if (shapeCounter%2 == 0) {
        s.setFill(c1);
        s.setStroke(c3);
      } else {
        s.setFill(c2);
        s.setStroke(c3);
      }
      mySpiral.addChild(s);
      shapeCounter ++;
    }
  }
}