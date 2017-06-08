
int totalSegments = 1200; // length of the spiral
int stepLength = 15;
PVector[] points;
float innerBoundary = 100;
float outerBoundary = 1000;

//////////////////EXPORTS///////////////////
import processing.dxf.*;
import processing.pdf.*;
import java.util.Calendar;
boolean savePDF = false;
boolean saveDXF = false;
boolean record = false;
String cadSoftware, ext;

void setup(){
  size(1000,1000);
  smooth();
  //colorMode(HSB,255,100,100);
  ellipseMode(CENTER);
  stroke(0);
  //println("move cursor vertically");
}
void draw(){
  background(155);
  //////////////////EXPORTS///////////////////
  if (record) beginRaw("superCAD."+cadSoftware, timestamp()+"."+ext);
  if (saveDXF) beginRaw(DXF, timestamp()+".dxf");
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  //////////////////EXPORTS///////////////////
  
  
  drawAxis();
  ellipseMode(CENTER);
  points = getTheodorus(totalSegments,stepLength);
  drawTheodorusSpiral(points, innerBoundary, outerBoundary);
  drawBoundaries(innerBoundary, outerBoundary);
  
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


void drawAxis(){
  strokeWeight(1);
  stroke(255);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);  
}


void drawBoundaries(float inner, float outer){
  strokeWeight(3);
  stroke(255,0,0);
  noFill();
  ellipseMode(CENTER);
  ellipse( width/2, height/2, outer, outer);
  ellipse(width/2, height/2, inner, inner);
}