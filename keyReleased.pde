void keyReleased() {

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
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}