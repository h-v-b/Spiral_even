void initGUI(ControlP5 cp5) {
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
    .setRange(0.1, 5)
    .setWidth(500)
    .setColorLabel(0);
    ;
    
    cp5.addSlider("minSize")
    .setPosition(15, 65)
    .setRange(2.5, 20)
    .setWidth(500)
    .setColorLabel(0);
    ;
    
    cp5.addSlider("maxSize")
    .setPosition(15, 75)
    .setRange(50, 500)
    .setWidth(500)
    .setColorLabel(0);
    ;
    
        cp5.addSlider("innerBoundary")
    .setPosition(15, 85)
    .setRange(1, 500)
    .setWidth(500)
    .setColorLabel(0);
    ;
    
    cp5.addSlider("outerBoundary")
    .setPosition(15, 95)
    .setRange(500, 1000)
    .setWidth(500)
    .setColorLabel(0);
    ;
    
}