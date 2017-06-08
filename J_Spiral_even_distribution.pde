import controlP5.*;
ControlP5 cp5;

// Spiral Controls
int amountOfPoints = 1000; // length of the spiral
int stepLength = 60;
float radiusMult = 1;
PVector[] points;
float innerBoundary = 100;
float outerBoundary = 1000;

float radiansStep=0.4;
float thetaStep = 0.5;

import geomerative.*;
RShape mySpiral;
RShape cleanSpiral;
RShape myLimits;

//////////////////EXPORTS///////////////////
import processing.dxf.*;
import processing.pdf.*;
import java.util.Calendar;
boolean savePDF = false;
boolean saveDXF = false;
boolean record = false;
String cadSoftware, ext;

void setup() {
  size(1000, 1000);
  smooth();

  cp5 = new ControlP5(this);
  initGUI(cp5);

  RG.init(this);

  myLimits = new RShape();
  initBoundaries(innerBoundary, outerBoundary);
  myLimits.translate(width/2, height/2);
}

void draw() {

  //////////////////EXPORTS///////////////////
  if (record) beginRaw("superCAD."+cadSoftware, timestamp()+"."+ext);
  if (saveDXF) beginRaw(DXF, timestamp()+".dxf");
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  //////////////////EXPORTS///////////////////

  // generate point cloud to draw ellipses
  //even distribution on Theodorus Spiral
  //points = getTheodorus(amountOfPoints,stepLength);

  // simple spiral
  points = getPointsOnSpiral(amountOfPoints, radiansStep, thetaStep);

  mySpiral = new RShape();
  drawShapesOnPoints(points, innerBoundary, outerBoundary, radiusMult);
  cleanSpiral = removeOverlaps(mySpiral);
  mySpiral.translate(width/2, height/2);
  cleanSpiral.translate(width/2, height/2);

  background(155);
  //mySpiral.draw();
  cleanSpiral.draw();
  myLimits.draw();
  //drawAxis();

  //////////////////EXPORTS///////////////////
  if (savePDF) {
    savePDF = false;
    endRecord();
    println ("pdf saved...");
  }
  if (saveDXF) {
    saveDXF = false;
    endRaw();
    println ("dxf saved...");
  }  
  if (record) {
    endRaw();
    record = false;
  }
  //////////////////EXPORTS///////////////////
}

RShape removeOverlaps(RShape spiral) {
  RShape cleanSpiral = new RShape();
  for (int i =0; i < spiral.children.length-1; i++) {
    RShape shapeToCut = spiral.children[i];
    RShape cuttingShape = spiral.children[i+1];      
    RShape cutShape = RG.diff(shapeToCut, cuttingShape);
    cleanSpiral.addChild(cutShape);
  }
  return cleanSpiral;
}

void drawAxis() {
  strokeWeight(1);
  stroke(255);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
}


void initBoundaries(float inner, float outer) {
  myLimits.addChild(RShape.createCircle(0, 0, inner));
  myLimits.addChild(RShape.createCircle(0, 0, outer));
  myLimits.setAlpha(0);
  myLimits.setStroke(2);
  myLimits.setStrokeWeight(2);
}