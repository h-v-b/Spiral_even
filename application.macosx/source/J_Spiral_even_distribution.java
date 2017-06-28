import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import geomerative.*; 
import processing.dxf.*; 
import processing.pdf.*; 
import java.util.Calendar; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class J_Spiral_even_distribution extends PApplet {


ControlP5 cp5;

// Spiral Controls
int amountOfPoints = 1000; // length of the spiral
int stepLength = 60;
float radiusMult = 1;
PVector[] points;
float innerBoundary = 100;
float outerBoundary = 1000;

float radiansStep=0.4f;
float thetaStep = 0.5f;
float minSize =  2.5f;
float maxSize = 100;


RShape mySpiral;
RShape cleanSpiral;
RShape myLimits;

//////////////////EXPORTS///////////////////



boolean savePDF = false;
boolean saveDXF = false;
boolean record = false;
String cadSoftware, ext;

public void setup() {
  
  

  cp5 = new ControlP5(this);
  initGUI(cp5);

  RG.init(this);

  myLimits = new RShape();
  initBoundaries(innerBoundary, outerBoundary);
  myLimits.translate(width/2, height/2);
}

public void draw() {

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
  drawShapesOnPoints(points, innerBoundary, outerBoundary, radiusMult, minSize, maxSize);
  mySpiral.translate(width/2, height/2);

    if(record || saveDXF || savePDF)
  {
    cleanSpiral = removeOverlaps(mySpiral);
    cleanSpiral.translate(width/2, height/2);
  }

  background(55);
  mySpiral.draw();
  myLimits.draw();
  drawAxis();

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

public RShape removeOverlaps(RShape spiral) {
  RShape cleanSpiral = new RShape();
  for (int i =0; i < spiral.children.length-1; i++) {
    RShape shapeToCut = spiral.children[i];
    RShape cuttingShape = spiral.children[i+1];      
    RShape cutShape = RG.diff(shapeToCut, cuttingShape);
    cleanSpiral.addChild(cutShape);
  }
  return cleanSpiral;
}

public void drawAxis() {
  strokeWeight(1);
  stroke(255);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
}


public void initBoundaries(float inner, float outer) {
  int c = color(0,0,0);
  myLimits.addChild(RShape.createCircle(0, 0, inner));
  myLimits.addChild(RShape.createCircle(0, 0, outer));
  myLimits.setAlpha(100);
  myLimits.setStroke(c);
  myLimits.setStrokeWeight(2);
}
public void initGUI(ControlP5 cp5) {
  cp5.addSlider("amountOfPoints")
    .setPosition(15, 15)
    .setRange(2, 5000)
    .setWidth(500)
    .setColorLabel(0);
    ;

  cp5.addSlider("stepLength")
    .setPosition(15, 25)
    .setRange(1, 100)
    .setWidth(500)
    .setColorLabel(0);
    ;

  cp5.addSlider("radiansStep")
    .setPosition(15, 35)
    .setRange(0, 10)
    .setWidth(500)
    .setColorLabel(0);
    ;

  cp5.addSlider("thetaStep")
    .setPosition(15, 45)
    .setRange(0, 5)
    .setWidth(500)
    .setColorLabel(0);
    ;

  cp5.addSlider("radiusMult")
    .setPosition(15, 55)
    .setRange(0.1f, 5)
    .setWidth(500)
    .setColorLabel(0);
    ;
    
      cp5.addSlider("minSize")
    .setPosition(15, 65)
    .setRange(2.5f, 20)
    .setWidth(500)
    .setColorLabel(0);
    ;
    
      cp5.addSlider("maxSize")
    .setPosition(15, 75)
    .setRange(50, 500)
    .setWidth(500)
    .setColorLabel(0);
    ;
    
}
public void drawCircle(PVector pos, float radius){
  //RShape s = RShape.createCircle(radius,pos.x,pos.y);
  RShape s = RShape.createRectangle(radius, radius,pos.x,pos.y);
}
public void drawShapesOnPoints(PVector[] points, float innerBoundary, float outerBoundary, float radiusMult, float minSize, float maxSize) {
  int shapeCounter = 0;
  int c1 = color(255, 255, 255);
  int c2 = color(100, 100, 100);
  int c3 = color (0, 0, 0);
  int c4 = color(100, 0, 0);
  for (int i = 0; i < amountOfPoints; i++) {
    PVector pos = new PVector(points[i].x, points[i].y);
    float distanceToCenter = abs(dist(pos.x, pos.y, 0, 0));
    // adjust size to innerBoundary
    float radius = map(1*abs(distanceToCenter), 1, 500,minSize, maxSize) ;
    if (abs(distanceToCenter) < innerBoundary/2)
      continue;
    if (distanceToCenter-innerBoundary/2 < radius/2) {
      //continue;
      radius = 2*(distanceToCenter-innerBoundary/2);
    }
    if (abs(distanceToCenter-outerBoundary/2) < radius/2) {
      //radius = 2*(outerBoundary/2-distanceToCenter);
      break;
    } 
    if (abs(distanceToCenter) > outerBoundary/2)
      break;
    /*
    float radius = stepLength*radiusMult;
    if (abs(distanceToCenter) < innerBoundary/2)
      continue;
    
    if (abs(distanceToCenter-outerBoundary/2) < radius/2) {
      radius = 2*(outerBoundary/2-distanceToCenter);
    } 
    if (abs(distanceToCenter) > outerBoundary/2)
      break;
    else
      radius = radius;
    */
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
public PVector[] getPointsOnSpiral(int amountOfPoints, float radiansStep, float thetaStep) {
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
public PVector[] getTheodorus(int segments, int len) {
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
public void keyReleased() {

  // EXPORTER KEYS///////////////////////////////////////////////////
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;
  if (key == 'd' || key == 'D') saveDXF = true;

  if (key == 'r') { 
    cadSoftware = "Rhino";
    ext = "rvb";
    record = true;
  }
  if (key == 's') { 
    cadSoftware = "SketchUP"; 
    ext = "skp";
    record = true;
  }
  if (key == 'a') { 
    cadSoftware = "AutoLISP"; 
    ext = "rb";
    record = true;
  }
  if (key == 'm') { 
    cadSoftware = "Maya"; 
    ext = "mel";
    record = true;
  }
  if (key == 'o') { 
    cadSoftware = "ObjFile"; 
    ext = "obj";
    record = true;
  }
  if (key == 'c') { 
    cadSoftware = "ArchiCAD"; 
    ext = "gdl";  
    record = true;
  }
}

// timestamp
public String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
  public void settings() {  size(1100, 1100);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "J_Spiral_even_distribution" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
