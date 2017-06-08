void initGUI(ControlP5 cp5) {
  cp5.addSlider("amountOfPoints")
    .setPosition(15, 15)
    .setRange(2, 2000)
    .setWidth(200);
    ;

  cp5.addSlider("stepLength")
    .setPosition(15, 25)
    .setRange(1, 100)
    .setWidth(200);
    ;

  cp5.addSlider("radiansStep")
    .setPosition(15, 35)
    .setRange(0, 1)
    .setWidth(200);
    ;

  cp5.addSlider("thetaStep")
    .setPosition(15, 45)
    .setRange(0, 1)
    .setWidth(200);
    ;

  cp5.addSlider("radiusMult")
    .setPosition(15, 55)
    .setRange(0.1, 5)
    .setWidth(200);
    ;
}